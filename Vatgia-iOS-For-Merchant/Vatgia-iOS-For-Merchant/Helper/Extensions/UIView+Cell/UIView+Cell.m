//
//  UICollectionViewCell+BNC.m
//  webbnc
//
//  Created by Pham Duc Giam on 08/12/14.
//  Copyright (c) 2014 BNC. All rights reserved.
//

#import "UIView+Cell.h"

@implementation UIView (Cell)

#pragma mark - constructor

#pragma mark - destructor

#pragma mark - public class methods

+ (UINib *)cell_nib
{
    NSString *nibNamed = NSStringFromClass(self);
    return [UINib nibWithNibName:nibNamed bundle:nil];
}

+ (NSString *)cell_identifier
{
    return @"cellIdentifier";
}

#pragma mark - private class methods

#pragma mark - override/overload

#pragma mark - public instance methods

#pragma mark - private instance methods

#pragma mark - public get/set methods

#pragma mark - private get/set methods

#pragma mark - public action methods

#pragma mark - private action methods

#pragma mark - delegate methods

@end
