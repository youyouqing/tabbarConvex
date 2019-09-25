//
//  UserInfoModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
//@property (nonatomic, copy) NSString *OpenID;
///token
@property (nonatomic, copy) NSString *Token;

///手机号码
@property (nonatomic, copy) NSString *Mobile;

///用户名
@property (nonatomic, copy) NSString *Account;

///会员编号
@property(nonatomic,assign)NSInteger MemberID;

///档案标识
@property (nonatomic, copy) NSString *RecordID;

///档案编号
@property (nonatomic, copy) NSString *RecordNo;

///是否注册环信
@property (nonatomic, copy) NSString *EasemobRegister;

///环信账号
@property (nonatomic, copy) NSString *UserAccount;

///性别编号  0、男  1、女  -1、未知
@property(nonatomic,assign)NSInteger SexID;

///会员头像
@property (nonatomic, copy) NSString *HeadImg;

///姓名
@property (nonatomic, copy) NSString *Name;
//健康报告，显示的是档案里面的名字
@property (nonatomic, copy) NSString *FullName;

///年龄
@property (nonatomic,assign) NSInteger Age;

///昵称
@property (nonatomic, copy) NSString *NickName;

@property(nonatomic,assign)NSInteger Height;

///出生年月
@property (nonatomic, copy) NSString *Birthday;

@end
