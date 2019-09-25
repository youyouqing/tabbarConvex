//
//  XKTopicDetialReplyFirstCommentCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKFirstCommtentModel.h"

@protocol XKTopicDetialReplyFirstCommentCellDelegate <NSObject>

@optional

/**
点赞功能的代理方法
 */
-(void)detailChangeTopicDataSoure:(XKFirstCommtentModel *) model;
/**
 一级评论功能的实现
 */
-(void)commtentFistReply:(XKFirstCommtentModel *) firstModel;

@end

@interface XKTopicDetialReplyFirstCommentCell : UITableViewCell

/**
 数据源
 */
@property (nonatomic,strong) XKFirstCommtentModel *model;

@property (nonatomic,weak) id<XKTopicDetialReplyFirstCommentCellDelegate> delegate;

@end
