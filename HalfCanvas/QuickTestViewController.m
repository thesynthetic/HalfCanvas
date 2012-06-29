//
//  QuickTestViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuickTestViewController.h"

@interface QuickTestViewController ()

@end

@implementation QuickTestViewController





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated 
{
    NSLog(@"Viewwillapear");
    
   
    
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Hello world";
    root.grouped = YES;
    QSection *section = [[QSection alloc] init];
    QLabelElement *label = [[QLabelElement alloc] initWithTitle:@"Hello" Value:@"world!"];
    
    [root addSection:section];
    [section addElement:label];
                
    [self setRoot:root];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
