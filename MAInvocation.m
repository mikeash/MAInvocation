#import "MAInvocation.h"

#import "MAInvocation-asm.h"

#import <objc/runtime.h>


enum ArgumentClassification
{
    ArgumentObject,
    ArgumentBlock,
    ArgumentNonObject
};

@implementation MAInvocation {
    NSMethodSignature *_sig;
    struct RawArguments _raw;
    BOOL _argumentsRetained;
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
        
        NSUInteger argsCount = [sig numberOfArguments];
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
        [self iterateObjectArguments: ^(NSUInteger idx, id obj, BOOL isBlock) {
            [obj release];
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
    return nil;
}

- (void)retainArguments
{
    if(_argumentsRetained)
        return;
    
    [self iterateObjectArguments: ^(NSUInteger idx, id obj, BOOL isBlock) {
        if(isBlock)
        {
            obj = [obj copy];
            [self setArgument: &obj atIndex: idx];
        }
        else
        {
            [obj retain];
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
    memcpy(retLoc, &_raw.rax_ret, size);
}

- (void)setReturnValue: (void *)retLoc
{
    NSUInteger size = [self returnValueSize];
    memcpy(&_raw.rax_ret, retLoc, size);
}

- (void)getArgument: (void *)argumentLocation atIndex: (NSInteger)idx
{
    uint64_t *src = [self argumentPointerAtIndex: idx];
    
    if(src)
    {
        NSUInteger size = [self sizeAtIndex: idx];
        memcpy(argumentLocation, src, size);
    }
}

- (void)setArgument: (void *)argumentLocation atIndex: (NSInteger)idx
{
    uint64_t *dest = [self argumentPointerAtIndex: idx];
    
    if(dest)
    {
        enum ArgumentClassification c = [self classifyArgumentAtIndex: idx];
        if(_argumentsRetained && c == ArgumentObject)
        {
            [*(id *)dest release];
            *(id *)dest = [*(id *)argumentLocation retain];
        }
        else if(_argumentsRetained && c == ArgumentBlock)
        {
            [*(id *)dest release];
            *(id *)dest = [*(id *)argumentLocation copy];;
        }
        else
        {
            NSUInteger size = [self sizeAtIndex: idx];
            memcpy(dest, argumentLocation, size);
        }
    }
}

- (void)invoke
{
    [self invokeWithTarget: [self target]];
}

- (void)invokeWithTarget: (id)target
{
    _raw.fptr = [target methodForSelector: [self selector]];
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

- (void)iterateObjectArguments: (void (^)(NSUInteger idx, id obj, BOOL isBlock))block
{
    for(NSUInteger i = 0; i < [_sig numberOfArguments]; i++)
    {
        enum ArgumentClassification c = [self classifyArgumentAtIndex: i];
        if(c == ArgumentObject || c == ArgumentBlock)
        {
            id arg;
            [self getArgument: &arg atIndex: i];
            block(i, arg, c == ArgumentBlock);
        }
    }
}

- (enum ArgumentClassification)classifyArgumentAtIndex: (NSUInteger)idx
{
    const char *idType = @encode(id);
    const char *blockType = @encode(void (^)(void));
    const char *type = [_sig getArgumentTypeAtIndex: idx];
    if(strcmp(type, idType) == 0)
        return ArgumentObject;
    if(strcmp(type, blockType) == 0)
        return ArgumentBlock;
    return ArgumentNonObject;
}

void MAInvocationForwardC(struct RawArguments *r)
{
    id obj = (id)r->rdi;
    SEL sel = (SEL)r->rsi;
    
    NSMethodSignature *sig = [obj methodSignatureForSelector: sel];
    
    MAInvocation *inv = [[MAInvocation alloc] initWithMethodSignature: sig];
    inv->_raw.rdi = r->rdi;
    inv->_raw.rsi = r->rsi;
    inv->_raw.rdx = r->rdx;
    inv->_raw.rcx = r->rcx;
    inv->_raw.r8 = r->r8;
    inv->_raw.r9 = r->r9;
    
    memcpy(inv->_raw.stackArgs, r->stackArgs, inv->_raw.stackArgsCount * sizeof(uint64_t));
    
    inv->_raw.isStretCall = r->isStretCall;
    
    [obj forwardInvocation: (id)inv];
    
    r->rax_ret = inv->_raw.rax_ret;
    r->rdx_ret = inv->_raw.rdx_ret;
    
    [inv release];
}

void MAInvocationCall_disabled(struct RawArguments *r)
{
    void (*f)(uint64_t, uint64_t, uint64_t, uint64_t, uint64_t, uint64_t, uint64_t, uint64_t, uint64_t) = r->fptr;
    f(r->rdi, r->rsi, r->rdx, r->rcx, r->r8, r->r9, r->stackArgs[0], r->stackArgs[1], r->stackArgs[2]);
    uint64_t stackArgs[r->stackArgsCount];
    for(uint64_t i = 0; i < r->stackArgsCount; i++)
        stackArgs[i] = r->stackArgs[i];
    r->fptr = stackArgs;
}

@end
