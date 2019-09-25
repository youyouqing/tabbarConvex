//
//  AdvertisingScrolllView.h
//  eHealthCare
//
//  Created by John shi on 2018/7/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisingScrolllView : UIView


/**
 加载滚动视图

 @param size 略
 @param imageArray 数据源
 @return 略
 */
- (instancetype)initWithSize:(CGSize)size iamgeArray:(NSArray *)imageArray;

@end
