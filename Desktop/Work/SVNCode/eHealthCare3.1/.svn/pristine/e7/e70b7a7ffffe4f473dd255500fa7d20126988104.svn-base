//
//  LanYaSDK.h
//  LanYaSDK
//
//  Created by iKnet on 16/9/26.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "RGKT_Configuration.h"

//蓝牙状态
typedef NS_ENUM(NSInteger,BluetoothStatus)
{
    BLE_STATUS_IDLE = 0,        //闲置
    BLE_STATUS_SCANNING,        //扫描
    BLE_STATUS_CONNECTING,      //正在连接
    BLE_STATUS_CONNECTED,       //已连接
    BLE_STATUS_PowerOn,         //打开
    BLE_STATUS_PowerOff,        //关闭
};
//外围蓝牙类型
typedef NS_ENUM(NSInteger, BluethoothType)
{
    BLE_UUID_FFF0,
    BLE_UUID_FFE0
};

@interface LanYaSDK : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

//搜索到的所有蓝牙设备
@property(strong,nonatomic)NSMutableArray       *scanDeviceListArr;
//蓝牙中央管理器
@property(strong,nonatomic)CBCentralManager     *bluetoothCentralManager;
//蓝牙当前状态
@property(assign,nonatomic)BluetoothStatus      bluetoothStatus;
//外围变量
@property(strong,nonatomic)CBPeripheral         *connectedPeripheral;
//写入特征
@property(strong,nonatomic)CBCharacteristic     *writeCharateristic;
//测量结果
@property(copy,nonatomic)NSDictionary           *measuredResults_Dic;
//外围蓝牙类型
@property(assign,nonatomic)BluethoothType       bluethoothType;

@property (nonatomic,assign) BOOL searchTool;//是否扫描到设备
@property (nonatomic,assign) NSInteger isConnectedEquipt;//2为连接
/**
 扫描失败
 */
-(void)searchFailDevice;

+(LanYaSDK*)shareInstance;
//初始化管理器数据
-(void)managerInitializeData;
//开始扫描蓝牙设备
-(void)startScan;
//停止扫描蓝牙设备  
-(void)stopScan;
//底层蓝牙握手
-(void)connectDevice:(id)peripheral;
//底层蓝牙断开
-(void)disconnectDevice:(CBPeripheral *)peripheral;
//血压设备握手
-(void)connectToRGKTSphygmomanometer;
//查询电量
-(void)getMeasureUsingRGKTMessage;
//开始测量
-(void)startMeasureUsingRGKTSphygmomanometer;
//停止测量
- (void)stopMeasureUsingRGKTSphygmomanometer;
@end

