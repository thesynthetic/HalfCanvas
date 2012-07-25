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
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AnswerViewController.h"


@interface ActivityViewController : UITableViewController
{
    
}

@property (nonatomic, retain) NSMutableArray *activityArray;
@property (nonatomic, retain) NSMutableDictionary *imageCache;
@property (nonatomic, retain) ASINetworkQueue *networkQueue;


-(void)removeCacheForURL:(NSString*)url;

@end
