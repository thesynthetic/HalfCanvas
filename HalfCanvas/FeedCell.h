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
@end


@interface FeedCell : UITableViewCell
{
    
    UIImageView *imageView;
    UIProgressView *imageProgressIndicator;
    UIButton *answerButton;
    UILabel *answerCount;
    UILabel *answerLabel;
    id <FeedCellDelegate> delegate;
    int index;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIProgressView *imageProgressIndicator;
@property (nonatomic, retain) IBOutlet UIButton *answerButton;
@property (nonatomic, retain) IBOutlet UILabel *answerCount;
@property (nonatomic, retain) IBOutlet UILabel *answerLabel;
@property (nonatomic, retain) id <FeedCellDelegate> delegate;
@property (nonatomic) int index;

-(IBAction)answerButtonClick:(id)sender;


@end
