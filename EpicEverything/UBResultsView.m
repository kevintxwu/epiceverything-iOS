//
//  UBResultsView.m
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import "UBResultsView.h"
#import "UIView+UBExtensions.h"

@interface UBResultsView ()

@property (nonatomic) UIButton *end;

@end

@implementation UBResultsView

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
    _end = [({
        UIButton *end = [[UIButton alloc] init];
        [end setTitle:@"End Game" forState:UIControlStateNormal];
        end.backgroundColor = [UIColor redColor];
        //[start.titleLabel setFont:[UIFont ub_textFont]];
        [end addTarget:_delegate action:@selector(endButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        end;
    }) ub_addToSuperview:self];
}

- (void)updateConstraints {
    
    [self.end mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([UIView ub_buttonWidth]);
        make.height.equalTo([UIView ub_buttonHeight]);
    }];
    
    [super updateConstraints];
}

@end


