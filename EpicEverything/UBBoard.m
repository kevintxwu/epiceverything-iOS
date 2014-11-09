//
//  UBBoard.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBBoard.h"

@implementation UBBoard : NSObject


- (id) initWithGame:(UBGame*)game{
    self = [super init];
    if (self) {
        _game = game;
        _spaces = [NSMutableArray arrayWithCapacity:8];
        for(int i=0; i < 8; i++){
            [self.spaces addObject: [[UBSpace alloc] initWithBoard:self withIndex:i]];
        }
        NSLog(@"Creating Board");
    }
    
    return self;
    
}

- (UBSpace*) spaceAtIndex:(int)index{
    NSAssert(index < 8 && index >= 0, @"Index must be between 0 and 7!");
    return [self.spaces objectAtIndex:index];
}

@end