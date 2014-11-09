//
//  EECreature.m
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
    _baseAttack = (int)data[@"attack"];
    _hitPoints = (int)data[@"hitPoints"];
    _mobility = (int)data[@"mobility"];
    _turnsInPlay = 0;
    _isDead = NO;
    
    _hasBlock = (BOOL)data[@"block"];
    _hasHaste = (BOOL)data[@"haste"];
    _hasRange = (BOOL)data[@"range"];
    return self;
}

@end
