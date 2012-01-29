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

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate>
{
    UITabBarController *parentNavController;
    UIImage *imageToPost;
}

@property (retain) IBOutlet UITabBarController *parentNavController;
@property (retain) UIImage *imageToPost;

@end
