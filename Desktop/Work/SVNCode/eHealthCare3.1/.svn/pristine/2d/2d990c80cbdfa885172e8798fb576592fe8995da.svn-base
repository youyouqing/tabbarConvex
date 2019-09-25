//
//  MSBluetoothManager.h
//  ThermometerDemo
//
//  Created by xubin luo on 14-4-30.
//  Copyright (c) 2014年 CoolBall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


/**
 HC-08

 @return 
 *///耳温枪HC-08 HTD02
#define MyPeripheralName @"CardioChek-333E"//BC014554  "HC-08"BLE-EMP-Ui  BC0145541001   "HC-08"BLE-EMP-Ui  BC0145541001 CardioChek-333E
#define MySUUID @"FFE0"  //
#define MyCUUID @"FFE0"
//FEE0
#define kNotificationSearch @"kNotificationSearch"
#define kNotificationConnected @"kNotificationConnected"
#define kNotificationDisconnected @"kNotificationDisconnected"
#define kNotificationconnectedFail @"kNotificationconnectedFail"
@protocol MSBluetoothManagerToolDelegate <NSObject>
/**
 更新链接状态
 */
@optional
-(void)updateManagerToolTheConnectionStatus:(NSInteger) connectionStatus;
/**
 检测结果传输
 @param dict jison数据 多个值  血脂
 */
@optional
-(void)resultManagerToolSend:(NSDictionary *)dict;
/**
 血压检测数据传输
 @param dict jison数据 一个值
 */
-(void)pressureManagerToolSend:(NSDictionary *)dict;
/**
 血氧检测数据传输
 @param dict jison数据 多个值
 */
@optional
-(void)oxygenManagerToolSend:(NSDictionary *)dict;
/**
 心率检测数据传输
 @param dict jison数据 多个值
 */
@optional
-(void)heartManagerToolSend:(NSDictionary *)dict;
/**
 体温检测数据传输
 @param dict jison数据 一个值
 */
@optional
-(void)temperatureManagerToolSend:(NSString *)dict;
/**
 心电检测数据传输
 @param ecgStr 字符串
 */
@optional
-(void)ecgManagerToolSend:(NSString *)ecgStr  nHR:(NSInteger)nHR lead:(BOOL)bLeadOff;



-(void)ecgManagerToolSendnHR:(NSInteger)nHR;



-(void)nGuiManagerToolSendnGu:(NSInteger)nGu;
@end

typedef enum _EN_Command_Type
{
    EN_Command_Invalid = -1,
    EN_Command_Start = 0x0,
    EN_Command_Mode1 = 0x1,
    EN_Command_Mode2,
    EN_Command_Mode3,
    EN_Command_Mode4,
    EN_Command_Mode5,
    EN_Command_Mode6,
    EN_Command_Mode7,
    EN_Command_Mode8,
    EN_Command_Mode9,
    EN_Command_Stop,
    EN_Command_Shutdown,//关机
}EN_CommandType;



@interface MSBluetoothManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (strong,nonatomic) CBService *cbServices;
@property (strong,nonatomic) CBCharacteristic *cbCharacteristcs;
@property (copy, nonatomic) NSString *recDataStr;//拼接数据
@property (nonatomic,assign)BOOL bluetoothPowerOn;
@property (nonatomic,copy) NSString *adVpersincalName;//设备名字
@property (nonatomic,assign) BOOL conntiontTool;//绑定设备不链接

@property (nonatomic,assign) BOOL searchtTool;//是否搜索到设备
@property (nonatomic,weak) id<MSBluetoothManagerToolDelegate> delegate;
/**
 *  单例方法
 *
 *  @return 单例
 */
+(MSBluetoothManager*)shareInstance;

/**
 *  开始扫描
 */
-(void)startScan;

/**
 *  停止扫描
 */
-(void)stopScan;


/**
 *  连接
 */
-(void)startconnect;

/**
 *  取消连接
 */
-(void)cancelConnect;


/**
 *  向设备写数据
 */
-(BOOL)writeData:(NSData*)data;

/**
 *  是否可以准备好写数据
 *
 *  @return 是否可以准备好写数据
 */
-(BOOL)isReady;

/**
 *  发送命令
 *
 *  @param command 命令内容
 *
 *  @return 是否发送成功
 */
-(BOOL)sendCommand:(EN_CommandType)command;


@end

