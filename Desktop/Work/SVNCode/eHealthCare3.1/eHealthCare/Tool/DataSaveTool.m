//
//  DataSaveTool.m
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "DataSaveTool.h"

@implementation DataSaveTool

//讲数据存储到plist文件里
+ (BOOL)saveDataAtPlistFile:(NSString *)plistName dataDic:(NSDictionary *)dataDic
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString * plistPath =[documentPath stringByAppendingPathComponent:plistName];
    
    NSMutableDictionary * plistDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    if (plistDic == nil)
    {
        plistDic = [[NSMutableDictionary alloc]init];
    }
    
    plistDic = [[NSMutableDictionary alloc]initWithDictionary:dataDic];
    
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:plistDic toFile:plistPath];   //序列化
    if (isSuccess)
    {
        NSLog(@"存储数据到%@成功",plistName);
        return YES;
    }
    
    NSLog(@"存储数据到%@失败",plistName);
    return NO;
}

//从plist文件里读取数据
+ (NSDictionary *)getDataFromPlistFile:(NSString *)plistName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString * plistPath =[documentPath stringByAppendingPathComponent:plistName];
    
    NSMutableDictionary * plistDic = [NSKeyedUnarchiver unarchiveObjectWithFile: plistPath];   //反序列化
    
    if (plistDic == nil)
    {
        return nil;
    }
    
    NSLog(@"从%@中取出来的数据:%@",plistName,[NSKeyedUnarchiver unarchiveObjectWithFile: plistPath]);
    return [NSKeyedUnarchiver unarchiveObjectWithFile: plistPath];
}

//查看沙盒里是否有该plist文件
+ (BOOL)fileExistsWithFileName:(NSString *)plistName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:plistName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    
    return fileExists;
}

//清除plist文件里的数据
+ (void)removeFileWithFileName:(NSString *)plistName
{
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:plistName];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:plistPath];
    
    if (bRet)
    {
        NSLog(@"清空了%@的数据",plistName);
        
        NSError *err;
        [fileMger removeItemAtPath:plistPath error:&err];
    }
}

@end
