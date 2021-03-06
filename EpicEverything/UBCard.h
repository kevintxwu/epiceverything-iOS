//
//  UBCard.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class UBPlayer;
@class UBGame;

@interface UBCard : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSData* picture;
@property (nonatomic) UBPlayer* owner;
@property (nonatomic) UBGame* game;
@property (nonatomic) int manaCost;
@property (nonatomic, copy) UIButton* iconImageView;
@property (nonatomic, copy) UIButton* cardImageView;
@property (nonatomic, copy) UIImageView* backImageView;


- (id)initFromHash:(NSDictionary*)data;

@end