//
//  UBGameView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBGameViewDelegate;

@interface UBGameView : UIView

@property (nonatomic, weak) id<UBGameViewDelegate> delegate;

@end

@protocol UBGameViewDelegate <NSObject>

- (void)nextButtonPressed:(id)sender;

@end