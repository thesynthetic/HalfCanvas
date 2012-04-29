//
//  FeedController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FeedCell.h"
#import "SBJson.h"
#import "Question.h"
#import "User.h"
#import "Image.h"
#import "QuestionCollection.h"
#import "MBProgressHUD.h"
#import "IconDownloader.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIDownloadCache.h"
#import "UploadImageController.h"
#import "PictureViewController.h"
#import "AnswerViewController.h"
#import "ASIFormDataRequest.h"

@class ASINetworkQueue;

@interface FeedController : UITableViewController <IconDownloaderDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate, FeedCellDelegate>
{
    QuestionCollection *qcol;
    NSMutableArray *qc;
    
    NSArray *questions;
    MBProgressHUD *HUD;
    NSMutableData *receivedData;   
    BOOL questionsLoaded;
    NSMutableDictionary *imageDownloadsInProgress;
    UIActionSheet *actionSheetQuestion;
    UIActionSheet *actionSheetAnswer;
    UIImagePickerController *picker;
    UIImage *imageToUpload;
    NSMutableDictionary *imageCache;
    
    //ASIHttp Variables
    ASINetworkQueue *networkQueue;
    
    //PictureViewer
    int pictureViewerIndex;
    
    //AnswerViewer
    int answerViewerIndex;
    
    int questionEndIndex;
    
    BOOL addingQuestion;
    UIView *nibView;
    
    BOOL loading;
    BOOL animationFinished;
}

-(IBAction)imageClick:(id)sender;
-(IBAction)loadData;
-(IBAction)cameraButtonClick;
-(IBAction)addAnswer:(id)sender;

@property (retain) NSMutableArray *qc;
@property (retain) QuestionCollection *qcol;
@property (retain) NSMutableDictionary *imageCache;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (retain) NSArray *questions;
@property (retain) UIActionSheet *actionSheetQuestion;
@property (retain) UIActionSheet *actionSheetAnswer;
@property (retain) UIImagePickerController *picker;
@property (retain) UIImage *imageToUpload;
@property (nonatomic) BOOL addingQuestion;



-(void)startCamera;
-(void)startPictureChooser;


- (void)imageFetchComplete:(ASIHTTPRequest *)request;
- (void)imageFetchFailed:(ASIHTTPRequest *)request;

- (void)handleAnswerclick:(int)indexNum;
- (void)handleMainImageClick:(int)indexNum;
- (void)handleAddAnswerClick:(int)indexNum;

@end
