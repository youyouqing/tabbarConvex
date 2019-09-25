//
//  ArchivesEditView.m
//  eHealthCare
//
//  Created by xiekang on 16/9/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArchivesEditView.h"
#define BORDERSPACE 8
#define DIVIDEPARTS 3
#define PICKHEIGHT 40
#import "EidtArchvieHeaderView.h"

@interface ArchivesEditView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger nowRow;
}
@property(strong, nonatomic) UIPickerView *picker;
@end
@implementation ArchivesEditView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
//        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, -40, frame.size.width, 40)];
//        buttonView.layer.borderColor = [UIColor colorWithWhite:0.90 alpha:1.0].CGColor;
////        buttonView.backgroundColor = [UIColor kMainColor];
//        buttonView.layer.borderWidth = 0.5;
//        buttonView.backgroundColor = [UIColor colorWithRed:230/255.0 green:252/255.0 blue:255/255.0 alpha:1.0];
//        [self addSubview:buttonView];
//
//        //取消按钮
//        UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        cancelbutton.frame = CGRectMake(BORDERSPACE, 0, 40, buttonView.frame.size.height );
////                cancelbutton.backgroundColor = [UIColor redColor];
//        [cancelbutton setTitleColor:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0]  forState:UIControlStateNormal];
//        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelbutton addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [buttonView addSubview:cancelbutton];
//
//        //确定按钮
//        UIButton *surebutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        surebutton.frame = CGRectMake(frame.size.width - BORDERSPACE - 40, 0, 40, buttonView.frame.size.height );
////                surebutton.backgroundColor = [UIColor blackColor];
//        [surebutton setTitleColor:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0]  forState:UIControlStateNormal];
//        [surebutton setTitle:@"确定" forState:UIControlStateNormal];
//        [surebutton addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [buttonView addSubview:surebutton];
//
        //时间
        self.picker = [[UIPickerView alloc]init];
        self.picker.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.picker.delegate = self;
        self.picker.dataSource = self;
        [self addSubview:self.picker];
        self.picker.showsSelectionIndicator = YES;
        CALayer *viewLayer = self.picker.layer;
        [viewLayer setFrame:CGRectMake(0, 0,KScreenWidth, frame.size.height)];
    
        self.dataArr = @[];
        
    }
    return self;
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    [self.picker reloadAllComponents];
    
     nowRow =0;
    
    [self.picker selectRow:0 inComponent:0 animated:YES];//**设置某一列的行数,也可以放到VC中设置

}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArr.count;
}

#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataArr[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    nowRow = row;
    
    DictionaryMsg *msg=self.dataArr[row];
    
    [self.delegate changeDataPicker:msg andRow:row withSelef:self];
    
    [self.picker reloadAllComponents];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth ,PICKHEIGHT)];
//    myView.backgroundColor = [UIColor kMainColor];
    DictionaryMsg *msg=[self.dataArr objectAtIndex:row];
    myView.text =msg.DictionaryName;
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = [UIFont boldSystemFontOfSize:18];
    if (row == nowRow) {
        [UIView animateWithDuration:0.5 animations:^{
            myView.textColor = [UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0];
        }];
    }
    
    return myView;
    
}

//每一行的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return PICKHEIGHT;
}

-(void)clickControlBtn:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = frame;
    }];
    NSLog(@"%@",button.titleLabel.text);
    if ([button.titleLabel.text isEqualToString:@"确定"]) {
        if ([self.delegate respondsToSelector:@selector(changeDataPicker:andRow:withSelef:)]) {
            [self.delegate changeDataPicker:self.dataArr[nowRow] andRow:nowRow withSelef:self];
//            [self.delegate changeDataPicker:self.dataArr[nowRow] andRow:nowRow];
        }
    }
}


@end
