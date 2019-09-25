//
//  CertificationController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "CertificationController.h"

@interface CertificationController ()
{
    BOOL phone_need_up;
    BOOL phone_need_down;
    
    BOOL code_need_top;
    BOOL code_need_down;
    
    BOOL is_phone_top;
    BOOL is_code_top;
    BOOL is_phone_error;
}
@property (weak, nonatomic) IBOutlet UIButton *completeAction;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;

@property (weak, nonatomic) IBOutlet UILabel *lineOne;

@property (weak, nonatomic) IBOutlet UILabel *lineTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *certicationLabTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabCons;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UILabel *certicationLab;
@property (weak, nonatomic) IBOutlet UITextField *certicationText;

@end

@implementation CertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"实名认证";
    self.titleLab.textColor = kMainTitleColor;

    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.completeAction.layer.cornerRadius = self.completeAction.frame.size.height/2.0;
    self.completeAction.clipsToBounds = YES;
    self.certicationText.delegate = self;
    self.nameText.delegate = self;
}
- (IBAction)action:(id)sender {
    
    
}
- (IBAction)readAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//开始编辑时触发，文本字段将成为first responder
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    if (textField == self.certicationText) {
        
        if (textField.text.length == 0) {
            phone_need_up = YES;
            phone_need_down = NO;
        }
        [self editingPhone];
        [self phoneRight];
    }else{
        self.lineTwo.backgroundColor = MainCOLOR;
        self.lineOne.backgroundColor = [UIColor getColor:@"EBF0F4"];
        if (textField.text.length == 0) {
            code_need_top = YES;
            code_need_down = NO;
        }
    }
    [self up_down];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == self.certicationText) {
        if (self.nameText.text.length == 0) {
            code_need_top = NO;
            code_need_down = YES;
        }
        if (textField.text.length == 0) {
            
            phone_need_up = NO;
            phone_need_down = YES;
        }
        if (textField.text.length > 0)
        {
            if ([Judge judgeIdentityCard:textField.text]) {
                //电话正确
                
                [self phoneRight];
            }else{
                //电话错误
                
                [self phoneWrong];
            }
            
        }
    } else{
        
        if (textField.text.length == 0) {
            code_need_top = NO;
            code_need_down = YES;
        }
        if (self.certicationText.text.length == 0) {
            phone_need_up = NO;
            phone_need_down = YES;
        }
        
        
        
    }
    [self up_down];
    
    
    
}
-(void)phoneWrong
{
    is_phone_error = YES;
}

-(void)phoneRight
{
    is_phone_error = NO;
}
-(void)editingPhone
{
    [UIView animateWithDuration:0.15 animations:^{
        self.lineOne.backgroundColor = MainCOLOR;
        self.lineTwo.backgroundColor = [UIColor getColor:@"EBF0F4"];
        
        
    }];
}
-(void)TipMoveUp:(BOOL)ret lab:(UILabel *)lab text:(UITextField *)text;
{
    [self.view layoutIfNeeded];
    if (ret) {
        //        if (!isTop) {
        //上移
        [UIView animateWithDuration:0.2 animations:^{
            
            
            lab.y = text.y - 26;
        }];
      
    }else{
       
        [UIView animateWithDuration:0.15 animations:^{
            
            
            lab.y = text.y;
            
        }];
       
    }
}
-(void)up_down
{
    if (phone_need_up && !is_phone_top) {
        [self TipMoveUp:YES lab:self.certicationLab text:self.certicationText];
        is_phone_top = YES;
    }
    if (phone_need_down && is_phone_top) {
        [self TipMoveUp:NO lab:self.certicationLab text:self.certicationText];
        is_phone_top = NO;
    }
    if (code_need_top && !is_code_top) {
        [self TipMoveUp:YES lab:self.nameLab text:self.nameText];
        is_code_top = YES;
    }
    if (code_need_down && is_code_top) {
        [self TipMoveUp:NO lab:self.nameLab text:self.nameText];
        is_code_top = NO;
    }
    if (is_phone_error) {
        self.certicationLab.text = @"手机号码错误";
        self.certicationLab.textColor = [UIColor getColor:@"FF4564"];
    }else{
        self.certicationLab.text = @"身份证号码";
        self.certicationLab.textColor = [UIColor getColor:@"B3BBC4"];
    }
    phone_need_up = phone_need_down =code_need_top=code_need_down =NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
