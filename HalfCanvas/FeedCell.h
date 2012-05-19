//
//  FeedCell.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class FeedCell;

@protocol FeedCellDelegate <NSObject>
@optional
- (void)handleMainImageClick:(int)indexNum;
- (void)handleAnswerclick:(int)indexNum;
- (void)handleAddAnswerClick:(int)indexNum;
@required
- (void)addCurrentMovie:(MPMoviePlayerController*)player;
@end


@interface FeedCell : UITableViewCell
{
    
    UIImageView *imageView;
    UIImageView *playButton;
    UIImageView *messageBubble;
    UIProgressView *imageProgressIndicator;
    UIButton *answerButton;
    UIButton *answerCountButton;
    UILabel *answerCountLabel;
    MPMoviePlayerController *mplayer;
    UIView *movieCanvas;
    NSString *movieURL;
    id <FeedCellDelegate> delegate;
    int index;
}

@property (nonatomic, retain) NSString *movieURL;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIView *movieCanvas;
@property (nonatomic, retain) IBOutlet UIImageView *playButton;
@property (nonatomic, retain) IBOutlet UIImageView *messageBubble;
@property (nonatomic, retain) IBOutlet UIProgressView *imageProgressIndicator;
@property (nonatomic, retain) IBOutlet UIButton *answerCount;
@property (nonatomic, retain) IBOutlet UIButton *answerButton;
@property (nonatomic, retain) IBOutlet UIButton *answerCountButton;
@property (nonatomic, retain) IBOutlet UILabel *answerCountLabel;
@property (nonatomic, retain) id <FeedCellDelegate> delegate;
@property (nonatomic) int index;

-(IBAction)answerButtonClick:(id)sender;
-(void)initExtras;

-(IBAction)answerCountClick:(id)sender;
-(IBAction)playMovie:(id)sender;

@end
