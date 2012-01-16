//
//  FeedController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedController.h"


@implementation FeedController



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
    NSLog(@"TabBarController loaded");
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8000/questions/"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }

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
    questionsLoaded = false;
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
    if (questionsLoaded) 
    {
        return [[[QuestionCollection sharedInstance] questions] count];
    }
    else 
    {
        return 0;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (questionsLoaded) 
    {
        return 1;
    }
    else 
    {
        return 0;
    }
    
}

-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (questionsLoaded) 
    {
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 20)];
        
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,30,30)];
        [userImageView setImage:[UIImage imageNamed:@"profile_picture.jpg"]];
        NSLog(@"Count: %d",[[[QuestionCollection sharedInstance] questions] count]);
        Question *test = [[[QuestionCollection sharedInstance] questions] objectAtIndex:section];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:[test user]];
        [myView addSubview:userLabel];
        [myView addSubview:userImageView];
                                                                       
                                                                       
        //[[headerView user] setText:@"test"];
        return myView;
    }
    else
    {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedCell";
    
    FeedCell *feedCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (feedCell == nil) {
        feedCell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return feedCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  200;
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load more pictures when at bottom of table (xth row)
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (segue.identifier.length > 0)
    {        
        if ([segue.identifier isEqualToString:@"QuestionToAnswer"])
        {
            //fdfad *viewControllerB = (ViewControllerB *)segue.destinationViewController;
            //And you can pass data between the two controller.  
            //viewControllerB.currentRow = self.selectedRow; 
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
  	[HUD hide:YES afterDelay:2];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    
    NSString *txt = [[NSString alloc] initWithData:receivedData encoding: NSASCIIStringEncoding];    
    NSLog(@"Data: %@",txt);
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    id jsonObjects = [jsonParser objectWithString:txt error:&error];
    
    if ([jsonObjects isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Dictionary");
        // treat as a dictionary, or reassign to a dictionary ivar
    }
    else if ([jsonObjects isKindOfClass:[NSArray class]])
    {
        NSLog(@"Array");
        // treat as an array or reassign to an array ivar.
        
        
        for (NSDictionary *dict in jsonObjects)
        {
            Question *newQuestion = [[Question alloc] init];
            NSDictionary *fieldDict = [dict objectForKey:@"fields"];
            [newQuestion setDescription:[fieldDict objectForKey:@"description"]];
            [newQuestion setImage_url:[fieldDict objectForKey:@"image_url"]];
            [newQuestion setUser:[fieldDict objectForKey:@"user"]];
            NSLog(@"Image Url: %@", [newQuestion image_url]);
            [[[QuestionCollection sharedInstance] questions] addObject:newQuestion];
            NSLog(@"Done adding");
        }
    }
    //HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] ;
    //HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
    questionsLoaded = true;
    [[self tableView] reloadData];  
}



@end
