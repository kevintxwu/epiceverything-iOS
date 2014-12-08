//
//  UBCreditsViewController.m
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBCreditsViewController.h"
#import "UBMenuViewController.h"
#import "UBCreditsView.h"

@interface UBCreditsViewController ()

@property (nonatomic) UBCreditsView *view;

@end

@implementation UBCreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UBCreditsView alloc] init];
    self.view.delegate = self;
}

- (void)returnButtonPressed:(id)sender {
    UBMenuViewController *menuVC = [[UBMenuViewController alloc] init];
    [self presentViewController:menuVC animated:YES completion:^{
        return;
    }];
}

@end
