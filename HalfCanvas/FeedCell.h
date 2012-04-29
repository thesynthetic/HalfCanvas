//
//  FeedCell.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedCell;
@protocol FeedCellDelegate <NSObject>
@optional
- (void)handleMainImageClick:(int)indexNum;
- (void)handleAnswerclick:(int)indexNum;
- (void)handleAddAnswerClick:(int)indexNum;
@end


@interface FeedCell : UITableViewCell
{
    
    UIImageView *imageView;
    UIImageView *messageBubble;
    UIProgressView *imageProgressIndicator;
    UIButton *answerButton;
    UIButton *answerCountButton;
    UILabel *answerCountLabel;
    id <FeedCellDelegate> delegate;
    int index;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
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

@end
