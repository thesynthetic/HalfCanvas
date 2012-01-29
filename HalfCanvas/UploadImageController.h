//
//  UploadImageController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UploadImageController : UIViewController
{
    UITextField *tags;
    UITextView *comments;
    UIBarItem *post;
    UIButton *cancel;
    
    UIImage *imagetoPost;
    UIImageView *viewer;
    
    UIScrollView *scroller;
}

@property (retain) IBOutlet UITextField *tags;
@property (retain) IBOutlet UITextView *comments;
@property (retain) IBOutlet UIBarItem *post;
@property (retain) IBOutlet UIButton *cancel;
@property (retain) UIImage *imageToPost;
@property (retain) IBOutlet UIScrollView *scroller;
@property (retain) IBOutlet UIImageView *viewer;

@end
