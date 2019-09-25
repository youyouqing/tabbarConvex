//
//  HealthPlanViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthPlanViewModel.h"

@implementation HealthPlanViewModel

+ (void)getHealthPlanCategoryListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getHealthPlanCategoryListUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getMyHealthPlanListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getMyHealthPlanListUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)joinHealthPlanWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_joinHealthPlanUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getTodayHealthPlanWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getTodayHealthPlanUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getTodayPlanDetailWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getTodayPlanDetailUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)finishTodayPlanWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_finishTodayHealthPlanUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getPlanResultDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getPlanResultDataUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
@end
