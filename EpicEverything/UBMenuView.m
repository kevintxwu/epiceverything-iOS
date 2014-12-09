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

@property (nonatomic) UIImageView *background;
@property (nonatomic) UILabel *title;
@property (nonatomic) UIButton *start;
@property (nonatomic) UIButton *instructions;

@property (nonatomic) UIButton *easy;
@property (nonatomic) UIButton *medium;
@property (nonatomic) UIButton *hard;

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
    
    _background = [({
        UIImageView *background = [[UIImageView alloc] init];
        [background setImage:[UIImage ub_menuBackground]];
        background;
    }) ub_addToBackOfSuperview:self];
    
    _title = [({
        UILabel *title = [[UILabel alloc] init];
        [title setFont:[UIFont ub_adventure]];
        [title setText:@"Epic Everything"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title;
    }) ub_addToSuperview:self];
    
    _easy = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Easy" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor clearColor];
        [start.titleLabel setFont:[UIFont ub_uchiyama]];
        [start.layer setBorderColor:[UIColor whiteColor].CGColor];
        [start.layer setBorderWidth:[UIView ub_borderWidth]];
        [start.layer setCornerRadius:[UIView ub_borderRadius]];
        start.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        start.layer.shadowColor = [UIColor blackColor].CGColor;
        start.layer.shadowOpacity = 0.5;
        [start addTarget:_delegate action:@selector(easyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self];
    
    _medium = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Medium" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor clearColor];
        [start.titleLabel setFont:[UIFont ub_uchiyamaMedium]];
        [start.layer setBorderColor:[UIColor whiteColor].CGColor];
        [start.layer setBorderWidth:[UIView ub_borderWidth]];
        [start.layer setCornerRadius:[UIView ub_borderRadius]];
        start.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        start.layer.shadowColor = [UIColor blackColor].CGColor;
        start.layer.shadowOpacity = 0.5;
        [start addTarget:_delegate action:@selector(mediumButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self];
    
    _hard = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Hard" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor clearColor];
        [start.titleLabel setFont:[UIFont ub_uchiyama]];
        [start.layer setBorderColor:[UIColor whiteColor].CGColor];
        [start.layer setBorderWidth:[UIView ub_borderWidth]];
        [start.layer setCornerRadius:[UIView ub_borderRadius]];
        start.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        start.layer.shadowColor = [UIColor blackColor].CGColor;
        start.layer.shadowOpacity = 0.5;
        [start addTarget:_delegate action:@selector(hardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self];
    
    _start = [({
        UIButton *start = [[UIButton alloc] init];
        [start setTitle:@"Start" forState:UIControlStateNormal];
        start.backgroundColor = [UIColor clearColor];
        [start.titleLabel setFont:[UIFont ub_uchiyama]];
        [start.layer setBorderColor:[UIColor whiteColor].CGColor];
        [start.layer setBorderWidth:[UIView ub_borderWidth]];
        [start.layer setCornerRadius:[UIView ub_borderRadius]];
        start.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        start.layer.shadowColor = [UIColor blackColor].CGColor;
        start.layer.shadowOpacity = 0.5;
        [start addTarget:_delegate action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        start;
    }) ub_addToSuperview:self];
    
    
    _instructions = [({
        UIButton *instructions = [[UIButton alloc] init];
        [instructions setTitle:@"Credits" forState:UIControlStateNormal];
        instructions.backgroundColor = [UIColor clearColor];
        [instructions.titleLabel setFont:[UIFont ub_uchiyama]];
        [instructions.layer setBorderColor:[UIColor whiteColor].CGColor];
        [instructions.layer setBorderWidth:[UIView ub_borderWidth]];
        [instructions.layer setCornerRadius:[UIView ub_borderRadius]];
        instructions.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        instructions.layer.shadowColor = [UIColor blackColor].CGColor;
        instructions.layer.shadowOpacity = 0.5;
        [instructions addTarget:_delegate action:@selector(creditsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        instructions;
    }) ub_addToSuperview:self];
}

- (void)updateConstraints {
    
    [self.background mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.medium.mas_top).with.offset([[UIView ub_titlePadding] floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset([[UIView ub_titlePadding] floatValue]);
    }];

    
    [self.medium mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(20);
        make.width.equalTo([UIView ub_shortButtonWidth]);
    }];
    

    [self.instructions mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.medium.mas_centerX);
        make.top.equalTo(self.medium.mas_bottom).with.offset([[UIView ub_padding] floatValue]);
        make.width.equalTo([UIView ub_buttonWidth]);
    }];
    
    [self.easy mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.instructions.mas_left);
        make.centerY.equalTo(self.mas_centerY).with.offset(20);
        make.width.equalTo([UIView ub_shortButtonWidth]);
    }];
    
    
    [self.hard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.instructions.mas_right);
        make.centerY.equalTo(self.mas_centerY).with.offset(20);
        make.width.equalTo([UIView ub_shortButtonWidth]);
    }];
    
    
    [super updateConstraints];
}

@end
