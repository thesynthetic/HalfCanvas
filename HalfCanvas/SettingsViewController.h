//
//  SettingsViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInViewController.h"
#import "MainTabBarController.h"
#import "ASIHTTPRequest.h"
#import <CommonCrypto/CommonDigest.h>

@interface SettingsViewController : UITableViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    BOOL loggedIn;
    
}

@property (nonatomic, retain) UIImage *profilePicture;

@end
