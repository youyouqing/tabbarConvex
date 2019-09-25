//
//  XKPayModel.h
//  eHealthCare
//
//  Created by mac on 17/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKPayModel : NSObject

/**
 通知回调地址
 */
@property (nonatomic,copy)NSString *CallUrl;

@property (nonatomic,copy)NSString *nonceStr;

/**
 交易类型
 */
@property (nonatomic,assign)NSInteger packageValue;

/**
 商户id
 */
@property (nonatomic,assign)NSInteger partnerId;

/**
 合作伙伴id
 */
@property (nonatomic,copy)NSString *prepayId;

/**
 支付的签名
 */
@property (nonatomic,copy)NSString *sign;

/**
 时间戳
 */
@property (nonatomic,assign)UInt32 timeStamp;

@end
