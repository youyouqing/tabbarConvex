//
//  RGKT_Configuration.h
//  RuiGuangKangTai
//
//  Created by 付亚明 on 10/9/14.
//  Copyright (c) 2014 付亚明. All rights reserved.
//

#ifndef RuiGuangKangTai_RGKT_Configuration_h
#define RuiGuangKangTai_RGKT_Configuration_h

typedef NS_ENUM(NSInteger, ISNoticeType)
{
    ISRefreshDataList       =1,             //刷新数据列表
    ISBluetoothConnectDone,                 //蓝牙连接成功（低层）
    ISBluetoothConnectError,                //蓝牙连接失败（低层）
    ISConnectDeviceSuccess,                 //连接设备成功
    ISConnectDeviceError,                   //连接设备失败
    ISGetPowerSuccess,                      //获取到设备电量
    ISMeasurementData,                      //测量实时数据
    ISMeasurementError,                     //测量途中发生失败
    ISConnectTimeOut,                       //连接超时或断开连接
    ISGetResultsData                        //获取测量结果
    
    
};
//注册通知ID
#define NOTICEKEYSTRING                     @"NoticeKeyString"
#define BluetoothDidPowerLow  @"BluetoothDidPowerLow"
#define BluetoothDidRefreshDevicesList  @"BluetoothDidRefreshDevicesList"
#define BluetoothDidConnectToDevice     @"BluetoothDidConnectToDevice"
#define BluetoothDidDisConnectToDevice  @"BluetoothDidDisConnectToDevice"
#define BluetoothConnectTimeout         @"BluetoothConnectTimeout"
//连接血压计成功
#define ConnectToRGKTSphygmomanometerSucceed            @"ConnectToRGKTSphygmomanometerSucceed"
//连接血压计失败
#define ConnectToRGKTSphygmomanometerFailed             @"ConnectToRGKTSphygmomanometerFailed"
//启动测量成功
#define StartMeasureUsingRGKTSphygmomanometerSucceed    @"StartMeasureUsingRGKTSphygmomanometerSucceed"
//启动测量失败
#define StartMeasureUsingRGKTSphygmomanometerFailed     @"StartMeasureUsingRGKTSphygmomanometerFailed"
//接收到测量结果
#define ReceivedRGKTSphygmomanometerMeasureResult       @"ReceivedRGKTSphygmomanometerMeasureResult"
//接收到测量数据
#define ReceivedRGKTSphygmomanometerMeasureData       @"ReceivedRGKTSphygmomanometerMeasureData"
#define GetWrongMessage @"GetWrongMessage"
//通知返回字典Key
#define TYPE            @"type"
#define OBJECT          @"object"

//血压测量操作
#define RGKT_BloodMeasureCommand                    0x01
#define RGKT_ConnectSphygmomanometer                0x01
#define RGKT_StartMeasure                           0x02
#define RGKT_StopMeasure                            0x03
#define RGKT_PowerOff                               0x04
#define RGKT_SendMeasureData                        0x05
#define RGKT_SendMeasureResult                      0x06
#define RGKT_SendWrongMessage                       0x07

//血压记忆操作
#define RGKT_BloodMemoryCommand                     0x02
#define RGKT_StartMemoryQuary                       0x01
#define RGKT_MemoryDelete                           0x02
#define RGKT_SendMemoryData                         0x03
#define RGKT_SendMemoryDataEnd                      0x04

//查询设备信息
#define RGKT_GetInfo                                0x04
#define RGKT_GetPower                               0x04
//应答标识************************
#define RGKT_ResponseSucceed                        0x00
#define RGKT_ResponseFailed                         0x01


//UUID
#define RGKT_Sphygmomanometer_ReadUUID              @"FFF1"
#define RGKT_Sphygmomanometer_WriteUUID             @"FFF2"

//#define RGKT_NewReadAndWriteUUID                    @"FFE1"
//
//#define fileService                                 0xFFE0
//#define fileSub                                     0xFFE1



//数据包**************************************
//包头
#define RGKT_RequestStart                           0xCC
#define RGKT_RequestSecond                          0x80
#define RGKT_ResponseStart                          0xAA
#define RGKT_ResponseSecond                         0x80

//测量结果字段
#define HeartAtriumShake                            @"heartAtriumShake"         //房颤
#define HeartRateIrregular                          @"heartRateIrregular"       //心率不齐
#define IsHealth                                    @"isHealth"                 //是否正常
#define HighPressure                                @"highPressure"             //收缩压
#define LowPressure                                 @"lowPressure"              //舒张压
#define DifferencePressure                          @"differencePressure"       //脉压差
#define HeartRate                                   @"heartRate"                //心率



#endif
