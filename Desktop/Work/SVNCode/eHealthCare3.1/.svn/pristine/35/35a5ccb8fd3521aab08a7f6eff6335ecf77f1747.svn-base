//
//  HealthRecordViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/11/3.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "HealthRecordViewModel.h"

@implementation HealthRecordViewModel
+ (void)editRecordResultDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:checkHomeEditPersonalReportUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getRecordResultDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:checkHomeGetPersonalReportUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
+ (void)getRecordFamilyPersonWithParmas:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    
    [NetWorkTool postAction:checkHomeGetFamilyPersonalUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
+ (void)getRecordRemindFamilyPersonWithParmas:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    
    [NetWorkTool postAction:checkHomeRemindFamilyPersonalUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
+ (void)getHealthRecordHomeResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    
    [NetWorkTool postAction:getHealthRecordHomeResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
+(void)getTopRecordDataResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    
    [NetWorkTool postAction:getTopRecordDataResult params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
@end
