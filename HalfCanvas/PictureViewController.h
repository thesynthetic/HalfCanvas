//
//  PictureViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController: UIViewController <UIScrollViewDelegate> {
    UIScrollView *imageScrollView;
	UIImageView *imageView;
    UIImage *image;
}

@property (nonatomic, retain) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;

-(IBAction)closePictureViewer:(id)sender;

@end





