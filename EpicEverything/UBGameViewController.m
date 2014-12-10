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
@property (nonatomic) NSTimer *AItimer;
@property (nonatomic) NSTimer *updateTimer;
@property (nonatomic) NSTimer *secondsTimer;
@property (nonatomic) NSTimer *turnTimer;
@property (nonatomic) NSTimer *drawTimer;


@end

@implementation UBGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[UBGame alloc] initTestGame];
    self.game.turnLength = 15; //SET TURN TIME HERE
    if (!self.AIspeed){
        self.AIspeed = 6.0;
    }
    self.view = [[UBGameView alloc] initWithFrame: CGRectMake(0,0,0,0) andGame: self.game];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"View did appear with AIspeed = %0.2f!", self.AIspeed);
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
    //[self switchTurn:self.game.playerOne];
    
}

- (void) startGame{
    NSLog(@"Starting Game!");
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                     target:self
                                   selector:@selector(updateState:)
                                   userInfo:nil
                                    repeats:YES];
    
    _drawTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                    target:self
                                                  selector:@selector(drawHand:)
                                                  userInfo:nil
                                                   repeats:YES];
    
    
  //  self.game.currentPlayer = self.game.playerOne;
 //   UBCard *drawnCard = [self.game startTurn:self.game.currentPlayer];
 //   NSAssert(!drawnCard, @"Should not draw on first turn!!");
    

}

- (void) drawHand:(NSTimer *)timer{
    if([self.game.playerOne.hand count] < 4){
        [self.view setUpNewCard:[self.game.playerOne drawCard] playerOne:YES];
        [self.view setUpNewCard:[self.game.playerTwo drawCard] playerOne:NO];
    }
    else{
        [self.drawTimer invalidate];
        [self beginTurnTimer];
    }
    
}

- (void) beginTurnTimer{
    _turnTimer = [NSTimer scheduledTimerWithTimeInterval:self.game.turnLength
                                     target:self
                                   selector:@selector(newTurn:)
                                   userInfo:nil
                                    repeats:YES];
    
    _secondsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(secondPassed:)
                                   userInfo:nil
                                    repeats:YES];
    _AItimer = [NSTimer scheduledTimerWithTimeInterval:self.AIspeed
                                     target:self
                                   selector:@selector(computerAction:)
                                   userInfo:nil
                                    repeats:YES];
    
    /*NSTimer * otherAI = [NSTimer scheduledTimerWithTimeInterval:self.AIspeed - 1.0
                                                         target:self
                                                       selector:@selector(playerOneComputerAction:)
                                                       userInfo:nil
                                                        repeats:YES];
     */
}

//switches turn from given player to other player
     /*
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
      */


- (void) newTurn:(NSTimer *)timer{
    //[self.view updateBoard];
    self.view.secondsPassed = 0;
    UBCard *drawnCard = [self.game startTurn:self.game.playerOne];
    if (drawnCard){
        [self.view setUpNewCard:drawnCard playerOne:YES];
    }
    drawnCard = [self.game startTurn:self.game.playerTwo];
    if (drawnCard){
        [self.view setUpNewCard:drawnCard playerOne:NO];
    }
    //[self computerMove:self.game.playerTwo];
}


- (void) computerAction:(NSTimer *)timer{
    [self computerMove:self.game.playerTwo];
}

- (void) playerOneComputerAction:(NSTimer *)timer{
    [self computerMove:self.game.playerOne];
}

- (void) secondPassed:(NSTimer *)timer{
    self.view.secondsPassed++;
    [self.game secondPassed];
}

- (void) updateState:(NSTimer *)timer{
    if(self.game.playerTwo.health <= 0 || self.game.playerOne.health <= 0){
        UBResultViewController *resultsVC = [[UBResultViewController alloc] init];
        [self.AItimer invalidate];
        [self.turnTimer invalidate];
        [self.secondsTimer invalidate];
        [self.updateTimer invalidate];
        if(self.game.playerTwo.health <= 0){
            resultsVC.victory = YES;
        }
        else{
           resultsVC.victory = NO;
        }
        [self presentViewController:resultsVC animated:YES completion:^{
            return;
        }];
        
    }
    else{
        [self.view updateBoard];
    }
    
}


- (void) computerMove:(UBPlayer*)player{
    
    int targets[4];
    int spaces[4];
    spaces[0] = 5;
    spaces[1] = 3;
    spaces[2] = 7;
    spaces[3] = 1;
    for(int i= 0; i < 4; i++){
        targets[i] = 2*i;
    }
    if(player == self.game.playerOne){
        for(int i = 0; i < 4; i++){
            spaces[i]--;
            targets[i]++;
        }
    }
    int rand = arc4random_uniform(1);
    if(rand){
        for(int i = 0; i < [player.hand count]; i++){
            UBCard* selected = player.hand[i];
            for(int j = 0; j < 4; j++){
                if([player canPlayCard:selected atSpace:spaces[j]]){
                    [player playCard:selected atSpace:spaces[j]];
                    i--;
                    return;
                    //break;
                }
            }
        }
        for(int i = 0; i < [player.creaturesInPlay count]; i++){
            UBCreature* creature = player.creaturesInPlay[i];
            for(int j = 0; j < 4; j++){
                if([creature canAttackSpace:[self.game.board spaceAtIndex:targets[j]]]){
                    NSLog(@"Can attack!");
                    UBCardView* cardView = [self.view getCardViewAtSpace:creature.space.position];
                    if(cardView){
                        [self.view attackCardAnimation:cardView andTargetPosition:targets[j]];
                    }
                    return;
                    //break;
                }
            }
        }
    }
    else{
        for(int i = 0; i < [player.creaturesInPlay count]; i++){
            UBCreature* creature = player.creaturesInPlay[i];
            for(int j = 0; j < 4; j++){
                if([creature canAttackSpace:[self.game.board spaceAtIndex:targets[j]]]){
                    NSLog(@"Can attack!");
                    UBCardView* cardView = [self.view getCardViewAtSpace:creature.space.position];
                    if(cardView){
                        [self.view attackCardAnimation:cardView andTargetPosition:targets[j]];
                    }
                    return;
                    //break;
                }
            }
        }
        for(int i = 0; i < [player.hand count]; i++){
            UBCard* selected = player.hand[i];
            for(int j = 0; j < 4; j++){
                if([player canPlayCard:selected atSpace:spaces[j]]){
                    [player playCard:selected atSpace:spaces[j]];
                    i--;
                    return;
                    //break;
                }
            }
        }
    }

    //[self switchTurn:player];
}






@end