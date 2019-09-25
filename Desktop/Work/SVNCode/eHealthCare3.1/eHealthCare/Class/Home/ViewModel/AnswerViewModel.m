//
//  AnswerViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/8/7.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AnswerViewModel.h"

@implementation AnswerViewModel

+ (void)getTestQuestionWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getTestQuestionUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)uploadTestResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_upLoadTestResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getPhysicalTestingDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getPhysicalTestingUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)uploadPhysicalTestResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_upLoadPhysicalTestResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getPhysicalTestResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:home_getPhysicalTestResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
@end
