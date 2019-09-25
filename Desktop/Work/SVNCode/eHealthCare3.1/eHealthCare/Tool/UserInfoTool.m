//
//  UserInfoTool.m
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "UserInfoTool.h"

@implementation UserInfoTool

+ (void)saveLoginInfo:(UserInfoModel *)model
{
    NSDictionary *dic = [model mj_keyValues];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"LoginInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UserInfoModel *)getLoginInfo
{
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginInfo"];
    UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:infoDic];
    return model;
}

+ (void)clearLoginInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveUserPhone:(NSString *)userPhone
{
    //保存手机号码
    [[NSUserDefaults standardUserDefaults] setObject:userPhone forKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUserPhone
{
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    return phone;
}

@end
