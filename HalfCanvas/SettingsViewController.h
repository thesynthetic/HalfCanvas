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
#import "ASIDownloadCache.h"
#import <CommonCrypto/CommonDigest.h>
#import "FeedController.h"
#import "MainTabBarController.h"
#import "ActivityViewController.h"
#import "GenericAnswerViewController.h"
#import "MBProgressHUD.h"

@interface SettingsViewController : UITableViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate>
{
    BOOL loggedIn;
    
}

@property (nonatomic, retain) UIImage *profilePicture;

- (NSString*)md5HexDigest:(NSString*)input;

@end
