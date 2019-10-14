//
//  NetWorkTool.h
//  DecentTrainUser
//
//  Created by shiyong on 2018/6/13.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "zlib.h"
#import "ResponseObject.h"
#import "CoreStatus.h"
#import "HttpRequestReturnObject.h"

#import "AFNetWorking.h"

@interface NetWorkTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param action  业务路径
 *  @param params  请求参数
 *
 */
+ (void)postAction:(NSString *)action params:(id)params finishedBlock:(void (^)(ResponseObject *response))finish;

@end