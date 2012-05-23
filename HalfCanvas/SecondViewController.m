//
//  SecondViewController.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

@synthesize parentNavController;
@synthesize imageToPost;
@synthesize popup;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewwillapear");
    
    if (cameraStatus == 10)
    {
        [self startCamera];
        
    }
    else if (cameraStatus == 20)
    {
        [self startPictureChooser];
    }
    else {
        popup = [[UIActionSheet alloc] initWithTitle:@"Test" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"From album", nil];
        [popup setActionSheetStyle:UIActionSheetStyleBlackOpaque];
        [popup showInView:self.view];
    }
    [super viewWillAppear:animated];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //[popup dismissWithClickedButtonIndex:buttonIndex animated:true];
    
    if (buttonIndex == 0) {
        cameraStatus = 10;
        [self startCamera];
    } else if (buttonIndex == 1) {
        cameraStatus = 20;
        [self startPictureChooser];
    } else if (buttonIndex == 2) {
        cameraStatus = 2;
        MainTabBarController *tabcontroller = (MainTabBarController*)self.navigationController.tabBarController;
        [tabcontroller goToFirstTab];
    }
}

-(void) startCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = true;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];
}

- (void) startPictureChooser
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = true;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:picker animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [popup dismissWithClickedButtonIndex:3 animated:false];
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//UIImagePickerController Delegate Functions
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //Process the image data here, please dont release it
    //Its an autoreleased item
    [self setImageToPost:image];
    [picker dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"didcapturepicture" sender:self];
}
//Function to get rid of the picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    cameraStatus = 30;
    [picker dismissModalViewControllerAnimated:YES];
    MainTabBarController *tabcontroller = (MainTabBarController*)self.navigationController.tabBarController;
    [tabcontroller goToFirstTab];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"didcapturepicture"])
    {
        // Get reference to the destination view controller

        
        // Pass any objects to the view controller here, like...

    }
}

@end
