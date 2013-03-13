// clang -framework Foundation -g -W -Wall -Wno-unused-parameter MAInvocation.m MAInvocation-asm.s tester.m

#import "MAInvocation.h"

#import <objc/runtime.h>


static unsigned gFailureCount;

static void Test(const char *name, void (*f)(void))
{
    @autoreleasepool
    {
        gFailureCount = 0;
        fprintf(stderr, "Testing %s...\n", name);
        f();
        
        if(gFailureCount > 0)
            fprintf(stderr, "FAILED: %u failures\n", gFailureCount);
        else
            fprintf(stderr, "Success\n");
    }
}

static void Assert(const char *file, int line, const char *name, _Bool cond, NSArray *toLog)
{
    if(!cond)
    {
        gFailureCount++;
        const char *logString = "";
        if([toLog count] > 0)
        {
            NSMutableString *s = [NSMutableString string];
            for(id obj in toLog)
                [s appendFormat: @" %@", obj];
            logString = [s UTF8String];
        }
        fprintf(stderr, "%s: %d: assertion failed: %s%s\n", file, line, name, logString);
    }
}

#define TEST(f) Test(#f, f)
#define ASSERT(cond, ...) Assert(__FILE__, __LINE__, #cond, cond, @[ __VA_ARGS__ ])

#define ARG(type, index, invocation) ^{ type temp; [invocation getArgument: &temp atIndex: (index)]; return temp; }()

struct BigStruct { int a, b, c, d, e, f, g, h, i, j; };

@interface TestClass : NSObject {
    @public
    SEL _calledSelector;
    NSArray *_calledArguments;
}

- (struct BigStruct)dummyStret;

@end

@implementation TestClass

- (void)dealloc
{
    [_calledArguments release];
    
    [super dealloc];
}

#define RECORD(...) [self recordCall: _cmd args: @[ __VA_ARGS__ ]]

- (void)recordCall: (SEL)sel args: (NSArray *)args
{
    _calledSelector = sel;
    [args retain];
    [_calledArguments release];
    _calledArguments = args;
}

- (id)retain
{
    RECORD();
    return [super retain];
}

- (void)empty
{
    RECORD();
}

- (void)intArg: (int)x
{
    RECORD(@(x));
}

- (void)lotsOfIntArgs: (int)a : (int)b : (int)c : (int)d : (int)e : (int)f : (int)g : (int)h : (int)i : (int)j
{
    RECORD(@(a), @(b), @(c), @(d), @(e), @(f), @(g), @(h), @(i), @(j));
}

- (int)returnInt
{
    RECORD();
    return 42;
}

- (NSRange)returnNSRange
{
    RECORD();
    return NSMakeRange(1111, 2222);
}

- (void)objArgs: a : b : c : d : e : f : g : h : i : j
{
    RECORD(a, b, c, d, e, f, g, h, i, j);
}

- (void)objArg: a : b
{
    RECORD(a, b);
}

- (struct BigStruct)dummyStret
{
    return (struct BigStruct){ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
}

- (void)cString: (char *)param
{
}

- (struct BigStruct)stret: a : b : c : d
{
    RECORD(a, b, c, d);
    return (struct BigStruct){ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
}

@end


@interface GenericForwarder

+ (id)alloc;
- (void)free;
- (id)id;
- (void)setMethodSignature: (NSMethodSignature *)sig;
- (void)setInvocationHandler: (void (^)(MAInvocation *inv))handler;

@end

@implementation GenericForwarder
{
    Class isa;
    NSMethodSignature *_sig;
    void (^_invocationHandler)(MAInvocation *);
}

+ (id)alloc
{
    GenericForwarder *obj = calloc(1, class_getInstanceSize(self));
    obj->isa = self;
    return obj;
}

- (void)free
{
    [_sig release];
    [_invocationHandler release];
    free(self);
}

- (id)id
{
    return self;
}

- (void)setMethodSignature: (NSMethodSignature *)sig
{
    [sig retain];
    [_sig release];
    _sig = sig;
}

- (void)setInvocationHandler: (void (^)(MAInvocation *inv))handler
{
    handler = [handler copy];
    [_invocationHandler release];
    _invocationHandler = handler;
}

- (NSMethodSignature *)methodSignatureForSelector: (SEL)sel
{
    return _sig;
}

- (void)forwardInvocation: (MAInvocation *)inv
{
    _invocationHandler(inv);
}

@end


static void Simple(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(empty);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv invoke];
    ASSERT(obj->_calledSelector == @selector(empty), NSStringFromSelector(obj->_calledSelector));
    ASSERT([obj->_calledArguments isEqual: @[]], obj->_calledArguments);
    [obj release];
}

static void Argument(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(intArg:);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv setArgument: &(int){ 42 } atIndex: 2];
    [inv invoke];
    ASSERT(obj->_calledSelector == @selector(intArg:), NSStringFromSelector(obj->_calledSelector));
    ASSERT([obj->_calledArguments isEqual: @[ @42 ]], obj->_calledArguments);
    [obj release];
}

static void LotsOfArguments(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(lotsOfIntArgs::::::::::);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    for(int i = 0; i < 10; i++)
        [inv setArgument: &(int){ i } atIndex: i + 2];
    [inv invoke];
    ASSERT(obj->_calledSelector == @selector(lotsOfIntArgs::::::::::), NSStringFromSelector(obj->_calledSelector));
    ASSERT([obj->_calledArguments isEqual: (@[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ])], obj->_calledArguments);
    [obj release];
}

static void ReturnValue(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(returnInt);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv invoke];
    ASSERT(obj->_calledSelector == @selector(returnInt), NSStringFromSelector(obj->_calledSelector));
    ASSERT([obj->_calledArguments isEqual: @[]], obj->_calledArguments);
    
    int val;
    [inv getReturnValue: &val];
    ASSERT(val == 42, @(val));
    
    [obj release];
}

static void ReturnSmallStruct(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(returnNSRange);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv invoke];
    ASSERT(obj->_calledSelector == @selector(returnNSRange), NSStringFromSelector(obj->_calledSelector));
    ASSERT([obj->_calledArguments isEqual: @[]], obj->_calledArguments);
    
    NSRange r;
    [inv getReturnValue: &r];
    ASSERT(r.location == 1111, @(r.location));
    ASSERT(r.length == 2222, @(r.length));
    
    [obj release];
}

static void ObjectArguments(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(objArgs::::::::::);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    for(int i = 0; i < 10; i++)
        [inv setArgument: &(id){ @(i) } atIndex: i + 2];
    [inv invoke];
    ASSERT(obj->_calledSelector == @selector(objArgs::::::::::), NSStringFromSelector(obj->_calledSelector));
    ASSERT([obj->_calledArguments isEqual: (@[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ])], obj->_calledArguments);
    [obj release];
}

static void RetainArguments(void)
{
    TestClass *obj = [[TestClass alloc] init];
    TestClass *obj2 = [[TestClass alloc] init];
    TestClass *obj3 = [[TestClass alloc] init];
    SEL sel = @selector(objArg::);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv setArgument: &obj2 atIndex: 2];
    [inv retainArguments];
    [inv setArgument: &obj3 atIndex: 3];
    
    ASSERT(obj2->_calledSelector == @selector(retain), NSStringFromSelector(obj2->_calledSelector));
    ASSERT(obj3->_calledSelector == @selector(retain), NSStringFromSelector(obj3->_calledSelector));
    [obj release];
    [obj2 release];
    [obj3 release];
}

static void ObjectReturn(void)
{
    TestClass *obj = [[TestClass alloc] init];
    SEL sel = @selector(self);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv invoke];
    
    id retval;
    [inv getReturnValue: &retval];
    ASSERT(retval == obj, retval, obj);
    
    [obj release];
}

static void BasicForwarding(void)
{
    __block GenericForwarder *obj = [GenericForwarder alloc];
    [obj setMethodSignature: [NSObject instanceMethodSignatureForSelector: @selector(self)]];
    
    __block BOOL ran = NO;
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        ASSERT(ARG(id, 0, inv) == obj);
        ASSERT(ARG(SEL, 1, inv) == @selector(self));
        ran = YES;
    }];
    [[obj id] self];
    ASSERT(ran);
    [obj free];
}

static void ForwardingLotsOfArguments(void)
{
    __block GenericForwarder *obj = [GenericForwarder alloc];
    
    [obj setMethodSignature: [TestClass instanceMethodSignatureForSelector: @selector(objArgs::::::::::)]];
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        for(int i = 0; i < 10; i++)
            ASSERT([ARG(id, i + 2, inv) isEqual: @(i)]);
    }];
    [[obj id] objArgs: @0 : @1 : @2 : @3 : @4 : @5 : @6 : @7 : @8 : @9];
    
    [obj setMethodSignature: [TestClass instanceMethodSignatureForSelector: @selector(lotsOfIntArgs::::::::::)]];
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        for(int i = 0; i < 10; i++)
            ASSERT(ARG(int, i + 2, inv) == i);
    }];
    [[obj id] lotsOfIntArgs: 0 : 1 : 2 : 3 : 4 : 5 : 6 : 7 : 8 : 9];
    
    [obj free];
}

static void ForwardingReturn(void)
{
    __block GenericForwarder *obj = [GenericForwarder alloc];
    
    [obj setMethodSignature: [NSObject instanceMethodSignatureForSelector: @selector(self)]];
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        [inv setReturnValue: &obj];
    }];
    ASSERT([[obj id] self] == obj);
    
    [obj setMethodSignature: [NSString instanceMethodSignatureForSelector: @selector(stringByAppendingString:)]];
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        NSString *s = [@"Hello " stringByAppendingString: ARG(id, 2, inv)];
        [inv setReturnValue: &s];
    }];
    ASSERT([[[obj id] stringByAppendingString: @"world"] isEqual: @"Hello world"]);
    
    [obj free];
}

static void ForwardingReturnSmallStruct(void)
{
    __block GenericForwarder *obj = [GenericForwarder alloc];
    
    [obj setMethodSignature: [NSString instanceMethodSignatureForSelector: @selector(rangeOfString:)]];
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        NSRange r = { 42, 999 };
        [inv setReturnValue: &r];
    }];
    
    NSRange r = [[obj id] rangeOfString: nil];
    ASSERT(r.location == 42, @(r.location));
    ASSERT(r.length == 999, @(r.length));
    
    [obj free];
}

static void ForwardingReturnBigStruct(void)
{
    __block GenericForwarder *obj = [GenericForwarder alloc];
    
    [obj setMethodSignature: [TestClass instanceMethodSignatureForSelector: @selector(dummyStret)]];
    [obj setInvocationHandler: ^(MAInvocation *inv) {
        struct BigStruct r = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        [inv setReturnValue: &r];
    }];
    
    struct BigStruct s = [[obj id] dummyStret];
    for(int i = 0; i < 10; i++)
        ASSERT(((int *)&s)[i] == i);
    
    [obj free];
}

static void StretCall(void)
{
    TestClass *obj = [[TestClass alloc] init];
    
    SEL sel = @selector(dummyStret);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv invoke];
    
    struct BigStruct s;
    [inv getReturnValue: &s];
    
    for(int i = 0; i < 10; i++)
        ASSERT(((int *)&s)[i] == i);
    
    [obj release];
}

static void CStringCopying(void)
{
    TestClass *obj = [[TestClass alloc] init];
    
    SEL sel = @selector(cString:);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    
    char *str = "abcdefg";
    [inv setArgument: &str atIndex: 2];
    
    char *outStr;
    [inv getArgument: &outStr atIndex: 2];
    ASSERT(str == outStr);
    
    [inv retainArguments];
    [inv getArgument: &outStr atIndex: 2];
    ASSERT(str != outStr);
    ASSERT(strcmp(str, outStr) == 0);
    
    [inv setArgument: &str atIndex: 2];
    [inv getArgument: &outStr atIndex: 2];
    ASSERT(str != outStr);
    ASSERT(strcmp(str, outStr) == 0);
    
    [obj release];
}

static void StretWithSixArguments(void)
{
    TestClass *obj = [[TestClass alloc] init];
    
    SEL sel = @selector(stret::::);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    
    for(int i = 0; i < 4; i++)
    {
        id arg = @(i);
        [inv setArgument: &arg atIndex: i + 2];
    }
    
    [inv invoke];
    
    ASSERT([obj->_calledArguments isEqual: (@[ @0, @1, @2, @3 ])], obj->_calledArguments);
    
    struct BigStruct s;
    [inv getReturnValue: &s];
    for(int i = 0; i < 10; i++)
        ASSERT(((int *)&s)[i] == i);
    
    [obj release];
}

int main(int argc, char **argv)
{
    TEST(Simple);
    TEST(Argument);
    TEST(LotsOfArguments);
    TEST(ReturnValue);
    TEST(ReturnSmallStruct);
    TEST(ObjectArguments);
    TEST(RetainArguments);
    TEST(ObjectReturn);
    TEST(BasicForwarding);
    TEST(ForwardingLotsOfArguments);
    TEST(ForwardingReturn);
    TEST(ForwardingReturnSmallStruct);
    TEST(ForwardingReturnBigStruct);
    TEST(StretCall);
    TEST(CStringCopying);
    TEST(StretWithSixArguments);
}
