//
//  XKNewHomeHealthPlanCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHomePlanModel.h"

@protocol XKNewHomeHealthPlanCellDelegate <NSObject>

- (void)XKNewHomeHealthPlanCellbuttonClick;

@end

@interface XKNewHomeHealthPlanCell : UITableViewCell

@property (nonatomic,assign)NSInteger isEmpty;

@property (nonatomic,strong)XKHomePlanModel *model;
@property (nonatomic, weak) id <XKNewHomeHealthPlanCellDelegate> delegate;
@end
