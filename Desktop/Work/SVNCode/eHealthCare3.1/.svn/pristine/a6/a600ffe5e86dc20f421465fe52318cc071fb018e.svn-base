//
//  HealthReportCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemListModel.h"
@protocol HealthReportCellDelegate <NSObject>

- (void)HealthReportCellbuttonClick:(ItemListModel *)ItemListMod;

@end

@interface HealthReportCell : UITableViewCell
@property(nonatomic, strong)ItemListModel *ItemListMod;
@property (nonatomic, weak) id <HealthReportCellDelegate> delegate;

@end
