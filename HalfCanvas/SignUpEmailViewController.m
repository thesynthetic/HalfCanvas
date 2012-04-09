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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (state == 0)
    {
        return 4;
    }
    else 
    {
        return 2;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 95, 21)];
    
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
        
        
    [cell addSubview:cellLabel];
        
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Handlers

-(IBAction)test:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;    
    state = [segmentedControl selectedSegmentIndex];
    [[self tableView] reloadData];
}

-(IBAction)doneButtonClick:(id)sender
{
    if (state == 0)
    {
        //Sign Up Handler
        

        
        
    }
    else 
    {
        NSLog(@"HERE");
        //Sign In Handler
        NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com/login/"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:[username text] forKey:@"username"];
        [request setPostValue:[password text] forKey:@"password"];
        [request startAsynchronous];
        
    }
}

#pragma mark - ASI HTTP Request Callback

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"Response: %@", responseString);
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"ERROR");
}

//Gravitar URL - Retro Style Identicon http://www.gravatar.com/avatar/f778d4000d84e1434d04eb8526ec3de2?d=retro


@end
