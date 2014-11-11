//
//  UBSpaceView.m
//  Epic Everything
//
//  Created by Joel Jacobs on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//
#import "UBSpaceView.h"
#import "UIView+UBExtensions.h"

@implementation UBSpaceView : UIView

- (id)initWithSpace:(UBSpace*)space{
    self = [super init];
    if (self) {
        _space = space;
        _image = [[UIImageView alloc] init];
        [self.image setImage:[UIImage ub_space]];
        if(space.position % 2 == 0){
            self.image.userInteractionEnabled = YES;
        }
        [_image ub_addToSuperview:self];
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    [self.image mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    [super updateConstraints];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touched on Space!");
    
}


@end