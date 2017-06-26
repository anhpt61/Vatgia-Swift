//
//  PITDelegateProxy.h
//  vatgia
//
//  Created by Pham Duc Giam on 02/11/15.
//  Copyright © 2015 maGicuD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PITDelegateProxy : NSProxy

@property (nonatomic, weak) id originalDelegate;

- (instancetype)initWithMiddleMan:(id)middleMan;

@end
