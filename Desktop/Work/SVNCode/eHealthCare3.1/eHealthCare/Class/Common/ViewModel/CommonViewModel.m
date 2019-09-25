//
//  CommonViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "CommonViewModel.h"

@implementation CommonViewModel

//校验token是否失效
+ (void)checkTokenIsFailureWithFinishedBlock:(void (^)(ResponseObject *response))finish
{
//    NSDictionary *dic = @{@"Token":[SingleTon shareInstance].token};
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@""};
    [NetWorkTool postAction:tokenIsFailureUrl params:dic finishedBlock:^(ResponseObject *response) {
       
        if (response.jsonDic.count > 0)
        {
            if (response.code != CodeTypeSucceed) {
                
                [SingleTon shareInstance].token = nil;
                [SingleTon shareInstance].isLogin = NO;
                [UserInfoTool clearLoginInfo];
            }
        }
        
        finish(response);
    }];
}

//订单付款校验
+ (void)checkOrderBeforePayMoneyWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:checkOrderPayUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        
        finish(response);
    }];
}

+ (void)payMoneyUseAliPay
{
    
}


@end
