//
//  CreativePeripheral.h
//  creative-sdk
//
//  Created by Creative on 14-9-5.
//  Copyright (c) 2014年 creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

enum {
    CREATIVEPERIPHERAL_CONNECT_STATUS_IDLE = 0,
    CREATIVEPERIPHERAL_CONNECT_STATUS_CONNECTING,
    CREATIVEPERIPHERAL_CONNECT_STATUS_CONNECTED,
};


@interface CreativePeripheral : NSObject

@property (atomic) NSMutableData *writeBuffer;
@property (nonatomic) CBPeripheral *peripheral;
@property(nonatomic) NSString *advName;
@property(nonatomic) uint8_t connectStatus;
@property (nonatomic) NSNumber *myRSSI;
@property (nonatomic) NSUUID *myUUID;

-(void)startWriteData;
@end
