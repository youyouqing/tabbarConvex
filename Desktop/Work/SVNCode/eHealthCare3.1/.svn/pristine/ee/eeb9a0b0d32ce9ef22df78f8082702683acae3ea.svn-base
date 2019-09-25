//
//  PersonalCenterModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCenterViewModel : NSObject


/**
 退出登录
 */
+ (void)signOutAction;


/**
 获取更换手机号验证码

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getChangePhoneNumMSMCodeWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 更换手机号

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)changePhoneNumWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



/**
 获取个人信息

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getPersonalMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

/**
 更换个人信息

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)resetPersonalMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 更换头像

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)changeHeadPhotoWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 意见反馈

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)sendSuggestionWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

//获取用户健康提醒设置
+ (void)getUserHealthRemindSetWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;

/**
 用户提交健康提醒设置
 */
+ (void)inputtUserHealthRemindSetWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
@end
