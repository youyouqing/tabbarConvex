//
//  LoginViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/6/29.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "LoginViewModel.h"
#import <ShareSDK/ShareSDK.h>

@implementation LoginViewModel

+ (void)getLoginMSMCodeParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:getLoginMSMCodeUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            
            
        }
        finish(response);
        
    }];
}

+ (void)loginActionWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:loginActionUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            [SingleTon shareInstance].isLogin = YES;
            [SingleTon shareInstance].token = response.Result[@"Token"];
            UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:response.Result];
            [UserInfoTool saveLoginInfo:model];
        }
        finish(response);
        
    }];
}

+ (void)getWechatLoginWithFinishedBlock:(void (^)(ResponseObject *))finish
{  /*绑定类型:1.微信  2.QQ  3.新浪微博  4.腾讯微博 5支付宝 6微信公众平台*/
    [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
        
        if (state == SSDKResponseStateSuccess)
        {
            NSDictionary *dic = @{@"Token":@"",
                                  @"OpenId":user.rawData[@"openid"],
                                  @"UnionId":user.rawData[@"unionid"],
                                  @"BindType":@(6)};
            
            [self thirdPartyWechatLoginWithParams:dic FinishedBlock:^(ResponseObject *response) {
                
                finish(response);
                
            }];
             
        }else
        {
            ResponseObject *response = [[ResponseObject alloc]init];
            response.code = CodeTypeFail;
            response.msg = @"登录失败";
            
            finish(response);
        }
        
    }];
}
//932
+ (void)thirdPartyWechatLoginWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:wechatLoginUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
           
        }
        finish(response);
        
    }];
}
+ (void)GuideQuestionLoginWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;
{
    
    [NetWorkTool postAction:GuideLoginUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
           
        }
        finish(response);
        
    }];
    
}
@end
