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
    self.view = [[UBGameView alloc] init];
}

- (void)nextButtonPressed:(id)sender {
    UBResultViewController *resultsVC = [[UBResultViewController alloc] init];
    [self presentViewController:resultsVC animated:NO completion:^{
        return;
    }];
}

@end