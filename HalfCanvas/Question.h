//
//  Question.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
{
    NSString *username;
    NSInteger question_id;
    NSString *image_url;
    NSString *description;
    NSString *user_profile_image_url;
    NSInteger answer_count;
}

@property (retain) NSString *username;
@property NSInteger question_id;
@property (retain) NSString *image_url;
@property (retain) NSString *description;
@property (retain) NSString *user_profile_image_url;
@property NSInteger answer_count;

@end