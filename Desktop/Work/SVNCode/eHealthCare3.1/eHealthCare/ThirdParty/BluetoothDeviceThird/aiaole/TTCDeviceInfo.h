//
//  TTCDeviceInfo.h
//  TTCDeviceInfo
//
//  Created by TTC on 15/7/17.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface TTCDeviceInfo : NSObject

@property (nonatomic,strong) CBPeripheral* cb;


@property (nonatomic,strong) NSString * macAddrss;// Mac address broadcasted by Bluetooth peripherals

@property (nonatomic,copy) NSString * UUIDString;//UUID of Bluetooth peripherals

@property (nonatomic,copy) NSString * localName;//Manufacturer identifier of the Bluetooth peripherals

@property (nonatomic,copy) NSString * name; //The name of the Bluetooth peripherals

@property (nonatomic,assign) NSInteger RSSI;

@property (nonatomic, strong) NSDictionary * advertisementDic;

@end
