//
//  XKRecordBasisCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历基础信息

#import <UIKit/UIKit.h>
#import "XKPatientDetailModel.h"

@protocol XKRecordBasisCellDelegate <NSObject>

@optional
-(void)basisFixDataSource:(XKPatientDetailModel *) data;

@end

@interface XKRecordBasisCell : UITableViewCell

/**
 数据源
 */
@property (nonatomic,strong) XKPatientDetailModel *model;

@property (nonatomic,assign) BOOL isEnableEdit;

@property (nonatomic,weak) id<XKRecordBasisCellDelegate> delegate;

@end
