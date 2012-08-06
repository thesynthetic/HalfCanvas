//
//  AnswerViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericAnswerViewController.h"

@interface GenericAnswerViewController()


@end

@implementation GenericAnswerViewController

@synthesize question_id;
@synthesize answerCollection;
@synthesize imageCache;
@synthesize popup;
@synthesize picker;
@synthesize imageToUpload;
@synthesize currentPlayer;
@synthesize mp;
@synthesize localURL;
@synthesize instanceURL;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.imageCache = [[NSMutableDictionary alloc] init];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f]];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"UINavigationBarHeader"] forBarMetrics:UIBarMetricsDefault];
    UIImageView *headerFade = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, 320, 2)];
    [headerFade setImage:[UIImage imageNamed:@"UINavigationBarHeaderFade@2x.png"]];
    [[[self parentViewController] view] addSubview:headerFade];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f]];
    
    

    
    answerCollection = [[NSMutableArray alloc] init];
    NSLog(@"Answer count: %d",[answerCollection count]);
    self.imageCache = [[NSMutableDictionary alloc] init];
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
    [networkQueue setShowAccurateProgress:true];
    [networkQueue setDelegate:self];
    
    //Turn on caching and set defaults
    [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
    [self loadData];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return [answerCollection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([answerCollection count] == 0 || [answerCollection count] == indexPath.section){
        return 50;
    }
    else {
        return  209;
    }
}

-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < [answerCollection count] && [answerCollection count] > 0)
    {
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
        [timestamp setText:[[answerCollection objectAtIndex:section] pub_life]];
        
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,5,30,30)];
        UIImage *tempImg = [imageCache objectForKey:[[answerCollection objectAtIndex:section] user_profile_image_url]];
        
        if (tempImg != nil)
        {
            [userImageView setImage:tempImg];
        }
        else
        {
            ASIHTTPRequest *request;
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[answerCollection objectAtIndex:section] user_profile_image_url]]];
            [request setTag:0];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy];
            [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [request setSecondsToCache:60*60*24];
            
            [networkQueue addOperation:request];
            [networkQueue go];
        }
        
        Answer *test = [answerCollection objectAtIndex:section];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:[test username]];
        [myView addSubview:userLabel];
        [myView addSubview:userImageView];
        [myView addSubview:timestamp];
        return myView;
    }
    else {
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100, 20)];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:@"No answers yet."];
        return myView;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [answerCollection count])
    {
        static NSString *CellIdentifier = @"AddHalfAnswer";
        
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
        static NSString *CellIdentifier = @"AnswerFeedCell";
        
        FeedCell *feedCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (feedCell == nil) {
            feedCell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        Answer *test = [answerCollection objectAtIndex:indexPath.section];
        
        [feedCell setDelegate:self];
        [feedCell setIndex:indexPath.section];
        [feedCell setMovieURL:[test image_url]];
        if ([test likeToggle])
        {
            [[feedCell heart] setImage:[UIImage imageNamed:@"Heart-Liked.png"]];
        }
        else
        {
            [[feedCell heart] setImage:[UIImage imageNamed:@"Heart.png"]];
        }
        [[feedCell likeCount] setText:[NSString stringWithFormat:@"%d",[test likeCount]]];
        
        return feedCell;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load more pictures when at bottom of table (xth row)
    
}

#pragma mark - ASIHTTPRequest

- (void)loadData
{
    
    NSURL *url = [NSURL URLWithString:instanceURL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:@"logged_in"])
    {
        [request setPostValue:[NSString stringWithFormat:@"%@",[prefs objectForKey:@"access_token"]] forKey:@"access_token"];
        NSLog(@"Question_id: %d", question_id);
        [request setDelegate:self];
        [request startAsynchronous];
        
        //Show HUD
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        HUD.removeFromSuperViewOnHide = YES;
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading";
        [HUD show:YES];
    }
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag == 0){
        NSString *responseString = [request responseString];
        NSLog(@"%@", responseString);
        //
        [answerCollection removeAllObjects];
        
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
                Answer *newAnswer = [[Answer alloc] init];
                [newAnswer setUsername:[dict objectForKey:@"username"]];
                [newAnswer setAnswer_id:[[dict objectForKey:@"answer_id"] integerValue]];
                [newAnswer setImage_url:[dict objectForKey:@"image_url"]];
                [newAnswer setPub_life:[dict objectForKey:@"pub_life"]];
                [newAnswer setDescription:[dict objectForKey:@"description"]];
                NSInteger likeToggle = [[dict objectForKey:@"like_toggle"] integerValue];
                
                if (likeToggle == 1)
                {
                    [newAnswer setLikeToggle:TRUE];
                }
                else
                {
                    [newAnswer setLikeToggle:FALSE];
                }
                [newAnswer setLikeCount:[[dict objectForKey:@"like_count"] integerValue]];
                [newAnswer setUser_profile_image_url:[dict objectForKey:@"user_profile_image_url"]];
                
                [answerCollection addObject:newAnswer];
            }
        }
        
        [[self tableView] reloadData];
        [HUD hide:YES];
    }
    else {
        [HUD hide:YES];
    }
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
    
}

#pragma mark - Image Viewer
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PictureViewer"])
    {
        PictureViewController *pictureView = [segue destinationViewController];
        [pictureView setImage:[imageCache objectForKey:[[answerCollection objectAtIndex:pictureViewerIndex] image_url]]];
        
    }
    if ([[segue identifier] isEqualToString:@"didcapturepicture2"])
    {
        UploadImageController *viewController = [segue destinationViewController];
        [viewController setQuestion_id:[self question_id]];
        [viewController setImageToUpload:[self imageToUpload]];
    }
}


-(void)handleMainImageClick:(int)indexNum
{
    NSLog(@"Action for index: %d",indexNum);
    pictureViewerIndex = indexNum;
    [self performSegueWithIdentifier:@"PictureViewer" sender:nil];
}

- (void)setCurrentMovie:(MPMoviePlayerController*)player
{
    if ([self currentPlayer] != nil)
    {
        [[self currentPlayer] stop];
    }
    [self setCurrentMovie:player];
}

#pragma mark - Add Answer Functions

- (IBAction)addAnswerClick:(id)sender
{
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


#pragma mark - UIImagePicker Functions

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self startCamera];
    } else if (buttonIndex == 1) {
        [self startPictureChooser];
    }
    else if (buttonIndex == 2) {
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    localURL = [info objectForKey:UIImagePickerControllerMediaURL];
    [picker dismissModalViewControllerAnimated:YES];
    [self setupVideoUploadRequest];
    
}


- (void)handlePlayMovie:(NSURL*)movieURL;
{
    mp = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    [[mp moviePlayer] prepareToPlay];
    [[mp moviePlayer] setUseApplicationAudioSession:NO];
    [[mp moviePlayer] setShouldAutoplay:YES];
    [[mp moviePlayer] setControlStyle:MPMovieControlStyleFullscreen];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self presentMoviePlayerViewControllerAnimated:mp];
}

-(void) moviePlayBackDidFinish:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [mp.moviePlayer stop];
    mp = nil;
    [self dismissMoviePlayerViewControllerAnimated];
}

-(void)handleToggleLike:(int)indexNum
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([prefs boolForKey:@"logged_in"])
    {
        //        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        //        [self.navigationController.view addSubview:HUD];
        
        // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
        // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
        //HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
        Answer *test = [answerCollection objectAtIndex:indexNum];
        NSURL *url;
        if ([test likeToggle])
        {
            url = [NSURL URLWithString:@"http://api.askdittles.com/unlike_answer/"];
        }
        else
        {
            url = [NSURL URLWithString:@"http://api.askdittles.com/like_answer/"];
        }
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:[NSString stringWithFormat:@"%d", [test answer_id]] forKey:@"answer_id"];
        [request setPostValue:[NSString stringWithFormat:@"%@",[prefs objectForKey:@"access_token"]] forKey:@"access_token"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(likeDidFinish:)];
        [request setDidFailSelector:@selector(likeDidFail:)];
        [request startAsynchronous];
    }
    else
    {
        [self performSegueWithIdentifier:@"SignUpPopUp" sender:self];
    }
    
    
}
#pragma mark - ASIHTTPDelegate

- (void)likeDidFinish:(ASIHTTPRequest *)request
{
    [self loadData];
}

- (void)likeDidFail:(ASIHTTPRequest *)request
{
    
}

- (void)videoUploadingDidFinish:(ASIHTTPRequest *)request
{
    [HUD hide:YES];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Upload complete";
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
    [self loadData];
}

- (void)videoUploadingDidFail:(ASIHTTPRequest *)request
{
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

-(void)setupVideoUploadRequest
{
    NSURL *url = [NSURL URLWithString:@"http://api.askdittles.com/create_video_answer/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [user objectForKey:@"access_token"];
    
    [request setPostValue:[NSString stringWithFormat:@"%d",question_id] forKey:@"question_id"];
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

@end
