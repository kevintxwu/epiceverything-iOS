//
//  EEPlayer.m
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
    
    return self;
}

- (BOOL) isMySpace:(int)index {
    if((index % 2 == 0 && !self.playerOne) || (index % 2 == 1 && self.playerOne)){
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

- (void) startTurn {
    self.myTurn = YES;
    self.mana = self.game.turnNumber;
    if (self.mana > 10){
        self.mana = 10;
    }
    [self drawCard];
}

- (UBCard *)drawCard
{
    NSAssert([self cardsRemaining] > 0, @"No more cards in the deck");
    UBCard *card = [self.deck lastObject];
    [self.deck removeLastObject];
    [self.hand addObject:card];
    return card;
}

- (void) endTurn
{
    NSAssert(self.myTurn, @"Only the current player can switch turns!");
    self.myTurn = NO;
    for(int i=0; i < [self.creaturesInPlay count]; i++){
        UBCreature* currCreature = [self.creaturesInPlay objectAtIndex:i];
        currCreature.turnsInPlay++;
    }
    [self.game endTurnByPlayer:self];
    
}

- (int)cardsRemaining
{
    return [self.deck count];
}


@end