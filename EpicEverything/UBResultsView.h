//
//  UBResultsView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBResultsViewDelegate;

@interface UBResultsView : UIView

@property (nonatomic, weak) id<UBResultsViewDelegate> delegate;

- (void) changeText;

@end

@protocol UBResultsViewDelegate <NSObject>

- (void)endButtonPressed:(id)sender;


@end
