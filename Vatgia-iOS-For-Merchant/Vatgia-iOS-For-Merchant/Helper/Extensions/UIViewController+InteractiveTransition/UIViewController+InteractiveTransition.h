//
//  UIView+UIViewController_InteractiveTransition.h
//  vatgiatest
//
//  Created by Pham Duc Giam on 31/10/15.
//  Copyright © 2015 maGicuD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentInteractiveTransition.h"

@interface UIViewController (InteractiveTransition)

@property (nonatomic, strong) PresentInteractiveTransition *interactiveTransition;

- (void)presentFromViewController:(UIViewController *)presetingViewController
           withInteractiveEnabled:(BOOL)interactiveEnabed;
@end
