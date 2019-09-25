//
//  XKHealthIntegralTaskCell.h
//  eHealthCare
//
//  Created by mac on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//健康积分任务列表表格子视图cell

#import <UIKit/UIKit.h>
#import "XKHealthIntergralDailyQuestListModel.h"
#import "XKXKHealthIntergralDailyPlanHealthDetailListModel.h"

@interface XKHealthIntegralTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botommCons;

/*每日任务数据源*/
@property (nonatomic,strong) XKHealthIntergralDailyQuestListModel *dailyModel;

/*福利任务数据源*/
@property (nonatomic,strong) XKXKHealthIntergralDailyPlanHealthDetailListModel *planModel;

@end
