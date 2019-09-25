//
//  BirthDayPickerView.m
//  UIDatePickerDemo
//
//  Created by xiekang on 16/7/27.
//  Copyright © 2016年 xiekang. All rights reserved.
//

#import "CommonPickerView.h"
#define BORDERSPACE 8
#define DIVIDEPARTS 5
@interface CommonPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) NSString *timeDateStr;
@property (nonatomic,strong)UIPickerView *datePicker;
//@property(nonatomic,strong) NSString *sureDateStr;
@property (nonatomic,strong)UIView *buttonView;
@property (nonatomic,strong)NSArray *scope;
@property (nonatomic,strong)NSArray *unit;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,assign)NSInteger com;

@end
@implementation CommonPickerView

-(void)setIsShowButtonView:(BOOL)isShowButtonView{
    
    _isShowButtonView=isShowButtonView;
    
    self.buttonView.hidden=YES;
    
    
    self.datePicker.frame=self.bounds;
    
}

/**
 初始化数据

 @param frame <#frame description#>
 @param scope <#scope description#>
 @param unit <#unit description#>
 @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame scope:(NSString *)scope unit:(NSArray *)unit
{
    if (self = [super initWithFrame: frame]) {
        
        NSArray *arr = [scope componentsSeparatedByString:@"-"];
        int mix = [[arr firstObject] intValue];
        int max = [[arr lastObject] intValue];
        
        NSMutableArray *scope = [NSMutableArray array];
        
        for (int i=mix; i<=max; i++) {
            [scope addObject:[NSString stringWithFormat:@"%d",i]];
        }
        self.scope = scope;
        self.unit = unit;
//        timeDateStr = [NSDate date];
        self.backgroundColor = [UIColor whiteColor];
        self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, frame.size.width+2, frame.size.height/DIVIDEPARTS - 0.5)];
        self.buttonView.layer.borderColor = [UIColor colorWithWhite:0.90 alpha:1.0].CGColor;
        self.buttonView.layer.borderWidth = 0.5;
        self.buttonView.backgroundColor = [UIColor colorWithRed:230/255.0 green:252/255.0 blue:255/255.0 alpha:1.0];
        [self addSubview:self.buttonView];
        
        //取消按钮
        UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelbutton.tag = 100;
        cancelbutton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2 - BORDERSPACE*2, self.buttonView.frame.size.height);
        cancelbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//        cancelbutton.backgroundColor = [UIColor kMainColor];
        cancelbutton.titleEdgeInsets = UIEdgeInsetsMake(0,BORDERSPACE, 0, 0);
        [cancelbutton setTitleColor:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0]  forState:UIControlStateNormal];
        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbutton addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:cancelbutton];
        
        //确定按钮
        UIButton *surebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        surebutton.tag = 200;
        surebutton.frame = CGRectMake(frame.size.width - ([UIScreen mainScreen].bounds.size.width/2 - BORDERSPACE*2), 0, [UIScreen mainScreen].bounds.size.width/2 - BORDERSPACE*2, self.buttonView.frame.size.height);
        surebutton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
//        surebutton.backgroundColor = [UIColor blackColor];
        surebutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [surebutton setTitleColor:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0]  forState:UIControlStateNormal];
        [surebutton setTitle:@"确定" forState:UIControlStateNormal];
        [surebutton addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:surebutton];
       
        //时间
        self.datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buttonView.frame), frame.size.width,frame.size.height/DIVIDEPARTS * (DIVIDEPARTS-1))];
        self.datePicker.delegate = self;
        self.datePicker.dataSource = self;
        [self.datePicker setValue:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0] forKey:@"textColor"];
        [self addSubview:self.datePicker];
        
    }
    return self;
}

/**
 关闭
 */
-(void)closePicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = frame;
    }];
}

/**
 打开数据
 */
-(void)openPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height-200;
        self.frame = frame;
    }];
}

-(void)clickControlBtn:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = frame;
    }];
    if (button.tag == 100) {
        NSLog(@"取消");
    }else{
        NSLog(@"确认");
        NSLog(@"%@,%@",self.scope[self.row],self.unit[self.com]);
        if ([self.delegate respondsToSelector:@selector(CommonPickerViewChange:andBtnTitle:)]) {
            
            [self.delegate CommonPickerViewChange:self.scope[self.row] andBtnTitle:button.titleLabel.text];
        }
    }
  
}

#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.scope.count;//根据数组的元素个数返回几行数据
            break;
        case 1:
            result = self.unit.count;
            break;
            
        default:
            break;
    }
    
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.scope[row];
            break;
        case 1:
            title = self.unit[row];
            break;
        default:
            break;
    }
    
    return title;
}

//选中某行后回调的方法，获得选中结果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    _row = row;
    _com = component;
   

}



@end
