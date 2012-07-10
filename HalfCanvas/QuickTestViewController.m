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
    
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Settings";
    root.grouped = YES;
    
    QRootElement *test = [[QRootElement alloc] init];
    QLabelElement *testElement = [[QLabelElement alloc] initWithTitle:@"Testing element" Value:@""];
    test.title = @"Test";
    test.grouped = YES;
    QSection *testSection = [[QSection alloc] initWithTitle:@"Test section"];
    
    [test addSection:testSection];
    [testSection addElement:testElement];
    
    
    QSection *questionSection = [[QSection alloc] initWithTitle:@"Questions"];
    QLabelElement *labelQ1 = [[QLabelElement alloc] initWithTitle:@"Questions you've asked" Value:@""];
    
    
    [root addSection:questionSection];
    [questionSection addElement:labelQ1];
    [questionSection addElement:test];
    
    
    QSection *lessonSection = [[QSection alloc] initWithTitle:@"Lessons"];
    QLabelElement *labelL1 = [[QLabelElement alloc] initWithTitle:@"Lessons you've created" Value:@""];
    
    [root addSection:lessonSection];
    [lessonSection addElement:labelL1];
    
    QSection *accountSection = [[QSection alloc] initWithTitle:@"Account"];
    QLabelElement *labelA1 = [[QLabelElement alloc] initWithTitle:@"Edit Profile" Value:@""];
    QLabelElement *labelA2 = [[QLabelElement alloc] initWithTitle:@"Change Profile Picture" Value:@""];
    
    [root addSection:accountSection];
    [accountSection addElement:labelA1];  
    [accountSection addElement:labelA2];
    
    
    [self setRoot:root];
    

}

-(void)viewWillAppear:(BOOL)animated 
{
    NSLog(@"Viewwillapear");
    
   
    
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
