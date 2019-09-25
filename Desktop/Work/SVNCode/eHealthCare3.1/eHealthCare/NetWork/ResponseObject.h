//
//  ResponseObject.h
//  DecentTrainUser
//
//  Created by shiyong on 2018/6/13.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, httpCodeType){
    
    CodeTypeFail = 500,        // 请求失败
    CodeTypeNoNetWork = 999,   // 没有网络
//    CodeTypeNoResource = ,  // 资源被删除
    CodeTypeSucceed = 200,        // 请求成功
//    CodeTypeLoginInvalid = ,  // 登录无效
    CodeTypeTokenFial = 102 ,//Token失效
//    CodeTypeNeedLogin = ,//需要重新登录
    CodeTypeNotOnLine = 113,//未登录
    CodeTypeWechatNotOnLine = 2//微信登录
};

@interface ResponseObject : NSObject

/** 整个返回的JSON字典 */
@property (nonatomic, strong) NSDictionary *jsonDic;
/** 已经解析的具体数据 */
@property (nonatomic, strong) id Result;
/** 状态码 0:请求成功 -911:请求失败 其它code码根据具体接口文档定义 */
@property (nonatomic, assign) httpCodeType code;
/** 客户端展示的提示 */
@property (nonatomic, copy) NSString *msg;
/** 服务器异常数据 */
@property (nonatomic, copy) NSString *messageErr;
/** 错误解决方案 */
@property (nonatomic, copy) NSString *solution;

@property (nonatomic, strong) NSError *error; //

@end

