//
//  UIImage+UBImage.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UIImage+UBImage.h"

@implementation UIImage (UBImage)

+ (UIImage *)ub_menuBackground {
    return [UIImage imageNamed:@"menu-bg.jpg"];
}

+ (UIImage *)ub_gameBackground {
    return [UIImage imageNamed:@"board-bg.jpg"];
}

+ (UIImage *)ub_cardBack {
    return [UIImage imageNamed:@"card-back.jpg"];
}

+ (UIImage *)ub_cards {
    return [UIImage imageNamed:@"cards.jpg"];
}

+ (UIImage *)ub_hp {
    return [UIImage imageNamed:@"hp.png"];
}

+ (UIImage *)ub_mana {
    return [UIImage imageNamed:@"mana.png"];
}

+ (UIImage *)ub_space {
    return [UIImage imageNamed:@"space.png"];
}

@end
