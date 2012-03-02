//
//  FeedCell.m
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedCell.h"
#import "FeedController.h"

@implementation FeedCell

@synthesize imageView;
@synthesize imageProgressIndicator;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib
{
    [imageView setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == imageView)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    
}

@end
