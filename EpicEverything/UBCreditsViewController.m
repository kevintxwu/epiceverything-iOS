//
//  UBCreditsViewController.m
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBCreditsViewController.h"
#import "UBCreditsView.h"

@interface UBCreditsViewController ()

@property (nonatomic) UBCreditsView *view;

@end

@implementation UBCreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UBCreditsView alloc] init];
}

@end
