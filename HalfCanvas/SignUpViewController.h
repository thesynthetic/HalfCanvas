//
//  SignUpViewController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
{
    UIButton *signUpButton;

}

@property (nonatomic, retain) IBOutlet UIButton *signUpButton;

-(IBAction)doneButtonClick:(id)sender;
-(IBAction)useEmailAddress:(id)sender;

@end
