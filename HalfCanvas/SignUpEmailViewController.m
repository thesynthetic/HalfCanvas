//
//  SignUpEmailViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUpEmailViewController.h"


@implementation SignUpEmailViewController

@synthesize username;
@synthesize password;
@synthesize email;
@synthesize segcontrol;
@synthesize doneCell;

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
    state = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0){
        if (state == 0)
        {
            return 4;
        }
        else 
        {
            return 2;
        }
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell;
    UILabel *cellLabel;
    
    if (indexPath.section == 0){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 95, 21)];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
        if (state == 0)
        {

            if (indexPath.row == 0)
            {
                username = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [cellLabel setText:@"Username"];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
                username.placeholder = @"johnsmith";
                username.adjustsFontSizeToFitWidth = YES;
                username.textColor = [UIColor blackColor];
                [cell addSubview:username];
            }
            if (indexPath.row == 1)
            {
                email = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [cellLabel setText:@"Email"];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
                email.placeholder = @"john@smith.com";
                email.adjustsFontSizeToFitWidth = YES;
                email.textColor = [UIColor blackColor];
                [cell addSubview:email];
            }
            if (indexPath.row == 2)
            {
                password = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [cellLabel setText:@"Password"];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                password.secureTextEntry = YES;
                password.adjustsFontSizeToFitWidth = YES;
                password.textColor = [UIColor blackColor];
                [cell addSubview:password];
            }
            if (indexPath.row == 3)
            {
                
                [cellLabel setText:@"Photo"];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
            }
        }
        else 
        {
            if (indexPath.row == 0)
            {
                username = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [cellLabel setText:@"Username"];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
                username.placeholder = @"johnsmith";
                username.adjustsFontSizeToFitWidth = YES;
                username.textColor = [UIColor blackColor];
                [cell addSubview:username];
            }
            if (indexPath.row == 1)
            {
                password = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [cellLabel setText:@"Password"];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                password.secureTextEntry = YES;
                password.adjustsFontSizeToFitWidth = YES;
                password.textColor = [UIColor blackColor];
                [cell addSubview:password];
            }
            
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else 
    {   
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(129, 11, 42, 21)];
        [cellLabel setTextAlignment:UITextAlignmentCenter];
        [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [cellLabel setBackgroundColor:[UIColor clearColor]];
        [cellLabel setText:@"Done"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
        
    [cell addSubview:cellLabel];
        
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
    
        if (state == 0) //Sign Up Handler
        {
            NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com/create_user/"];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request setDelegate:self];
            [request setPostValue:[username text] forKey:@"username"];
            [request setPostValue:[password text] forKey:@"password"];
            [request setPostValue:[email text] forKey:@"email"];
            [request startAsynchronous];        
        }
        else //Sign In Handler
        {
            NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com/login/"];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request setDelegate:self];
            [request setPostValue:[username text] forKey:@"username"];
            [request setPostValue:[password text] forKey:@"password"];
            [request startAsynchronous];
        }
    }
}

#pragma mark - Handlers

-(IBAction)test:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;    
    state = [segmentedControl selectedSegmentIndex];
    NSLog(@"State = %d",state);
    //[[self tableView] reloadData];
    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - ASI HTTP Request Callback

- (void)requestFinished:(ASIHTTPRequest *)request
{    
   
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *jsonError = nil;
    
    id jsonObjects = [jsonParser objectWithString:[request responseString] error:&jsonError];
    
    if ([jsonObjects isKindOfClass:[NSDictionary class]])
    {
        NSString *errorcode = [jsonObjects objectForKey:@"errorcode"];
        NSString *errormessage = [jsonObjects objectForKey:@"errormessage"];
        if ([errorcode doubleValue] != 0)
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:errormessage
                                                              message:@""
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
        else 
        {
            //Handle access code and setting NSUserDefaults
            NSDictionary *data = [jsonObjects objectForKey:@"data"];
            NSString *access_token = [data objectForKey:@"access_token"];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setValue:access_token forKey:@"access_token"];
            [user setValue:[username text] forKey:@"username"];
            [user setBool:TRUE forKey:@"logged_in"];

            [self.navigationController dismissModalViewControllerAnimated:true];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"ERROR");
}

//Gravitar URL - Retro Style Identicon http://www.gravatar.com/avatar/f778d4000d84e1434d04eb8526ec3de2?d=retro


@end
