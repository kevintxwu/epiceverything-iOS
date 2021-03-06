//
//  GameViewController.m
//  EpicEverything
//
//  Created by Varun Rau, Joel Jacobs, Jordeen Chang, and Kevin Wu on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBGameViewController.h"
#import "UBResultViewController.h"
#import "UBGameView.h"
#import "UBMenuView.h"
#import "UBGame.h"
#import "UBCard.h"
#import "UBBoard.h"
#import "UBCreature.h"
#import "UBPlayer.h"
#import "UBSpace.h"


@interface UBGameViewController ()

@property (nonatomic) UBGameView *view;

@end

@implementation UBGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[UBGame alloc] initTestGame];
    self.view = [[UBGameView alloc] initWithFrame: CGRectMake(0,0,0,0) andGame: self.game];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"View did appear!");
    [self performSelector:@selector(startGame) withObject:nil afterDelay:1.0f];
}

- (void)nextButtonPressed:(id)sender {
    UBResultViewController *resultsVC = [[UBResultViewController alloc] init];
    [self presentViewController:resultsVC animated:NO completion:^{
        return;
    }];
}


- (void)endTurnPressed:(id)sender{
    NSLog(@"end");
    [self switchTurn:self.game.playerOne];
    
}

- (void) startGame{
    NSLog(@"Starting Game!");
    for (int i=0; i<4; i++){
        [self.view drawCardAnimation:[self.view setUpNewCard:[self.game.playerOne drawCard] playerOne:YES]];
        [self.view updateBoard];
        //sleep(1.5);
        [self.view drawCardAnimation:[self.view setUpNewCard:[self.game.playerTwo drawCard] playerOne:NO]];
        [self.view updateBoard];
        //sleep(1.5);
    }
    
    
    self.game.currentPlayer = self.game.playerOne;
    self.game.turnNumber = 1;
    UBCard *drawnCard = [self.game startTurn:self.game.currentPlayer];
    NSAssert(!drawnCard, @"Should not draw on first turn!!");
    [self.view updateBoard];
    
}

//switches turn from given player to other player
- (void) switchTurn:(UBPlayer*)player{
    NSLog(@"Switching turn!");
    if(player == self.game.currentPlayer){
        [self.game endTurn:player];
        
        UBCard *drawnCard = [self.game startTurn:self.game.currentPlayer];
        
        if (drawnCard){
            [self.view drawCardAnimation:[self.view setUpNewCard:drawnCard playerOne:self.game.playerOne.myTurn]];
        }
        [self.view updateBoard];
        if(self.game.currentPlayer == self.game.playerTwo){
            [self computerMove:self.game.playerTwo];
        }
    }
    


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
                //insert play animation here
                [self.view updateBoard];
                //sleep(1);
                break;
            }
        }
    }
    sleep(1);
    for(int i = 0; i < [player.creaturesInPlay count]; i++){
        UBCreature* creature = player.creaturesInPlay[i];
        for(int j = 0; j < 4; j++){
            if([creature canAttackSpace:[self.game.board spaceAtIndex:targets[j]]]){
                NSLog(@"Can attack!");
                [creature attackSpace:[self.game.board spaceAtIndex:targets[j]]];
                //insert attack animation here
                [self.view updateBoard];
                //sleep(1);
                break;
            }
        }
    }
    [self switchTurn:player];
}






@end