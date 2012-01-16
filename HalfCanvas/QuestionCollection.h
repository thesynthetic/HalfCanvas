//
//  QuestionCollection.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCollection : NSObject
{
    NSMutableArray *questions;
}

+ (QuestionCollection*) sharedInstance;

@property (retain) NSMutableArray *questions;

@end

