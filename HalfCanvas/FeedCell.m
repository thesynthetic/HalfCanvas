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
@synthesize delegate;
@synthesize index;
@synthesize answerCount;
@synthesize answerLabel;

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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == answerCount || [touch view] == answerLabel)
    {
        [answerCount setAlpha:1.0];
        [answerLabel setAlpha:1.0];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == answerCount || [touch view] == answerLabel)
    {
        [answerCount setAlpha:0.5];
        [answerLabel setAlpha:0.5];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == imageView)
    {
        [[self delegate] handleMainImageClick:[self index]];
    }
    if ([touch view] == answerCount || [touch view] == answerLabel)
    {
        [answerCount setAlpha:0.5];
        [answerLabel setAlpha:0.5];
        [[self delegate] handleAnswerclick:[self index]];
    }
    

}



@end
