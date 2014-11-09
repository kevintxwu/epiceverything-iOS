//
//  UBEndView.h
//  EpicEverything
//
//  Created by Varun Rau on 11/9/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBEndViewDelegate;


@interface UBEndView : UIView


@property (nonatomic, weak) id<UBEndViewDelegate> delegate;

@end

@protocol UBEndViewDelegate <NSObject>

- (void)playAgainButtonPressed:(id)sender;
- (void)returnButtonPressed:(id)sender;

@end
