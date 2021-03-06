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
#import "NSString+UBString.h"
#import <Masonry/Masonry.h>

@interface UIView (UBExtensions)

- (instancetype)ub_addToSuperview:(UIView *)view;
- (instancetype)ub_addToBackOfSuperview:(UIView *)view;

#pragma mark - Menu View

+ (NSNumber *)ub_buttonHeight;
+ (NSNumber *)ub_buttonWidth;
+ (NSNumber *)ub_padding;
+ (NSNumber *)ub_titlePadding;
+ (CGFloat)ub_borderWidth;
+ (CGFloat)ub_borderRadius;

#pragma mark - Credit View
+ (NSNumber *)ub_creditsParagraphPadding;

@end
