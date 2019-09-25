//
//  XKRecordBasisCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历基础信息

#import "XKRecordBasisCell.h"
#import "UIFollowTimePickView.h"

@interface XKRecordBasisCell ()<UITextFieldDelegate,UIFollowTimePickViewDelegate>


/**
 背景视图1
 */
@property (weak, nonatomic) IBOutlet UIView *backViewCon;


/**
 背景视图2
 */
@property (weak, nonatomic) IBOutlet UIView *backViewTwo;

/**
 就诊人文本标签
 */
@property (weak, nonatomic) IBOutlet UITextField *txtOne;

/**
就诊时间文本标签
 */
@property (weak, nonatomic) IBOutlet UITextField *txtTwo;

/**
 时间选择器
 */
@property (nonatomic, strong) UIFollowTimePickView *timePicker;

@end

@implementation XKRecordBasisCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = [UIColor clearColor];
//    self.backViewCon.layer.cornerRadius = 6;
//    self.backViewCon.layer.masksToBounds = YES;
//
//    self.backViewTwo.layer.cornerRadius = 6;
//    self.backViewTwo.layer.masksToBounds = YES;
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 50) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.backViewCon.layer.mask=maskTwoLayer;
   
     self.txtOne.delegate = self;
}

-(UIFollowTimePickView *)timePicker
{
    if (!_timePicker) {
        _timePicker = [[UIFollowTimePickView alloc]initWithFrame:CGRectMake(0, KScreenHeight-250, KScreenWidth, 200)];
        _timePicker.delegate = self;
    }
    return _timePicker;
}

/**
 文本框的协议方法
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    self.model.MemberName = textField.text;
    
    if ([self.delegate respondsToSelector:@selector(basisFixDataSource:)]) {
        
        [self.delegate basisFixDataSource:self.model];
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.model.MemberName = textField.text;
    
    if ([self.delegate respondsToSelector:@selector(basisFixDataSource:)]) {
        
        [self.delegate basisFixDataSource:self.model];
        
    }
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)setModel:(XKPatientDetailModel *)model{
    
    _model = model;
    
    self.txtOne.text = _model.MemberName;
    
    if (_model.AttendanceTime != 0) {
        Dateformat *dateFor = [[Dateformat alloc] init];
        
        NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_model.AttendanceTime]] withFormat:@"yyyy-MM-dd"];
        self.txtTwo.text = timeStr;
    }
    
}

#pragma mark - 时间选择器代理方法
//时间选择器--确定取消按钮代理方法
-(void)birthDayPickerChange:(NSString *)dateStr andBtnTitle:(NSString *)title
{
    NSLog(@"%@ -- %@",dateStr,title);
    
    if ([title isEqualToString:@"确定"]) {
        self.txtTwo.text = dateStr;
        
        NSDateFormatter *datef = [[NSDateFormatter alloc] init];
        datef.dateFormat = @"yyyy-MM-dd";
        NSDate *date = [datef dateFromString:dateStr];
        
        if ([self.delegate respondsToSelector:@selector(basisFixDataSource:)]) {
            
            self.model.AttendanceTime = (long)[date timeIntervalSince1970]*1000;
            [self.delegate basisFixDataSource:self.model];
            
        }
        
    }
    [self.timePicker hiddenTimeView];
    
}


-(void)setIsEnableEdit:(BOOL)isEnableEdit{
    
    _isEnableEdit = isEnableEdit;
    
    if (_isEnableEdit) {//可以编辑
        self.txtOne.enabled = YES;
        self.txtTwo.enabled = YES;
    }else{//不可以编辑
        self.txtOne.enabled = NO;
        self.txtTwo.enabled = NO;
    }
    
}

/**
 输入就诊人姓名
 */
- (IBAction)oneAction:(id)sender {
    
    NSLog(@"输入就诊人姓名");
    
    [self.txtOne becomeFirstResponder];
    
}
/**
 输入就诊时间
 */
- (IBAction)twoAction:(id)sender {
    
    NSLog(@"输入就诊时间");
     [self.txtOne resignFirstResponder];
    if (self.txtTwo.enabled) {
        if (![[self parentController].view.subviews containsObject:self.timePicker]) {
            [[self parentController].view addSubview:self.timePicker];
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.timePicker.alpha = 1;
            self.timePicker.top = [self parentController].view.frame.size.height - 200;
        }];
        [self.timePicker bringSubviewToFront:[self parentController].view];
        
    }else{
        return;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
