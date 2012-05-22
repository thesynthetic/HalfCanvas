//
//  ActivityViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ActivityCell.h"
#import "Action.h"

@interface ActivityViewController : UITableViewController
{
    
}

@property (nonatomic, retain) NSMutableArray *activityArray;
@end
