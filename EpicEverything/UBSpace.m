//
//  UBSpace.m
//  EpicEverything
//
//  Created by Joel Jacobs on 11/8/14.
//  Copyright (c) 2014 Unboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UBSpace.h"
#import "UIImage+UBImage.h"

@implementation UBSpace : NSObject



- (id) initWithBoard:(UBBoard*)board withIndex:(int)i{
    self = [self init];
    if (self){
        _board = self.board;
        _index = i;
        _image = [[UIImageView alloc] init];
        [self.image setImage:[UIImage ub_space]];
    }
    return self;
}


- (BOOL) occupied {
    if (self.creature){
        return YES;
    }
    return NO;
}

@end