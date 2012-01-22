//
//  QuestionCollection.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionCollection.h"

@implementation QuestionCollection

@synthesize questionArray;

+ (NSMutableArray *)questions
{
    // the instance of this class is stored here
    static QuestionCollection *myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        [myInstance setQuestionArray:[[NSMutableArray alloc] init]];
    }
    // return the instance of this class
    return myInstance.questionArray;
}




@end
