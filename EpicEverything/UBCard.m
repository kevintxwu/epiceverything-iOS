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
    return self;
}

@end
