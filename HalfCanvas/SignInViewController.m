//
//  SignInViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignInViewController.h"


@implementation SignInViewController

@synthesize username;
@synthesize password;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0)
    {
        return 2;
    }
    if (section == 1) 
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        
    // Configure the cell...
    

        UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 95, 21)];
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
        else 
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
        
        [cell addSubview:cellLabel];


    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            UILabel *signInLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 95, 21)];
            [signInLabel setFont:[UIFont boldSystemFontOfSize:16]];    
            [signInLabel setText:@"Sign In"];
            [signInLabel setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:signInLabel];
        }
    }
        
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
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self signIn:self];
            
        }
        
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)signIn:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://askdittles.com/login/"];
	
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[username text] forKey:@"username"];
    [request setPostValue:[password text] forKey:@"password"];
    
    
	// Create a request
	// You don't normally need to retain a synchronous request, but we need to in this case because we'll need it later if we reload the table data
	//[self setRequest:[ASIHTTPRequest requestWithURL:url]];
    
	// Start the request
	[request startSynchronous];
	
	// Request has now finished
	NSError *error = [request error];
    NSString *response;
    if (!error) {
        response = [request responseString];
    }
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *jsonError = nil;
    id jsonObjects = [jsonParser objectWithString:response error:&jsonError];
    
    if ([jsonObjects isKindOfClass:[NSDictionary class]])
    {
        // treat as a dictionary, or reassign to a dictionary ivar
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
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
}

@end
