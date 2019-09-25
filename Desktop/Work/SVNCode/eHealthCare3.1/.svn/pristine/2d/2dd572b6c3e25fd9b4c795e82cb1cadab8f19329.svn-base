//
//  CRSpotCheck.h
//  health
//
//  Created by Creative on 14-8-21.
//  Copyright (c) 2014年 creative. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BLEPort.h"
#import "CRCommon.h"
#import "CreativePeripheral.h"


#define MODE_OVER 0
#define MODE_ING 1
#define MODE_NULL 255
#define NIBP_ERROR_NO_ERROR 0
#define NIBP_ERROR_CUFF_NOT_WRAPPED 1
#define NIBP_ERROR_OVERPRESSURE_PROTECTION 2
#define NIBP_ERROR_NO_VALID_PULSE 3
#define NIBP_ERROR_EXCESSIVE_MOTION 4
#define NIBP_ERROR_RESULT_FAULT 5
#define NIBP_ERROR_AIR_LEAKAG 6
#define NIBP_ERROR_LOW_POWER 7




@protocol  SpotCheckDelegate;
@interface CRSpotCheck : NSObject
@property(nonatomic,assign) CreativePeripheral *peri;
@property (assign,nonatomic) id<SpotCheckDelegate> delegate;
+(CRSpotCheck *)sharedInstance;
-(void) addData:(NSData *)data;
-(void) SetNIBPAction:(BOOL)bFlag port:(CreativePeripheral *)currentPort;
-(void) SetECGAction:(BOOL)bFlag port:(CreativePeripheral *)currentPort;
- (void)setECGDataBiteCountTwelve:(BOOL)beTwelve ForPort:(CreativePeripheral *)currentPort;
-(void) QueryDeviceVer:(CreativePeripheral *)currentPort;
-(void) QueryEcgVer:(CreativePeripheral *)currentPort;

-(void) QueryNIBPStatus:(CreativePeripheral *)currentPort;
-(void) QuerySpO2Status:(CreativePeripheral *)currentPort;
-(void) QueryGluStatus:(CreativePeripheral *)currentPort;
-(void) QueryTmpStatus:(CreativePeripheral *)currentPort;

//@property (nonatomic) CreativePeripheral *SpotCheckPort;
-(void)setTimePC300:(CreativePeripheral *)currentPort Time:(NSString *)time;

//add for upgrade
-(void) queryDeviceForUpdate:(CreativePeripheral *)port;
-(void) restartDeviceForUpdate:(CreativePeripheral *)port;
-(void) restartDeviceForUpdateBegin:(CreativePeripheral *)peri;
//-(void)sendProgram;
-(void) upgradeDeviceEnd:(CreativePeripheral *)currentPort;
@end


@protocol SpotCheckDelegate <NSObject>
@required




@optional
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetDeviceID:(NSData *)sDeviceID;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetDeviceVer:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor Power:(int)nPower;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGVer:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor;


-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpo2Wave:(struct dataWave *)wave;



-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGRealTime:(struct ecgWave)wave HR:(int)nHR lead:(BOOL)bLeadOff  ;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGRealTime:(struct ecgWave)wave HR:(int)nHR lead:(BOOL)bLeadOff BeTwelve:(BOOL)beTwelve;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGResult:(int)nResult HR:(int)nHR;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetTmp:(BOOL)bManualStart ProbeOff:(BOOL)ProbeOff Temp:(int)Tmp TempStatus:(int)TmpStatus ResultStatus:(int)nResultStatus;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetGlu:(int)nGlu ResultStatus:(int) nGluStatus andUnit:(int)gluUnit;
//type:  0.百捷，1.艾欧乐，2.怡成
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetGlu:(int)nGlu ResultStatus:(int) nGluStatus andUnit:(int)gluUnit Type:(int)type;


-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetUA:(int)nUA;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetCholesterol:(int)nCholesterol;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNibpStatus:(int)nStatus HWMajor:(int)nHWMajor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajor SWMinor:(int)nSWMinor;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpO2Status:(int)nStatus HWMajor:(int)nHWMajor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajor SWMinor:(int)nSWMinor;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetGluStatus:(int)nStatus HWMajor:(int)nHWMajor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajor SWMinor:(int)nSWMinor;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetTmpStatus:(int)nStatus HWMajor:(int)nHWMajor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajor SWMinor:(int)nSWMinor;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetEcgGain:(int)gain;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNIBPAction:(BOOL)bStart;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetECGAction:(BOOL)bStart;
- (void)spotCheck:(CRSpotCheck *)spotCheck TwelveBitCountSetDone:(BOOL)beTwelve;
-(void)OnGetPowerOff:(CRSpotCheck *)spotCheck;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetSpo2Param:(BOOL)bProbeOff spo2Value:(int)nSpO2 prValue:(int)nPR piValue:(int)nPI mMode:(int)nMode spo2Status:(int)nStatus;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetTemp:(float)tempValue;

//-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNibpError:(int)nError;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNIBPResult:(BOOL)bHR Pulse:(int)nPulse MAP:(int)nMap SYS:(int)nSys Dia:(int)nDia Grade:(int)nGrade BPErr:(int)nBPErr;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetNIBPRealTime:(BOOL)bHeartBeat NIBP:(int)nNIBP;

-(void)timeSynchroniztion:(CRSpotCheck *)spotCheck;

//add for upgrade
-(void)deviceDidRestart:(CRSpotCheck *)spotCheck;
-(void)deviceDidRestartNext:(CRSpotCheck *)spotCheck;
-(void)deviceBeginSendData:(CRSpotCheck *)spotCheck;
-(void)deviceUpgradeEnd:(CRSpotCheck *)spotCheck;
-(void)dataPercentage:(double)nP;
-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetUpgradeHardware:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetCheckStatus:(int)nPage andFlags:(int)nFlag;

-(void)spotCheck:(CRSpotCheck *)spotCheck OnGetH600Version:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor andStatus:(BOOL)bStatus andConnect:(BOOL)bConnect;

@end

