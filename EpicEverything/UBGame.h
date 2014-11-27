//
//  UBGame.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBPlayer.h"
#import "UBCard.h"
#import "UBBoard.h"
#import "UBCreature.h"

@class UBCreature;
@class UBPlayer;
@class UBBoard;


@interface UBGame : NSObject


@property (nonatomic) UBPlayer* playerOne;
@property (nonatomic) UBPlayer* playerTwo;
//@property (nonatomic) UBPlayer* currentPlayer;
@property (nonatomic) UBBoard* board;
@property (nonatomic) int turnNumber;
@property (nonatomic) int turnLength;


- (id) initTestGame;

//- (void) startGame;

- (UBCard*) startTurn:(UBPlayer*)player;

- (void) endTurn:(UBPlayer*)player;

- (void) gameWonByPlayer:(UBPlayer*)winner;

- (void) secondPassed;
@end