//
//  UBCreature.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBCreature.h"

@implementation UBCreature : UBCard


- (id)initFromHash:(NSDictionary*)data{
    self = [super initFromHash:data];
    
    _baseAttack = [data[@"attack"] integerValue];
    _totalHitPoints = [data[@"hitPoints"] integerValue];
    _mobility = [data[@"mobility"] integerValue];
    _turnsInPlay = -1;
    _isDead = NO;
    
    _hasBlock = (BOOL)data[@"block"];
    _hasSpeed = (BOOL)data[@"haste"];
    _hasRange = (BOOL)data[@"range"];
    return self;
}
    
- (void) playOnSpace:(UBSpace*)space{
    self.space = space;
    self.space.creature = self;
    self.turnsInPlay = 0;
    self.hitPoints = self.totalHitPoints;
}

- (BOOL) canAttackSpace: (UBSpace*)target{
    if(!(self.hasSpeed || self.turnsInPlay > 0) || self.attackedThisTurn)
        return NO;
    else if([[self enemiesInRangeWithBlock] count] != 0){
        if(!target.occupied || !target.creature.hasBlock){
            return NO;
        }
        else{
            return YES;
        }
    }
    else if(self.hasRange || abs(target.position - self.space.position) <= 2){
        return YES;
    }
    return NO;
       
}

- (void) attackSpace: (UBSpace*)target{
    NSAssert([self canAttackSpace:target], @"Must be able to attack space!");
    NSLog(@"%@ is attacking space %d!", self.name, target.position);
    if (!target.occupied && ![self.owner isMySpace:target.position]){
        self.owner.opponent.health -= self.baseAttack;
        if (self.owner.opponent.health <= 0){
            [self.owner.game gameWonByPlayer:self.owner];
        }
    }
    else
    {
        
        target.creature.hitPoints -= self.baseAttack;
        if(![self.owner isMySpace:target.position] && (target.creature.hasRange || abs(target.position - self.space.position) <= 2)){
            //if not attacking own creature and in range of enemy, take counterattack damage
            self.hitPoints -= target.creature.baseAttack;
        }
        NSLog(@"%@ now has %d hit points!", target.creature.name, target.creature.hitPoints);
        NSLog(@"%@ now has %d hit points!", self.name, self.hitPoints);
        if (target.creature.hitPoints <= 0){
            [target.creature removeFromPlay];
        }
        if (self.hitPoints <= 0){
            [self removeFromPlay];
        }
        else{
            self.attackedThisTurn = YES;
        }

        
    }
}

- (NSMutableArray*) enemiesInRangeWithBlock{
    NSMutableArray *inRange = [NSMutableArray array];
    NSMutableArray *enemyCreatures = self.owner.opponent.creaturesInPlay;
    for (int i=0; i < [enemyCreatures count]; i++){
        if((self.hasRange || (((UBCreature*)enemyCreatures[i]).space.position - self.space.position) == 1) &&((UBCreature*)enemyCreatures[i]).hasBlock){
            [inRange addObject:enemyCreatures[i]];
        }
    }
    return inRange;
}

- (void) removeFromPlay{
    [self.owner.creaturesInPlay removeObject:self];
    [self.owner.graveyard addObject:self];
    self.space.creature = nil;
    self.space = nil;
    self.isDead = YES;
}



@end
