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
    NSString *description;
    NSString *user;
    NSString *image_url;
    UIImage *image;
    bool beingDownloaded;
}

@property (retain) NSString *description;
@property (retain) NSString *user;
@property (retain) NSString *image_url;
@property (retain) UIImage *image;
@property bool beingDownloaded;

@end
