//
//  UBMenuView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBMenuView.h"
#import "UIView+UBExtensions.h"

@interface UBMenuView ()

@property (nonatomic) UIButton *start;
@property (nonatomic) UIButton *instructions;

@end

@implementation UBMenuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
        [self updateConstraints];
    }
    return self;
}

- (void)createSubviews {
    _start = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Start Game" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor redColor];
        //[start.titleLabel setFont:[UIFont ub_textFont]];
        [start addTarget:_delegate action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self];
    
    _instructions = [({
        UIButton *instructions = [[UIButton alloc] init];
        [instructions setTitle:@"Instructions" forState:UIControlStateNormal];
        instructions.backgroundColor = [UIColor redColor];
        //[instructions.titleLabel setFont:[UIFont ub_textFont]];
        //[instructions addTarget:_delegate action:@selector(instructionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        instructions;
    }) ub_addToSuperview:self];
}

- (void)updateConstraints {
    
    [self.start mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(-[[UIView ub_buttonHeight] floatValue]);
        make.width.equalTo([UIView ub_buttonWidth]);
    }];
    
    [self.instructions mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.start.mas_centerX);
        make.top.equalTo(self.start.mas_bottom).with.offset([[UIView ub_padding] floatValue]);
        make.width.equalTo([UIView ub_buttonWidth]);
    }];
    
    [super updateConstraints];
}

@end
