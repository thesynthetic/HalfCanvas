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
@synthesize answerCountButton;
@synthesize answerButton;
@synthesize answerCountLabel;
@synthesize messageBubble;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)initExtras 
{
    [answerCount setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [answerCount setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [answerButton setBackgroundImage:[UIImage imageNamed:@"Answer-Button-Background.png"] forState:UIControlStateHighlighted];
    [answerCountButton setBackgroundImage:[UIImage imageNamed:@"Answer-Button-Background.png"] forState:UIControlStateHighlighted];
    
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
        [[self delegate] handleMainImageClick:[self index]];
        //imageView.frame;
    }
}

-(IBAction)answerCountClick:(id)sender
{
    [[self delegate] handleAnswerclick:[self index]];
}

-(IBAction)addAnswerClick:(id)sender
{
      [[self delegate] handleAddAnswerClick:[self index]];
}

@end
