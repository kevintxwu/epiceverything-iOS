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


#pragma mark - Menu View

+ (NSNumber *)ub_buttonHeight {
    return @40;
}

+ (NSNumber *)ub_buttonWidth {
    return @200;
}

+ (NSNumber *)ub_padding {
    return @10;
}

+ (CGFloat)ub_borderWidth {
    return 2.0f;
}

+ (CGFloat)ub_borderRadius {
    return 6.0f;
}

@end
