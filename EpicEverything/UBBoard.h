//
//  EEBoard.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBGame.h"
#import "UBSpace.h"

@class UBGame;
@class UBSpace;

@interface UBBoard : NSObject


@property (nonatomic, copy) NSMutableArray* spaces;
@property (nonatomic) UBGame* game;

- (UBSpace*)spaceAtIndex:(int)index;
- (id) initWithGame:(UBGame*)game;


@end