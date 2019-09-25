//
//  XKRecordTypeCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历类型信息

#import <UIKit/UIKit.h>
#import "XKPatientDetailModel.h"

@protocol XKRecordTypeCellDelegate <NSObject>

@optional
-(void)typeFixDataSource:(XKPatientDetailModel *) model;

@end

@interface XKRecordTypeCell : UITableViewCell

@property (nonatomic,strong) XKPatientDetailModel *model;

@property (nonatomic,strong) NSArray *typeArray;

@property (nonatomic,assign) BOOL isEnableEdit;

@property (nonatomic,weak) id<XKRecordTypeCellDelegate> delegate;

@end
