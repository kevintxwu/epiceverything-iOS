//
//  ViewController.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBMenuViewController.h"
#import "UBGameViewController.h"
#import "UBCreditsViewController.h"

@interface UBMenuViewController ()

@property (nonatomic) UBMenuView *view;

@end

@implementation UBMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UBMenuView alloc] init];
}

- (void)startButtonPressed:(id)sender {
    UBGameViewController *gameVC = [[UBGameViewController alloc] init];
   // [self.navigationController pushViewController:gameVC animated:YES];
    [self presentViewController:gameVC animated:YES completion:^{
        return;
    }];
}

- (void)easyButtonPressed:(id)sender {
    UBGameViewController *gameVC = [[UBGameViewController alloc] init];
    gameVC.AIspeed = 9.0;
    [self presentViewController:gameVC animated:YES completion:^{
        return;
    }];
}

- (void)mediumButtonPressed:(id)sender {
    UBGameViewController *gameVC = [[UBGameViewController alloc] init];
    gameVC.AIspeed = 6.0;
    [self presentViewController:gameVC animated:YES completion:^{
        return;
    }];
}

- (void)hardButtonPressed:(id)sender {
    UBGameViewController *gameVC = [[UBGameViewController alloc] init];
    gameVC.AIspeed = 3.0;
    // [self.navigationController pushViewController:gameVC animated:YES];
    [self presentViewController:gameVC animated:YES completion:^{
        return;
    }];
}

- (void)creditsButtonPressed:(id)sender {
    UBCreditsViewController *creditsVC = [[UBCreditsViewController alloc] init];
    //[self.navigationController pushViewController:creditsVC animated:YES];
    [self presentViewController:creditsVC animated:YES completion:^{
        return;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
