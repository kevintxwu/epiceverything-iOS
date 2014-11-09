//
//  ViewController.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBMenuViewController.h"
#import "UBGameViewController.h"

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
    [self presentViewController:gameVC animated:NO completion:^{
        return;
    }];
}

- (void)instructionsButtonPressed:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
