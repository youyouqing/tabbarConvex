//
//  CheckResultViewController.h
//  NewEquipmentCheck
//
//  Created by xiekang on 2017/8/16.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iGate.h"
#import "LanYaSDK.h"
#import "XKDeviceDetailMod.h"

//#import "RGKT_MeasureResult_Model.h"
@class XKDectingViewController;
@interface CheckResultViewController : BaseViewController<CiGateDelegate>
{
    CiGate *iGate;
    CiGateState _state;
   
    integer_t _rxFormat;
    uint32_t _totalBytesRead;
    
    
    LanYaSDK *maibobo;//脉搏波血压
    
}
@property (copy, nonatomic)NSString *BluetoothName;

//@property (strong, nonatomic)XKDeviceDetailMod *deviceMod;
//@property (strong, nonatomic) RGKT_MeasureResult_Model  *measureResult;//maibob
@property CiGateState state;
@property(assign,nonatomic)XKDetectStyle DectStyle;
@property(assign,nonatomic)BOOL isOtherDect; //手动检测还是自动检测
@property(assign,nonatomic)int BloodSugarType;//血糖类型餐前餐后
@property(copy,nonatomic)NSString *manualText;
@property(copy,nonatomic)NSString *manualTwoText;
@property(copy,nonatomic)NSString *manualThreeText;
@property(copy,nonatomic)NSString *manualFourText;

@property(copy,nonatomic)NSString *dectingNameImage;//检测中的图片

@property(strong,nonatomic)NSArray *pressAiaoleArr;

- (void)iGateDidUpdateState:(CiGateState)iGateState;
- (void)iGateDidReceivedData:(NSData *)data;
@property (copy, nonatomic) NSString *sendDataStr;
@property (copy, nonatomic) NSString *recDataStr;
@property (copy, nonatomic) NSString *recAiAoleDataStr;

@end
