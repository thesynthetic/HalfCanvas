//
//  Answer.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject
{
    NSString *username;
    NSInteger answer_id;
    NSString *image_url;
    NSString *description;
    NSString *user_profile_image_url;
}

@property (retain) NSString *username;
@property NSInteger answer_id;
@property (retain) NSString *image_url;
@property (retain) NSString *description;
@property (retain) NSString *user_profile_image_url;

@end
