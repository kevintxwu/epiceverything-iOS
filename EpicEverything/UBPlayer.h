//
//  UBPlayer.h
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBGame.h"
#import "UBBoard.h"
#import "UBCard.h"
#import "UBPlayer.h"

@class UBCard;
@class UBBoard;

@interface UBPlayer : NSObject

@property (nonatomic, copy) NSMutableArray* hand;
@property (nonatomic, copy) NSMutableArray* deck;
@property (nonatomic, copy) NSMutableArray* graveyard;
@property (nonatomic, copy) NSMutableArray* creaturesInPlay;
@property (nonatomic) UBGame* game;
@property (nonatomic) UBPlayer* opponent;
@property (nonatomic) BOOL myTurn;
@property (nonatomic) BOOL playerOne;
@property (nonatomic) int mana;
@property (nonatomic) int health;

- (id) initWithGame:(UBGame*)game asPlayerOne:(BOOL)which;

- (UBCard*) drawCard;

- (void) startTurn;

- (void) endTurn;

- (int) cardsRemaining;

- (void) addCardToDeck:(UBCard*)card;

- (void) shuffleDeck;

- (BOOL) canPlayCard:(UBCard*)card atSpace:(int) index;

- (BOOL) isMySpace:(int)index;


@end