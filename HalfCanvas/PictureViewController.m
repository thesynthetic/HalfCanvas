//
//  PictureViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PictureViewController.h"

@implementation PictureViewController

@synthesize navBar;
@synthesize scrollView;
@synthesize image;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    
    //[scrollView setUserInteractionEnabled:true];
    //[imageView setUserInteractionEnabled:true];
    [scrollView setContentSize:CGSizeMake(1000,1000)];
    [scrollView setMinimumZoomScale:scrollView.frame.size.width / imageView.frame.size.width];
    [scrollView setContentOffset:CGPointMake(1000,0)];
    [scrollView setDelegate:self];
    [scrollView setMaximumZoomScale:2.0];
    [scrollView setZoomScale:scrollView.minimumZoomScale];
    [scrollView setPagingEnabled:TRUE];

    [imageView setImage:image];
    [scrollView addSubview:imageView];
    [super viewDidLoad];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
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

-(IBAction)closePictureViewer:(id)sender
{
    [self dismissModalViewControllerAnimated:true];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"uh");
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == [self scrollView])
    {
        if (touch.tapCount == 1) {
        //    [self dismissModalViewControllerAnimated:true];
            
            if (hiddenEdges){
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                [navBar setAlpha:1.0];
                [UIView commitAnimations];
                hiddenEdges = false;
            }
            else 
            {
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                [navBar setAlpha:0.0];
                [UIView commitAnimations];
                
                hiddenEdges = true;
            }
            
        }
    }
    
}


@end
