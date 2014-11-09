//
//  UBCreature.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBCard.h"

@class UBSpace;


@interface UBCreature : UBCard

@property (nonatomic) int baseAttack;
@property (nonatomic) int hitPoints;
@property (nonatomic) int mobility;
@property (nonatomic) int turnsInPlay;

@property (nonatomic) BOOL hasBlock;
@property (nonatomic) BOOL hasHaste;
@property (nonatomic) BOOL hasRange;
@property (nonatomic) BOOL isDead;
@property (nonatomic) UBSpace* position;
@property (nonatomic) NSMutableArray* statusEffects;

- (id)initFromHash:(NSDictionary*)data;

- (BOOL) canAttackCreature: (UBCreature*)target;

- (int) getTotalAttack;




@end