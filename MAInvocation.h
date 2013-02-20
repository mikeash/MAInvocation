#import <Foundation/Foundation.h>

@interface MAInvocation : NSInvocation

+ (MAInvocation *)invocationWithMethodSignature:(NSMethodSignature *)sig;

@end
