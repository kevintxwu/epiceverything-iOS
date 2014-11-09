//
//  EEGame.m
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
        _turnNumber = 0;
    }
    NSLog(@"Game Created!!!");
    return self;

    
    
}

- (void) startGame{
    for (int i=0; i<5; i++){
        [_playerOne drawCard];
        [_playerTwo drawCard];
    }
    
    _currentPlayer = self.playerOne;
    _turnNumber = 1;
}

- (void) endTurnByPlayer:(UBPlayer*)cPlayer{
    NSAssert(cPlayer == self.currentPlayer, @"Only the current player can switch turns!");
    
    if(self.currentPlayer == self.playerOne){
        self.currentPlayer = self.playerTwo;
        [self.playerTwo startTurn];
    }
    else{
        self.currentPlayer = self.playerOne;
        self.turnNumber++;
        [self.playerOne startTurn];
    }
    
}

- (void) gameWonByPlayer:(UBPlayer*)winner{
    
}


@end