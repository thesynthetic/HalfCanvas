//
//  SettingsViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController

@synthesize profilePicture;

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
    self.title = @"Account";
    
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"UINavigationBarHeader"] forBarMetrics:UIBarMetricsDefault];
    UIImageView *headerFade = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, 320, 2)];
    [headerFade setImage:[UIImage imageNamed:@"UINavigationBarHeaderFade@2x.png"]];
    [[[self parentViewController] view] addSubview:headerFade];
    [[self tableView] setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0f]];
    

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
    
    loggedIn = false;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:@"logged_in"])
    {
        loggedIn = true;
    }
    
    [[self tableView] reloadData];
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    if (loggedIn)
//    {
//        return 2;
//    }
//    else
//    {
//        return 1;
//    }
//}


    
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//       
//
//    // Configure the cell...
//    return cell;
//}

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
    if (indexPath.section == 0 && indexPath.row == 0)
    {
            [self performSegueWithIdentifier:@"AccountToQuestionsAsked" sender:nil];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1)
    {
     
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setBool:false forKey:@"logged_in"];
        [user setValue:nil forKey:@"access_token"];
        [user setValue:nil forKey:@"username"];
        [user synchronize];
        MainTabBarController *mainTab = (MainTabBarController*)self.tabBarController;
        [mainTab setSelectedIndex:0];
        
    }
    
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose from Album", @"Use default", nil];
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
   
    }
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"LessonsCreatedToAnswers" sender:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"LessonsLikedToAnswers" sender:nil];
    }
    
    [[self tableView] deselectRowAtIndexPath:indexPath animated:FALSE];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"LessonsCreatedToAnswers"])
    {
        GenericAnswerViewController *viewController = [segue destinationViewController];
        [viewController setTitle:@"My Lessons"];
        [viewController setInstanceURL:@"http://api.askdittles.com/user_answers/"];
    }
    if ([[segue identifier] isEqualToString:@"LessonsLikedToAnswers"])
    {
        GenericAnswerViewController *viewController = [segue destinationViewController];
        [viewController setTitle:@"Likes"];
        [viewController setInstanceURL:@"http://api.askdittles.com/user_answer_likes/"];
    }
    
    
}

#pragma mark - Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) 
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
    }
    else if (buttonIndex == 1) 
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    } 
    else if (buttonIndex == 2) 
    {
        //Set Profile Picture to Default
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *email = [user objectForKey:@"email"];
        
        ASIHTTPRequest *request;
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?d=identicon",[self md5HexDigest:@"ryeguy_24@yahoo.com"]]];
        request = [[ASIHTTPRequest alloc] initWithURL:url];
        [request setDidFinishSelector:@selector(profileGravatarRequestFinished:)];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self setProfilePicture:image];
    [self imageWithImage:image scaledToSize:CGSizeMake(150.0f, 150.0f)];

    //Send to server
    
    NSURL *url = [NSURL URLWithString:@"http://api.askdittles.com/change_profile_picture/"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [user objectForKey:@"access_token"];
    
    [request setPostValue:access_token forKey:@"access_token"];
    UIImage *scaledImage = [self imageWithImage:profilePicture scaledToSize:CGSizeMake(100.0,100.0)];
    [request setData:UIImageJPEGRepresentation(scaledImage,1.0) withFileName:@"upload.jpg" andContentType:@"image/jpeg" forKey:@"file"];
    
    [request setDidFinishSelector:@selector(profilePictureUpdateFinished:)];
    [request setDelegate:self];
    [request startAsynchronous];
    
    [self dismissModalViewControllerAnimated:true];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:true];
}

-(void)profileGravatarRequestFinished:(ASIHTTPRequest *)request
{
    UIImage *img = [UIImage imageWithData:[request responseData]];
    [self setProfilePicture:[self imageWithImage:img scaledToSize:CGSizeMake(150.0f, 150.0f)]];
    
    NSURL *url = [NSURL URLWithString:@"http://api.askdittles.com/change_profile_picture/"];
    ASIFormDataRequest *newRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [user objectForKey:@"access_token"];
    
    [newRequest setPostValue:access_token forKey:@"access_token"];
    UIImage *scaledImage = [self imageWithImage:profilePicture scaledToSize:CGSizeMake(100.0,100.0)];
    [newRequest setData:UIImageJPEGRepresentation(scaledImage,1.0) withFileName:@"upload.jpg" andContentType:@"image/jpeg" forKey:@"file"];
    
    [newRequest setDidFinishSelector:@selector(profilePictureUpdateFinished:)];
    [newRequest setDelegate:self];
    [newRequest startAsynchronous];
    
    [self dismissModalViewControllerAnimated:true];

    
}

- (void)profilePictureUpdateFinished:(ASIHTTPRequest *)request
{
    NSLog(@"Profile updated");
    NSLog(@"Response string: %@",[request responseString]);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *username = [user objectForKey:@"username"];
    NSString *url = [NSString stringWithFormat:@"https://s3.amazonaws.com/dittles/users/%@.jpg",username];
    [[ASIDownloadCache sharedCache] removeCachedDataForURL:[NSURL URLWithString:url]];
    
    MainTabBarController *tabcontroller = (MainTabBarController*)self.navigationController.tabBarController;
    UINavigationController *nc = (UINavigationController*)[[tabcontroller viewControllers] objectAtIndex:0];
    FeedController *fc = (FeedController*)[[nc viewControllers] objectAtIndex:0];
    [fc removeCacheForURL:[url lowercaseString]];
    [[fc tableView] reloadData];
    nc = (UINavigationController*)[[tabcontroller viewControllers] objectAtIndex:1];
    ActivityViewController *ac = [[nc viewControllers] objectAtIndex:0];
    [ac removeCacheForURL:[url lowercaseString]];
    [[ac tableView] reloadData];
}



- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


@end
