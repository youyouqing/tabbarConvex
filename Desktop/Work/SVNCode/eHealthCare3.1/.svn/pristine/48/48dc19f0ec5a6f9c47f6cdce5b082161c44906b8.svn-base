//
//  HealthPlanReportCell.h
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopRecordModel.h"
@protocol HealthPlanReportCellDelegate <NSObject>

- (void)HealthPlanReportCellbuttonClick:(TopRecordModel *)tMod remind:(BOOL)remind;

@end


@interface HealthPlanReportCell : UITableViewCell
@property(nonatomic, strong)TopRecordModel *PlanListMod;
@property(assign,nonatomic)NSInteger userMemberID;
@property (nonatomic, weak) id <HealthPlanReportCellDelegate> delegate;
@end
