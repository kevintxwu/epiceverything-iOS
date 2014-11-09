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
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (void)creditsButtonPressed:(id)sender {
    UBCreditsViewController *creditsVC = [[UBCreditsViewController alloc] init];
    [self.navigationController pushViewController:creditsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
