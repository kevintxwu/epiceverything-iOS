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
+ (CGFloat)ub_heightScaled:(CGFloat)height;
+ (CGFloat)ub_widthScaled:(CGFloat)width;

+ (CGFloat)ub_heightSpacingScaled:(CGFloat)height;
+ (CGFloat)ub_widthSpacingScaled:(CGFloat)width;

#pragma mark - Menu View

+ (NSNumber *)ub_buttonHeight;
+ (NSNumber *)ub_buttonWidth;
+ (NSNumber *)ub_padding;
+ (NSNumber *)ub_titlePadding;
+ (CGFloat)ub_borderWidth;
+ (CGFloat)ub_borderRadius;
+ (NSNumber *)ub_shortButtonWidth;

#pragma mark - Credit View
+ (NSNumber *)ub_creditsParagraphPadding;

#pragma mark - Game View

+ (NSNumber *)ub_cardHeight;

+ (NSNumber *)ub_cardWidth;

+ (NSNumber *)ub_spaceHeight;

+ (NSNumber *)ub_spaceWidth;

+ (NSNumber *)ub_swordsWidth;

+ (NSNumber *)ub_iconWidth;

+ (NSNumber *)ub_statusIconWidth;

+ (NSNumber *)ub_opponentCardWidth;

+ (NSNumber *)ub_opponentCardHeight;

+ (NSNumber *)ub_selectedCardWidth;

+ (NSNumber *)ub_selectedCardHeight;

+ (NSNumber *)ub_smallerStatusIconWidth;

+ (NSNumber *)ub_selectedStatusIconWidth;

@end
