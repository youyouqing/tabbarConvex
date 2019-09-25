//
//  XKMedicalRecordDetailController.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPatientModel.h"
#import "XKPatientTypeModel.h"

@interface XKMedicalRecordDetailController : BaseViewController

/**
 电子病历上个页面数据源
 */
@property (nonatomic,strong) XKPatientModel *model;

/**
 电子病历类型数据源
 */
@property (nonatomic,strong) NSArray *typeArray;

/**
 记录当前会员id
 */
@property (nonatomic,assign) NSInteger MemberID;


@end
