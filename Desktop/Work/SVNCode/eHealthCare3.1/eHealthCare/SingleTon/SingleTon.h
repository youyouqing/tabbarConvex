//
//  singleTon.h
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTon : NSObject

+ (SingleTon *)shareInstance;

///标记是否登录
@property (nonatomic, assign) BOOL isLogin;

///token
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSInteger disT;
@property (nonatomic, assign) NSInteger stepCount;//首页那边从HealthKit获取来的步数  运动那边也用得到
@end
