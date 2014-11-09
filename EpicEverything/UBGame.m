//
//  UBGame.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBGame.h"

@implementation  UBGame : NSObject

- (id) initTestGame {
    self = [super init];
    if (self) {
        NSLog(@"Creating Game!");
        _board = [[UBBoard alloc] initWithGame:self];
        
        _playerOne = [[UBPlayer alloc] initWithGame:self asPlayerOne:YES];
        _playerTwo = [[UBPlayer alloc] initWithGame:self asPlayerOne:NO];
        self.playerOne.opponent = self.playerTwo;
        self.playerTwo.opponent = self.playerOne;
        
        NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"plist"];
        NSMutableArray *allCards = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
        
        
        
        for (int i = 0; i < [allCards count]; i++){
            NSDictionary *currData = allCards[i];
            UBCard *currCard = nil;
            if([currData[@"type"] isEqualToString:@"creature"]){
                currCard = [[UBCreature alloc] initFromHash:currData];
            }
            else{
                currCard = nil;
            }
            [_playerOne addCardToDeck:currCard];
        }
        
        for (int i = 0; i < [allCards count]; i++){
            NSDictionary *currData = allCards[i];
            UBCard *currCard = nil;
            if([currData[@"type"] isEqualToString:@"creature"]){
                currCard = [[UBCreature alloc] initFromHash:currData];
            }
            else{
                currCard = nil;
            }
            [_playerTwo addCardToDeck:currCard];
        }
        
        [_playerOne shuffleDeck];
        [_playerTwo shuffleDeck];
        _turnNumber = 0;
    }
    NSLog(@"Game Created!!!");
    return self;

    
    
}

- (void) startGame{
    NSLog(@"Starting Game!");
    for (int i=0; i<4; i++){
        [_playerOne drawCard];
        [_playerTwo drawCard];
    }
    
    _currentPlayer = self.playerOne;
    _turnNumber = 1;
    [self.playerOne startTurn];
    //[self computerMove:self.playerOne];
    
}

- (void) endTurnByPlayer:(UBPlayer*)cPlayer{
    NSAssert(cPlayer == self.currentPlayer, @"Only the current player can switch turns!");
    
    if(self.currentPlayer == self.playerOne){
        self.currentPlayer = self.playerTwo;
        [self.playerTwo startTurn];
        [self computerMove:self.playerTwo];
    }
    else{
        self.currentPlayer = self.playerOne;
        self.turnNumber++;
        [self.playerOne startTurn];
        //[self computerMove:self.playerOne];
    }
    
}

- (void) gameWonByPlayer:(UBPlayer*)winner{
    NSLog(@"GAME OVER");
    exit(0);
}

- (void) computerMove:(UBPlayer*)player{
   
    NSInteger targets[4];
    NSInteger spaces[4];
    spaces[0] = 5;
    spaces[1] = 3;
    spaces[2] = 7;
    spaces[3] = 1;
    for(int i= 0; i < 4; i++){
        targets[i] = 2*i;
    }
    for(int i = 0; i < [player.hand count]; i++){
        UBCard* selected = player.hand[i];
        for(int j = 0; j < 4; j++){
            if([player canPlayCard:selected atSpace:spaces[j]]){
                [player playCard:selected atSpace:spaces[j]];
                i--;
                break;
            }
        }
    }
    for(int i = 0; i < [player.creaturesInPlay count]; i++){
        UBCreature* creature = player.creaturesInPlay[i];
        for(int j = 0; j < 4; j++){
            if([creature canAttackSpace:[self.board spaceAtIndex:targets[j]]]){
                NSLog(@"Can attack!");
                [creature attackSpace:[self.board spaceAtIndex:targets[j]]];
                break;
            }
        }
    }
    [player endTurn];
}


@end