//
//  UBResultViewController.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBResultViewController.h"
#import "UBMenuViewController.h"

@interface UBResultViewController ()

@property (nonatomic) UBResultsView *view;

@end

@implementation UBResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UBResultsView alloc] init];
}

- (void)endButtonPressed:(id)sender {
    UBMenuViewController *menuVC = [[UBMenuViewController alloc] init];
    [self presentViewController:menuVC animated:NO completion:^{
        return;
    }];
}
@end
