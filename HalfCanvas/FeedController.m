//
//  FeedController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedController.h"


@implementation FeedController

@synthesize imageDownloadsInProgress;
@synthesize questions;
@synthesize popup;
@synthesize picker;
@synthesize imageToPost;
@synthesize qcol;
@synthesize qc;

@synthesize imageCache;

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
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    qc = [[NSMutableArray alloc] init];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    self.imageCache = [[NSMutableDictionary alloc] init];
    
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    //failed = NO;
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
    [networkQueue setShowAccurateProgress:true];
    [networkQueue setDelegate:self];
    
    //Turn on caching and set defaults
    [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
    
    
    
    
    [self loadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [qc count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([qc count] > 0) 
    {
        return 1;
    }
    else 
    {
        //If not loaded yet (2 will fill the screen)
        return 2;
    }
    
}

-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([qc count] > 0) 
    {
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor whiteColor]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 20)];
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,30,30)];
        UIImage *tempImg = [imageCache objectForKey:[[qc objectAtIndex:section] user_profile_image_url]];
                                                     
        if (tempImg != nil)
        {
            [userImageView setImage:tempImg];
        }
        else 
        {
            ASIHTTPRequest *request;
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[qc objectAtIndex:section] user_profile_image_url]]];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
            [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [request setSecondsToCache:60*60*24*7];

            [networkQueue addOperation:request];
            [networkQueue go];
        }
        
        Question *test = [qc objectAtIndex:section];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:[test username]];
        [myView addSubview:userLabel];
        [myView addSubview:userImageView];
        
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

    UIImage *tempImg = [imageCache objectForKey:[[qc objectAtIndex:indexPath.section] image_url]];
    
    if (tempImg != nil)
    {
        [[feedCell imageView] setImage:tempImg];
    }
    else 
    {
        ASIHTTPRequest *request;
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[qc objectAtIndex:indexPath.section] image_url]]];
        [request setDownloadCache:[ASIDownloadCache sharedCache]];
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
        [request setSecondsToCache:60*60*24*7];
        [request setDownloadProgressDelegate:[feedCell imageProgressIndicator]];
        
        [networkQueue addOperation:request];
        [networkQueue go];
        
    }

    return feedCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  350;
}
-(IBAction)imageClick:(id)sender 
{
    NSLog(@"CLICKED!");
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
}


////New Functions
//- (void)startImageDownload:(Question *)question forIndexPath:(NSIndexPath *)indexPath
//{
//    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
//    if (iconDownloader == nil) 
//    {
//        iconDownloader = [[IconDownloader alloc] init];
//        iconDownloader.question = [[QuestionCollection questions] objectAtIndex:indexPath.section];
//        NSLog(@"Downloading index: %d",indexPath.section);
//        iconDownloader.indexPath = indexPath;
//        iconDownloader.delegate = self;
//        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
//        [iconDownloader startDownload];
//    }
//}

//// called by our ImageDownloader when an icon is ready to be displayed
//- (void)appImageDidLoad:(NSIndexPath *)indexPath
//{
//    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
//    if (iconDownloader != nil)
//    {
//        FeedCell *feedCell = [self.tableView cellForRowAtIndexPath:indexPath];
//        
//        // Display the newly loaded image
//        [[[QuestionCollection questions] objectAtIndex:indexPath.section] setImage:iconDownloader.question.image];
//        feedCell.imageView.image = iconDownloader.question.image;
//    }
//}


//- (void)loadImagesForOnscreenRows
//{
//    if ([[QuestionCollection questions] count] > 0)
//    {
//        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
//        for (NSIndexPath *indexPath in visiblePaths)
//        {
//            Question *question = [[QuestionCollection questions] objectAtIndex:indexPath.section];
//            
//            if (!question.image) // avoid the app icon download if the app already has an icon
//            {
//                [self startImageDownload:question forIndexPath:indexPath];
//            }
//        }
//    }
//}

//// Load images for all onscreen rows when scrolling is finished
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate)
//	{
//        [self loadImagesForOnscreenRows];
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self loadImagesForOnscreenRows];
//}

#pragma mark - Popup Menu for Camera

- (void)cameraButtonClick
{
    popup = [[UIActionSheet alloc] initWithTitle:@"Post a problem" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"From album", nil];
    [popup showFromTabBar:self.tabBarController.tabBar];
    
    //[popup setActionSheetStyle:UIActionSheetStyleBlackOpaque];
//    [popup showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self startCamera];
    } else if (buttonIndex == 1) {
        [self startPictureChooser];
    } 
    else if (buttonIndex == 2) {
//        [popup dismissWithClickedButtonIndex:buttonIndex animated:true];  
    }
}

//-(void)actionSheetCancel:(UIActionSheet *)actionSheet   
//{
//    NSLog(@"cancel");
//}


#pragma mark - Image Picker

-(void) startCamera
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = true;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];
}

- (void) startPictureChooser
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = true;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:picker animated:YES];
}



//UIImagePickerController Delegate Functions
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self setImageToPost:image];
    [picker dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"didcapturepicture" sender:self];
}
//Function to get rid of the picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"didcapturepicture"])
    {
        UploadImageController *vc = [segue destinationViewController];
        [vc setImageToPost:[self imageToPost]];
    }
}

#pragma mark - Server Connectivity

//Load JSON Data from Server
-(IBAction)loadData
{
    NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com:8000/questions/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy];
    
    [request startAsynchronous];

    
    //Show HUD
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    //HUD.labelText = @"Loading";
    
    [HUD show:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([request didUseCachedResponse])
    {
        NSLog(@"Did use cache!");   
    }
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@", responseString);
    [qc removeAllObjects];
    
    // Parse JSON Data and create question collection
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    id jsonObjects = [jsonParser objectWithString:responseString error:&error];
    
    if ([jsonObjects isKindOfClass:[NSDictionary class]])
    {
        // treat as a dictionary, or reassign to a dictionary ivar
    }
    else if ([jsonObjects isKindOfClass:[NSArray class]])
    {
        //Load the server data into Core Data
        
        for (NSDictionary *dict in jsonObjects)
        {
            Question *newQuestion = [[Question alloc] init];

            [newQuestion setUsername:[dict objectForKey:@"username"]];
            [newQuestion setQuestion_id:[[dict objectForKey:@"question_id"] integerValue]];
            [newQuestion setImage_url:[dict objectForKey:@"image_url"]];
            [newQuestion setDescription:[dict objectForKey:@"description"]];
            [newQuestion setUser_profile_image_url:[dict objectForKey:@"user_profile_image_url"]];             

            [qc addObject:newQuestion];
            NSLog(@"%d",[qc count]);
        }
    }
    
    [HUD hide:YES];
    [[self tableView] reloadData];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection" 
                                                    message:[error description]
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //Todo: Display Error Message
}


- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
	UIImage *img = [UIImage imageWithData:[request responseData]];
    NSLog(@"Downloaded...%@",[[request url] absoluteString]);
    [imageCache setObject:img forKey:[[request url] absoluteString]];
    [[self tableView] reloadData];
}

- (void)imageFetchFailed:(ASIHTTPRequest *)request
{
	/*
     if (!failed) {
		if ([[request error] domain] != NetworkRequestErrorDomain || [[request error] code] != ASIRequestCancelledErrorType) {
			UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download images" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[alertView show];
		}
		failed = YES;
	}
     */
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    NSLog(@"clicked");
}




@end
