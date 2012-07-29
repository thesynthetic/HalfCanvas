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
@synthesize actionSheetAnswer;
@synthesize actionSheetQuestion;
@synthesize picker;
@synthesize imageToUpload;
@synthesize qcol;
@synthesize qc;
@synthesize ac;
@synthesize addingQuestion;
@synthesize imageCache;
@synthesize takingPicture;
@synthesize localURL;

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
    ac = [[NSMutableArray alloc] init];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"UINavigationBarHeader@2x.png"] forBarMetrics:UIBarMetricsDefault];
    UIImageView *headerFade = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, 320, 2)];
    [headerFade setImage:[UIImage imageNamed:@"UINavigationBarHeaderFade@2x.png"]];
    [[[self parentViewController] view] addSubview:headerFade];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f]];
    
//    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
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
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"HCStatusBar" owner:self options:nil];
    nibView = [nibObjects objectAtIndex:0];
    nibView.frame = CGRectMake(0,400, 320, 35);
    nibView.alpha = 0;
    [[[self parentViewController] view] addSubview:nibView];
    
    //Turn on caching and set defaults
    [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
    questionEndIndex = 10;
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
    //if ([qc count] > 0)
    //{
    //    return [qc count] + 1;       
    //}
    //else 
    //{
        return [qc count];
    //}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([qc count] > 0) 
    {
        if (section == [qc count] - 1)
        {
            return 2;
        }
        else 
        {
            return 1;            
        }

    }
    
    else 
    {
        //If not loaded yet (2 will fill the screen)
        return 2;
    }
    
}

-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([qc count] > 0 && section < [qc count]) 
    {
        Question *thisQuestion = [qc objectAtIndex:section];
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 4, 100, 20)];
        [userLabel setTextColor:[UIColor colorWithRed:94.0/255.0 green:94.0/255.0 blue:94.0/255.0 alpha:1.0f]];
        [userLabel setBackgroundColor:[UIColor clearColor]];
        
        UILabel *timestamp = [[UILabel alloc] initWithFrame:CGRectMake(50, 18, 100, 20)];
        [timestamp setTextColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0f]];
        [timestamp setBackgroundColor:[UIColor clearColor]];
        [timestamp setFont:[UIFont systemFontOfSize:9]];
        [timestamp setText:[thisQuestion pub_life]];
        
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,5,30,30)];
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
            //[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
            [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy];
            [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [request setSecondsToCache:60*60*24];

            [networkQueue addOperation:request];
            [networkQueue go];
        }
        
        
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:[thisQuestion username]];
        [myView addSubview:userLabel];
        [myView addSubview:userImageView];
        [myView addSubview:timestamp];
        
        return myView;
    }
    else
    {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row)
    {
        static NSString *CellIdentifier = @"LoadMoreCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //cell.contentView.backgroundColor = [UIColor grayColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"FeedCell";
        
        FeedCell *feedCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (feedCell == nil) {
            feedCell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [feedCell setDelegate:self];
        [feedCell initExtras];
        [feedCell setIndex:indexPath.section];
        UIImage *tempImg = [imageCache objectForKey:[[qc objectAtIndex:indexPath.section] image_url]];
        if ([[qc objectAtIndex:indexPath.section] answer_count] > 0)
        {
            [[feedCell answerCountLabel] setText:[NSString stringWithFormat:@"%i lessons posted", [[qc objectAtIndex:indexPath.section] answer_count]]];
            [[feedCell answerCountLabel] setFont:[UIFont systemFontOfSize:13]];
            [[feedCell answerCountLabel] setTextColor:[UIColor colorWithRed:0.0 green:146.0/255.0 blue:255.0/255.0 alpha:1.0]];
            
            [[feedCell answerCountButton] setUserInteractionEnabled:TRUE];
            
            [[feedCell createAnswerButton] setHidden:TRUE];
            [[feedCell createAnswerButton] setUserInteractionEnabled:FALSE];
        }
        else
        {
            [[feedCell answerCountLabel] setText:@"No lessons posted"];
            [[feedCell answerCountLabel] setFont:[UIFont systemFontOfSize:10]];
            [[feedCell answerCountLabel] setTextColor:[UIColor grayColor]];
            
            [[feedCell answerCountButton] setUserInteractionEnabled:FALSE];
            
            [[feedCell createAnswerButton] setHidden:FALSE];
            [[feedCell createAnswerButton] setUserInteractionEnabled:TRUE];
        }
        
       
        
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row){
        return 50;
    }
    else {
        return  356; 
    }

}
-(IBAction)imageClick:(id)sender 
{

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
    if (indexPath.row == 1)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        questionEndIndex = questionEndIndex + 10;
        [self loadData];
        
    }
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
    cell.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f];

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
    [self setTakingPicture:TRUE];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:@"logged_in"])
    {
        actionSheetQuestion = [[UIActionSheet alloc] initWithTitle:@"Choose Source for Question" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Upload from Album", nil];
        [actionSheetQuestion setTag:0];
        [actionSheetQuestion showFromTabBar:self.tabBarController.tabBar];
    }
    else
    {
        [self performSegueWithIdentifier:@"SignUpPopUp" sender:self];
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self startCamera];
    } else if (buttonIndex == 1) {
        [self startPictureChooser];
    } 
    if ([actionSheet tag] == 1)
    {
        [self setAddingQuestion:false];
    }
    else {
        [self setAddingQuestion:true];
    }
}


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


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
        
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([self takingPicture])
    {
        [self setImageToUpload:[info objectForKey:UIImagePickerControllerEditedImage]];
        [picker dismissModalViewControllerAnimated:YES];
        if ([self addingQuestion])
        {
            [self performSegueWithIdentifier:@"didcapturepicture1" sender:self];
        }
        else 
        {
            [self performSegueWithIdentifier:@"didcapturepicture2" sender:self];
        }
    }
    else {
        localURL = [info objectForKey:UIImagePickerControllerMediaURL];
        [self setupVideoUploadRequest];
        [picker dismissModalViewControllerAnimated:YES];
    }
}

-(void)setupVideoUploadRequest
{
    NSURL *url = [NSURL URLWithString:@"http://api.askdittles.com/create_video_answer/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [user objectForKey:@"access_token"];
    
    [request setPostValue:[NSString stringWithFormat:@"%d",answerViewerIndex] forKey:@"question_id"];
    [request setPostValue:access_token forKey:@"access_token"];
    [request setDelegate:self];
    [request setFile:[localURL path] withFileName:@"upload.mp4" andContentType:@"video/mp4" forKey:@"file"];
    [request setShowAccurateProgress:YES];
    [request setDidFinishSelector:@selector(videoUploadingDidFinish:)];
    [request setDidFailSelector:@selector(videoUploadingDidFail:)];
    [request setTag:1];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    
    [request startAsynchronous];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"didcapturepicture1"])
    {
        UploadImageController *viewController = [segue destinationViewController];
        [viewController setIsQuestion:YES];
        [viewController setImageToUpload:[self imageToUpload]];
    }
    if ([[segue identifier] isEqualToString:@"didcapturepicture2"])
    {
        UploadImageController *viewController = [segue destinationViewController];
        [viewController setIsQuestion:NO];
        [viewController setQuestion_id:answerViewerIndex];
        [viewController setImageToUpload:[self imageToUpload]];
    }
    
    if ([[segue identifier] isEqualToString:@"PictureViewer"])
    {
        // Get reference to the destination view controller
        PictureViewController *pictureView = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [pictureView setImage:[imageCache objectForKey:[[qc objectAtIndex:pictureViewerIndex] image_url]]];
    }
    
    if ([[segue identifier] isEqualToString:@"AnswerViewer"])
    {
        AnswerViewController *answerView = [segue destinationViewController];
        [answerView setQuestion_id:answerViewerIndex];
    }
}

#pragma mark - Server Connectivity

//Load JSON Data from Server
-(IBAction)loadData
{
    loading = true;
    
    NSURL *url = [NSURL URLWithString:@"http://api.askdittles.com/questions/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%d", 0] forKey:@"start"];
    [request setPostValue:[NSString stringWithFormat:@"%d", questionEndIndex] forKey:@"end"];  
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:@"logged_in"])
    {
        NSLog(@"%@",[prefs valueForKey:@"access_token"]);
        [request setPostValue:(NSString*)[prefs valueForKey:@"access_token"] forKey:@"access_token"];
    }
    [request setDelegate:self];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setTag:0];
    [request startAsynchronous];

    
    NSError *error;
    if (![[GANTracker sharedTracker] trackPageview:@"FeedView" withError:&error]) {
        
    }
    
    //Show HUD

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.removeFromSuperViewOnHide = YES;
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
}


- (void)videoUploadingDidFinish:(ASIHTTPRequest *)request
{
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
    [HUD hide:YES afterDelay:1];
    [self loadData];
}

- (void)videoUploadingDidFail:(ASIHTTPRequest *)request
{
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.labelText = @"Unable to upload.";
//    HUD.removeFromSuperViewOnHide = YES;
//    [HUD hide:YES afterDelay:2];
    [HUD hide:YES];

    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to upload."
                                                      message:@"Would you like to retry?"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Retry",nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Cancel"])
    {
        //Cancel
        [HUD hide:YES];
    }
    else if([title isEqualToString:@"Retry"])
    {
        //Retry upload
        [HUD hide:YES];
        [self setupVideoUploadRequest];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];

    [qc removeAllObjects];
    [ac removeAllObjects];
    
    // Parse JSON Data and create question collection
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *latest_timestamp_loaded;
    NSDate *max_timestamp;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSDate *date = [df dateFromString:@"2012-07-24 21:17:46:121426"];
    
    if ([user objectForKey:@"latest_timestamp_loaded"] != nil){
        latest_timestamp_loaded =  [user objectForKey:@"latest_timestamp_loaded"];
        max_timestamp = [user objectForKey:@"latest_timestamp_loaded"];
    }
    else {
        latest_timestamp_loaded = [df dateFromString:@"1900-01-01 00:00:00:000000"];
        max_timestamp = [df dateFromString:@"1900-01-01 00:00:00:000000"];
    }
    int new_action_count = 0;
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    id jsonObjects = [jsonParser objectWithString:responseString error:&error];
    if ([jsonObjects isKindOfClass:[NSDictionary class]])
    {
        // treat as a dictionary, or reassign to a dictionary ivar
        NSArray *question_list = [jsonObjects objectForKey:@"question_list"];
        NSArray *action_list = [jsonObjects objectForKey:@"action_list"];
        
        if (action_list != nil)
        {
            //Handle Action List
        }        
        for (NSDictionary *dict in question_list)
        {
            Question *newQuestion = [[Question alloc] init];
            
            [newQuestion setUsername:[dict objectForKey:@"username"]];
            [newQuestion setQuestion_id:[[dict objectForKey:@"question_id"] integerValue]];
            [newQuestion setImage_url:[dict objectForKey:@"image_url"]];
            [newQuestion setDescription:[dict objectForKey:@"description"]];
            [newQuestion setUser_profile_image_url:[dict objectForKey:@"user_profile_image_url"]];             
            [newQuestion setAnswer_count:[[dict objectForKey:@"answer_count"] integerValue]];
            [newQuestion setPub_life:[dict objectForKey:@"pub_life"]];

            [qc addObject:newQuestion];
        }

        for (NSDictionary *dict in action_list)
        {
            Action *newAction = [[Action alloc] init];
            
            //Update needed for updated API
            [newAction setSenderImageURL:[dict objectForKey:@"sender_image_url"]];
            [newAction setSenderUsername:[dict objectForKey:@"sender"]];
            
            [newAction setPubLife:[dict objectForKey:@"pub_life"]];
            [newAction setTimestamp:[df dateFromString:[dict objectForKey:@"pub_date"]]];
            
            [newAction setQuestionID:[[dict objectForKey:@"question_id"] integerValue]];
            [newAction setActionType:[dict objectForKey:@"type"]];
            
            [ac addObject:newAction];
            
            if ([[newAction timestamp] compare:latest_timestamp_loaded] == NSOrderedDescending)
            {
                new_action_count += 1;
            }
            
            if ([[newAction timestamp] compare:max_timestamp] == NSOrderedDescending){
                max_timestamp = [newAction timestamp];
            }
        }
        
        if ([max_timestamp compare:latest_timestamp_loaded] == NSOrderedDescending){
            [user setObject:max_timestamp forKey:@"latest_timestamp_loaded"];
        }
        
        if (new_action_count > 0){
            [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%d",new_action_count]];
        }
        
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate setGlobalQuestions:qc];
        [appDelegate setGlobalActions:ac];
    }
    else if ([jsonObjects isKindOfClass:[NSArray class]])
    {
        //Load the server data into Core Data   
    }
    
    [HUD hide:YES];
    //loading = false;
    
    //[self performSelector:@selector(removeLoadingBanner) withObject:self afterDelay:1.0];
    
    
    [[self tableView] reloadData];
}

-(void)removeLoadingBanner
{
    [UIView animateWithDuration:0.25
     
                          delay: 0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         nibView.alpha = 0.0;
                         
                         // Create a nested animation that has a different
                         // duration, timing curve, and configuration.
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    /*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection" 
                                                    message:[error description]
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
     */
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Unable to connect.";
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];
}


- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
	UIImage *img = [UIImage imageWithData:[request responseData]];
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

-(void)handleMainImageClick:(int)indexNum
{
    pictureViewerIndex = indexNum;
    [self performSegueWithIdentifier:@"PictureViewer" sender:nil];
}

- (void)handleAnswerclick:(int)indexNum
{
    Question *question = [qc objectAtIndex:indexNum];
    answerViewerIndex = [question question_id];
    [self performSegueWithIdentifier:@"AnswerViewer" sender:nil];
}
                                       
- (void)handleAddAnswerClick:(int)indexNum
{
    [self setTakingPicture:FALSE];
    Question *question = [qc objectAtIndex:indexNum];
    answerViewerIndex = [question question_id];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:@"logged_in"])
    {
        //Display instruction screen, with continue button to UIImagePickerController for recording
        NSLog(@"Display instruction screen.");
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        [picker setVideoMaximumDuration:120.0f];
        [picker setCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
        [picker setVideoQuality:UIImagePickerControllerQualityTypeMedium];
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:@"SignUpPopUp" sender:self];
        
    }
}


-(void)removeCacheForURL:(NSString*)url{
    [imageCache removeObjectForKey:url];
}

@end
