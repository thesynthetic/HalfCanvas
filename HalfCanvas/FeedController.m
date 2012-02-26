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

@synthesize userE;
@synthesize imageE;
@synthesize questionE;
@synthesize objectContext;


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
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
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
    return [[QuestionCollection questions] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([[QuestionCollection questions] count] > 0) 
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
    if ([[QuestionCollection questions] count] > 0) 
    {
        CGRect  viewRect = CGRectMake(0, 0, 320, 40);
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:[UIColor whiteColor]];
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 20)];
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,30,30)];
        [userImageView setImage:[UIImage imageNamed:@"profile_picture.jpg"]];
        Question *test = [[QuestionCollection questions] objectAtIndex:section];
        [userLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userLabel setText:[test user]];
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
    
    // Configure the cell...
    
    
    
    if (![[[QuestionCollection questions] objectAtIndex:indexPath.section] image])
    {
        
        NSLog(@"Index: %d",indexPath.section);
       //if (self.tableView.decelerating == NO && self.tableView.dragging == NO )
        //{
            NSLog(@"Starting to load image: %d",indexPath.section);
            [self startImageDownload:[[QuestionCollection questions] objectAtIndex:indexPath.section] forIndexPath:indexPath];
        //}  
        [[feedCell imageView] setImage:nil];
    }
    else
    {
        
        [[feedCell imageView] setImage:[[[QuestionCollection questions] objectAtIndex:indexPath.section] image]];
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


//New Functions
- (void)startImageDownload:(Question *)question forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.question = [[QuestionCollection questions] objectAtIndex:indexPath.section];
        NSLog(@"Downloading index: %d",indexPath.section);
        iconDownloader.indexPath = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        FeedCell *feedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // Display the newly loaded image
        [[[QuestionCollection questions] objectAtIndex:indexPath.section] setImage:iconDownloader.question.image];
        feedCell.imageView.image = iconDownloader.question.image;
    }
}


- (void)loadImagesForOnscreenRows
{
    if ([[QuestionCollection questions] count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Question *question = [[QuestionCollection questions] objectAtIndex:indexPath.section];
            
            if (!question.image) // avoid the app icon download if the app already has an icon
            {
                [self startImageDownload:question forIndexPath:indexPath];
            }
        }
    }
}

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - Popup Menu for Camera

- (void)cameraButtonClick
{
    popup = [[UIActionSheet alloc] initWithTitle:@"Upload Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"From album", nil];
    [popup setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    [popup showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self startCamera];
    } else if (buttonIndex == 1) {
        [self startPictureChooser];
    } else if (buttonIndex == 2) {
        [popup dismissWithClickedButtonIndex:buttonIndex animated:true];  
    }
}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet   
{
    
    
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

-(IBAction)loadData
{
    NSURL *url = [NSURL URLWithString:@"http://stripedcanvas.com:8000/questions/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
        
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    
    objectContext = [self managedObjectContext];
    if (objectContext != nil)
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        
        User *userE = [NSEntityDescription
                        insertNewObjectForEntityForName:@"User" 
                                          inManagedObjectContext:context];
        Question *questionE = [NSEntityDescription
                       insertNewObjectForEntityForName:@"FailedBankInfo" 
                       inManagedObjectContext:context];

        
        userE.name = @"Test Bank";
        userE.bla = @"Testville";
        userE.state = @"Testland";
        
        FailedBankDetails *failedBankDetails = [NSEntityDescription
                                                insertNewObjectForEntityForName:@"FailedBankDetails" 
                                                inManagedObjectContext:context];
        failedBankDetails.closeDate = [NSDate date];
        failedBankDetails.updatedDate = [NSDate date];
        failedBankDetails.zip = [NSNumber numberWithInt:12345];
        failedBankDetails.info = failedBankInfo;
        failedBankInfo.details = failedBankDetails;
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }
        
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
        
        /*
         for (NSDictionary *dict in jsonObjects)
         {
         Question *newQuestion = [[Question alloc] init];
         NSDictionary *fieldDict = [dict objectForKey:@"fields"];
         [newQuestion setDescription:[fieldDict objectForKey:@"description"]];
         [newQuestion setImage_url:[fieldDict objectForKey:@"image_url"]];
         [newQuestion setUser:[fieldDict objectForKey:@"user"]];
         [[QuestionCollection   questions] addObject:newQuestion];
         }
         */
    }
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
    //Todo: Display Error Message
}


#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (persistentStoreCoordinator != nil)
    {
        return persistentStoreCoordinator;
    }
    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    return persistentStoreCoordinator;
}




@end
