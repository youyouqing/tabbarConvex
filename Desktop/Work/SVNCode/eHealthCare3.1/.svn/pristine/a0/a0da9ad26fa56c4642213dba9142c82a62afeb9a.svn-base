//
//  TestReportViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TestReportViewModel.h"

@implementation TestReportViewModel

+ (void)getTestReportListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:getTestReportListUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
        
    }];
}

@end
