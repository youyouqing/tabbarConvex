//
//  XKHealthIntegralSginModel.h
//  eHealthCare
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本每日签到商品数据模型

#import <Foundation/Foundation.h>

@interface XKHealthIntegralSginModel : NSObject

/**SellID
 Int32
 商家编号
 */
@property (nonatomic,assign) NSInteger SellID;

/**ProductID
 Int32
 商品编号
 */
@property (nonatomic,assign) NSInteger ProductID;

/**ProductName
 String
 商品名称
 */
@property (nonatomic,copy) NSString *ProductName;

/**ImgUrl
 String
 商品图片
 */
@property (nonatomic,copy) NSString *ImgUrl;

/**Integral
 Int32
 明日可得康币
 */
@property (nonatomic,assign) NSInteger Integral;

@end
