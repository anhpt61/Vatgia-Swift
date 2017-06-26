//
//  UIView+UIViewController_InteractiveTransition.m
//  vatgiatest
//
//  Created by Pham Duc Giam on 31/10/15.
//  Copyright © 2015 maGicuD. All rights reserved.
//

#import "UIViewController+InteractiveTransition.h"
#import <objc/runtime.h>

static char interactiveTransitionKey;

@implementation UIViewController (InteractiveTransition)

#pragma mark - constructor

#pragma mark - destructor

#pragma mark - public class methods

#pragma mark - private class methods

#pragma mark - override/overload

#pragma mark - public instance methods

- (void)presentFromViewController:(UIViewController *)presetingViewController
           withInteractiveEnabled:(BOOL)interactiveEnabed
{
    [self.interactiveTransition presentViewController:self
                                   fromViewController:presetingViewController
                               withInteractiveEnabled:interactiveEnabed];
}

#pragma mark - private instance methods

#pragma mark - public get/set methods

- (void)setInteractiveTransition:(PresentInteractiveTransition *)interactiveTransition
{
    objc_setAssociatedObject(self, &interactiveTransitionKey, interactiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PresentInteractiveTransition *)interactiveTransition
{
    id interactiveTransition = objc_getAssociatedObject(self, &interactiveTransitionKey);
    if (!interactiveTransition)
    {
        interactiveTransition = [[PresentInteractiveTransition alloc] init];
        self.interactiveTransition = interactiveTransition;
    }
    
    return interactiveTransition;
}

#pragma mark - private get/set methods

#pragma mark - public action methods

#pragma mark - private action methods

#pragma mark - delegate methods

@end
