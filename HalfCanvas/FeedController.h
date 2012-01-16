//
//  FeedController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedCell.h"
#import "SBJson.h"
#import "Question.h"
#import "QuestionCollection.h"
#import "MBProgressHUD.h"

@interface FeedController : UITableViewController
{
    MBProgressHUD *HUD;
    NSMutableData *receivedData;   
    BOOL questionsLoaded;
}


@end
