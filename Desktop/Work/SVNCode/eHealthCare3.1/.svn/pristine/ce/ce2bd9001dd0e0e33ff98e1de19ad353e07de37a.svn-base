//
//  CiGateDelegate.h
//  iGate
//
//  Created by zhan on 12-6-18.
//  Copyright (c) 2012年 Novacomm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CiGateTypes.h"

@class CiGate;

/*!
 *  @protocol CiGateDelegate
 *
 *  @discussion Delegate protocol for CBiGate.
 *
 */
@protocol CiGateDelegate <NSObject>

@required

- (void)iGateDidUpdateState:(CiGateState)iGateState;
- (void)iGateDidReceivedData:(NSData *)data;

@optional

/*!
 *  @method iGateDidFoundDevice:name:RSSI:
 *
 *  @discussion Invoked upon when a device is found.
 *      For the first time a device is found, the devUUID might be NULL, the device will be assigned an UUID
 *      after it is connected. Next time it is found by the same host (iPhone/iPad), the same devUUID 
 *      (assigned when firstly connected) is reported. 
 *      The devName can be used to connect to a device when it is found by the host at the first time (because
 *      the devUUID is NULL for the first time as explained). Please also see connectDevice:deviceName: in iGate.h
 *      RSSI is the RF signal level when the device get found.
 *
 */

- (void)iGateDidFoundDevice:(CFUUIDRef)devUUID name:(NSString *)devName RSSI:(NSNumber *)RSSI;

/*!
 *  @method iGateDidUpdateConnectDevRSSI:error:
 *
 *  @discussion Invoked upon completion of a -[getConnectDevRSSI:] request.
 *      If successful, "error" is nil and the "rssi" indicates the new RSSI value.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
- (void)iGateDidUpdateConnectDevRSSI:(NSNumber *)rssi error:(NSError *)error;

/*!
 *  @method iGateDidUpdateConnectDevAddr
 *
 *  @discussion Invoked when the Bluetooth address of the connect device is got.
 *
 */
- (void)iGateDidUpdateConnectDevAddr:(CBluetoothAddr *)addr;

/*!
 *  @method iGateDidUpdateConnectDevAIO:level
 *
 *  @discussion Invoked when the AIO level of the connected device is read.
 *
 */
- (void)iGateDidUpdateConnectDevAIO:(integer_t)aioSelector level:(integer_t)aioLevel;

/*!
 *  @method iGateDidRetrieveConnectDevIBeaconMajor
 *
 *  @discussion Invoked when the iBeacon major number of the connected device is read.
 *
 */
- (void)iGateDidRetrieveConnectDevIBeaconMajor:(UInt16)majorNumber;

/*!
 *  @method iGateDidRetrieveConnectDevIBeaconMinor
 *
 *  @discussion Invoked when the iBeacon minor number of the connected device is read.
 *
 */
- (void)iGateDidRetrieveConnectDevIBeaconMinor:(UInt16)minorNumber;

/*!
 *  @method iGateDidRetrieveConnectIBeaconPower
 *  @param power	The power level in dBm.
 *  @discussion Invoked when the iBeacon RF power measured at one meter distance of the connected device is read.
 *
 */
- (void)iGateDidRetrieveConnectDevIBeaconPower:(int16_t)power;

/*!
 *  @method iGateDidRetrieveConnectIBeaconInterval
 *  @param power	The inberval in milliseconds.
 *  @discussion Invoked when the iBeacon advertisement interval is read.
 *
 */
- (void)iGateDidRetrieveConnectDevIBeaconInterval:(int16_t)interval;


/*!
 *  @method iGateDidFinishControlCommand
 *
 *  @discussion Invoked when the a iGate remote control command feedback is received.
 *
 */
- (void)iGateDidFinishControlCommand:(RCERR_T)error;

/*!
 *  @method iGateDidRetrieveBatteryLevel
 *  @param power	The inberval in milliseconds.
 *  @discussion Invoked when the iBeacon advertisement interval is read.
 *
 */
- (void)iGateDidRetrieveBatteryLevel:(UInt8)levelInPercentage;

/*!
 *  @method iGateDidRetrieveLinklossAlertLevel
 *  @param level	enum value ALERT_LEVEL_T.
 *  @discussion Invoked when the link loss alert level is read.
 *
 */
- (void)iGateDidRetrieveLinklossAlertLevel:(ALERT_LEVEL_T)level;

/*!
 *  @method iGateDidRetrieveTxPower
 *  @param power value in dBm
 *  @discussion Invoked when the Tx power is read.
 *
 */
- (void)iGateDidRetrieveTxPower:(int)power;

/*!
 *  @method iGateDidRetrieveBaudRate
 *  @param baudRate enum value
 *  @discussion Invoked when the baud rate of the connected device is read.
 *
 */
- (void)iGateDidRetrieveBaudRate:(UART_BAUD_RATE_T)baudRate;

@end

