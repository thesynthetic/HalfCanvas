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
@synthesize playButton;
@synthesize movieCanvas;

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

-(IBAction)playMovie:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/halfcanvas/video/Test-out.mp4"];
    mplayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:mplayer];
    mplayer.view.frame = CGRectMake(0, 0, 310, 200);
    mplayer.controlStyle = MPMovieControlStyleDefault;
    mplayer.shouldAutoplay = YES;
    [[self playButton] setHidden:TRUE];
    [self.movieCanvas addSubview:mplayer.view];
    
}

-(void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]){
        [player.view removeFromSuperview];
    }
}


@end
