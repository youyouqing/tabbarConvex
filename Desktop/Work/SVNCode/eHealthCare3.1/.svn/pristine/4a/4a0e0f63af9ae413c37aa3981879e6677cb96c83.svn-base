//
//  XKBloodFatChooseView.h
//  eHealthCare
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本血脂四项选择视图  创建者：张波

#import <UIKit/UIKit.h>
#import "XKPhySicalItemModel.h"

@protocol XKBloodFatChooseViewDelegate
@optional
//选中某一行
-(void)didSelectOnce:(XKPhySicalItemModel *)model;

@end

@interface XKBloodFatChooseView : UIView

@property (nonatomic,strong) NSArray *dataArray;

-(void)openAllView;
-(void)closeAllView;

/**代理对象*/
@property (nonatomic,weak) id<XKBloodFatChooseViewDelegate> delegate;

@end
