//
//  ActivityCell.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Acti;

@interface ActivityCell : UITableViewCell
{

}

@property (retain, nonatomic) IBOutlet UIImageView *senderImage;
@property (retain, nonatomic) IBOutlet UILabel *senderUsername;
@property (retain, nonatomic) IBOutlet UILabel *text;
@property (nonatomic) NSInteger questionID;



@end
