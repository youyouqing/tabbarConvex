//
//  BluetoothConnectionTool.m
//  PC300
//
//  Created by jamkin on 2017/4/19.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import "BluetoothConnectionTool.h"
#import "CRSpotCheck.h"
#import "CRCreativeSDK.h"
#import "CRSpo2.h"
#import "XKSearchToolView.h"
static id _instance;

@interface BluetoothConnectionTool ()<CreativeDelegate,SpotCheckDelegate,UIActionSheetDelegate>{

    CreativePeripheral *currentPort;
    
    BOOL bIsActionEcg;
    BOOL bIsActionNibp;
    
}
/**
 收缩图
 */
@property(strong,nonatomic)XKSearchToolView *searchEquipView;


@property(assign,nonatomic)NSInteger jumpIndex;
@end

@implementation BluetoothConnectionTool
@synthesize foundPorts;
+ (instancetype)sharedInstanceTool{
    @synchronized(self){
        if(_instance == nil){
            _instance = [[self alloc] init];
        }

    }

    return _instance;
}
-(XKSearchToolView *)searchEquipView
{
    if (!_searchEquipView) {
        _searchEquipView = [[NSBundle mainBundle]loadNibNamed:@"XKSearchToolView" owner:self options:nil].firstObject;
        _searchEquipView.x = 0;
        _searchEquipView.y = 0;
        _searchEquipView.width = KScreenWidth;
        _searchEquipView.height = KScreenHeight;
        _searchEquipView.delegate = self;
    }
    return _searchEquipView;
}
-(void)scanDevice{
    
//    if (self.conntiontTool == 2) {
//        self.searchEquipView.alpha = 0;
//        self.searchEquipView.style = 2;
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        [window addSubview:self.searchEquipView];
//    }
//    
    NSLog(@"*********---扫描设备------%@",currentPort);
    
    self.searchTool = NO;
    [CRCreativeSDK sharedInstance].delegate = self;
    [CRSpotCheck sharedInstance].delegate = self;
    

    self.conntiontStatus = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [foundPorts removeAllObjects];
//        currentPort = nil;
        [[CRCreativeSDK sharedInstance] startScan:5.0];
         [CRSpotCheck sharedInstance].delegate = self;

        if ([self.adVpersincalName isEqualToString:@"POD"]) {
               [CRSpo2 sharedInstance].delegate = self;
        }
       else
            self.searchEquipView.alpha = 1.0;
        
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if (self.searchTool == NO) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(searchFailDevice)]) {
                
                [self.delegate searchFailDevice];
            }
            
        }
        
        
    });
    
}
#pragma mark   搜索代理协议
-(void)beginAgainToSearchDectTool;
{
    [self scanDevice];

}
#pragma mark sdk 协议
-(void)OnSearchCompleted:(CRCreativeSDK *)bleSerialComManager{
    NSLog(@"*********---扫描设备完成-***********---%@",currentPort);
    
    BOOL isConnectSearch = NO;
    
    foundPorts = [[CRCreativeSDK sharedInstance] GetDeviceList];
    for (CreativePeripheral *p in foundPorts) {
        if ([p.advName isEqualToString:@"POD"]) {
            
            [[CRSpotCheck sharedInstance] QueryDeviceVer:p];
            
             [[NSNotificationCenter defaultCenter] postNotificationName:@"PODSearch" object:@[p.peripheral]];
            currentPort = p;
            self.searchTool = YES;
            isConnectSearch = YES;
            if (self.conntiontTool == 3) {
                //对外抛出连接的通知
               
//                self.searchEquipView.style = 5;
                if ([self.delegate respondsToSelector:@selector(TheConnectionPodStatus:)]) {
                    [self.delegate TheConnectionPodStatus:7];
                }
                [[CRCreativeSDK sharedInstance] connectDevice:p];
            }
          
            
            
            
        }
         else  if ([p.advName  containsString: @"PC"]) {
            isConnectSearch = YES;
            NSLog(@"advName=------%@",p.advName);
             currentPort = p;
//            self.searchEquipView.style = 5;
             [[CRCreativeSDK sharedInstance] connectDevice:p];

             if ([self.delegate respondsToSelector:@selector(updateTheConnectionStatus:)]) {
                 [self.delegate updateTheConnectionStatus:7];
             }
             
        }
      
        
    }

    
}
//-(void)crManager:(CRCreativeSDK *)crManager OnFindDevice:(CreativePeripheral *)port
//{
//    if([port.advName  isEqual: @"PC-200"]||[port.advName  isEqual: @"PC_300SNT"]||[port.advName isEqual:@"POD"]||[port.advName  isEqual: @"PC-300SNT"])//CardioChek-333E   QN-Scale ||[port.advName  isEqual: @"PC-100"]||[port.advName  isEqual: @"POD"]||[port.advName  isEqual: @"HC-08"]||[port.advName  isEqual: @"HTD02"]
//    {
//        if ([port.advName isEqual:@"POD"]) {
////                    [[CRCreativeSDK sharedInstance] searchPortsTimeout];//停止扫描，返回
//            [[CRSpotCheck sharedInstance] QueryDeviceVer:currentPort];//xuyagng
//            
//               currentPort = port;
//            //对外抛出连接的通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PODSearch" object:@[port.peripheral]];
//            
//            if (self.conntiontTool == 3) {
//                [[CRCreativeSDK sharedInstance] connectDevice:port];
//            }
//        }
//        else
//        {
//           currentPort = port;
//            
//           NSLog(@"port*************=------%@",port);
//            
//           [[CRCreativeSDK sharedInstance] connectDevice:port];
//            
//        }
//    }
//    
//}

//connect 成功
-(void)crManager:(CRCreativeSDK *)crManager OnConnected:(CreativePeripheral *)peripheral withResult:(resultCodeType)result CurrentCharacteristic:(CBCharacteristic *)theCurrentCharacteristic{
    NSLog(@"显示点东西");
    NSInteger CRCreativeSDK  = [[NSUserDefaults standardUserDefaults] integerForKey:@"CRCreativeSDKF"];
    
    if (CRCreativeSDK == 2) {
         NSLog(@"OnConnected%@",currentPort);

    }
   
    NSString *connectString = [[NSString alloc] init];
    if (result == RESULT_SUCCESS)
    {
//        self.searchEquipView.style = 4;

        [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"CRCreativeSDKF"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        connectString = @"连接成功";
        self.conntiontStatus = 2;
        NSLog(@"连接成功");
        bIsActionEcg = FALSE;
        bIsActionNibp = FALSE;

        if ([peripheral.advName isEqual:@"POD"]) {
            
            
            if ([self.delegate respondsToSelector:@selector(TheConnectionPodStatus:)]) {
                [self.delegate TheConnectionPodStatus:2];
            }
            //NSLog(@"open success");/xuyagng
            [[CRSpo2 sharedInstance] QueryDeviceVer:currentPort];
            
            [[CRSpo2 sharedInstance] SetParamAction:TRUE port:currentPort];
            
            [[CRSpo2 sharedInstance] SetWaveAction:TRUE port:currentPort];
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(updateTheConnectionStatus:)]) {
                [self.delegate updateTheConnectionStatus:2];
            }
            [self beginAutoTest];
        }

       
//        self.connectionStatus=2;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.searchEquipView removeFromSuperview];
        });
    }
    else
    {
//        self.searchEquipView.style = 3;
        
        connectString = @"连接失败";
        self.conntiontStatus = 3;
        if ([self.delegate respondsToSelector:@selector(updateTheConnectionStatus:)]) {
            [self.delegate updateTheConnectionStatus:3];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeWindowRoot" object:nil];
//        self.connectionStatus=4;
        
    }
    
    
    

}
- (void) stopScan;
{
  //  [[CRCreativeSDK sharedInstance]stopScanAndSearchComplete];
    
}
/**
 断开链接
 */
-(void)disconnectDevice;
{
    NSLog(@"---disconnectDevice-----%@",currentPort);

    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"CRCreativeSDKF"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    currentPort.connectStatus = CREATIVEPERIPHERAL_CONNECT_STATUS_CONNECTED;
    [[CRCreativeSDK sharedInstance] disconnectDevice:currentPort];
   // [[CRCreativeSDK sharedInstance]closePort:currentPort];
    currentPort = nil;
}
-(void)PoddisconnectDevice;
{
    
     NSLog(@"---currentPort-----%@",currentPort);
    currentPort.connectStatus = CREATIVEPERIPHERAL_CONNECT_STATUS_CONNECTED;
    [[CRCreativeSDK sharedInstance] disconnectDevice:currentPort];
    // [[CRCreativeSDK sharedInstance]closePort:currentPort];
     currentPort = nil;
}
-(void)crManager:(CRCreativeSDK *)crManager OnConnectFail:(CBPeripheral *)port
{
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"CRCreativeSDKF"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     NSLog(@"didClosedPort---%d", [[NSUserDefaults standardUserDefaults]integerForKey:@"CRCreativeSDKF"]);

    if ([self.delegate respondsToSelector:@selector(updateTheConnectionStatus:)]) {
        [self.delegate updateTheConnectionStatus:4];
    }
    self.conntiontStatus = 4;
//    self.connectionStatus=3;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeWindowRoot" object:nil];
     currentPort = nil;
}

-(void)showAlert:(NSString *)message
{
    UIAlertView *connectAlert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [connectAlert show];
}

-(void) ShowNibpError:(int)nError
{
    NSString *message = [[NSString alloc] init];//NSLocalizedString(@"未扫描到设备",@"未扫描到设备");
    switch (nError) {
        case NIBP_ERROR_CUFF_NOT_WRAPPED:
            message = @"Cuff error";
            break;
        case NIBP_ERROR_OVERPRESSURE_PROTECTION:
            message = @"Overpressure protection";
            break;
        case NIBP_ERROR_NO_VALID_PULSE:
            message = @"No valid pulse measurement";//测量不到有效的脉搏。
            break;
        case NIBP_ERROR_EXCESSIVE_MOTION:
            message = @"Excessive interference";//说明:干预过多(测量中移动、说话等)。
            break;
        case NIBP_ERROR_RESULT_FAULT:
            message = @"Invalid result"; //测量结果数值有误。
            break;
        case NIBP_ERROR_AIR_LEAKAG:
            message = @"Air leakage";//漏气。
            break;
        case NIBP_ERROR_LOW_POWER:
            message = @"Low battery,measurement terminated.";
            break;
        default:
            break;
    }
    
    [self showAlert:message];
    
}

#pragma mark spotcheck delegate
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNIBPResult:(BOOL)bHR Pulse:(int)nPulse MAP:(int)nMap SYS:(int)nSys Dia:(int)nDia Grade:(int)nGrade BPErr:(int)nBPErr
{
    
    if (nBPErr)
    {
        [self ShowNibpError:nBPErr];
    }
    else
    {
        
        
        if ([self.delegate respondsToSelector:@selector(resultSend:)]) {
            [self.delegate resultSend:@{@"value1":@(nPulse),@"value2":@(nMap),@"value3":@(nSys),@"value4":@(nDia),@"value5":@(nGrade),@"value6":@(nBPErr)}];
        }
        
//        NSLog(@"%@",[NSString stringWithFormat:@"%d",nSys]);
//        NSLog(@"%@",[NSString stringWithFormat:@"%d",nDia]);
//        NSLog(@"%@",[NSString stringWithFormat:@"%d",nMap]);
        NSLog(@"%@",[NSString stringWithFormat:@"%d",nPulse]);
    

    }
    
}

/**
 获取pc300血压数据的变化值
 */
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNIBPRealTime:(BOOL)bHeartBeat NIBP:(int)nNIBP
{
//    NSLog(@"%@",[NSString stringWithFormat:@"%d",nNIBP]);
    
    if ([self.delegate respondsToSelector:@selector(pressureSend:)]) {
        [self.delegate pressureSend:@{@"pressure":@(nNIBP)}];
    }
    
}


-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetGlu:(int)nGlu ResultStatus:(int) nGluStatus
{
    
    NSString *tmpGlu = [[NSString alloc]init];
    float tmpGlufloat = ((float)nGlu)/10;
    tmpGlu = [NSString stringWithFormat:@"%2.1f",tmpGlufloat];
    if ([self.delegate respondsToSelector:@selector(nGuiSendnGu:)]) {
        [self.delegate nGuiSendnGu:nGlu];
    }
   
    NSLog(@"血糖测量11111值nGlu%@",[NSString stringWithFormat:@"nHR%d---%@",nGlu,tmpGlu]);
    
}
-(void) showDeviceInfo:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor
{
    
}

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetDeviceVer:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor Power:(int)nPower Battery:(int)nBattery200
{
    
}

/**
 获取pc300体温数据的变化值
 */
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetTemp:(float)temp1
{
    NSString *tmpTempString = [[NSString alloc] init];
    tmpTempString =[NSString stringWithFormat:@"%2.1f",temp1];
    
    if ([self.delegate respondsToSelector:@selector(temperatureSend:)]) {
        [self.delegate temperatureSend:@{@"temperature":@(temp1)}];
    }
 
//    tempNum.text = tmpTempString;
}

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpo2Wave:(struct dataWave *)wave
{
    
    NSString *newString = [NSString stringWithFormat:@"%d,%d",wave[0].nWave,wave[1].nWave];
//    waveNum.text = newString;
    
    NSLog(@"Pc300wave%@",[NSString stringWithFormat:@"%d,%d,%d,%d",wave[0].nWave,wave[1].nWave,wave[2].nWave,wave[3].nWave]);
    
    
    if ([self.delegate respondsToSelector:@selector(ecgSend:nHR:lead:)]) {
        [self.delegate ecgSend:[NSString stringWithFormat:@"%d,%d,%d,%d",wave[0].nWave,wave[1].nWave,wave[2].nWave,wave[3].nWave] nHR:0 lead:0];
    }
}

/**
 获取pc300心率血氧数据的变化值  PR  脉率值  血氧
 */
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpo2Param:(BOOL)bProbeOff spo2Value:(int)nSpO2 prValue:(int)nPR piValue:(int)nPI mMode:(int)nMode spo2Status:(int)nStatus
{
    NSLog(@"spo2");
    NSLog(@"%d  %d",nSpO2,nPR);
    if ([self.delegate respondsToSelector:@selector(oxygenSend:)]) {
         [self.delegate oxygenSend:@{@"value1":@(nSpO2),@"value2":@(nPR),@"value3":@(nPI),@"value4":@(nMode),@"value5":@(nStatus)}];
        
         currentPort.connectStatus = CREATIVEPERIPHERAL_CONNECT_STATUS_CONNECTED;
        
    }
    
    if ([self.delegate respondsToSelector:@selector(heartSend:)]) {
         [self.delegate heartSend:@{@"value1":@(nSpO2),@"value2":@(nPR),@"value3":@(nPI),@"value4":@(nMode),@"value5":@(nStatus)}];
    }
  

}

//CREATIVE_TRUE 为导联脱落,CREATIVE_FALSE 为导联正常
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGRealTime:(struct ecgWave)wave HR:(int)nHR lead:(BOOL)bLeadOff
{
    
    NSLog(@"CRSpotCheck:%@",[NSString stringWithFormat:@"%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",wave.wave[0].nWave,wave.wave[1].nWave,wave.wave[2].nWave,wave.wave[3].nWave,wave.wave[4].nWave,wave.wave[5].nWave,wave.wave[6].nWave,wave.wave[7].nWave,wave.wave[8].nWave,wave.wave[9].nWave,wave.wave[10].nWave,wave.wave[11].nWave,wave.wave[12].nWave,wave.wave[13].nWave,wave.wave[14].nWave,wave.wave[15].nWave,wave.wave[16].nWave,wave.wave[17].nWave,wave.wave[18].nWave,wave.wave[19].nWave,wave.wave[20].nWave,wave.wave[21].nWave,wave.wave[22].nWave,wave.wave[23].nWave,wave.wave[24].nWave]);
    
    if ([self.delegate respondsToSelector:@selector(ecgSend:nHR:lead:)]) {
        [self.delegate ecgSend:[NSString stringWithFormat:@"%d,%d,%d,%d,%d",wave.wave[0].nWave,wave.wave[1].nWave,wave.wave[2].nWave,wave.wave[3].nWave,wave.wave[4].nWave] nHR:nHR lead:bLeadOff];
    }
    
    
}
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGResult:(int)nResult HR:(int)nHR;
{
//ecgSendnHR:
    if ([self.delegate respondsToSelector:@selector(ecgSendnHR:)]) {
        [self.delegate ecgSendnHR:nHR];
    }
 
     NSLog(@"%@",[NSString stringWithFormat:@"nHR%d",nHR]);


}
/*血糖测量值*/
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetGlu:(int)nGlu ResultStatus:(int) nGluStatus andUnit:(int)gluUnit;
{
    
    if ([self.delegate respondsToSelector:@selector(nGuiSendnGu:)]) {
        [self.delegate nGuiSendnGu:nGlu];
    }
 
    NSLog(@"血糖测量值nGlu%@",[NSString stringWithFormat:@"nHR%d",nGlu]);
}


-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetGluStatus:(int)nStatus HWMajor:(int)nHWMajor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajor SWMinor:(int)nSWMinor;
{

 NSLog(@"OnGetGluStatus%@",[NSString stringWithFormat:@"nHR%d",nStatus]);
}



#pragma mark    xueyang脉搏波血氧  pod
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpo2Param:(BOOL)bProbeOff spo2Value:(int)nSpO2 prValue:(int)nPR piValue:(int)nPi mMode:(int)nMode batPower:(int)nPower spo2Status:(int)nStatus gradePower:(int)nGradePower;
{
    NSLog(@"%d --- %d ---- %d ----",nSpO2,nPi,nPR);

}

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpO2Status:(int)nStatus HWMajor:(int)nHWMajor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajor SWMinor:(int)nSWMinor;

{
    
    NSLog(@"%d.%d",nHWMajor,nHWMinor);
    NSLog(@"%d.%d",nHWMinor,nSWMinor);
}
#pragma mark   血氧断开连接
-(void)crSpo2:(CRSpo2 *)crSpo2 OnGetSpo2Param:(BOOL)bProbeOff spo2Value:(int)nSpO2 prValue:(int)nPR piValue:(int)nPi mMode:(int)nMode batPower:(int)nPower spo2Status:(int)nStatus gradePower:(int)nGradePower
{

    
    NSLog(@"OnGetSpo2Param%d,%d,%d",nSpO2,nPi,nPR);
    if ([self.delegate respondsToSelector:@selector(oxygenPodSend:)]) {
        [self.delegate oxygenPodSend:@{@"value1":@(nSpO2),@"value2":@(nPR),@"value3":@(nPi)}];
    }
    
}


-(void)crSpo2:(CRSpo2 *)crSpo2 OnGetSpo2Wave:(struct dataWave *)wave
{
    
    if ([self.delegate respondsToSelector:@selector(ecgSend:nHR:lead:)]) {
        [self.delegate ecgSend:[NSString stringWithFormat:@"%d,%d,%d,%d,%d",wave[0].nWave,wave[1].nWave,wave[2].nWave,wave[3].nWave,wave[4].nWave] nHR:0 lead:0];
    }

}


-(void)crSpo2:(CRSpo2 *)crSpo2 OnGetDeviceVer:(NSData *)nDeviceID HWMajor:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor
{
    NSLog(@"nDeviceID = %@",nDeviceID);
    NSLog(@"%d.%d",nHWMajeor,nHWMinor);
    NSLog(@"%d.%d",nSWMajeor,nSWMinor);
}

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNIBPAction:(BOOL)bStart;
{
     NSLog(@"OnGetNIBPAction%@",currentPort);
//     [self beginAutoTest];
}
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGAction:(BOOL)bStart;
{
    
    NSLog(@"OnGetECGAction%@",currentPort);
    if (bStart) {
            bIsActionEcg = TRUE;
        }
        else
        {
            bIsActionEcg = FALSE;
        }
//    [self beginAutoTest];

}


#pragma mark   自动测量
-(void)beginAutoTest
{

    if ([self.adVpersincalName containsString:@"pressure"]) {
        [[CRSpotCheck sharedInstance] SetNIBPAction:TRUE port:currentPort];//血压
    }
    if ([self.adVpersincalName containsString:@"blueRate"]) {
        [[CRSpotCheck sharedInstance] SetECGAction:TRUE port:currentPort];//脉率
    }
}

@end
