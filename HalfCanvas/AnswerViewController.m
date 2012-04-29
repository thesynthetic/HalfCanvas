//
//  AnswerViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()


@end

@implementation AnswerViewController

@synthesize question_id;
@synthesize answerCollection;
@synthesize imageCache;
@synthesize popup;
@synthesize picker;
@synthesize imageToUpload;

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
    self.imageCache = [[NSMutableDictionary alloc] init];
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


- (void)viewWillAppear:(BOOL)animated{
    
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
    [super viewWillAppear:animated];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return [answerCollection count] == 0 ? 1 : [answerCollection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if ([answerCollection count] > 0) 
    {
        if (section == [answerCollection count] - 1)
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
        
        
        return 1;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([answerCollection count] == 0 || 1 == indexPath.row){
        return 50;
    }
    else {
        return  350; 
    }
    
    
}

-  (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([answerCollection count] > 0){
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor whiteColor]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 20)];
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,30,30)];
        UIImage *tempImg = [imageCache objectForKey:[[answerCollection objectAtIndex:section] user_profile_image_url]];
        
        if (tempImg != nil)
        {
            [userImageView setImage:tempImg];
        }
        else 
        {
            ASIHTTPRequest *request;
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[answerCollection objectAtIndex:section] user_profile_image_url]]];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
            [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [request setSecondsToCache:60*60*24*7];
            
            [networkQueue addOperation:request];
            [networkQueue go];
        }
        
        Answer *test = [answerCollection objectAtIndex:section];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:[test username]];
        [myView addSubview:userLabel];
        [myView addSubview:userImageView];
        
        return myView;
    }
    else {
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor whiteColor]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100, 20)];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:@"No answers yet."];


        
        return myView;

        
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row || [answerCollection count] == 0)
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
        [feedCell setDelegate:self];
        [feedCell setIndex:indexPath.section];
        UIImage *tempImg = [imageCache objectForKey:[[answerCollection objectAtIndex:indexPath.section] image_url]];
        
        
        if (tempImg != nil)
        {
            [[feedCell imageView] setImage:tempImg];
        }
        else 
        {
            ASIHTTPRequest *request;
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[answerCollection objectAtIndex:indexPath.section] image_url]]];
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





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self addAnswerClick];
        
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load more pictures when at bottom of table (xth row)
    
}

#pragma mark - ASIHTTPRequest

- (void)loadData
{
    NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com/answers/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%d", question_id] forKey:@"question_id"];
    NSLog(@"Question_id: %d", question_id);
    [request setDelegate:self];
    [request startAsynchronous];

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
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
            [newAnswer setDescription:[dict objectForKey:@"description"]];
            [newAnswer setUser_profile_image_url:[dict objectForKey:@"user_profile_image_url"]];             
            [answerCollection addObject:newAnswer];
        }
    }
    
    [[self tableView] reloadData];
    [HUD hide:YES];
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

#pragma mark - Add Answer Functions

- (void)addAnswerClick
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:@"logged_in"])
    {    
        popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Upload from Album", nil];
        [popup showFromTabBar:self.tabBarController.tabBar];
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


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self setImageToUpload:image];
    [picker dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"didcapturepicture2" sender:self];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}




@end
