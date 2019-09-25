//
//  XKTopicHotDetialCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKTopicModel.h"
#import "XKFirstCommtentModel.h"

@protocol XKTopicHotDetialCellDelegate <NSObject>

@optional
-(void)detailChangeTopicDataSoure:(XKFirstCommtentModel *) model;
-(void)commtentFistReply:(XKFirstCommtentModel *) firstModel;
-(void)replySecondeCommtent:(XKFirstCommtentModel *) firstModel withSeconde:(XKSecondeCommtentModel *)secondeModel;
-(void)jumpTopXKHotTopicDetailBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;

@end

@interface XKTopicHotDetialCell : UITableViewCell

@property (nonatomic,assign)BOOL noShow;
/**
 话题详情页面数据
 */
@property (nonatomic,strong) XKFirstCommtentModel *model;
@property (nonatomic,strong) XKTopicModel *topicModel;
@property (nonatomic,weak) id<XKTopicHotDetialCellDelegate> delegate;

@end
