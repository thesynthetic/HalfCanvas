//
//  ActivityViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"


@implementation ActivityViewController

@synthesize activityArray;
@synthesize imageCache;
@synthesize networkQueue;


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



    self.imageCache = [[NSMutableDictionary alloc] init];
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue reset];
    [networkQueue setDelegate:self];
    [networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
    [networkQueue setShowAccurateProgress:true];

    self.clearsSelectionOnViewWillAppear = NO;
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    activityArray = [appDelegate globalActions];
    [[self tableView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:nil];
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
    return [activityArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityCell";
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Action *action = [activityArray objectAtIndex:indexPath.row];
    NSString *senderImageURL = [action senderImageURL];
    UIImage *tempImg = [imageCache objectForKey:senderImageURL];    
    
    if (tempImg != nil)
    {
        [[cell senderImage] setImage:tempImg];
    }
    else 
    {
        ASIHTTPRequest *request;
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:senderImageURL]];
        [request setDownloadCache:[ASIDownloadCache sharedCache]];
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
        [request setSecondsToCache:60*60*24*7];
        //[request setDownloadProgressDelegate:[feedCell imageProgressIndicator]];
        
        [networkQueue addOperation:request];
        [networkQueue go];    
    }

    if ([[action actionType] isEqualToString:@"like"])
    {
        [[cell text] setText:@"likes your lesson"];
    }
    else if ([[action actionType] isEqualToString:@"answer"]) 
    {
        [[cell text] setText:@"posted a lesson for you"];
    }
    
    
    [[cell senderUsername] setText:[action senderUsername]];
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
    
    Action *action = [activityArray objectAtIndex:indexPath.row];
    if ([[action actionType] isEqualToString:@"like"] || [[action actionType] isEqualToString:@"answer"])
    {
        //Load answer page
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        AnswerViewController *answerView = [sb instantiateViewControllerWithIdentifier:@"AnswerViewController"];
        [answerView setQuestion_id:24];
        [self.navigationController pushViewController:answerView animated:YES];
        
    }
    else 
    {
        //Other type (not handled)
    }
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - Network Queue callback

- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
	UIImage *img = [UIImage imageWithData:[request responseData]];
    [imageCache setObject:img forKey:[[request url] absoluteString]];
    [[self tableView] reloadData];
}

- (void)imageFetchFailed:(ASIHTTPRequest *)request
{
     //Incomplete Implementation: Handle failed image request
}

-(void)removeCacheForURL:(NSString*)url{
    [imageCache removeObjectForKey:url];
}


@end
