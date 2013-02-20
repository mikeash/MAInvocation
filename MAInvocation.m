#import "MAInvocation.h"

@implementation MAInvocation

+ (NSInvocation *)invocationWithMethodSignature: (NSMethodSignature *)sig
{
    return [[[self alloc] initWithMethodSignature: sig] autorelease];
}

- (id)initWithMethodSignature: (NSMethodSignature *)sig
{
    if((self = [super init]))
    {
    }
    return self;
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
    return nil;
}

- (void)setTarget: (id)target
{
}

- (SEL)selector
{
    return NULL;
}

- (void)setSelector: (SEL)selector
{
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
}

- (void)invokeWithTarget: (id)target
{
}

@end
