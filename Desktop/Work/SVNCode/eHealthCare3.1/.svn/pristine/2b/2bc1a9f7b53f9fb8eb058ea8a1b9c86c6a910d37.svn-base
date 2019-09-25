//
//  HealthRecordCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopRecordModel.h"

@protocol HealthRecordCellDelegate <NSObject>

- (void)HealthRecordCellbuttonClick:(int)recprdModRemindType remind:(BOOL)remind  ;

@end




@interface HealthRecordCell : UITableViewCell
@property(strong,nonatomic)TopRecordModel *recprdMod;
@property (nonatomic, weak) id <HealthRecordCellDelegate> delegate;
@property(assign,nonatomic)NSInteger userMemberID;
@end
