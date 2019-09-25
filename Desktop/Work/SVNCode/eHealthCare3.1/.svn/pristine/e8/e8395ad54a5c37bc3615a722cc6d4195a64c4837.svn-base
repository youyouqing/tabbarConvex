//
//  CheerYourselfUpViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "CheerYourselfUpViewModel.h"

@implementation CheerYourselfUpViewModel

+ (void)getListenMyselfListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:listenMyselfListUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

@end
