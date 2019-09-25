//
//  XKTopicDetialReplySecondeCommentCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSecondeCommtentModel.h"

@protocol XKTopicDetialReplySecondeCommentCellDelegate <NSObject>

@optional
-(void)sendSecondeCommendMsg:(XKSecondeCommtentModel *) model;

@end

@interface XKTopicDetialReplySecondeCommentCell : UITableViewCell

/**
 数据源
 */
@property (nonatomic,strong) XKSecondeCommtentModel *model;

/**
 代理
 */
@property (nonatomic,weak) id<XKTopicDetialReplySecondeCommentCellDelegate> delegate;

@end
