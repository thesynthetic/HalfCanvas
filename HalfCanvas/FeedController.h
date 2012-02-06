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
#import "UploadImageController.h"

@interface FeedController : UITableViewController <IconDownloaderDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    NSArray *questions;
    MBProgressHUD *HUD;
    NSMutableData *receivedData;   
    BOOL questionsLoaded;
    NSMutableDictionary *imageDownloadsInProgress;
    UIActionSheet *popup;
    UIImagePickerController *picker;
    UIImage *imageToPost;
}

-(IBAction)imageClick:(id)sender;
-(IBAction)loadData;
-(IBAction)cameraButtonClick;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (retain) NSArray *questions;
@property (retain) UIActionSheet *popup;
@property (retain) UIImagePickerController *picker;
@property (retain) UIImage *imageToPost;

- (void)startImageDownload:(Question *)question forIndexPath:(NSIndexPath *)indexPath;
- (void)loadImagesForOnscreenRows;
-(void)startCamera;
-(void)startPictureChooser;


@end
