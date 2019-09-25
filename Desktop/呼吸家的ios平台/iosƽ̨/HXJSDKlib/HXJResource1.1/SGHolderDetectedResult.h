//
//  SGHolderDetectedResult.h
//  BluetoothDev
//
//  Created by solon on 16/8/23.
//  Copyright © 2016年 solon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SGHolderDetectedResult : NSObject

/**
 
 #db_sk_report_info_b1(命令代码),0b1（终端类型）,q98YiB7Sf9（IMEI）,A2.906(协议版本),1(渠道号),23(消息长度), 32(B1存储数据总量),0(发送第几条数据),2016-01-01-01:58:04(B1数据存储时间),0(性别),0（年龄）,0（身高）,0（体重）,  252(pef),3.78(fev1),6.79(fvc),4.03(mef75),3.73(mef50),3.41(mef25),3.65(mmef),0(预留),
 2N3F404E4O4X545A5F5J5M5O5Q5T5W6065696E6J6O6S6V6X6Z707070706Z6Z6Y6X6W6W6V6U6T6T6S6S6S6R6R6R6R6Q6Q6Q6P6P6P6P6O6O6O6O6N6N6M6M6M6L6K6J6J6I6H6H6G6F6E6E6E6E6E6E6D6D6D6D6D6C6C6C6C6B6A6A6968676665646361605Y5W5V5U5T5S5R5R5Q5Q5Q5P5P5P5P5P5P5O5O5O5O5O5N5N5N5N5M5M5M5M5M5M5M5M5M5M5M5M5M5N5O5P5Q5S5T5U5V5V5W5W5W5W5V5V5V5V5V5V5W5W5W5V5V5U5T5S5R5Q5O5M5L5J5I5G5F5D5C5A5856534Z4V4R4L4F473Y3O3E332R2E1Z1H0Y0J0A0700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
     1907(CRC16校验码)

 */
@property (nonatomic,strong) NSString *commandCode;
@property (nonatomic,strong) NSString *terminalType;
@property (nonatomic,strong) NSString *IMEI;
@property (nonatomic,strong) NSString *protocalVersion;
@property (nonatomic,strong) NSString *channelNumber;
@property (nonatomic,strong) NSString *msgLength;
@property (nonatomic,strong) NSString *totalData;
@property (nonatomic,strong) NSString *dataIndex;
@property (nonatomic,strong) NSString *saveTime;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *height;
@property (nonatomic,strong) NSString *weight;
@property (nonatomic,strong) NSString *pef;
@property (nonatomic,strong) NSString *fev1;
@property (nonatomic,strong) NSString *fvc;
@property (nonatomic,strong) NSString *mef75;
@property (nonatomic,strong) NSString *mef50;
@property (nonatomic,strong) NSString *mef25;
@property (nonatomic,strong) NSString *mmef;
@property (nonatomic,strong) NSString *reserveValue;
@property (nonatomic,strong) NSString *pefGroup;
@property (nonatomic,strong) NSString *CRC16Code;

@property (nonatomic,strong) NSArray *pefGroups;

- (instancetype)initWithDetectedResultString:(NSString *)result;

- (BOOL)hasNullProperty;

+ (instancetype)holderDetectedResultWithResultString:(NSString *)result;



@end
