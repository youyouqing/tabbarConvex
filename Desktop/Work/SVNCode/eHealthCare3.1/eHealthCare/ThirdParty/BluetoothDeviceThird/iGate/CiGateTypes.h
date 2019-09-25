//
//  CiGateTypes.h
//  iGate
//
//  Created by Zhan on 12-11-19.
//
//

#ifndef iGate_CiGateTypes_h
#define iGate_CiGateTypes_h

/*!
 *  @enum CiGateState
 *
 *  @discussion Represents the current state of a iGate.
 *
 */
enum {
	CiGateStateInit = 0,	// State unknown, update imminent.
    CiGateStatePoweredOff,  // Bluetooth is currently powered off.
    CiGateStateUnknown,     // State unknown, update imminent.
    CiGateStateResetting,   // The connection with the system service was momentarily lost, update imminent.
	CiGateStateUnsupported,	// Something wrong, iOS device not support BTLE or not power on.
    CiGateStateUnauthorized,// The app is not authorized to use Bluetooth Low Energy.
    CiGateStateIdle,        // Bluetooth is currently powered on and available to use.
	CiGateStateSearching,	// The iGate is searching to a device.
	CiGateStateConnecting,	// the iGate is connecting to a device.
	CiGateStateConnected,	// The igate is connected with a device.
    CiGateStateBonded,	    // The igate is bondeded (and the connection is encypted) with a device.
};
typedef NSInteger CiGateState;

typedef struct {
    UInt8 type;
    UInt16 nap;
    unsigned uap:8;
    unsigned lap:24;
} CBluetoothAddr;
//typedef const struct CBluetoothAddr* CBtAddrRef;

/*!
 *  @macro IGATE_MAX_SEND_DATE_LEN
 *
 *  @discussion There's a limitation in packet size in low level BTLE data packet,
 *              so for each time
 *
 */
#define IGATE_MAX_SEND_DATE_LEN 20

/*!
 *  @enum Alert Level
 *
 *  @discussion Represents the alert level.
 *
 */
enum {
    alert_level_no = 0,	//
    alert_level_mild = 1,
    alert_level_high = 2,
    alert_level_reserved
};
typedef NSInteger ALERT_LEVEL_T;

/*!
 *  @enum Alert Level
 *
 *  @discussion Represents the alert level.
 *
 */
enum {
    UART_BAUD_RATE_2400 = 0,
    UART_BAUD_RATE_9600,
    UART_BAUD_RATE_19200,
    UART_BAUD_RATE_38400,
    UART_BAUD_RATE_57500,
    UART_BAUD_RATE_115200,
    UART_BAUD_RATE_230400,
    UART_BAUD_RATE_460800,
    UART_BAUD_RATE_921600,
    UART_BAUD_RATE_1382400,
    UART_BAUD_RATE_1843200,
    UART_BAUD_RATE_2764800,
    UART_BAUD_RATE_3686400
};
typedef NSInteger UART_BAUD_RATE_T;

/*!
 *  @enum remote control errors
 *
 *  @discussion the remote control return errors.
 *
 */
enum {
    /* external error code for users */
    RCERR_NO_ERROR=0,
    RCERR_CMD_NOT_ALLOW_FOR_STATE,
    RCERR_CMD_FORMAT_ERROR,
    RCERR_CMD_NOT_EXIST,
    RCERR_CMD_EXE_ERR,
    RCERR_SM_MODE_NONE
};
typedef NSInteger RCERR_T;

#endif
