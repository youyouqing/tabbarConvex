//
//  PersonalCenterModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PersonalCenterViewModel.h"

@implementation PersonalCenterViewModel

//退出登录
+ (void)signOutAction
{
    [UserInfoTool clearLoginInfo];
    [SingleTon shareInstance].token = nil;
    [SingleTon shareInstance].isLogin = NO;
}

//获取更换手机号验证码
+ (void)getChangePhoneNumMSMCodeWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:getChangePhoneMSMCodeUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
        }
        
        finish(response);
        
    }];
}

//更换手机号
+ (void)changePhoneNumWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:changePhoneNumUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            //更换手机号
            NSString *newPhone = [dic objectForKey:@"NewMobile"];
            if (newPhone.length > 0) {
                UserInfoModel *model = [UserInfoTool getLoginInfo];
                model.Mobile = newPhone;
                [UserInfoTool saveLoginInfo:model];
            }
            
        }
        
        finish(response);
        
    }];
}

//获取个人信息
+ (void)getPersonalMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:getPersonalMesaageUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
        
    }];
}

//更改个人信息
+ (void)resetPersonalMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:resetPersonalMessageUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            
        }
        
        finish(response);
        
    }];
}

//更换头像
+ (void)changeHeadPhotoWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:changeHeadPhotoUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            //更换头像
            NSString *newHeadPhoto = [dic objectForKey:@"HeadImg"];
            if (newHeadPhoto.length > 0) {
                UserInfoModel *model = [UserInfoTool getLoginInfo];
                model.HeadImg = newHeadPhoto;
                [UserInfoTool saveLoginInfo:model];
            }
            
        }
        finish(response);
        
    }];
}

//意见反馈
+ (void)sendSuggestionWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:sendSuggestionUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
        
    }];
}
+ (void)getUserHealthRemindSetWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:getUserHealthRemindSetUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
        
    }];
}
//用户提交健康提醒设置
+ (void)inputtUserHealthRemindSetWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:inputUserHealthRemindSetUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
        
    }];
    
}
@end
