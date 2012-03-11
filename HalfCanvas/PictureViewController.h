//
//  PictureViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController
{
    bool hiddenEdges;
    UINavigationBar *navBar;
    UIScrollView *scrollView;
    UIImageView *imageView;
    UIImage *image;
}

@property (retain) IBOutlet UINavigationBar *navBar;
@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) IBOutlet UIImageView *imageView;
@property (retain) UIImage *image;

-(IBAction)closePictureViewer:(id)sender;
@end
