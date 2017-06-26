//
//  TransitionAnimator.h
//  Presentation
//
//  Created by Pham Duc Giam on 19/12/14.
//  Copyright (c) 2014 Pham Duc Giam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentInteractiveTransition : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, weak) UIViewController *presentedViewController;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) BOOL presenting;
@property (nonatomic, readonly) BOOL interactionInProgress;

- (void)presentViewController:(UIViewController *)presetedViewController
           fromViewController:(UIViewController *)presetingViewController
       withInteractiveEnabled:(BOOL)interactiveEnabled;

- (void)dismiss;

@end
