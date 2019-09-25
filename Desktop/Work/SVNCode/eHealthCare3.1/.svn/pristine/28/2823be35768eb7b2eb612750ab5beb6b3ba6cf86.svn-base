//
//  CRSpo2.h
//  ble demo
//
//  Created by Creative on 14-7-2.
//  Copyright (c) 2014年 周骁. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BLEPort.h"
#import "CRCommon.h"
#import "CreativePeripheral.h"


@protocol  CRSpo2Delegate;

@interface CRSpo2 : NSObject

@property (assign,nonatomic) id<CRSpo2Delegate> delegate;
@property(nonatomic,assign) CreativePeripheral *peri;
+(CRSpo2 *)sharedInstance;
-(void) addData:(NSData *)data;
-(void) SetParamAction:(BOOL)bFlag port:(CreativePeripheral *)spo2Port;

-(void) SetWaveAction:(BOOL)bFlag port:(CreativePeripheral *)spo2Port;

-(void) QueryDeviceVer:(CreativePeripheral *)spo2Port;

@property (nonatomic) int nCanMakePara;
@property (nonatomic) int nCanMakeWave;
@end



@protocol CRSpo2Delegate <NSObject>
@required
-(void)crSpo2:(CRSpo2 *)crSpo2 OnGetSpo2Param:(BOOL)bProbeOff spo2Value:(int)nSpO2 prValue:(int)nPR piValue:(int)nPi mMode:(int)nMode batPower:(int)nPower spo2Status:(int)nStatus gradePower:(int)nGradePower;

-(void)crSpo2:(CRSpo2 *)crSpo2 OnGetSpo2Wave:(struct dataWave *)wave;

@optional
-(void)crSpo2:(CRSpo2 *)crSpo2 OnGetDeviceVer:(NSData *)nDeviceID HWMajor:(int)nHWMajeor HWMinor:(int)nHWMinor SWMajor:(int)nSWMajeor SWMinor:(int)nSWMinor;


@end
