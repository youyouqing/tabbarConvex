//
//  XKTopicDetialReplyController.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKFirstCommtentModel.h"
#import "XKSecondeCommtentModel.h"
#import "XKTopicModel.h"

@interface XKTopicDetialReplyController : BaseViewController

/**
 当前话题
 */
@property (nonatomic,strong) XKTopicModel *currentModel;

/**
 第一级评论
 */
@property (nonatomic,strong) XKFirstCommtentModel *firstModel;

@end
