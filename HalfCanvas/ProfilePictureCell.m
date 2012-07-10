//
//  ProfilePictureCell.m
//  Dittles
//
//  Created by Ryan Hittner on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfilePictureCell.h"

@implementation ProfilePictureCell

@synthesize mainLabel;
@synthesize delegate;
@synthesize button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)didTapPhoto:(id)sender
{
    NSLog(@"got it");
    [[self delegate] handleProfilePictureTap:self];
}

//http://www.gravatar.com/avatar/00000000000000000000000000000000?d=identicon
@end
