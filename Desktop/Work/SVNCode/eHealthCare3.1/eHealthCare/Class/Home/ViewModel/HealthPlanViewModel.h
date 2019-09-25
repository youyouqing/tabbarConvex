//
//  HealthPlanViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthPlanViewModel : NSObject

///获取健康计划分类各分类列表
+ (void)getHealthPlanCategoryListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


///获取我的健康计划列表
+ (void)getMyHealthPlanListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


///加入健康计划
+ (void)joinHealthPlanWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


///根据健康计划编号获取当日健康计划
+ (void)getTodayHealthPlanWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


///获取当日计划详情
+ (void)getTodayPlanDetailWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


///完成当日计划
+ (void)finishTodayPlanWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


///获取 (计划完成界面)用户计划结果数据
+ (void)getPlanResultDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

@end
