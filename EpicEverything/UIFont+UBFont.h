//
//  UIFont+UBFont.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (UBFont)

+ (UIFont *)ub_adventure;
+ (UIFont *)ub_endTurn;
+ (UIFont *)ub_blackCastle;
+ (UIFont *)ub_blackCastleBigger;
+ (UIFont *)ub_uchiyama;
+ (UIFont *)ub_uchiyamaMedium;

+ (float)ub_scaleFontSize:(float)size;

// Credits
+ (UIFont *)ub_creditsTitle;
+ (UIFont *)ub_creditsParagraph;

@end
