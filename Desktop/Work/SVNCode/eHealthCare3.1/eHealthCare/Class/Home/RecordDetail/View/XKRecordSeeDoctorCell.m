//
//  XKRecordSeeDoctorCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历原因和结果

#import "XKRecordSeeDoctorCell.h"

@interface XKRecordSeeDoctorCell ()<UITextViewDelegate>

/**
 背景视图1
 */
@property (weak, nonatomic) IBOutlet UIView *backViewOne;

/**
 背景视图2
 */
@property (weak, nonatomic) IBOutlet UIView *backViewTwo;



@end

@implementation XKRecordSeeDoctorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backViewOne.layer.cornerRadius = 3;
    self.backViewOne.layer.masksToBounds = YES;
    
    self.backViewTwo.layer.cornerRadius = 3;
    self.backViewTwo.layer.masksToBounds = YES;
     self.backgroundColor = [UIColor clearColor];
    self.resonTxt.delegate = self;
    self.resultTxt.delegate = self;
}

/**
 文本框的协议方法
 */
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
   
    if (textView == self.resonTxt) {
        self.model.AttendanceReason = textView.text;
    }
    
    if (textView == self.resultTxt) {
        self.model.AttendanceResult = textView.text;
    }
    
    if ([self.delegate respondsToSelector:@selector(seeDoctorFixDataSource:)]) {
        
        [self.delegate seeDoctorFixDataSource:self.model];
        
    }
    
    return YES;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
-(void)setIsEnableEdit:(BOOL)isEnableEdit{
    
    _isEnableEdit = isEnableEdit;
    
    if (_isEnableEdit) {//可以编辑
        self.resonTxt.userInteractionEnabled = YES;
        self.resultTxt.userInteractionEnabled = YES;
      
    }else{//不可以编辑
        self.resonTxt.userInteractionEnabled = NO;
        self.resultTxt.userInteractionEnabled = NO;
    }
    
}

-(void)setModel:(XKPatientDetailModel *)model{
    
    _model = model;
    
    self.resonTxt.text = _model.AttendanceReason;
    
    self.resultTxt.text = _model.AttendanceResult;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end