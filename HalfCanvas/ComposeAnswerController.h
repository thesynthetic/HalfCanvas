//
//  ComposeAnswerController.h
//  HalfCanvas
//
//  Created by Ryan Hittner on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionCollection.h"

@interface ComposeAnswerController : UIViewController
{
    QuestionCollection *questions;
    NSInteger selectedQuestion;
}
@end
