//
//  XKBindEquipmentViewController.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iGate.h"
#import "QingNiuSDK.h"
#import "QingNiuDevice.h"
#import "QingNiuUser.h"
#import "XKDeviceMod.h"
#import "XKBindTopTitleView.h"
#import "XKBindGuideTableViewCell.h"
#import "XKSearchEquiptView.h"
#import "XKDeviceDetailMod.h"
#import "XKDeviceProductMod.h"
#import "MSBluetoothManager.h"
#import "MSBluetoothManager.h"
#import "XKDectingViewController.h"
#import "BLEManager.h"
#import "TTCDeviceInfo.h"
#import "LanYaSDK.h"
#import "CRCreativeSDK.h"
#import "CheckResultViewController.h"
#import "XKValidationAndAddScoreTools.h"
#import <CoreBluetooth/CoreBluetooth.h>//导入蓝牙

@interface XKBindEquipmentViewController : BaseViewController<CiGateDelegate>
{
    CiGate *iGate;//爱康  iGate
    CiGateState _state;
    integer_t _rxFormat;
    uint32_t _totalBytesRead;
   
    
    
    UIButton *_scanButton;//体脂秤
    NSMutableArray *_allScanDevice;
    NSMutableArray *_deviceData;
    NSDictionary *_deviceDataDic;
    BOOL _scanFlag;
    QingNiuWeightUnit _qingNiuWeightUnit;//青牛体脂秤
    
    
    
    
    //  爱奥乐
    NSMutableArray* _deviceArray;
    NSTimer* _scanTimer;
    NSInteger* _scnaID;
    NSTimer* _connectTimer;
    NSInteger a;
//     NSArray* _deviceInfoManager;
}
@property(strong,nonatomic)XKDeviceMod *model;//蓝牙设备名字
@property(assign,nonatomic)XKDetectStyle style;
@property CiGateState state;
//@property (nonatomic,assign) int ProductID;

@property (nonatomic,assign) BOOL searchTool;//是否扫描到设备

@property (copy, nonatomic) NSString *sendDataStr;
@property (copy, nonatomic) NSString *recDataStr;

- (void)iGateDidUpdateState:(CiGateState)iGateState;
- (void)iGateDidReceivedData:(NSData *)data;
@end
