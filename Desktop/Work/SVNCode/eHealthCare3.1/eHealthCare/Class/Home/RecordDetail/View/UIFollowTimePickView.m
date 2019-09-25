//
//  UIFollowTimePickView.m
//  DoctorVersion
//
//  Created by xiekang on 16/12/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIFollowTimePickView.h"
#define BORDERSPACE 8
#define DIVIDEPARTS 5
@interface UIFollowTimePickView()
@property(nonatomic,strong) NSString *timeDateStr;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIView *buttonView;

@end
@implementation UIFollowTimePickView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        //        timeDateStr = [NSDate date];
        self.backgroundColor = [UIColor whiteColor];
        self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, frame.size.width+2, frame.size.height/DIVIDEPARTS - 0.5)];
        self.buttonView.layer.borderColor = [UIColor colorWithWhite:0.90 alpha:1.0].CGColor;
        self.buttonView.layer.borderWidth = 0.5;
        self.buttonView.backgroundColor = [UIColor colorWithRed:230/255.0 green:252/255.0 blue:255/255.0 alpha:1.0];
        [self addSubview:self.buttonView];
        
        //取消按钮
        UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelbutton.frame = CGRectMake(0, 0, KScreenWidth/2 - BORDERSPACE*2, self.buttonView.frame.size.height);
        cancelbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        //        cancelbutton.backgroundColor = [UIColor kMainColor];
        cancelbutton.titleEdgeInsets = UIEdgeInsetsMake(0,BORDERSPACE, 0, 0);
        [cancelbutton setTitleColor:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0]  forState:UIControlStateNormal];
        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbutton addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:cancelbutton];
        
        //确定按钮
        UIButton *surebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        surebutton.frame = CGRectMake(frame.size.width - (KScreenWidth/2 - BORDERSPACE*2), 0, KScreenWidth/2 - BORDERSPACE*2, self.buttonView.frame.size.height);
        surebutton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        //        surebutton.backgroundColor = [UIColor blackColor];
        surebutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [surebutton setTitleColor:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0]  forState:UIControlStateNormal];
        [surebutton setTitle:@"确定" forState:UIControlStateNormal];
        [surebutton addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:surebutton];
        
        //时间
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buttonView.frame), frame.size.width,frame.size.height/DIVIDEPARTS * (DIVIDEPARTS-1))];
        [self.datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        [self.datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"zh_CN"]];
        [self.datePicker setValue:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0] forKey:@"textColor"];
        
        //定义最大日期为当前日期
//        [self.datePicker setMaximumDate:[NSDate date]];
        //定义最小日期
        NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
        [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
        NSDate *minDate = [NSDate date];
        
        [self.datePicker setMaximumDate:minDate];
        
//        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"newLastDate"]) {//有上次随访记录的情况下
//            [self.datePicker setMinimumDate:[[NSUserDefaults standardUserDefaults]objectForKey:@"newLastDate"]];//设置有效最小日期为上次随访日期
//        }else{//无随访记录的情况下
//            [self.datePicker setMinimumDate:[NSDate date]];//设置有效最小日期，但是其他还是会显示
//        }
        
//        NSDate *defaultDate = [formatter_minDate dateFromString:@"1990-01-01"];
        
        [self.datePicker setDate:[NSDate date] animated:YES];//设置当前显示的时间
        self.datePicker.datePickerMode = UIDatePickerModeDate;//类型
        [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.datePicker];
        
    }
    return self;
}

-(void)dateChange:(UIDatePicker *)datepicker
{
    NSDate *date = [datepicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    self.timeDateStr = [dateFormatter stringFromDate:date];
    
//    if (_isShowButtonView) {
//        //因此确定按钮等
//        if ([self.delegate respondsToSelector:@selector(birthDayPickerChange:withInstanc:)]) {
//            
//            [self.delegate birthDayPickerChange:self.timeDateStr withInstanc:self];
//            
//        }
//    }
}

-(void)clickControlBtn:(UIButton *)button
{
    [self hiddenTimeView];
//    NSLog(@"%@",button.titleLabel.text);
    if ([self.delegate respondsToSelector:@selector(birthDayPickerChange:andBtnTitle:)]) {
    
        NSDate *date = [self.datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyy-MM-dd"];
        self.timeDateStr = [dateFormatter stringFromDate:date];
//        NSLog(@"%@",self.timeDateStr);
        [self.delegate birthDayPickerChange:self.timeDateStr andBtnTitle:button.titleLabel.text];
    }
}

-(void)hiddenTimeView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = frame;
    }];
}
@end
