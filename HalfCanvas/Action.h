//
//  Action.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject {
    NSString *senderUsername;
    NSString *senderImageURL;
    NSInteger questionID;
    NSString *actionType;
}

@property (retain) NSString *senderUsername;
@property (retain) NSString *senderImageURL;
@property (nonatomic) NSInteger questionID;
@property (retain) NSString *actionType;
@property (retain) NSString *pubLife;
@property (retain, nonatomic) NSNumber *timestamp;

@end