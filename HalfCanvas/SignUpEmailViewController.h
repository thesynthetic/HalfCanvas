//
//  SignUpEmailViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@interface SignUpEmailViewController : UITableViewController <ASIHTTPRequestDelegate>
{
    UISegmentedControl *segcontrol;    
    UITextField *username;
    UITextField *password;
    UITextField *email;
    //0 = sign up; 1 = sign in
    int state;
    
}


@property (retain) UITextField *username;
@property (retain) UITextField *password;
@property (retain) UITextField *email;
@property (nonatomic, retain) UISegmentedControl *segcontrol;

-(IBAction)test:(id)sender;
-(IBAction)doneButtonClick:(id)sender;

@end