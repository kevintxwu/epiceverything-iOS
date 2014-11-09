//
//  UBEndViewController.m
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBEndViewController.h"
#import "UBGameViewController.h"
#import "UBMenuViewController.h"

@interface UBEndViewController ()

@property (nonatomic) UBEndView *view;

@end

@implementation UBEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UBEndView alloc] init];
}


- (void)returnButtonPressed:(id)sender {
    UBMenuViewController *menuVC = [[UBMenuViewController alloc] init];
    [self.navigationController pushViewController:menuVC animated:YES];
}

- (void)playAgainButtonPressed:(id)sender {
    UBGameViewController *gameVC = [[UBGameViewController alloc] init];
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
