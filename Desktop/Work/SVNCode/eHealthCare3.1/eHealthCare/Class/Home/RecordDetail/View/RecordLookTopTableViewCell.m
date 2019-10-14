//
//  RecordLookTopTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "RecordLookTopTableViewCell.h"
#import "UIFollowTimePickView.h"
#import "XKPatientTypeModel.h"
@interface RecordLookTopTableViewCell()

@property (weak, nonatomic) IBOutlet UITextField *PatineTimeText;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITextField *roomText;
@property (weak, nonatomic) IBOutlet UITextField *yiyuanText;
@property (weak, nonatomic) IBOutlet UITextField *yishengText;
/**
 时间选择器
 */
@property (nonatomic, strong) UIFollowTimePickView *timePicker;
@end

@implementation RecordLookTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = [UIColor clearColor];
    
  
   
     self.roomText.delegate = self;
     self.yiyuanText.delegate = self;
     self.yishengText.delegate = self;
    
    
}
-(void)setIsEnableEdit:(BOOL)isEnableEdit{
    
    _isEnableEdit = isEnableEdit;
    
    if (_isEnableEdit) {//可以编辑
        self.PatineTimeText.enabled =self.typeText.enabled =self.roomText.enabled =self.yiyuanText.enabled =self.yishengText.enabled = YES;
    }else{//不可以编辑
        self.PatineTimeText.enabled =self.typeText.enabled =self.roomText.enabled =self.yiyuanText.enabled =self.yishengText.enabled = NO;
    }
    
}
-(void)setTypeArray:(NSArray *)typeArray{
    _typeArray = typeArray;
    for (XKPatientTypeModel *type in _typeArray) {
        
        if (type.PatientTypeID == _model.AttendanceType) {
            
             self.typeText.text = type.PatientTypeName;
            break;
        }
        
    }
}

-(void)setModel:(XKPatientDetailModel *)model{
    
    _model = model;
    if (_model.AttendanceTime != 0) {
        Dateformat *dateFor = [[Dateformat alloc] init];
        
        NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_model.AttendanceTime]] withFormat:@"yyyy-MM-dd"];
        self.PatineTimeText.text = timeStr;
    }
    
    
    
    
     self.roomText.text = model.DepartmentsName;
    
     self.yiyuanText.text = model.AttendanceHospital;
    
    
     self.yishengText.text = model.DoctorName;
}
/**
 文本框的协议方法
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == self.yiyuanText) {
        self.model.AttendanceHospital = textField.text;
    }
    
    if (textField == self.roomText) {
        self.model.DepartmentsName = textField.text;
    }
    if (textField == self.yishengText) {
        self.model.DoctorName = textField.text;
    }
    
    if ([self.delegate respondsToSelector:@selector(hospitalMessageFix:)]) {
        
        [self.delegate hospitalMessageFix:self.model];
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.yiyuanText) {
        self.model.AttendanceHospital = textField.text;
    }
    
    if (textField == self.roomText) {
        self.model.DepartmentsName = textField.text;
    }
    if (textField == self.yishengText) {
        self.model.DoctorName = textField.text;
    }
    
    if ([self.delegate respondsToSelector:@selector(hospitalMessageFix:)]) {
        
        [self.delegate hospitalMessageFix:self.model];
        
    }
    [textField resignFirstResponder];
    
    return YES;
    
}

- (IBAction)yiyuanAction:(id)sender {
     [self.yiyuanText becomeFirstResponder];
}
- (IBAction)yishengAction:(id)sender {
     [self.yishengText becomeFirstResponder];
}
- (IBAction)roomAction:(id)sender {
     [self.roomText becomeFirstResponder];
}
- (IBAction)typeAction:(id)sender {
    if (self.typeText.enabled) {//可以编辑
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (int i=0; i<self.typeArray.count; i++) {
            
            XKPatientTypeModel *type = self.typeArray[i];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:type.PatientTypeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self.typeText.text = action.title;
                
                for (XKPatientTypeModel *type1 in self.typeArray) {
                    
                    if ([type1.PatientTypeName isEqualToString:action.title]) {
                        self.model.AttendanceType = type1.PatientTypeID;
                        if ([self.delegate respondsToSelector:@selector(typeFixDataSource:)]) {
                            [self.delegate typeFixDataSource:self.model];
                        }
                        
                        break;
                        
                    }
                    
                }
                
            }];
            
            [alert addAction:action];
            
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:action];
        
        [[self parentController] presentViewController:alert animated:YES completion:nil];
        
    }else{//不可编辑
        return;
        
    }
    
    NSLog(@"就诊类型选择");
}
- (IBAction)timeAction:(id)sender {
    if (self.PatineTimeText.enabled) {
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
-(UIFollowTimePickView *)timePicker
{
    if (!_timePicker) {
        _timePicker = [[UIFollowTimePickView alloc]initWithFrame:CGRectMake(0, KScreenHeight-250, KScreenWidth, 200)];
        _timePicker.delegate = self;
    }
    return _timePicker;
}
#pragma mark - 时间选择器代理方法
//时间选择器--确定取消按钮代理方法
-(void)birthDayPickerChange:(NSString *)dateStr andBtnTitle:(NSString *)title
{
    NSLog(@"%@ -- %@",dateStr,title);
    
    if ([title isEqualToString:@"确定"]) {
        self.PatineTimeText.text = dateStr;
        
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end