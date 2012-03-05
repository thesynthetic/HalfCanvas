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
@end


@interface FeedCell : UITableViewCell
{
    
    UIImageView *imageView;
    UIProgressView *imageProgressIndicator;
    id <FeedCellDelegate> delegate;
    int index;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIProgressView *imageProgressIndicator;
@property (nonatomic, retain) id <FeedCellDelegate> delegate;
@property (nonatomic) int index;


@end
