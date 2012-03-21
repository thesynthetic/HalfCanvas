//
//  AnswerViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"
#import "ASIDownloadCache.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "Answer.h"
#import "FeedCell.h"
#import "PictureViewController.h"

@interface AnswerViewController : UITableViewController <MBProgressHUDDelegate, FeedCellDelegate>
{
    NSInteger question_id;
    
    NSMutableArray *answerCollection;   
    NSMutableDictionary *imageCache;
    
    ASINetworkQueue *networkQueue;
    
    MBProgressHUD *HUD;
    
    //PictureViewer
    int pictureViewerIndex;
}

@property NSInteger question_id;
@property (retain) NSMutableArray *answerCollection;
@property (retain) NSMutableDictionary *imageCache;

- (void)loadData;

@end
