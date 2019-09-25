//
//  CheerYourselfUpViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheerYourselfUpViewModel : NSObject


/**
 获取 为自己加油 数据列表

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getListenMyselfListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

@end
