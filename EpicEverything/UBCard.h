//
//  EECard.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//


#import <Foundation/Foundation.h>

@class UBPlayer;
@class UBGame;

@interface UBCard : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSData* picture;
@property (nonatomic) UBPlayer* owner;
@property (nonatomic) UBGame* game;
@property (nonatomic) int manaCost;


- (id)initFromHash:(NSDictionary*)data;

@end