//
//  FamilyRelationController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "FamilyRelationController.h"
#import "CertificationController.h"

@interface FamilyRelationController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineOneLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneLabTopCons;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation FamilyRelationController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.myTitle = @"家庭联系人";
    self.titleLab.textColor = kMainTitleColor;

    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.addBtn.layer.cornerRadius = self.addBtn.frame.size.height/2.0;
    self.addBtn.clipsToBounds = YES;
     self.lineOneLab.backgroundColor = [UIColor getColor:@"EBF0F4"];
    self.phoneLabTopCons.constant = 0;
}
//开始编辑时触发，文本字段将成为first responder
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
   // if (textField.text.length>0) {
         self.lineOneLab.backgroundColor = kMainColor;
   // }else
   // self.lineOneLab.backgroundColor = [UIColor getColor:@"EBF0F4"];
    
   self.phoneLabTopCons.constant = 26;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.lineOneLab.backgroundColor = [UIColor getColor:@"EBF0F4"];
    if (textField.text.length>0) {
        self.phoneLabTopCons.constant = 26;
    }else
       self.phoneLabTopCons.constant = 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)CertificationAction:(id)sender {
    if (self.phoneText.text.length != 11) {
        ShowErrorStatus(@"请输入正确的手机号");
        return;
    }
    
    CertificationController *add = [[CertificationController alloc]initWithType:pageTypeNormal];
    [self.navigationController pushViewController:add animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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