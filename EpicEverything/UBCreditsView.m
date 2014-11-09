//
//  UBCreditsView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBCreditsView.h"
#import "UIView+UBExtensions.h"

@interface UBCreditsView ()

@property (nonatomic) UIImageView *background;
@property (nonatomic) UILabel *title;
@property (nonatomic) UILabel *credits;
@property (nonatomic) UIButton *returnButton;

@end

@implementation UBCreditsView

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
        [title setFont:[UIFont ub_creditsTitle]];
        [title setText:@"Credits"];
        [title setTextColor:[UIColor whiteColor]];
        title.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        title.layer.shadowColor = [UIColor blackColor].CGColor;
        title.layer.shadowOpacity = 0.5;
        title;
    }) ub_addToSuperview:self];
    
    _credits = [({
        UILabel *credits = [[UILabel alloc] init];
        [credits setFont:[UIFont ub_creditsParagraph]];
        [credits setText:[NSString ub_creditsString]];
        [credits setTextColor:[UIColor whiteColor]];
        [credits setTextAlignment:NSTextAlignmentCenter];
        credits.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        credits.layer.shadowColor = [UIColor blackColor].CGColor;
        credits.layer.shadowOpacity = 0.5;
        [credits setNumberOfLines:0];
        credits;
    }) ub_addToSuperview:self];
    
    _returnButton = [({
        UIButton *returnButton = [[UIButton alloc] init];
        [returnButton setTitle:@"Return" forState:UIControlStateNormal];
        returnButton.backgroundColor = [UIColor clearColor];
        [returnButton.titleLabel setFont:[UIFont ub_uchiyama]];
        [returnButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [returnButton.layer setBorderWidth:[UIView ub_borderWidth]];
        [returnButton.layer setCornerRadius:[UIView ub_borderRadius]];
        returnButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        returnButton.layer.shadowColor = [UIColor blackColor].CGColor;
        returnButton.layer.shadowOpacity = 0.5;
        [returnButton addTarget:_delegate action:@selector(returnButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        returnButton;
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
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset([[UIView ub_titlePadding] floatValue]);
    }];
    
    [self.credits mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.title.mas_bottom).with.offset([[UIView ub_titlePadding] floatValue]);
        make.trailing.equalTo(self.mas_right).with.offset(-[[UIView ub_creditsParagraphPadding] floatValue]);
        make.leading.equalTo(self.mas_left).with.offset([[UIView ub_creditsParagraphPadding] floatValue]);
    }];
    
    [self.returnButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.self.mas_bottom).with.offset(-[[UIView ub_titlePadding] floatValue]);
        make.width.equalTo([UIView ub_buttonWidth]);
    }];
    
    [super updateConstraints];
}


@end
