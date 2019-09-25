//
//  XKRecordHospitalMessageCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历医院信息

#import "XKRecordHospitalMessageCell.h"

@interface XKRecordHospitalMessageCell ()<UITextFieldDelegate>

/**
 背景视图1
 */
@property (weak, nonatomic) IBOutlet UIView *backViewOne;

/**
 背景视图2
 */
@property (weak, nonatomic) IBOutlet UIView *backViewTwo;

/**
 背景视图3
 */
@property (weak, nonatomic) IBOutlet UIView *backViewThree;

/**
 就诊医院文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txtOne;

/**
 就诊科室文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txtTwo;

/**
 医生姓名文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txtThree;

@end

@implementation XKRecordHospitalMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
 self.backgroundColor = [UIColor clearColor];
//    self.backViewOne.layer.cornerRadius = 6;
//    self.backViewOne.layer.masksToBounds = YES;
//
//    self.backViewTwo.layer.cornerRadius = 6;
//    self.backViewTwo.layer.masksToBounds = YES;
//
//    self.backViewThree.layer.cornerRadius = 6;
//    self.backViewThree.layer.masksToBounds = YES;
    
    
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 50) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.backViewThree.layer.mask=maskTwoLayer;
    
    self.txtOne.delegate = self;
    
    self.txtTwo.delegate = self;
    
    self.txtThree.delegate = self;

}
/**
 输入就诊医院
 */
- (IBAction)actionOne:(id)sender {
    NSLog(@"输入就诊医院");
    [self.txtOne becomeFirstResponder];
    
}
/**
 输入就诊科室
 */
- (IBAction)actionTwo:(id)sender {
    NSLog(@"输入就诊科室");
    [self.txtTwo becomeFirstResponder];
    
}
/**
 输入医生姓名
 */
- (IBAction)actionThree:(id)sender {
    
    NSLog(@"输入医生姓名");
    
    [self.txtThree becomeFirstResponder];
    
}

/**
 文本框的协议方法
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == self.txtOne) {
        self.model.AttendanceHospital = textField.text;
    }
    
    if (textField == self.txtTwo) {
        self.model.DepartmentsName = textField.text;
    }
    if (textField == self.txtThree) {
       self.model.DoctorName = textField.text;
    }
    
    if ([self.delegate respondsToSelector:@selector(hospitalMessageFix:)]) {
        
        [self.delegate hospitalMessageFix:self.model];
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.txtOne) {
        self.model.AttendanceHospital = textField.text;
    }
    
    if (textField == self.txtTwo) {
        self.model.DepartmentsName = textField.text;
    }
    if (textField == self.txtThree) {
        self.model.DoctorName = textField.text;
    }
    
    if ([self.delegate respondsToSelector:@selector(hospitalMessageFix:)]) {
        
        [self.delegate hospitalMessageFix:self.model];
        
    }
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)setModel:(XKPatientDetailModel *)model{
    
    _model = model;
    
    self.txtOne.text = _model.AttendanceHospital;
    
    self.txtTwo.text = _model.DepartmentsName;
    
    self.txtThree.text = _model.DoctorName;
    
}

-(void)setIsEnableEdit:(BOOL)isEnableEdit{
    
    _isEnableEdit = isEnableEdit;
    
    if (_isEnableEdit) {//可以编辑
        self.txtOne.enabled = YES;
        self.txtTwo.enabled = YES;
        self.txtThree.enabled = YES;
    }else{//不可以编辑
        self.txtOne.enabled = NO;
        self.txtTwo.enabled = NO;
        self.txtThree.enabled = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
