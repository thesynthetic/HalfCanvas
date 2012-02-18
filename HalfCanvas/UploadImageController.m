//
//  UploadImageController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UploadImageController.h"

@implementation UploadImageController

@synthesize tags;
@synthesize comments;
@synthesize post;
@synthesize cancel;
@synthesize imageToPost;
@synthesize scroller;
@synthesize viewer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [scroller setScrollEnabled:true];
    [scroller setContentSize:CGSizeMake(320,550)];
    [comments.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [comments.layer setBorderWidth: 1.0];
    [comments.layer setCornerRadius:5];
    [comments.layer setMasksToBounds:YES];
    
    [viewer setImage:imageToPost];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
