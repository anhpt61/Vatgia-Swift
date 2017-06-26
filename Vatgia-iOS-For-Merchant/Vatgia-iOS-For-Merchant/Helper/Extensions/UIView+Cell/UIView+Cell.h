//
//  UICollectionViewCell+BNC.h
//  webbnc
//
//  Created by Pham Duc Giam on 08/12/14.
//  Copyright (c) 2014 BNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Cell)

/**
 return nib that contains cell for each devices (iphone/ipad)
 */
+ (UINib *)cell_nib;

/**
 return identifier of cell
 */
+ (NSString *)cell_identifier;

@end
