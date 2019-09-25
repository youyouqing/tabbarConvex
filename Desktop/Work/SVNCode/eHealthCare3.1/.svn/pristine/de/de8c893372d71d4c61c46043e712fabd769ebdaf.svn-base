//
//  VersionHelp.h
//  eHealthCare
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionHelp : NSObject

/*是否需要更新的状态 0不需要 1需要 2强制更新*/
@property (nonatomic,assign)NSInteger Status;

/*更新app的地址*/
@property (nonatomic,copy)NSString *UploadAddress;

/*更新显示的时间段*/
@property (nonatomic,assign)NSInteger IntervalTime;

/*更新的日志*/
@property (nonatomic,copy)NSString *UpdateLog;

+ (void)setSystemVersion:(NSMutableDictionary *)dict;

+ (VersionHelp *)getSystemVersion;

+(NSMutableDictionary *)getSystemVersionCacheDic;

+(void)removeVersion;

@end
