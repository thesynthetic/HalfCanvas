//
//  ProfilePictureCell.h
//  Dittles
//
//  Created by Ryan Hittner on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ProfilePictureDelegate <NSObject>
@optional
- (void)handleProfilePictureTap:(id)sender;
@end

@interface ProfilePictureCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *mainLabel;
@property (nonatomic, retain) id <ProfilePictureDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton *button;

-(IBAction)didTapPhoto:(id)sender;

@end
