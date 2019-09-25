//
//  DataSaveTool.h
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSaveTool : NSObject


/**
 存储到plist文件

 @param plistName plist文件名称
 @param dataDic 需要被存储的数据
 @return 是否存储成功
 */
+ (BOOL)saveDataAtPlistFile:(NSString *)plistName dataDic:(NSDictionary *)dataDic;


/**
 读取数据从plist文件

 @param plistName plist文件名称
 @return 取出来的数据
 */
+ (NSDictionary *)getDataFromPlistFile:(NSString *)plistName;


/**
 查看沙盒里是否有该plist文件

 @param plistName plist文件名称
 @return 是否存在
 */
+ (BOOL)fileExistsWithFileName:(NSString *)plistName;

/**
 移除对应plist文件的数据

 @param plistName 需要移除的plist文件名称
 */
+ (void)removeFileWithFileName:(NSString *)plistName;

@end
