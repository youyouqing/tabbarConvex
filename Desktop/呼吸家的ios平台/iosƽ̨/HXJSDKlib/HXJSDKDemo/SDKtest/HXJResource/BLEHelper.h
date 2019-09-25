//
//  BLEHelper.h
//  huxijia
//
//  Created by solon on 16/9/6.
//  Copyright © 2016年 huxijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SGHolderDetectedResult.h"
#import "SGHttpTool.h"

//#define kWebBaseUrl @"http://www.huxijia.cn/hxj/auth2api/" //api请求接口目录
//#define kWebTokenUrl @"http://www.huxijia.cn/hxj/auth2"//token请求访问

#define kWebBaseUrl @"http://120.25.91.51/hxj/auth2api/"//测试访问auth2接口
#define kWebTokenUrl @"http://120.25.91.51/hxj/auth2/"//token请求访问
/***** BLE *******/
#define kBLEPeripherial @"B"
#define kBLEServiceUUID @"FFE0"
#define kBLECharacteristic @"FFE1"
#define kPeripheralId @"peripheralId"
/***** BLE *******/

@class SGHolderInfo,BLEHelper;

typedef NS_ENUM(NSInteger,SGRecordWarnType) {
    SGRecordWarnTypePEF = 0,
    SGRecordWarnTypeFEV1,
    SGRecordWarnTypeFVC
};

typedef NS_ENUM(NSInteger,BLEConnectStatusType) {
    BLEConnectOnStatus = 0,
    BLEConnectingStatus,
    BLEConnectOffStatus,
    BLEWillUpdateDeviceStatus,
    BLEUpdatingDeviceStatus,
    BLEDidUpdateDeviceStatus
};

@protocol BLEHelperDelegate <NSObject>

@required

/**
 *  蓝牙测试数据返回
 *
 *  @param helper          单例对象
 *  @param detectedResults 保存每一组检测值
 *  @param result          当前的测试数据
 */
- (void)BLEHelper:(BLEHelper *)helper detectedResults:(NSArray *)detectedResults currentResult:(SGHolderDetectedResult *)result;

@optional

- (void)BLEHelper:(BLEHelper *)helper ConnectStatusType:(BLEConnectStatusType)type;

- (void)BLEHelper:(BLEHelper *)helper getAccessToken:(NSString *)accessToken;
/**
 *  蓝牙更新
 *
 *  @param count 总共多少个更新包
 *  @param index 更新到第几个
 */
- (void)BLEHelperWriteValueCount:(NSInteger)count atIndex:(NSInteger)index;

@end

/**
 *  使用此类除了调用单例以外，还需要requestMatchInfoWithHolderInfo调用此方法
 *  传入检测人信息否则不会成功
 */

@interface BLEHelper : NSObject


/** 蓝牙管理者 */
@property (nonatomic,strong) CBCentralManager *centralManager;
/** 外设数组 */
@property (nonatomic,strong) NSMutableArray *peripherals;
/** 当前活动的外设 */
@property (nonatomic,strong) CBPeripheral *connectedPeripheral;
/** 当前连接的character */
@property (nonatomic,strong) CBCharacteristic *connectedCharacter;
/** 蓝牙可用状态 */
@property (nonatomic,assign) BOOL connectedStatus;

@property (nonatomic,assign) BLEConnectStatusType BLEConnectStatus;

@property (nonatomic,copy) void(^BLEConnectStatusBlock)(BLEConnectStatusType);

/** 蓝牙返回的数据 */
@property (nonatomic,strong) NSMutableArray<SGHolderDetectedResult *> *detectedResults;
/** 是否需要更新默认不更新 */
@property (nonatomic,assign) BOOL updateDeviceVersion;

@property (nonatomic,weak) id<BLEHelperDelegate> delegate;

//设备版本号连接成功后才会有值
@property (nonatomic,strong) NSString *BleDeviceVersion;


+ (instancetype)shareBLEHelper;

/** 链接到的外设可以传nil根据IMEI号连接对应设备 */
- (void)connectedPeripheral:(CBPeripheral *)peripheral imei:(NSString *)imei;





#pragma mark - 这里传入检测人配对信息
/** 获取检测人数据 */
- (void)requestMatchInfoWithHolderDict:(NSDictionary *)holderDict;

/** 停止扫描 */
- (void)stopScanP;
/** 取消链接 */
- (void)cancelBLEConnect;



@end
