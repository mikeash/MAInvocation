#import "MAInvocation.h"

@implementation MAInvocation

+ (NSInvocation *)invocationWithMethodSignature: (NSMethodSignature *)sig
{
    return [super invocationWithMethodSignature: sig];
}

@end
