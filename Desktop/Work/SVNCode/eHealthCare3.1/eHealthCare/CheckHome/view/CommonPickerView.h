//
//  BirthDayPickerView.h
//  UIDatePickerDemo
//
//  Created by xiekang on 16/7/27.
//  Copyright © 2016年 xiekang. All rights reserved.
//携康3.0身高下部弹窗选择框

#import <UIKit/UIKit.h>
@class CommonPickerView;
@protocol CommonPickerViewDelegate <NSObject>
@optional
-(void)CommonPickerViewChange:(NSString *)dateStr andBtnTitle:(NSString *)title;
-(void)CommonPickerViewChange:(NSString *)dateStr withInstanc:(CommonPickerView *) picker;

@end

@interface CommonPickerView : UIView

@property (nonatomic,assign)id <CommonPickerViewDelegate> delegate;

@property (nonatomic,assign)BOOL isShowButtonView;
-(void)closePicker;
-(void)openPicker;
-(instancetype)initWithFrame:(CGRect)frame scope:(NSString *)scope unit:(NSArray *)unit;
@end
