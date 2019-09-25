//
//  XKDeviceMod.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKDeviceMod : NSObject
@property (nonatomic,assign) int ProductID;

@property (nonatomic,copy) NSString *ProductName;

/**
 梭罗图
 */
@property (nonatomic,copy) NSString *ImgUrl;

@property (nonatomic,copy) NSString *HpptUrl;

@property (nonatomic,copy) NSString *PhysicalItemID;


@property (nonatomic,assign) int DeviceID;


@property (nonatomic,copy) NSString *BluetoothName;
@end
