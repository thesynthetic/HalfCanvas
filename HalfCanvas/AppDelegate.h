//
//  AppDelegate.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionCollection.h"
#import "SBJson.h"
#import "Question.h"
#import "FeedController.h"
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableData *receivedData;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain) NSMutableData *receivedData;

@end
