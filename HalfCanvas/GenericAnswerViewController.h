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
#import "MainTabBarController.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface GenericAnswerViewController : UITableViewController <MBProgressHUDDelegate, FeedCellDelegate, UIImagePickerControllerDelegate, ASIHTTPRequestDelegate, UIAlertViewDelegate>
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
@property (retain) MPMoviePlayerViewController *mp;
@property (nonatomic, retain) NSURL *localURL;
@property (nonatomic, retain) NSString *instanceURL;


- (void)loadData;
-(void)setupVideoUploadRequest;

- (void)startCamera;
- (void)startPictureChooser;
- (void)handleMainImageClick:(int)indexNum;
- (void)handlePlayMovie:(NSURL*)movieURL;

-(IBAction)playbackMovie:(id)sender;
- (IBAction)addAnswerClick:(id)sender;

- (void)likeDidFinish:(ASIHTTPRequest *)request;
- (void)likeDidFail:(ASIHTTPRequest *)request;

@end
