//
//  TopicCell.h
//  仿网易导航
//
//  Created by xiekang on 2017/6/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTopicFrame.h"
@class MHTopicFrame,TopicCell;
@protocol TopicCellDelegate <NSObject>

@optional


/** 用户点击更多按钮 */
- (void)topicCellForClickedMoreAction:(TopicCell *)topicCell;

/** 用户点击点赞按钮 */
- (void)topicCellForClickedThumbAction:(TopicCell *)topicCell;

/** 点击某一行的cell */
- (void) topicCell:(TopicCell *)topicCell  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/** 更多 */
- (void) topicCell:(TopicCell *)topicCell  didSelectMore:(NSInteger )indexPathSection;
@end

@interface TopicCell : UITableViewCell
@property (nonatomic , strong) MHTopicFrame *topicFrame;

@property (nonatomic , weak) id <TopicCellDelegate> delegate;
@property (nonatomic , assign) NSInteger cellId;

/** 点赞 */
@property (nonatomic , weak) UIButton *thumbBtn;

@property (nonatomic , strong) UITableView *infoTableView;
/** 昵称 */
@property (nonatomic , weak) UILabel *nicknameLable;
@end
