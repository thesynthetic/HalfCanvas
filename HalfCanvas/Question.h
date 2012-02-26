//
//  Question.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) User *user;

@end
