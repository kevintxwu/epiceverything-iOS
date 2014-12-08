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

- (void) initWithVictory:(BOOL)win{
    self.victory = win;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UBResultsView alloc] init];
    if(!self.victory){
     [self.view changeText];
    }
}

- (void)viewDidAppear {
    /*if(!self.victory){
        [self.view changeText];
    }*/
}

- (void)endButtonPressed:(id)sender {
    NSLog(@"ENDING");
    
    UBMenuViewController *menuVC = [[UBMenuViewController alloc] init];
    [self presentViewController:menuVC animated:YES completion:^{
        return;
    }];
}
@end
