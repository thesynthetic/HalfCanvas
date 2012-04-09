//
//  SignUpViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController

@synthesize signUpButton;

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
    [super viewDidLoad];
    [signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    
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

#pragma mark - Action Handlers

-(IBAction)doneButtonClick:(id)sender
{
    [self dismissModalViewControllerAnimated:true];
}

-(IBAction)useEmailAddress:(id)sender
{
    [self performSegueWithIdentifier:@"UseEmailAddress" sender:self];
}



@end
