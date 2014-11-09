//
//  UBCard.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBCard.h"

@implementation UBCard : NSObject


- (id)initFromHash:(NSDictionary*)data{
    self = [super init];
    _name = data[@"name"];
    _manaCost = (int)data[@"manaCost"];
    _iconImageView = [[UIButton alloc] init];
    [self.iconImageView setImage:[UIImage imageNamed: [self.name stringByAppendingString:@".png"]] forState: UIControlStateNormal];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _cardImageView = [[UIButton alloc] init];
    [self.cardImageView setImage:[UIImage imageNamed: [self.name stringByAppendingString:@"-card.png"]] forState: UIControlStateNormal];
    self.cardImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backImageView = [[UIImageView alloc] init];
    [self.backImageView setImage:[UIImage imageNamed: @"card-back.png"]];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    return self;
}

@end
