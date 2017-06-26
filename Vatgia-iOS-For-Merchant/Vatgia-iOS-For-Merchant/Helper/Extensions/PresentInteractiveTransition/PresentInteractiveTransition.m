//
//  TransitionAnimator.m
//  Presentation
//
//  Created by Pham Duc Giam on 19/12/14.
//  Copyright (c) 2014 Pham Duc Giam. All rights reserved.
//

#import "PresentInteractiveTransition.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "PITDelegateProxy.h"

static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@interface PresentInteractiveTransition () <UIGestureRecognizerDelegate, UIScrollViewDelegate, UIViewControllerTransitioningDelegate>
{
    BOOL _dismissFromTop;
    BOOL _dismissing;
    BOOL _interactiveEnabled;
    CGFloat _accumulativeContentOffsetY;
    __weak UIView *_backgroundView;
}

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) PITDelegateProxy *delegateProxy;

@end

@implementation PresentInteractiveTransition

@synthesize interactionInProgress = _interactionInProgress;
@synthesize panGestureRecognizer = _panGestureRecognizer;

#pragma mark - constructor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _presenting = NO;
        _interactionInProgress = NO;
        _dismissFromTop = YES;
        _dismissing = NO;
        
        self.delegateProxy = [[PITDelegateProxy alloc] initWithMiddleMan:self];
    }
    return self;
}

#pragma mark - destructor

- (void)dealloc
{
    // sanity check
    if (_scrollView.delegate == _delegateProxy)
    {
        _scrollView.delegate = _delegateProxy.originalDelegate;
    }
}

#pragma mark - public class methods

#pragma mark - private class methods

#pragma mark - override/overload

#pragma mark - public instance methods

- (void)presentViewController:(UIViewController *)presetedViewController
           fromViewController:(UIViewController *)presetingViewController
       withInteractiveEnabled:(BOOL)interactiveEnabled
{
    if (!presetedViewController
        || !presetingViewController) {
        return;
    }
    _presentedViewController = presetedViewController;
    _presentingViewController = presetingViewController;
    _interactiveEnabled = interactiveEnabled;
    
    _presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    _presentedViewController.modalPresentationCapturesStatusBarAppearance = YES;
    _presentedViewController.transitioningDelegate = self;
    
    // create pan gesture before adding it to presented view controller's root view because it may set scroll view inside viewDidLoad of preseted view controller
    UIPanGestureRecognizer *panGestureRecognizer = self.panGestureRecognizer;
    if (![_presentedViewController.view.gestureRecognizers containsObject:panGestureRecognizer]) {
        [_presentedViewController.view addGestureRecognizer:panGestureRecognizer];
    }
    
    [presetingViewController
     presentViewController:presetedViewController
     animated:YES
     completion:^{
     }];
}

- (void)dismiss
{
    if (!_presentingViewController
        || !_presentedViewController) {
        return;
    }
    
    [_presentingViewController dismissViewControllerAnimated:YES
                                                  completion:nil];
}

#pragma mark - private instance methods

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    /*_backgroundView.backgroundColor = [UIColor colorWithWhite:0
                                                        alpha:0.75f*percentComplete];*/
    [super updateInteractiveTransition:percentComplete];
}

#pragma mark - public get/set methods

- (void)setScrollView:(UIScrollView *)scrollView
{
    if (!scrollView) {
        return;
    }
    
    if (_presentedViewController
        && _panGestureRecognizer
        && [_presentedViewController.view.gestureRecognizers containsObject:_panGestureRecognizer]) {
        [_presentedViewController.view removeGestureRecognizer:_panGestureRecognizer];
    }

    if (_scrollView.delegate == self.delegateProxy)
    {
        _scrollView.delegate = self.delegateProxy.originalDelegate;
    }
    
    _scrollView = scrollView;
    
    if (_scrollView.delegate != self.delegateProxy)
    {
        self.delegateProxy.originalDelegate = _scrollView.delegate;
        _scrollView.delegate = (id)self.delegateProxy;
    }
}

#pragma mark - private get/set methods

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer
        = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(panHandle:)];
        _panGestureRecognizer.delegate = self;
    }
    return _panGestureRecognizer;
}

#pragma mark - public action methods

#pragma mark - private action methods

- (void)panHandle:(UIPanGestureRecognizer *)sender
{
    UIView *view = sender.view;
    CGPoint velocity = [sender velocityInView:view];
    CGPoint translation = [sender translationInView:view];
    CGFloat percentage  = fabs(translation.y / CGRectGetHeight(view.bounds));
    if (sender.state == UIGestureRecognizerStateBegan) {
        _interactionInProgress = YES;
        _dismissFromTop = (velocity.y > 0);
        [self.presentedViewController dismissViewControllerAnimated:YES
                                                         completion:nil];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self updateInteractiveTransition:percentage];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        _interactionInProgress = NO;
        _dismissFromTop = YES;
        if(percentage < 0.4) {
            [self cancelInteractiveTransition];
        } else {
            [self finishInteractiveTransition];
        }
    }
    else if (sender.state == UIGestureRecognizerStateCancelled) {
        [self cancelInteractiveTransition];
        _interactionInProgress = NO;
        _dismissFromTop = YES;
    }
}

#pragma mark - delegate methods

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.presenting) {
        CGRect frame = [transitionContext initialFrameForViewController:fromVC];
        
        CGRect endFrame = frame;
        
        fromVC.view.userInteractionEnabled = NO;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
        backgroundView.backgroundColor = [UIColor colorWithWhite:0
                                                          alpha:0.5f];
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [containerView addSubview:backgroundView];
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
        [containerView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        
        [backgroundView addSubview:toVC.view];
        _backgroundView = backgroundView;
        
        CGRect startFrame = endFrame;
        startFrame.origin.y = frame.size.height;
        
        toVC.view.frame = startFrame;
        
        double duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             toVC.view.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
    else
    {
        toVC.view.userInteractionEnabled = YES;
        
        CGRect frame = [transitionContext initialFrameForViewController:fromVC];
        CGRect endFrame = frame;
        if (_dismissFromTop) {
            endFrame.origin.y = frame.size.height;
        }
        else {
            endFrame.origin.y = -frame.size.height;
        }
        
        double duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             fromVC.view.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             if ([transitionContext transitionWasCancelled]) {
                                 fromVC.view.frame = frame;
                             }
                             else {
                                 [fromVC.view removeFromSuperview];
                             }
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _panGestureRecognizer) {
        if (_scrollView
            && !_interactionInProgress) {
            return NO;
        }
        CGPoint translation = [_panGestureRecognizer translationInView:_panGestureRecognizer.view];
        return fabs(translation.y) > fabs(translation.x);
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.decelerating) {
        return;
    }
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat bottomContentOffsetY = scrollView.contentSize.height - scrollView.bounds.size.height;
    if (bottomContentOffsetY < 0) {
        bottomContentOffsetY = 0;
    }
    if (contentOffset.y < 0.0f
        || contentOffset.y > bottomContentOffsetY) {
        if (!_interactionInProgress) {
            _interactionInProgress = YES;
            _dismissFromTop = contentOffset.y < 0;
            _accumulativeContentOffsetY = 0;
            [self.presentedViewController dismissViewControllerAnimated:YES
                                                             completion:nil];
        }
    }
    
    if (_interactionInProgress) {
        if (_dismissFromTop) {
            _accumulativeContentOffsetY += contentOffset.y;
        }
        else {
            _accumulativeContentOffsetY += contentOffset.y - bottomContentOffsetY;
        }
        CGFloat percentage  = fabs(_accumulativeContentOffsetY / CGRectGetHeight(scrollView.bounds));
        [self updateInteractiveTransition:percentage];
        if (_dismissFromTop) {
            [scrollView setContentOffset:CGPointZero
                                animated:NO];
        }
        else {
            [scrollView setContentOffset:CGPointMake(contentOffset.x, bottomContentOffsetY)
                                animated:NO];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
 
    CGPoint velocity = [scrollView.panGestureRecognizer velocityInView:scrollView];
    if (_interactionInProgress) {
        _interactionInProgress = NO;
     
        if (decelerate) {
            if ((_dismissFromTop && ((velocity.y < 1200 && velocity.y > 0) || velocity.y < 0))
                || (!_dismissFromTop && ((velocity.y > -1200 && velocity.y < 0) || velocity.y > 0))) {
                [self cancelInteractiveTransition];
            }
            else {
                [self finishInteractiveTransition];
            }
        }
        else {
            CGFloat percentage;
            if (_dismissFromTop) {
                percentage = scrollView.contentOffset.y / scrollView.bounds.size.height;
            }
            else {
                percentage = 1.0f - (scrollView.contentOffset.y + scrollView.bounds.size.height) / scrollView.contentSize.height;
            }
            if (percentage < 0.4) {
                if ((_dismissFromTop && ((velocity.y < 1200 && velocity.y > 0) || velocity.y < 0))
                    || (!_dismissFromTop && ((velocity.y > -1200 && velocity.y < 0) || velocity.y > 0))) {
                    [self cancelInteractiveTransition];
                }
                else {
                    [self finishInteractiveTransition];
                }
            } else {
                [self finishInteractiveTransition];
            }
        }
        _dismissFromTop = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
    CGPoint velocity = [scrollView.panGestureRecognizer velocityInView:scrollView];
    CGFloat percentage;
    if (_dismissFromTop) {
        percentage = scrollView.contentOffset.y / scrollView.bounds.size.height;
    }
    else {
        percentage = 1.0f - (scrollView.contentOffset.y + scrollView.bounds.size.height) / scrollView.contentSize.height;
    }
    /*if (_interactionInProgress) {
        _interactionInProgress = NO;
        //_dismissFromTop = YES;
        //CGFloat percentage  = fabs(_accumulativeContentOffsetY / CGRectGetHeight(scrollView.bounds));
        if(percentage < 0.4) {
            [self cancelInteractiveTransition];
        } else {
            [self finishInteractiveTransition];
        }
    }*/
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    presented.modalPresentationStyle = UIModalPresentationCustom;
    presented.modalPresentationCapturesStatusBarAppearance = YES;
    _presenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _presenting = NO;
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _interactiveEnabled && _interactionInProgress ? self : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _interactiveEnabled && _interactionInProgress ? self : nil;
}

@end
