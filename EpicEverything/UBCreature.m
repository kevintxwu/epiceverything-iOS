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
    _secondsInPlay = -1;
    _isDead = NO;
    _cooldown = 10;
    _secondsSinceLastAttack = 0;
    
    _hasBlock = [data[@"block"] boolValue];
    _hasSpeed = [data[@"speed"] boolValue];
    _hasRange = [data[@"range"] boolValue];
    return self;
}
    
- (void) playOnSpace:(UBSpace*)space{
    self.space = space;
    self.space.creature = self;
    self.secondsInPlay = 0;
    if (self.hasSpeed){
        self.secondsSinceLastAttack = self.cooldown;
    }
    self.hitPoints = self.totalHitPoints;
}

- (BOOL) canAttackSpace: (UBSpace*)target{
    if(![self canAttackNow] || (!target.occupied && [self.owner isMySpace:target.position]) || target == self.space){
           return NO;
    }
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

- (BOOL) canAttackNow{
    if(!(self.hasSpeed || self.secondsInPlay >= 0) || self.secondsSinceLastAttack < self.cooldown){
        return NO;
    }
    return YES;
}

- (void) attackSpace: (UBSpace*)target{
    //NSAssert([self canAttackSpace:target], @"Must be able to attack space!");
    if([self canAttackSpace:target]){
        NSLog(@"%@ is attacking space %d!", self.name, target.position);
        if (!target.occupied && ![self.owner isMySpace:target.position]){
            self.owner.opponent.health -= self.baseAttack;
            if (self.owner.opponent.health <= 0){
                //[self.owner.game gameWonByPlayer:self.owner];
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
            
            
        }
       // NSLog(@"RESETTING COOLDOWN");
        self.secondsSinceLastAttack = 0;
    }
    else{
        NSLog(@"ERROR: TRIED TO ATTACK BUT ACTUALLY CAN'T");
    }
    
}

- (NSMutableArray*) enemiesInRangeWithBlock{
    NSMutableArray *inRange = [NSMutableArray array];
    NSMutableArray *enemyCreatures = self.owner.opponent.creaturesInPlay;
    for (int i=0; i < [enemyCreatures count]; i++){
        if((self.hasRange || abs(((UBCreature*)enemyCreatures[i]).space.position - self.space.position) == 1) && ((UBCreature*)enemyCreatures[i]).hasBlock){
            [inRange addObject:enemyCreatures[i]];
        }
    }
    return inRange;
}

- (void) secondPassed {
    self.secondsInPlay += 1;
    self.secondsSinceLastAttack += 1;
}


- (void) removeFromPlay{
    [self.owner.creaturesInPlay removeObject:self];
    [self.owner.graveyard addObject:self];
    self.space.creature = nil;
    self.space = nil;
    self.secondsInPlay = -1;
    self.secondsSinceLastAttack = 0;
    self.isDead = YES;
}



@end
