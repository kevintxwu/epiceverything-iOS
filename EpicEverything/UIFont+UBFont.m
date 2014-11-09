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
    return [UIFont fontWithName:@"Adventure" size:75.0f];
}

+ (UIFont *)ub_endTurn {
    return [UIFont fontWithName:@"Adventure" size:25.0f];
}

+ (UIFont *)ub_blackCastle {
    return [UIFont fontWithName:@"BlackCastleMF" size:30.0f];
}

+ (UIFont *)ub_uchiyama {
    return [UIFont fontWithName:@"uchiyama" size:30.0f];
}

+ (UIFont *)ub_creditsTitle {
    return [UIFont fontWithName:@"Adventure" size:50.0f];
}

+ (UIFont *)ub_creditsParagraph {
    return [UIFont fontWithName:@"Lato-Black" size:16.0f];
}

@end
