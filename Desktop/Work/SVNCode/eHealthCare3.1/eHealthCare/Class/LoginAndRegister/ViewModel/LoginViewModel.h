//
//  LoginViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/6/29.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject



/**
 登录时候获取短信验证码

 @param dic 请求参数
 @param finish 返回请求数据
 */
+ (void)getLoginMSMCodeParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

/**
 登录

 @param dic 请求参数
 @param finish 返回请求数据
 */
+ (void)loginActionWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



/**
 第三方微信登录
 */
+ (void)getWechatLoginWithFinishedBlock:(void (^)(ResponseObject *response))finish;

/**
 第三方微信登录

 @param dic 请求参数
 @param finish 返回请求数据
 */
+ (void)thirdPartyWechatLoginWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



/**
获取登录前引导页问题

 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+ (void)GuideQuestionLoginWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;
@end