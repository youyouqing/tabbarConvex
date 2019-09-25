//
//  SportViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportViewModel.h"

@implementation SportViewModel

+ (void)updateSprotMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:updateSportMessageUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
        
    }];
}
+(void)loadSprotMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    
    
    [NetWorkTool postAction:home_sportsUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            
            
        }
        finish(response);
        
    }];
}
@end
