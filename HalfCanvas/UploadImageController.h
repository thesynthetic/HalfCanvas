//
//  UploadImageController1.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface UploadImageController : UITableViewController <ASIHTTPRequestDelegate>
{
    UITextView *comments;
    UITextField *tags;
    UIImage *imageToUploader;
    MBProgressHUD *HUD;
    BOOL isQuestion;
    int question_id;
}

@property (nonatomic, retain) IBOutlet UITextView *comments;
@property (nonatomic, retain) IBOutlet UITextField *tags;
@property (nonatomic, retain) UIImage *imageToUpload;
@property (nonatomic) BOOL isQuestion;
@property (nonatomic) int question_id;

-(IBAction)cancelButton:(id)sender;
-(IBAction)doneButton:(id)sender;

-(void)uploadDataAsQuestion;
-(void)uploadDataAsAnswer;

@end

