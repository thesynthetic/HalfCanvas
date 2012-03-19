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

@interface UploadImageController1 : UITableViewController <ASIHTTPRequestDelegate>
{
    UITextView *comments;
    UITextField *tags;
    UIImage *imageToUploader;
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) IBOutlet UITextView *comments;
@property (nonatomic, retain) IBOutlet UITextField *tags;
@property (nonatomic, retain) UIImage *imageToUpload;

-(IBAction)cancelButton:(id)sender;
-(IBAction)doneButton:(id)sender;

@end
