//
//  MainViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/31.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

+ (void)getHotTopicHealthPlanAndMoreWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish
{
    [NetWorkTool postAction:home_getHotTopicHealthPlanAndMoreAboutUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getHealthTestWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getHealthTestUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getTopicCategoryOrInformationCategoryOrHealthPlanCategoryWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getTopicCategoryOrinformationCategoryOrHealthPlanCategoryUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
+ (void)gethometree_getHomeResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:hometree_getHomeResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
//获取预约挂号160对接接口加密串
+ (void)gethomeAppointmentResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:@"127" params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
@end