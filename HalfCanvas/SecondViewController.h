//
//  SecondViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
#import "UploadImageController.h"

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    UITabBarController *parentNavController;
    UIImage *imageToPost;
    UIActionSheet *popup;
    NSUInteger cameraStatus;
}

@property (retain) IBOutlet UITabBarController *parentNavController;
@property (retain) UIImage *imageToPost;
@property (retain) UIActionSheet *popup;

-(void) startPictureChooser;
-(void) startCamera;

@end
