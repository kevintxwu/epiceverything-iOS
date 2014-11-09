//
//  UBCreature.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBCard.h"
#import "UBSpace.h"

@class UBSpace;


@interface UBCreature : UBCard

@property (nonatomic) int baseAttack;
@property (nonatomic) int hitPoints;
@property (nonatomic) int totalHitPoints;
@property (nonatomic) int mobility;
@property (nonatomic) int turnsInPlay;  //Set to -1 if not in play

@property (nonatomic) BOOL hasBlock;
@property (nonatomic) BOOL hasSpeed;
@property (nonatomic) BOOL hasRange;
@property (nonatomic) BOOL isDead;
@property (nonatomic) BOOL attackedThisTurn;
@property (nonatomic) UBSpace* space;
@property (nonatomic) NSMutableArray* statusEffects;



- (id)initFromHash:(NSDictionary*)data;

- (BOOL) canAttackSpace: (UBSpace*)target;

- (void) attackSpace: (UBSpace*)target;

- (void) removeFromPlay;

- (int) getTotalAttack;

- (void) playOnSpace:(UBSpace*)space;




@end