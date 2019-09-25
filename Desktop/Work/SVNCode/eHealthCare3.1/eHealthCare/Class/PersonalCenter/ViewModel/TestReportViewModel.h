//
//  TestReportViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestReportViewModel : NSObject


/**
 获取测评报告列表数据

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getTestReportListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

@end
