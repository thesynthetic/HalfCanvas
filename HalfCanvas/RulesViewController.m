//
//  RulesViewController.m
//  Dittles
//
//  Created by Ryan Hittner on 8/5/12.
//
//

#import "RulesViewController.h"

@interface RulesViewController ()

@end

@implementation RulesViewController

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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(IBAction)touchA:(id)selector
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Wrong"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    [message show];
}

-(IBAction)touchB:(id)selector
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Try again"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    [message show];
}


-(IBAction)touchC:(id)selector
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Nope"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
    [message show];
}


-(IBAction)closeMe:(id)selector
{
  
    [self.navigationController dismissModalViewControllerAnimated:true];
}

@end
