//
//  EncryptionTool.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//加密工具类

#import <Foundation/Foundation.h>

@interface EncryptionTool : NSObject

#pragma mark MD5加密
/*****************MD5加密****************/

/**
 32位小写加密

 @param str 需要加密的字符串
 @return 被加密后的字符串
 */
+ (NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 32位大写加密
 
 @param str 需要加密的字符串
 @return 被加密后的字符串
 */
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 16位大写加密
 
 @param str 需要加密的字符串
 @return 被加密后的字符串
 */
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;

/**
 16位小写加密
 
 @param str 需要加密的字符串
 @return 被加密后的字符串
 */
+ (NSString *)MD5ForLower16Bate:(NSString *)str;

#pragma mark DES加密


/**
 DES加密

 @param plainText 需要被加密的字符串
 @param key 秘钥
 @return 加密后的字符串
 */
+ (NSString *)encryptUseDES2:(NSString *)plainText key:(NSString *)key;



/**
 DES解密

 @param cipherText 需要被解密的字符串
 @param key 秘钥
 @return 解密后的字符串
 */
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
