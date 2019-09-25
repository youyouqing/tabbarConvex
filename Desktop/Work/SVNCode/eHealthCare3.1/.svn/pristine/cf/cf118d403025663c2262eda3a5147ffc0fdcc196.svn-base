//
//  XKBindTopTitleView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKDeviceDetailMod.h"
#import "XKDeviceProductMod.h"
@protocol XKBindTopTitleViewDelegate <NSObject>



/**
 去购买
 */
-(void)bindTopTitleBuyTools;

@end

@interface XKBindTopTitleView : UIView
/**
 协议啊代理
 */
@property(weak,nonatomic)id<XKBindTopTitleViewDelegate>delegate;

/**
 模型数据
 */
@property(strong,nonatomic)XKDeviceProductMod *deviceDetailMod;


@end
