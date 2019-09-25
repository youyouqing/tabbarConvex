//
//  XKRecordHospitalMessageCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历医院信息

#import <UIKit/UIKit.h>
#import "XKPatientDetailModel.h"

@protocol XKRecordHospitalMessageCellDelegate <NSObject>

@optional
-(void)hospitalMessageFix:(XKPatientDetailModel *) data;

@end

@interface XKRecordHospitalMessageCell : UITableViewCell

/**
 数据源
 */
@property (nonatomic,strong) XKPatientDetailModel *model;

@property (nonatomic,assign) BOOL isEnableEdit;

@property (nonatomic,weak) id<XKRecordHospitalMessageCellDelegate> delegate;

@end
