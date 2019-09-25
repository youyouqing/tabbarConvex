//
//  SGHttpTool.h
//  HXJBlueSDK
//
//  Created by solon on 16/10/9.
//  Copyright © 2016年 solon. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SGHttpTool : NSObject

//请求带token的
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
//获取code


@end
