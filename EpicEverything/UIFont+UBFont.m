//
//  UIFont+UBFont.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UIFont+UBFont.h"

@implementation UIFont (UBFont)

+ (UIFont *)ub_adventure {
    return [UIFont fontWithName:@"Adventure" size:[UIFont ub_scaleFontSize:75.0f]];
}

+ (UIFont *)ub_endTurn {
    return [UIFont fontWithName:@"Adventure" size:[UIFont ub_scaleFontSize:25.0f]];
}

+ (UIFont *)ub_blackCastle {
    return [UIFont fontWithName:@"BlackCastleMF" size:[UIFont ub_scaleFontSize:30.0f]];
}

+ (UIFont *)ub_blackCastleBigger {
    return [UIFont fontWithName:@"BlackCastleMF" size:[UIFont ub_scaleFontSize:32.0f]];
}

+ (UIFont *)ub_uchiyama {
    return [UIFont fontWithName:@"uchiyama" size:[UIFont ub_scaleFontSize:30.0f]];
}

+ (UIFont *)ub_uchiyamaMedium {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return [UIFont fontWithName:@"uchiyama" size:[UIFont ub_scaleFontSize:30.0f]];
    }
    else{
        return [UIFont fontWithName:@"uchiyama" size:[UIFont ub_scaleFontSize:26.0f]];
    }
}

+ (UIFont *)ub_creditsTitle {
    return [UIFont fontWithName:@"Adventure" size:[UIFont ub_scaleFontSize:50.0f]];
}

+ (UIFont *)ub_creditsParagraph {
    return [UIFont fontWithName:@"Lato-Black" size:[UIFont ub_scaleFontSize:16.0f]];
}

+ (float)ub_scaleFontSize:(float)size{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return size * 1.5;
    }
    else{
        return size;
    }
}

@end
