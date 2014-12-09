//
//  UIView+UBExtensions.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UIView+UBExtensions.h"

@implementation UIView (UBExtensions)

- (instancetype)ub_addToSuperview:(UIView *)view {
    [view addSubview:self];
    return self;
}

- (instancetype)ub_addToBackOfSuperview:(UIView *)view {
    [view addSubview:self];
    [view sendSubviewToBack:self];
    return self;
}

+ (CGFloat)ub_widthScaled:(CGFloat)width{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return width * 1.8;
    }
    else{
        return width;
    }
}

+ (CGFloat)ub_heightScaled:(CGFloat)height{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return height * 1.8;
    }
    else{
        return height;
    }
}

+ (CGFloat)ub_widthSpacingScaled:(CGFloat)width{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return width * 1.8;
    }
    else{
        return width;
    }
}

+ (CGFloat)ub_heightSpacingScaled:(CGFloat)height{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return height * 1.8;
    }
    else{
        return height;
    }
}



#pragma mark - Menu View

+ (NSNumber *)ub_buttonHeight {
    return @([UIView ub_heightScaled:50.0]);
}

+ (NSNumber *)ub_buttonWidth {
    return @([UIView ub_widthScaled:320]);
}

+ (NSNumber *)ub_shortButtonWidth {
    return @([UIView ub_widthScaled:100]);
}

+ (NSNumber *)ub_padding {
    return @([UIView ub_heightSpacingScaled:15]);
}

+ (NSNumber *)ub_titlePadding {
     return @([UIView ub_heightSpacingScaled:20]);
}


+ (CGFloat)ub_borderWidth {
    return [UIView ub_widthSpacingScaled:2.0f];
}

+ (CGFloat)ub_borderRadius {
    return [UIView ub_widthSpacingScaled:6.0f];
}

#pragma mark - Credits View

+ (NSNumber *)ub_creditsParagraphPadding {
    return @90;
}

#pragma mark - Game View

+ (NSNumber *)ub_cardHeight {
    return @([UIView ub_heightScaled:120.6]);
}

+ (NSNumber *)ub_cardWidth {
    return @([UIView ub_widthScaled:75]);
}

+ (NSNumber *)ub_opponentCardHeight {
    return @([UIView ub_widthScaled:108.3]);
}

+ (NSNumber *)ub_opponentCardWidth {
    return @([UIView ub_widthScaled:70]);
}

+ (NSNumber *)ub_selectedCardWidth {
    return @([UIView ub_widthScaled:116]);
}

+ (NSNumber *)ub_selectedCardHeight {
    return @([UIView ub_widthScaled:186.5]);
}

+ (NSNumber *)ub_spaceHeight {
    return @([UIView ub_heightScaled:100]);
}

+ (NSNumber *)ub_spaceWidth {
    return @([UIView ub_widthScaled:100]);
}

+ (NSNumber *)ub_iconWidth {
    return @([UIView ub_widthScaled:45]);
}

+ (NSNumber *)ub_statusIconWidth {
    return @([UIView ub_widthScaled:20]);
}

+ (NSNumber *)ub_selectedStatusIconWidth {
    return @([UIView ub_widthScaled:22]);
}

+ (NSNumber *)ub_smallerStatusIconWidth {
    return @([UIView ub_widthScaled:14]);
}

+ (NSNumber *)ub_swordsWidth {
    return @([UIView ub_widthScaled:36]);
}









@end
