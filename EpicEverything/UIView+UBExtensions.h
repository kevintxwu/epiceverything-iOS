//
//  UIView+UBExtensions.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+UBColors.h"
#import "UIImage+UBImage.h"
#import "UIFont+UBFont.h"
#import <Masonry/Masonry.h>

@interface UIView (UBExtensions)

- (instancetype)ub_addToSuperview:(UIView *)view;

#pragma mark - Menu View

+ (NSNumber *)ub_buttonHeight;
+ (NSNumber *)ub_buttonWidth;
+ (NSNumber *)ub_padding;

@end
