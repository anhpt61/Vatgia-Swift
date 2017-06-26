//
//  PITDelegateProxy.m
//  vatgia
//
//  Created by Pham Duc Giam on 02/11/15.
//  Copyright © 2015 maGicuD. All rights reserved.
//

#import "PITDelegateProxy.h"

@interface PITDelegateProxy ()

@property (nonatomic, weak) id middleMan;

@end

@implementation PITDelegateProxy

- (instancetype)initWithMiddleMan:(id)middleMan
{
    if (self)
    {
        self.middleMan = middleMan;
    }
    return self;
}

- (NSInvocation *)_copyInvocation:(NSInvocation *)invocation
{
    NSInvocation *copy = [NSInvocation invocationWithMethodSignature:[invocation methodSignature]];
    NSUInteger argCount = [[invocation methodSignature] numberOfArguments];
    
    for (int i = 0; i < argCount; i++)
    {
        char buffer[sizeof(intmax_t)];
        [invocation getArgument:(void *)&buffer atIndex:i];
        [copy setArgument:(void *)&buffer atIndex:i];
    }
    
    return copy;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self.middleMan respondsToSelector:invocation.selector])
    {
        NSInvocation *invocationCopy = [self _copyInvocation:invocation];
        [invocationCopy invokeWithTarget:self.middleMan];
    }
    
    if ([self.originalDelegate respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:self.originalDelegate];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    id result = [self.originalDelegate methodSignatureForSelector:sel];
    if (!result) {
        result = [self.middleMan methodSignatureForSelector:sel];
    }
    
    return result;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return ([self.originalDelegate respondsToSelector:aSelector]
            || [self.middleMan respondsToSelector:aSelector]);
}

@end
