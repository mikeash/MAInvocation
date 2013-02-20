// clang -framework Foundation MAInvocation.m tester.m

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

#define RECORD(...) [self addCall: _cmd args: @[ __VA_ARGS__ ]]

- (void)addCall: (SEL)sel args: (NSArray *)args
{
    if(!_calledSelectors)
        _calledSelectors = [[NSMutableArray alloc] init];
    if(!_calledArguments)
        _calledArguments = [[NSMutableArray alloc] init];
    
    [_calledSelectors addObject: NSStringFromSelector(sel)];
    [_calledArguments addObject: args];
}

- (void)empty
{
    RECORD();
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
}

int main(int argc, char **argv)
{
    TEST(Simple);
}
