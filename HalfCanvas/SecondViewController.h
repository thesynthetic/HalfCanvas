//
//  SecondViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate>
{
    UITabBarController *parentNavController;
}

@property (retain) IBOutlet UITabBarController *parentNavController;
@end
