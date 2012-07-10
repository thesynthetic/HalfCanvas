//
//  MainTabBarController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "Question.h"
#import "QuestionCollection.h"

@interface MainTabBarController : UITabBarController <UITabBarControllerDelegate>
{



}

@property (retain) UIProgressView *progressView;

-(void) goToFirstTab;
-(UIProgressView*) setupProgressBar;
-(void) removeProgressBar;
@end
