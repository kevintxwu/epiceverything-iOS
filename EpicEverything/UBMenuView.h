//
//  UBMenuView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBMenuViewDelegate;

@interface UBMenuView : UIView

@property (nonatomic, weak) id<UBMenuViewDelegate> delegate;

@end

@protocol UBMenuViewDelegate <NSObject>

- (void)startButtonPressed:(id)sender;
- (void)creditsButtonPressed:(id)sender;


@end
