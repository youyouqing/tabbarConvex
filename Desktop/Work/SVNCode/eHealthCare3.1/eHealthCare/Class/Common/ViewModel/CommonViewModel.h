//
//  CommonViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonViewModel : NSObject


/**
 检查token是否失效

 @param finish 请求回调
 */
+ (void)checkTokenIsFailureWithFinishedBlock:(void (^)(ResponseObject *response))finish;


/***************************商城***************************/
/**
 订单付款之前校验

 @param finish 请求回调
 */
+ (void)checkOrderBeforePayMoneyWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

/***************************支付***************************/
/**
 跳转支付宝支付
 */
+ (void)payMoneyUseAliPay;


/**
 跳转微信支付
 */
+ (void)payMoneyUseWechat;


@end
