//
//  iGate.h
//  iGate
//
//  Created by Zhan on 12-6-18.
//  Copyright (c) 2012年 Novacomm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CiGateDelegate.h"


@interface CiGate : NSObject<CiGateDelegate>

/*!
 *  @property delegate
 *
 *  @discussion The delegate object you want to receive iGate events.
 *
 */
@property(assign, nonatomic) id<CiGateDelegate> delegate;

/*!
 *  @property state
 *
 *  @discussion The current state of the iGate.
 *      Initially set to CiGateInit.
 *		It can be updated at any moment, upon which the relevant delegate callback will be invoked.
 *      Handle the state changes in iGateDidUpdateState.
 *
 */
@property(readonly) CiGateState state;

/*!
 *  @method initWithDelegate:queue:
 *
 *  @param delegate	The delegate to receive the iGate events such as state changes, received data indications.
 *  @param aFlag set TRUE to automatically connect to the founded device, currently please
                 always set it TRUE.
 *  @discussion The initialization call of iGate.
 *
 */
- (CiGate *)initWithDelegate:(id<CiGateDelegate>)aDelegate autoConnectFlag:(BOOL)aFlag serviceUuidStr:(NSString*)uuidStr;

/*!
 *  @method initWithDelegate:queue:
 *
 *  @param delegate	The delegate to receive the iGate events such as state changes, received data indications.
 *  @param aFlag set TRUE to automatically connect to the founded device, currently please
 always set it TRUE.
 *  @param bondDevUUID The bonded device UUID. When iGate is bonded to a device,
 *         it only connects to the bonded device when several BTLE devices is nearby.
 *  @discussion The initialization call of iGate.
 *
 */
- (CiGate *)initWithDelegate:(id<CiGateDelegate>)aDelegate autoConnectFlag:(BOOL)aFlag BondDevUUID:(CFUUIDRef)bondDevUUID serviceUuidStr:(NSString*)uuidStr;

/*!
 *  @method startSearch:
 *
 *  @discussion Start search for device. If no bond UUID is set before startSearch,
 *              iGate will try to connect/bond to a new device.
 *
 */
- (void)startSearch;

/*!
 *  @method stopSearch:
 *
 *  @discussion Stop search for device.
 *
 */
- (void)stopSearch;

/*!
 *  @method connectDevice:deviceName:
 *
 *  @discussion Connect to a device by device UUID or device name.
 *              if devUUID is NULL, or the specified UUID doesn't match with any found devices,
 *              the deviceName will be used to search within the found devices, the first device
 *              whose name is matched will be connected. So if many devices around are with the
 *              the same name, it will connect to the one found firstly.
 *
 */
- (void)connectDevice:(CFUUIDRef)devUUID deviceName:(NSString *)name;

/*!
 *  @method disconnectDevice:
 *
 *  @discussion While connected, use this method to disconnect the device.
 *  @see iGateDidUpdateState: , the iGateState will be idle after disconnect.
 *       And if iGate is inited with autoConnectFlag set to TRUE,
 *       a new search will be started.
 *       devUUID: the UUID of the connected device, it can be explictly set by the app,
 *       or NULL to let the lib choose the connected device.
 */
- (BOOL) disconnectDevice:(CFUUIDRef)devUUID;

/*!
 *  @method getConnectDevName:
 *
 *  @discussion get the connected device name.
 *               
 *
 */
- (NSString *) getConnectDevName;

/*!
 *  @method setConnectDevName:
 *
 *  @discussion set the connected device name. The connected device's name is only writable
 *              after it is bonded
 *
 */

- (void) setConnectDevName:(NSString *)name;

/*!
 *  @method getConnectDevRSSI:
 *
 *  @discussion While connected, fetch the current RSSI of the link/connected device.
 *  @see iGateDidUpdateConnectDevRSSI:error: of CiGateDelegate protocol
 *
 */
- (void) getConnectDevRSSI;

/*!
 *  @method getConnectDevUUID:
 *
 *  @discussion get the connected device UUID. If the current iGate state is bonded,
 *              the connected device UUID is also the bonded UUID. The user of iGate
 *              may save the UUID and reload it by setBondDevUUID so the app only
 *              connect to known devices.
 */
- (CFUUIDRef) getConnectDevUUID;

/*!
 *  @method getConnectDevAddr:
 *
 *  @discussion get the connected device's Bluetooth Address.
 *  See iGateDidUpdateConnectDevAddr:(CBluetoothAddr *)addr; of CiGateDelegate protocol
 */
- (void) readConnectDevAddr;

/*!
 *  @method readConnectDevAioLevel:
 *
 *  @discussion get the connected device's AIO level.
 *  aioSelector: 0~2
 */
- (void) readConnectDevAioLevel:(integer_t)aioSelector;

/*!
 *  @method setBondDevUUID:
 *
 *  @param bondDevUUID	The bonded device UUID. When iGate is bonded to a device,
 *         it only connects to the bonded device when several BTLE devices is nearby.
 *  @discussion set the Bonded device UUID before start search so only known device
 *              can be connected.
 *              The iGate will copy UUID in setBondDevUUID, so the user can release
 *              the passed in CFUUIDRef after it returns.
 *
 */
- (BOOL) setBondDevUUID:(CFUUIDRef)bondDevUUID;

/*!
 *  @method send data to the connected device:
 *
 *  @discussion Limit the data length <=20.
 *
 */
- (void)sendData:(NSData *)data;

/*!
 *  @method send ctr to the connected device:
 *
 *  @discussion Limit the data length <=20.
 *
 */
- (void)sendRawCtrData:(NSData *)data;

/*!
 *  @method retrieveIBeaconMajorNumber:
 *
 *  @discussion retrieve the connected device's iBeacon Major Number.
 */

- (void) retrieveIBeaconMajorNumber;

/*!
 *  @method setupIBeaconMajor:
 *
 *  @param majorNumber	The new value of iBeacon Major Number.
 *  @discussion set a new value for the connected device's iBeacon Major Number.
 *
 */

- (void) setupIBeaconMajorNumber:(UInt16)majorNumber;

/*!
 *  @method retrieveIBeaconMinorNumber:
 *
 *  @discussion retrieve the connected device's iBeacon Major Number.
 */

- (void) retrieveIBeaconMinorNumber;

/*!
 *  @method setupIBeaconMinorNumber:
 *
 *  @param minorNumber	The new value of iBeacon Minor Number.
 *  @discussion set a new value for the connected device's iBeacon Minor Number.
 *
 */

- (void) setupIBeaconMinorNumber:(UInt16)minorNumber;

/*!
 *  @method retrieveIBeaconPowerlevelAtOneMeter:
 *
 *  @discussion retrieve the connected device's iBeacon power level at one meter distance.
 */

- (void) retrieveIBeaconPowerlevelAtOneMeter;

/*!
 *  @method setupIBeaconPowerlevelAtOneMeter:
 *
 *  @param powerLevel	The new value of iBeacon power level at one meter distance.
 *  @discussion set a new value for the connected device's iBeacon power level at one meter distance.
 *
 */
- (void) setupIBeaconPowerlevelAtOneMeter:(UInt16)powerLevel;


/*!
 *  @method setupIBeaconUUID128:
 *
 *  @param uuid128	The new proximityUUID value of iBeacon in a NSString format.
 *  @discussion set a new proximityUUID for the connected device.
 *
 */
- (void) setupIBeaconUUID128:(NSString *)uuid128;

/*!
 *  @method retrieveIBeaconAdvertiseInterval:
 *
 *  @discussion retrieve the connected device's iBeacon power level at one meter distance.
 */

- (void) retrieveIBeaconAdvertiseInterval;

/*!
 *  @method setupIBeaconAdvertiseInterval:
 *
 *  @param advInterval	The new value of iBeacon power level at one meter distance.
 *  @discussion set a new value for the connected device's iBeacon power level at one meter distance.
 *
 */

- (void) setupIBeaconAdvertiseInterval:(UInt16)advInterval;

/*!
 *  @method retrieveBatteryLevel:
 *
 *
 *  @discussion read the battery level in percentage, the value will be reported by
 *  iGateDidRetrieveBatteryLevel:
 *  See iGateDidRetrieveBatteryLevel:(UInt8)levelInPercentage of CiGateDelegate protocol.
 */
- (void) retrieveBatteryLevel;

/*!
 *  @method retrieveTxPower:
 *  @discussion read the connected device's transmission power, the value will be reported by
 *  iGateDidRetrieveTxPower:
 *  See iGateDidRetrieveTxPower:(int)power of CiGateDelegate protocol.
 */
- (void) retrieveTxPower;

/*!
 *  @method retrieveLinkLossAlertLevel:
 *  @discussion read the connected device's link loss alert level, the value will be reported by
 *  iGateDidRetrieveLinklossAlertLevel:
 *  See iGateDidRetrieveLinklossAlertLevel:(ALERT_LEVEL_T)level of CiGateDelegate protocol.
 */
- (void) retrieveLinkLossAlertLevel;

/*!
 *  @method setupLinkLossAlertLevel:
 *  @discussion configure the connected device's link loss alert level.
 */
- (void) setupLinkLossAlertLevel:(ALERT_LEVEL_T)alertLevel;

/*!
 *  @method setupImmAlertLevel:
 *  @discussion configure the connected device's link loss alert level.
 */
- (void) setupImmAlertLevel:(ALERT_LEVEL_T)alertLevel;

/*!
 *  @method retrieveBaudRate:
 *  @discussion read the connected device's uart baud rate, the value will be reported by
 *  iGateDidRetrieveBaudRate:
 *  See iGateDidRetrieveBaudRate:(UART_BAUD_RATE_T)baudRate of CiGateDelegate protocol.
 */
- (void) retrieveBaudRate;

/*!
 *  @method setupBaudRate:
 *  @discussion configure the connected device's uart baud rate.
 */
- (void) setupBaudRate:(UART_BAUD_RATE_T)baudRate;


@end

