//
//  SignInViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "SBJsonParser.h"

@interface SignInViewController : UITableViewController
{
    UITextField *username;
    UITextField *password;
    
}


@property (retain) UITextField *username;
@property (retain) UITextField *password;

- (IBAction)signIn:(id)sender;

@end
