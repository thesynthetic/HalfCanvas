//
//  SignUpEmailViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "ProfilePictureCell.h"
#import <CommonCrypto/CommonDigest.h>

@interface SignUpEmailViewController : UITableViewController <ASIHTTPRequestDelegate, UITextFieldDelegate, ProfilePictureDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    UISegmentedControl *segcontrol;    
    UITextField *username;
    UITextField *password;
    UITextField *email;
    
    UITableViewCell *doneCell;
    
    //0 = sign up; 1 = sign in
    int state;
    
}


@property (retain) UITextField *username;
@property (retain) UITextField *password;
@property (retain) UITextField *email;
@property (retain) NSString *usernameString;
@property (retain) NSString *passwordString;
@property (retain) NSString *emailString;

@property (nonatomic, retain) UISegmentedControl *segcontrol;
@property (nonatomic, retain) IBOutlet UITableViewCell *doneCell;
@property (nonatomic, retain) UIImage *profilePicture;

-(IBAction)test:(id)sender;
-(IBAction)submitClick:(id)sender;


- (void)handleProfilePictureTap:(id)sender;
- (void)usernameDidChange:(id)sender;
- (void)passwordDidChange:(id)sender;
- (void)emailDidChange:(id)sender;

- (NSString*)md5HexDigest:(NSString*)input;
- (void)profilePictureRequestFinished:(ASIHTTPRequest *)request;
@end
