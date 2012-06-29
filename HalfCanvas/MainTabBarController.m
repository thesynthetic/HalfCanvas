//
//  MainTabBarController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarController.h"



@implementation MainTabBarController

@synthesize progressView;

-(id)initWithCoder:(NSCoder *)aDecoder 
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        NSLog(@"TabBar being initialized.");
    }

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.delegate = self;

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

-(void) goToFirstTab
{
    [self setSelectedIndex:0];
    
}

-(UIProgressView*) setupProgressBar
{
    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar ];
    progressView.frame = CGRectMake(0,490, 320,10);
    [[self view] addSubview:progressView];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:nil
                     animations:^{
                         progressView.frame = CGRectMake(0,470, 320,10);
                         CGRect test = self.tabBar.frame;
                         self.tabBar.frame = CGRectMake(test.origin.x, test.origin.y-10, test.size.width, test.size.height);
                     }
                     completion:nil];
    
    return progressView;
}

-(void) removeProgressBar
{

    [[self view] addSubview:progressView];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:nil
                     animations:^{
                         progressView.frame = CGRectMake(0,480, 320,10);
                         CGRect test = self.tabBar.frame;
                         self.tabBar.frame = CGRectMake(test.origin.x, test.origin.y+10, test.size.width, test.size.height);
                     }
                     completion:nil];
}





@end
