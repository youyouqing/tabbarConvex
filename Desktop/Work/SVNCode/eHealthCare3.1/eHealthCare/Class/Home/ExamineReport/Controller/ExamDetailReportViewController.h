//
//  ExamDetailReportViewController.h
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalArcHeadView.h"
#import "ExanubeReportModel.h"
#import "PersonalArcModel.h"
#import "FamilyObject.h"
@interface ExamDetailReportViewController : BaseViewController

/**
 cell下半部分部分数据检测时间等
 */
@property (nonatomic, strong)ExanubeReportModel *PhysicalExaminationModel;


/**
 头部年龄性别
 */
@property (nonatomic, strong)FamilyObject *personal;
@end
