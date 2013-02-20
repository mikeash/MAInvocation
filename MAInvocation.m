#import "MAInvocation.h"

@implementation MAInvocation {
    NSMethodSignature *_sig;
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
    }
    return self;
}

- (void)dealloc
{
    [_sig release];
    
    [super dealloc];
}

- (NSMethodSignature *)methodSignature
{
    return nil;
}

- (void)retainArguments
{
}

- (BOOL)argumentsRetained
{
    return YES;
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
}

- (void)setReturnValue: (void *)retLoc
{
}

- (void)getArgument: (void *)argumentLocation atIndex: (NSInteger)idx
{
}

- (void)setArgument: (void *)argumentLocation atIndex: (NSInteger)idx
{
}

- (void)invoke
{
    [self invokeWithTarget: [self target]];
}

- (void)invokeWithTarget: (id)target
{
}

@end
