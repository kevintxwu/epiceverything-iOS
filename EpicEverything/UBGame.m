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



- (UBCard*) startTurn:(UBPlayer*)player{
    NSAssert(player == self.currentPlayer, @"Only the current player can start their turn!");
    NSLog(@"Starting Turn %d!", self.turnNumber);
    player.myTurn = YES;
    player.mana = self.turnNumber;
    if (player.mana > 10){
        player.mana = 10;
    }
    if(!(player.playerOne && self.turnNumber == 1)){  //Player 1 doesn't draw on first turn
        return [player drawCard];
    }
    return nil;
}


- (void) endTurn:(UBPlayer*)player
{
    NSAssert(player.myTurn, @"Only the current player can end their turn!");
    player.myTurn = NO;
    for(int i=0; i < [player.creaturesInPlay count]; i++){
        UBCreature* currCreature = [player.creaturesInPlay objectAtIndex:i];
        currCreature.turnsInPlay++;
        currCreature.attackedThisTurn = NO;
    }
    
    self.currentPlayer = player.opponent;
    if (player == self.playerTwo){
        self.turnNumber++;
    }
    
}

- (void) gameWonByPlayer:(UBPlayer*)winner{
    NSLog(@"GAME OVER");
    exit(0);
}

/*- (void) computerMove:(UBPlayer*)player{
   
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
} */


@end