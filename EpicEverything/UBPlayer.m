//
//  UBPlayer.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBPlayer.h"

@implementation UBPlayer : NSObject

- (id) initWithGame:(UBGame *)game asPlayerOne:(BOOL)which{
    self = [super init];
    _hand = [[NSMutableArray alloc] init];
    _deck = [[NSMutableArray alloc] init];
    _graveyard = [[NSMutableArray alloc] init];
    _creaturesInPlay = [NSMutableArray arrayWithCapacity:4];
    _game = game;
    _playerOne = which;
    _mana = 0;
    _health = 20;
    
    return self;
}

- (BOOL) isMySpace:(int)index {
    //Player 1 has spaces 0, 2, 4, 6.  Player 2 has spaces 1, 3, 5, 7
    if((index % 2 == 0 && self.playerOne) || (index % 2 == 1 && !self.playerOne)){
        return YES;
    }
    return NO;
}




- (BOOL) canPlayCard:(UBCard*)card atSpace:(int) index{
    if (![self.hand containsObject:card] || card.manaCost > self.mana){
        return NO;
    }
    else if ([card isKindOfClass:[UBCreature class]] && [self isMySpace:index] &&
             ![[self.game.board spaceAtIndex:index] occupied]){
        return YES;
    }
    return NO;
}

- (void) playCard:(UBCard*)card atSpace:(int) index{
    NSAssert([self canPlayCard:card atSpace:index], @"Must be able to play card!");
    [self.hand removeObject:card];
    if ([card isKindOfClass:[UBCreature class]]){
        [self.creaturesInPlay addObject:card];
        [(UBCreature*)card playOnSpace:[self.game.board spaceAtIndex:index]];
        self.mana -= card.manaCost;
        NSLog(@"Playing %@ at space %d", card.name,index);
    }
    
}

- (void) addCardToDeck:(UBCard*)card {
    [_deck addObject:card];
    card.owner = self;
}

- (void)shuffleDeck
{
    NSUInteger count = [self.deck count];
    NSMutableArray *shuffled = [NSMutableArray array];
    
    for (int t = 0; t < count; ++t)
    {
        int i = arc4random() % [self cardsRemaining];
        UBCard *card = [self.deck objectAtIndex:i];
        [shuffled addObject:card];
        [self.deck removeObjectAtIndex:i];
    }
    
    NSAssert([self cardsRemaining] == 0, @"Original deck should now be empty");
    
    self.deck = shuffled;
}

/*- (void) startTurn {
    NSLog(@"Starting Turn %d!", self.game.turnNumber);
    self.myTurn = YES;
    self.mana = self.game.turnNumber;
    if (self.mana > 10){
        self.mana = 10;
    }
    if(!(self.playerOne && self.game.turnNumber == 1)){  //Player 1 doesn't draw on first turn
        [self drawCard];
    }
    
} */

- (UBCard *)drawCard
{
    if([self cardsRemaining] <= 0){
        NSLog(@"No more cards in the deck!");
        return nil;
    }
    
    UBCard *card = [self.deck lastObject];
    [self.deck removeLastObject];
    [self.hand addObject:card];
    NSLog(@"Drew %@!", card.name);
    return card;
}

/*- (void) endTurn
{
    NSAssert(self.myTurn, @"Only the current player can switch turns!");
    self.myTurn = NO;
    for(int i=0; i < [self.creaturesInPlay count]; i++){
        UBCreature* currCreature = [self.creaturesInPlay objectAtIndex:i];
        currCreature.turnsInPlay++;
        currCreature.attackedThisTurn = NO;
    }
    [self.game endTurnByPlayer:self];
    
} */

- (int)cardsRemaining
{
    return [self.deck count];
}


@end