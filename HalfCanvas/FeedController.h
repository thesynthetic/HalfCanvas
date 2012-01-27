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
#import "IconDownloader.h"

@interface FeedController : UITableViewController <IconDownloaderDelegate>
{
    NSArray *questions;
    MBProgressHUD *HUD;
    NSMutableData *receivedData;   
    BOOL questionsLoaded;
    NSMutableDictionary *imageDownloadsInProgress;
    
}

-(IBAction)imageClick:(id)sender;
-(IBAction)loadData;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (retain) NSArray *questions;

- (void)startImageDownload:(Question *)question  forIndexPath:(NSIndexPath *)indexPath;
- (void)loadImagesForOnscreenRows;

@end
