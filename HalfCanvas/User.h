//
//  User.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSData * user_image;
@property (nonatomic, retain) NSString * user_image_url;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *question;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addQuestionObject:(NSManagedObject *)value;
- (void)removeQuestionObject:(NSManagedObject *)value;
- (void)addQuestion:(NSSet *)values;
- (void)removeQuestion:(NSSet *)values;

@end
