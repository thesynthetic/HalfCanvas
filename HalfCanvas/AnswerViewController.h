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
#import "UploadImageController.h"


@interface AnswerViewController : UITableViewController <MBProgressHUDDelegate, FeedCellDelegate, UIImagePickerControllerDelegate>
{
    NSInteger question_id;
    NSMutableArray *answerCollection;   
    NSMutableDictionary *imageCache;
    ASINetworkQueue *networkQueue;
    MBProgressHUD *HUD;
    int pictureViewerIndex;
    UIActionSheet *popup;
    UIImagePickerController *picker;
    UIImage *imageToUpload;

}

@property (retain) MPMoviePlayerController *currentPlayer;
@property NSInteger question_id;
@property (retain) NSMutableArray *answerCollection;
@property (retain) NSMutableDictionary *imageCache;
@property (retain) UIActionSheet *popup;
@property (retain) UIImagePickerController *picker;
@property (retain) UIImage *imageToUpload;


- (void)loadData;
- (void)addAnswerClick;
- (void)startCamera;
- (void)startPictureChooser;
- (void)handleMainImageClick:(int)indexNum;

-(IBAction)playbackMovie:(id)sender;

@end
