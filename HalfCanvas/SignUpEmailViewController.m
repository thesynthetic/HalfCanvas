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
@synthesize doneCell;
@synthesize profilePicture;
@synthesize usernameString;
@synthesize passwordString;
@synthesize emailString;

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
    if (state == 0){
        return 1;
    }
    else 
    {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0){
        if (state == 0)
        {
            return 4;
        }
        else 
        {
            return 2;
        }
    }
    else
    {
        if (state == 0)
        {
            return 0;
        }
        else
        {
            return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 3){
        return 105.0f;
    }
    else {
        return 45.0f;
    }
 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell;
    UILabel *cellLabel;
    
    if (indexPath.section == 0){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 95, 21)];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
        if (state == 0)
        {

            if (indexPath.row == 0)
            {
                username = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [username setReturnKeyType:UIReturnKeyDone];
                [username setDelegate:self];
                [username addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                if (usernameString != nil){
                    [username setText:usernameString];                    
                }
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
                [email setReturnKeyType:UIReturnKeyDone];
                [email setDelegate:self];
                [email addTarget:self action:@selector(emailDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                if (emailString != nil){
                    [email setText:emailString];        
                }
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
                [password setReturnKeyType:UIReturnKeyDone];
                [password setDelegate:self];
                [password addTarget:self action:@selector(passwordDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                if (passwordString != nil){
                    [password setText:passwordString];        
                }
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
                ProfilePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfilePictureCell"];
                [cell setDelegate:self];
                if ([self profilePicture] != nil){
                    [[cell button] setBackgroundImage:[self profilePicture] forState:UIControlStateNormal];
                }
                
                return cell;

            }
        }
        else 
        {
            if (indexPath.row == 0)
            {
                username = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                [username setReturnKeyType:UIReturnKeyDone];
                [username setDelegate:self];
                [username addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                if (usernameString != nil){
                    [username setText:usernameString];                    
                }
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
                [password setReturnKeyType:UIReturnKeyDone];
                [password setDelegate:self];
                [password addTarget:self action:@selector(passwordDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                if (passwordString != nil){
                    [password setText:passwordString];        
                }
                [cellLabel setText:@"Password"];
                [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [cellLabel setBackgroundColor:[UIColor clearColor]];
                password.secureTextEntry = YES;
                password.adjustsFontSizeToFitWidth = YES;
                password.textColor = [UIColor blackColor];
                [cell addSubview:password];
            }
            
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else 
    {   
        if (state == 1){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 300, 21)];
            [cellLabel setTextAlignment:UITextAlignmentCenter];
            [cellLabel setFont:[UIFont boldSystemFontOfSize:16]];
            [cellLabel setBackgroundColor:[UIColor clearColor]];
            [cellLabel setText:@"Forgot Password"];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
      
    }
        
    [cell addSubview:cellLabel];
        
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://askdittles.com/password_reset/"]];
    }
}

#pragma mark - Handlers

-(IBAction)test:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;    
    state = [segmentedControl selectedSegmentIndex];
    NSLog(@"State = %d",state);
    [[self tableView] reloadData];
    
    //NSIndexSet *test = [[NSIndexSet alloc] initWithIndex:0];
    //[[self tableView] reloadSections:test withRowAnimation:UITableViewRowAnimationFade];
    

}

-(IBAction)submitClick:(id)sender
{
    if (state == 0) //Sign Up Handler
    {
        NSURL *url = [NSURL URLWithString:@"http://askdittles.com/create_user/"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setDelegate:self];
        [request setPostValue:[username text] forKey:@"username"];
        [request setPostValue:[password text] forKey:@"password"];
        [request setData:UIImageJPEGRepresentation([self profilePicture],0.35) withFileName:@"upload.jpg" andContentType:@"image/jpeg" forKey:@"file"];
        [request setPostValue:[email text] forKey:@"email"];
        [request startAsynchronous];     
    }
    else //Sign In Handler
    {
        NSURL *url = [NSURL URLWithString:@"http://askdittles.com/login/"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setDelegate:self];
        [request setPostValue:[username text] forKey:@"username"];
        [request setPostValue:[password text] forKey:@"password"];
        [request startAsynchronous];
    }
    
}

#pragma mark - ASI HTTP Request Callback

- (void)requestFinished:(ASIHTTPRequest *)request
{    
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *jsonError = nil;
    
    id jsonObjects = [jsonParser objectWithString:[request responseString] error:&jsonError];
    
    if ([jsonObjects isKindOfClass:[NSDictionary class]])
    {
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
            [user setValue:emailString forKey:@"email"];
            [user setBool:TRUE forKey:@"logged_in"];

            [self.navigationController dismissModalViewControllerAnimated:true];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"ERROR: %@", [error debugDescription]);
}

//Gravitar URL - Retro Style Identicon http://www.gravatar.com/avatar/f778d4000d84e1434d04eb8526ec3de2?d=retro

#pragma mark - ProfilePictureDelegate Functions

- (void)handleProfilePictureTap:(id)sender
{
    NSLog(@"received");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose from Album", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - ActionSheetDelegate Functions

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
    }
    else if (buttonIndex == 1) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    } 
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self setProfilePicture:image];
    [picker dismissModalViewControllerAnimated:YES];
    [[self tableView] reloadData];

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - UITextField Change

- (void)usernameDidChange:(id)sender{
    UITextField *temp = (UITextField*)sender;
    [self setUsernameString:[temp text]];
}

- (void)passwordDidChange:(id)sender{
    UITextField *temp = (UITextField*)sender;
    [self setPasswordString:[temp text]];
}

- (void)emailDidChange:(id)sender{
    UITextField *temp = (UITextField*)sender;
    [self setEmailString:[temp text]];
    
    ASIHTTPRequest *request;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?d=identicon",[self md5HexDigest:[self emailString]]]];
    request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request setDidFinishSelector:@selector(profilePictureRequestFinished:)];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)profilePictureRequestFinished:(ASIHTTPRequest *)request
 {
     UIImage *img = [UIImage imageWithData:[request responseData]];
     [self setProfilePicture:img];
     [[self tableView] reloadData];
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
