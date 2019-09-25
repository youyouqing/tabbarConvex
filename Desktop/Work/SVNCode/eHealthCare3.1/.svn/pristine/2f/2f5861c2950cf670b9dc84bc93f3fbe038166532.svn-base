//
//  RemindCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthData.h"

@protocol RemindCellDelegate <NSObject>

- (void)RemindDataClick:(NSInteger)remindType;

@end

@interface RemindCell : UITableViewCell
@property (nonatomic,strong) HealthData *healthData;
@property (nonatomic, weak) id <RemindCellDelegate> delegate;
@end
