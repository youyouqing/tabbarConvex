//
//  XKRecordTypeCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历类型信息

#import "XKRecordTypeCell.h"
#import "XKPatientTypeModel.h"

@interface XKRecordTypeCell ()

/**
 背景视图2
 */
@property (weak, nonatomic) IBOutlet UIView *backViewTwo;

/**
 就诊类型文本标签
 */
@property (weak, nonatomic) IBOutlet UITextField *txtType;

@end

@implementation XKRecordTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.backViewTwo.layer.cornerRadius = 6;
    self.backViewTwo.layer.masksToBounds = YES;
}

-(void)setModel:(XKPatientDetailModel *)model{
    
    _model = model;
    
}

-(void)setTypeArray:(NSArray *)typeArray{
    _typeArray = typeArray;
    for (XKPatientTypeModel *type in _typeArray) {
        
        if (type.PatientTypeID == _model.AttendanceType) {
            
            self.txtType.text = type.PatientTypeName;
            break;
        }
        
    }
}

-(void)setIsEnableEdit:(BOOL)isEnableEdit{
    
    _isEnableEdit = isEnableEdit;
    
    if (_isEnableEdit) {//可以编辑
        self.txtType.enabled = YES;
    }else{//不可以编辑
        self.txtType.enabled = NO;
    }
    
}

/**
 纠正类型选择
 */
- (IBAction)typeAction:(id)sender {
    
    if (self.txtType.enabled) {//可以编辑
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (int i=0; i<self.typeArray.count; i++) {
            
            XKPatientTypeModel *type = self.typeArray[i];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:type.PatientTypeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self.txtType.text = action.title;
                
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
