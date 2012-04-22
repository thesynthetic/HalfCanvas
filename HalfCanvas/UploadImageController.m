//
//  UploadImageController1.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UploadImageController.h"


@implementation UploadImageController

@synthesize comments;
@synthesize tags;
@synthesize imageToUpload;
@synthesize isQuestion;
@synthesize question_id;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

-(IBAction)cancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:false];
}

-(IBAction)doneButton:(id)sender
{
    NSLog(@"Upload");
    
    //Upload
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDAnimationFade;

	HUD.delegate = self;
    HUD.labelText = @"Uploading";
    
    [HUD show:YES];
    
    if (isQuestion)
    {
        [self uploadDataAsQuestion];
    }
    else 
    {
        [self uploadDataAsAnswer];
    }
}

-(void)uploadDataAsQuestion
{
    NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com/create_question/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setData:UIImageJPEGRepresentation(imageToUpload,0.35) withFileName:@"upload.jpg" andContentType:@"image/jpeg" forKey:@"file"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [user objectForKey:@"access_token"];
    [request setPostValue:access_token forKey:@"access_token"];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)uploadDataAsAnswer
{
    NSLog(@"%d",[self question_id]);
    NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com/create_answer/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setData:UIImageJPEGRepresentation(imageToUpload,0.35) withFileName:@"upload.jpg" andContentType:@"image/jpeg" forKey:@"file"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [user objectForKey:@"access_token"];
    [request setPostValue:[NSString stringWithFormat:@"%d",[self question_id]] forKey:@"question_id"];
    [request setPostValue:access_token forKey:@"access_token"];
    [request setDelegate:self];
    [request startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [HUD hide:YES];
    [self.navigationController popViewControllerAnimated:false];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [HUD hide:YES];
    HUD.labelText = @"Could not upload.";
    
    [HUD show:YES];
	[HUD hide:YES afterDelay:3];
}


@end
