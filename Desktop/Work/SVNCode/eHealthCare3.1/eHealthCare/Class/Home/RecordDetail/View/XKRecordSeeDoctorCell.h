//
//  XKRecordSeeDoctorCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历原因和结果

#import <UIKit/UIKit.h>
#import "XKPatientDetailModel.h"

@protocol XKRecordSeeDoctorCellDelegate <NSObject>

@optional
-(void)seeDoctorFixDataSource:(XKPatientDetailModel *) model;

@end

@interface XKRecordSeeDoctorCell : UITableViewCell

/**
 数据源
 */
@property (nonatomic,strong) XKPatientDetailModel *model;

@property (nonatomic,assign) BOOL isEnableEdit;

@property (nonatomic,weak) id<XKRecordSeeDoctorCellDelegate> delegate;
/**
 就诊原因文本视图
 */
@property (weak, nonatomic) IBOutlet UITextView *resonTxt;

/**
 就诊结果文本视图
 */
@property (weak, nonatomic) IBOutlet UITextView *resultTxt;
@end