//
//  UIView+Image.m
//  vatgia
//
//  Created by Pham Duc Giam on 03/03/16.
//  Copyright © 2016 maGicuD. All rights reserved.
//

#import "UIView+Image.h"

@implementation UIView (Image)

#pragma mark - constructor

#pragma mark - destructor

#pragma mark - public class methods

#pragma mark - private class methods

#pragma mark - override/overload

#pragma mark - public instance methods

- (UIImage *)image_capture
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - private instance methods

#pragma mark - public get/set methods

#pragma mark - private get/set methods

#pragma mark - public action methods

#pragma mark - private action methods

#pragma mark - delegate methods

@end
