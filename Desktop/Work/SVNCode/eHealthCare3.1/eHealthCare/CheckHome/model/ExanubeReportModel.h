//
//  ExanubeReportModel.h
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExanubeReportModel : NSObject
@property(nonatomic, strong)NSString *ExceptionCount;//异常项
@property(nonatomic, strong)NSString *CheckCount;//完成项
@property(nonatomic, strong)NSString *TestTime;
@property(nonatomic, strong)NSString *PhysicalExaminationID;
//是否总检
@property (nonatomic,assign)NSInteger IsOverall;

@property(nonatomic, assign)NSInteger cellIndex;
@property(nonatomic, strong)NSString *year;
@property(nonatomic, strong)NSString *day;

// 从健康监测和健康档案传值过来的名字。,暂时可以修改
@property(nonatomic, strong)NSString *FulName;
@end
