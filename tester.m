// clang -framework Foundation -g -W -Wall -Wno-unused-parameter MAInvocation.m tester.m

#import "MAInvocation.h"

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

@interface TestClass : NSObject {
    @public
    NSMutableArray *_calledSelectors;
    NSMutableArray *_calledArguments;
}

@end

@implementation TestClass

- (id)init
{
    if((self = [super init]))
    {
        _calledSelectors = [[NSMutableArray alloc] init];
        _calledArguments = [[NSMutableArray alloc] init];
    }
    return self;
}

#define RECORD(...) [self addCall: _cmd args: @[ __VA_ARGS__ ]]

- (void)addCall: (SEL)sel args: (NSArray *)args
{
    [_calledSelectors addObject: NSStringFromSelector(sel)];
    [_calledArguments addObject: args];
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

- (void)objArgs: a : b : c : d : e : f : g : h : i : j
{
    RECORD(a, b, c, d, e, f, g, h, i, j);
}

- (void)objArg: a
{
    RECORD(a);
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
    ASSERT([obj->_calledSelectors isEqual: @[ @"empty" ]], obj->_calledSelectors);
    ASSERT([obj->_calledArguments isEqual: @[ @[] ]], obj->_calledArguments);
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
    ASSERT([obj->_calledSelectors isEqual: @[ @"intArg:" ]], obj->_calledSelectors);
    ASSERT([obj->_calledArguments isEqual: @[ @[ @42 ] ]], obj->_calledArguments);
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
    ASSERT([obj->_calledSelectors isEqual: @[ @"lotsOfIntArgs::::::::::" ]], obj->_calledSelectors);
    ASSERT([obj->_calledArguments isEqual: (@[ @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ] ])], obj->_calledArguments);
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
    ASSERT([obj->_calledSelectors isEqual: @[ @"returnInt" ]], obj->_calledSelectors);
    ASSERT([obj->_calledArguments isEqual: @[ @[] ]], obj->_calledArguments);
    
    int val;
    [inv getReturnValue: &val];
    ASSERT(val == 42, @(val));
    
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
    ASSERT([obj->_calledSelectors isEqual: @[ @"objArgs::::::::::" ]], obj->_calledSelectors);
    ASSERT([obj->_calledArguments isEqual: (@[ @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ] ])], obj->_calledArguments);
    [obj release];
}

static void RetainArguments(void)
{
    TestClass *obj = [[TestClass alloc] init];
    TestClass *obj2 = [[TestClass alloc] init];
    SEL sel = @selector(objArg:);
    MAInvocation *inv = [MAInvocation invocationWithMethodSignature: [obj methodSignatureForSelector: sel]];
    [inv setTarget: obj];
    [inv setSelector: sel];
    [inv setArgument: &obj2 atIndex: 2];
    [inv retainArguments];
    
    ASSERT([obj2->_calledSelectors isEqual: @[ @"retain" ]], obj2->_calledSelectors);
    [obj release];
    [obj2 release];
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

int main(int argc, char **argv)
{
    TEST(Simple);
    TEST(Argument);
    TEST(LotsOfArguments);
    TEST(ReturnValue);
    TEST(ObjectArguments);
    TEST(RetainArguments);
    TEST(ObjectReturn);
}
