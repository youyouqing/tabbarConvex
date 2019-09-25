//
//  SportViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportViewModel : NSObject


/**
 上传运动信息

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)updateSprotMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



+ (void)loadSprotMessageWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

@end
