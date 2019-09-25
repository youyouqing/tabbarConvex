//
//  UserInfoTool.h
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserInfoTool : NSObject


/**
 存储用户数据

 @param model 用户数据model
 */
+ (void)saveLoginInfo:(UserInfoModel *)model;


/**
 取存储的用户数据

 @return 存储的用户数据
 */
+ (UserInfoModel *)getLoginInfo;


/**
 清空存储的用户数据
 */
+ (void)clearLoginInfo;


/**
 存储用户登录成功之后的手机号

 @param userPhone 用户手机号
 */
+ (void)saveUserPhone:(NSString *)userPhone;


/**
 取存储的用户手机号

 @return 存储的用户数据
 */
+ (NSString *)getUserPhone;

@end
