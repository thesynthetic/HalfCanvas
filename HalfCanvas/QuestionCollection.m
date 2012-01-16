//
//  QuestionCollection.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionCollection.h"

@implementation QuestionCollection

@synthesize questions;

+ (QuestionCollection *)sharedInstance
{
    // the instance of this class is stored here
    static QuestionCollection *myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        [myInstance setQuestions:[[NSMutableArray alloc] init]];
    }
    // return the instance of this class
    return myInstance;
}




@end
