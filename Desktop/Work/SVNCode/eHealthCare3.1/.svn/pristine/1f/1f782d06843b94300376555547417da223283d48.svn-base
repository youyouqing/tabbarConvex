//
//  XKAcountHistoryHeadView.h
//  eHealthCare
//
//  Created by jamkin on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepModel.h"
/**协议申明*/
@protocol XKAcountHistoryHeadViewDelegate <NSObject>

/**
 用于展示尾部数据的协议方法
 */
-(void)showCurrentDayData:(StepModel *)model;

@end

@interface XKAcountHistoryHeadView : UIView

/**
 存放数据的数组
 */
@property (nonatomic,strong) NSArray *dataArray;

/**
 存放原始数据的数组
 */
@property (nonatomic,strong) NSArray *orgionalArray;

/**
 代理对象
 */
@property (nonatomic,weak) id<XKAcountHistoryHeadViewDelegate> delegate;

@end
