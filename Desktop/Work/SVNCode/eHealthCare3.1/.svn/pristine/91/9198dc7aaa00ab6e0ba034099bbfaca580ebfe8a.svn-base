//
//  BirthDayPickerView.h
//  UIDatePickerDemo
//
//  Created by xiekang on 16/7/27.
//  Copyright © 2016年 xiekang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XkInputFieldTwo.h"

@class BirthDayPickerView;

@protocol BirthDayPickerViewDelegate <NSObject>

@optional

-(void)birthDayPickerChange:(NSString *)dateStr andBtnTitle:(NSString *)title;
-(void)birthDayPickerChange:(NSString *)dateStr withInstanc:(BirthDayPickerView *) picker;

@end

@interface BirthDayPickerView : UIView

@property (nonatomic, weak)id <BirthDayPickerViewDelegate> delegate;

@property (nonatomic,assign)BOOL isShowButtonView;

@property (nonatomic,strong) XkInputFieldTwo *field;

-(void)closePicker;
-(void)openPicker;

@end
