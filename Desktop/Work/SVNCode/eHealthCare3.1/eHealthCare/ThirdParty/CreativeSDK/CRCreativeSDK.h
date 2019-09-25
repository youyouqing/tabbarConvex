//
//  CRCreativeSDK.h
//  creative-sdk
//
//  Created by Creative on 14-9-4.
//  Copyright (c) 2014年 creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CreativePeripheral.h"

enum {
    LE_STATUS_IDLE = 0,
    LE_STATUS_SCANNING,
    LE_STATUS_CONNECTING,
    LE_STATUS_CONNECTED
};
typedef enum _result_code{
    RESULT_SUCCESS                      = 0,
    RESULT_ERROR_BASE                   = 1,
    RESULT_ERROR_PORT_INVALID           = RESULT_ERROR_BASE + 1,
    RESULT_ERROR_STATE_WRONG            = RESULT_ERROR_BASE + 2,
    RESULT_ERROR_NULL_ADDRESS           = RESULT_ERROR_BASE + 3,
    RESULT_ERROR_DISCOVER_TIMEOUT       = RESULT_ERROR_BASE + 4,
    RESULT_CODE_TYPE_END
}resultCodeType;

typedef enum _central_state{
    CENTRAL_STATE_UNKNOWN,
    CENTRAL_STATE_RESETTING,
    CENTRAL_STATE_UNSUPPORTED,
    CENTRAL_STATE_UNAUTHORIZED,
    CENTRAL_STATE_POWEREDOFF,
    CENTRAL_STATE_POWEREDON,
    CENTRAL_STATE_END
}centralStateType;

@protocol CreativeDelegate;


@interface CRCreativeSDK : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>


@property(nonatomic) id<CreativeDelegate> delegate;

@property (nonatomic) centralStateType isState;
+(CRCreativeSDK *)sharedInstance;
-(void)closePort:(CreativePeripheral *) port;


-(NSMutableArray *)GetDeviceList;

-(void)stopScanAndSearchComplete;
-(void)scanDevice;
- (void) startScan:(float)timeout;
- (void) stopScan;
- (void)connectDevice:(CreativePeripheral *) myPeripheral;
- (void)disconnectDevice:(CreativePeripheral *) aPeripheral;

@end

@protocol CreativeDelegate <NSObject>
@optional
-(void)bleSerilaComManagerDidStateChange:(CRCreativeSDK *)crManager;
-(void)OnSearchCompleted:(CRCreativeSDK *)crManager;
//-(void)didDataReceivedOnPort:(CRCreativeSDK *)crManager andData:(NSData *)data;
-(void)crManager:(CRCreativeSDK *)crManager OnFindDevice:(CreativePeripheral *)port;
-(void)crManager:(CRCreativeSDK *)crManager OnConnected:(CreativePeripheral *)peripheral withResult:(resultCodeType)result CurrentCharacteristic:(CBCharacteristic *)theCurrentCharacteristic;
-(void)didDataReceivedOnPeripheral:(CRCreativeSDK *)crManager ;
-(void)crManager:(CRCreativeSDK *)crManager OnConnectFail:(CBPeripheral *)port;
-(void)crManager:(CRCreativeSDK *)crManager didReceiveBody:(float)nWeight andStatus:(Byte)nStatus;
-(void)OnConnectDeviceFailed:(CRCreativeSDK *)crManager;

@end
