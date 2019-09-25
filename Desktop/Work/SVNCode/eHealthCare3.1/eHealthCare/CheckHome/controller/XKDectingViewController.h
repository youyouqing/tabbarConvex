//
//  XKDectingViewController.h
//  eHealthCare
//
//  Created by xiekang on 2017/11/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHouseHoldModel.h"
#import "XKPhySicalItemModel.h"

typedef void (^DectDataReload)(BOOL Reload);
@interface XKDectingViewController : BaseViewController
@property(assign,nonatomic)XKDetectStyle style;
@property(strong,nonatomic)XKHouseHoldModel *model;
/**
 蓝牙工具
 */
@property (nonatomic,strong) BluetoothConnectionTool *bc;


@property (nonatomic, copy) DectDataReload  isReload;
@end
