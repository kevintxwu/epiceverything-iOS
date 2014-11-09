//
//  UBSpaceView.h
//  Epic Everything
//
//  Created by Joel Jacobs on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBGame.h"

@protocol UBSpaceViewDelegate;

@interface UBSpaceView : UIView

@property (nonatomic) UBSpace* space;
@property (nonatomic) UIImageView* image;
@property (nonatomic, weak) id<UBSpaceViewDelegate> delegate;

- (id)initWithSpace:(UBSpace*)space;

@end

@protocol UBSpaceViewDelegate <NSObject>

@end