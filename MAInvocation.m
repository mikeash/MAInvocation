#import "MAInvocation.h"

#import "MAInvocation-asm.h"

#import <objc/runtime.h>


enum TypeClassification
{
    TypeObject,
    TypeBlock,
    TypeCString,
    TypeInteger,
    TypeTwoIntegers,
    TypeEmptyStruct,
    TypeStruct,
    TypeOther
};

@implementation MAInvocation {
    NSMethodSignature *_sig;
    struct RawArguments _raw;
    BOOL _argumentsRetained;
    void *_stretBuffer;
}

+ (void)initialize
{
    objc_setForwardHandler(MAInvocationForward, MAInvocationForwardStret);
}

+ (NSInvocation *)invocationWithMethodSignature: (NSMethodSignature *)sig
{
    return [[[self alloc] initWithMethodSignature: sig] autorelease];
}

- (id)initWithMethodSignature: (NSMethodSignature *)sig
{
    if((self = [super init]))
    {
        _sig = [sig retain];
        
        _raw.isStretCall = [self isStretReturn];
        
        NSUInteger argsCount = [sig numberOfArguments];
        if(_raw.isStretCall)
            argsCount++;
        
        if(argsCount > 6)
        {
            _raw.stackArgsCount = argsCount - 6;
            _raw.stackArgs = calloc(argsCount - 6, sizeof(*_raw.stackArgs));
        }
    }
    return self;
}

- (void)dealloc
{
    if(_argumentsRetained)
    {
        [self iterateRetainableArguments: ^(NSUInteger idx, id obj, id block, char *cstr) {
            [obj release];
            [block release];
            free(cstr);
        }];
    }
    
    [_sig release];
    free(_raw.stackArgs);
    
    [super dealloc];
}

- (NSString *)description
{
    NSMutableArray *stackArgsStrings = [NSMutableArray array];
    for(NSUInteger i = 0; i < _raw.stackArgsCount; i++)
        [stackArgsStrings addObject: [NSString stringWithFormat: @"%llx", _raw.stackArgs[i]]];
    NSString *stackArgsString = [stackArgsStrings componentsJoinedByString: @" "];
    return [NSString stringWithFormat: @"<%@ %p: rdi=%llx rsi=%llx rdx=%llx rcx=%llx r8=%llx r9=%llx stackArgs=%p(%llx)[%@] rax_ret=%llx rdx_ret=%llx isStretCall=%llx>", [self class], self, _raw.rdi, _raw.rsi, _raw.rdx, _raw.rcx, _raw.r8, _raw.r9, _raw.stackArgs, _raw.stackArgsCount, stackArgsString, _raw.rax_ret, _raw.rdx_ret, _raw.isStretCall];
}

- (NSMethodSignature *)methodSignature
{
    return _sig;
}

- (void)retainArguments
{
    if(_argumentsRetained)
        return;
    
    [self iterateRetainableArguments: ^(NSUInteger idx, id obj, id block, char *cstr) {
        if(obj)
        {
            [obj retain];
        }
        else if(block)
        {
            block = [block copy];
            [self setArgument: &block atIndex: idx];
        }
        else if(cstr)
        {
            if(cstr != NULL)
                cstr = strdup(cstr);
            [self setArgument: &cstr atIndex: idx];
        }
    }];
    _argumentsRetained = YES;
}

- (BOOL)argumentsRetained
{
    return _argumentsRetained;
}

- (id)target
{
    id target;
    [self getArgument: &target atIndex: 0];
    return target;
}

- (void)setTarget: (id)target
{
    [self setArgument: &target atIndex: 0];
}

- (SEL)selector
{
    SEL sel;
    [self getArgument: &sel atIndex: 1];
    return sel;
}

- (void)setSelector: (SEL)selector
{
    [self setArgument: &selector atIndex: 1];
}

- (void)getReturnValue: (void *)retLoc
{
    NSUInteger size = [self returnValueSize];
    memcpy(retLoc, [self returnValuePtr], size);
}

- (void)setReturnValue: (void *)retLoc
{
    NSUInteger size = [self returnValueSize];
    memcpy([self returnValuePtr], retLoc, size);
}

- (void)getArgument: (void *)argumentLocation atIndex: (NSInteger)idx
{
    NSInteger rawArgumentIndex = idx;
    if(_raw.isStretCall)
        rawArgumentIndex++;
    
    uint64_t *src = [self argumentPointerAtIndex: rawArgumentIndex];
    assert(src);
    
    NSUInteger size = [self sizeAtIndex: idx];
    memcpy(argumentLocation, src, size);
}

- (void)setArgument: (void *)argumentLocation atIndex: (NSInteger)idx
{
    NSInteger rawArgumentIndex = idx;
    if(_raw.isStretCall)
        rawArgumentIndex++;
    
    uint64_t *dest = [self argumentPointerAtIndex: rawArgumentIndex];
    assert(dest);
    
    enum TypeClassification c = [self classifyArgumentAtIndex: idx];
    if(_argumentsRetained && c == TypeObject)
    {
        id old = *(id *)dest;
        *(id *)dest = [*(id *)argumentLocation retain];
        [old release];
    }
    else if(_argumentsRetained && c == TypeBlock)
    {
        id old = *(id *)dest;
        *(id *)dest = [*(id *)argumentLocation copy];
        [old release];
    }
    else if(_argumentsRetained && c == TypeCString)
    {
        char *old = *(char **)dest;
        
        char *cstr = *(char **)argumentLocation;
        if(cstr != NULL)
            cstr = strdup(cstr);
        *(char **)dest = cstr;
        
        free(old);
    }
    else
    {
        NSUInteger size = [self sizeAtIndex: idx];
        memcpy(dest, argumentLocation, size);
    }
}

- (void)invoke
{
    [self invokeWithTarget: [self target]];
}

- (void)invokeWithTarget: (id)target
{
    [self setTarget: target];
    _raw.fptr = [target methodForSelector: [self selector]];
    if(_raw.isStretCall)
        _raw.rdi = (uint64_t)[self returnValuePtr];
    MAInvocationCall(&_raw);
}

#pragma mark Private

- (uint64_t *)argumentPointerAtIndex: (NSInteger)idx
{
    uint64_t *ptr = NULL;
    if(idx == 0)
        ptr = &_raw.rdi;
    if(idx == 1)
        ptr = &_raw.rsi;
    if(idx == 2)
        ptr = &_raw.rdx;
    if(idx == 3)
        ptr = &_raw.rcx;
    if(idx == 4)
        ptr = &_raw.r8;
    if(idx == 5)
        ptr = &_raw.r9;
    if(idx >= 6)
        ptr = _raw.stackArgs + idx - 6;
    return ptr;
}

- (NSUInteger)sizeAtIndex: (NSInteger)idx
{
    return [self sizeOfType: [_sig getArgumentTypeAtIndex: idx]];
}

- (NSUInteger)returnValueSize
{
    return [self sizeOfType: [_sig methodReturnType]];
}

- (NSUInteger)sizeOfType: (const char *)type
{
    NSUInteger size;
    NSGetSizeAndAlignment(type, &size, NULL);
    return size;
}

- (void)iterateRetainableArguments: (void (^)(NSUInteger idx, id obj, id block, char *cstr))block
{
    for(NSUInteger i = 0; i < [_sig numberOfArguments]; i++)
    {
        enum TypeClassification c = [self classifyArgumentAtIndex: i];
        if(c == TypeObject || c == TypeBlock)
        {
            id arg;
            [self getArgument: &arg atIndex: i];
            
            id o = c == TypeObject ? arg : nil;
            id b = c == TypeBlock ? arg : nil;
            block(i, o, b, NULL);
        }
        else if(c == TypeCString)
        {
            char *arg;
            [self getArgument: &arg atIndex: i];
            
            block(i, nil, nil, arg);
        }
    }
}

- (enum TypeClassification)classifyArgumentAtIndex: (NSUInteger)idx
{
    return [self classifyType: [_sig getArgumentTypeAtIndex: idx]];
}

- (enum TypeClassification)classifyType: (const char *)type
{
    const char *idType = @encode(id);
    const char *blockType = @encode(void (^)(void));
    const char *charPtrType = @encode(char *);
    if(strcmp(type, idType) == 0)
        return TypeObject;
    if(strcmp(type, blockType) == 0)
        return TypeBlock;
    if(strcmp(type, charPtrType) == 0)
        return TypeCString;
    
    char intTypes[] = { @encode(signed char)[0], @encode(unsigned char)[0], @encode(short)[0], @encode(unsigned short)[0], @encode(int)[0], @encode(unsigned int)[0], @encode(long)[0], @encode(unsigned long)[0], @encode(long long)[0], @encode(unsigned long long)[0], '?', '^', 0 };
    if(strchr(intTypes, type[0]))
        return TypeInteger;
    
    if(type[0] == '{')
        return [self classifyStructType: type];
    
    return TypeOther;
}

- (enum TypeClassification)classifyStructType: (const char *)type
{
    __block enum TypeClassification structClassification = TypeEmptyStruct;
    [self enumerateStructElementTypes: type block: ^(const char *type) {
        enum TypeClassification elementClassification = [self classifyType: type];
        if(structClassification == TypeEmptyStruct)
            structClassification = elementClassification;
        else if([self isIntegerClass: structClassification] && [self isIntegerClass: elementClassification])
            structClassification = TypeTwoIntegers;
        else
            structClassification = TypeStruct;
    }];
    return structClassification;
}

- (BOOL)isIntegerClass: (enum TypeClassification)classification
{
    return classification == TypeObject || classification == TypeBlock || classification == TypeCString || classification == TypeInteger;
}

- (void)enumerateStructElementTypes: (const char *)type block: (void (^)(const char *type))block
{
    const char *equals = strchr(type, '=');
    const char *cursor = equals + 1;
    while(*cursor != '}')
    {
        block(cursor);
        cursor = NSGetSizeAndAlignment(cursor, NULL, NULL);
    }
}

- (BOOL)isStretReturn
{
    return [self classifyType: [_sig methodReturnType]] == TypeStruct;
}

- (void *)returnValuePtr
{
    if(_raw.isStretCall)
    {
        if(_stretBuffer == NULL)
            _stretBuffer = calloc(1, [self returnValueSize]);
        return _stretBuffer;
    }
    else
    {
        return &_raw.rax_ret;
    }
}

void MAInvocationForwardC(struct RawArguments *r)
{
    id obj;
    SEL sel;
    
    if(r->isStretCall)
    {
        obj = (id)r->rsi;
        sel = (SEL)r->rdx;
    }
    else
    {
        obj = (id)r->rdi;
        sel = (SEL)r->rsi;
    }
    
    NSMethodSignature *sig = [obj methodSignatureForSelector: sel];
    
    MAInvocation *inv = [[MAInvocation alloc] initWithMethodSignature: sig];
    inv->_raw.rdi = r->rdi;
    inv->_raw.rsi = r->rsi;
    inv->_raw.rdx = r->rdx;
    inv->_raw.rcx = r->rcx;
    inv->_raw.r8 = r->r8;
    inv->_raw.r9 = r->r9;
    
    memcpy(inv->_raw.stackArgs, r->stackArgs, inv->_raw.stackArgsCount * sizeof(uint64_t));
    
    [obj forwardInvocation: (id)inv];
    
    r->rax_ret = inv->_raw.rax_ret;
    r->rdx_ret = inv->_raw.rdx_ret;

    if(r->isStretCall && inv->_stretBuffer)
    {
        memcpy((void *)r->rdi, inv->_stretBuffer, [inv returnValueSize]);
    }
    
    [inv release];
}

@end
