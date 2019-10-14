//
//  AddFamilyBindPhoneViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AddFamilyBindPhoneViewController.h"
#import "AddFamilyViewModel.h"
#import "FamilyObject.h"
#import "HealthRecordController.h"
#import "HealthExamineController.h"
@interface AddFamilyBindPhoneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *relationBtn;

@end

@implementation AddFamilyBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.addBtn.clipsToBounds = YES;
    self.addBtn.layer.cornerRadius = self.addBtn.frame.size.height/2.0;
     [self.relationBtn setTitle:self.model.DictionaryName forState:UIControlStateNormal];
    self.iconImage.clipsToBounds = YES;
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.height/2.0;
    
    self.relationBtn.clipsToBounds = YES;
    self.relationBtn.layer.cornerRadius = self.iconImage.frame.size.height/2.0;
    
    
    if (self.model.FamilyHead.length>0) {
        [self.relationBtn sd_setImageWithURL:[NSURL URLWithString:self.model.FamilyHead] forState:UIControlStateNormal];
    }
}
- (void)addFamilyResultWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"FamilyMobile":self.model.FamilyMobile.length>0?self.model.FamilyMobile:@" ",
                          @"FamilyName": self.model.DictionaryName,
                          @"Birthday": self.model.Birthday,
                           @"FamilyHead": self.model.FamilyHead.length>0?self.model.FamilyHead:@" ",
                          };
      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [AddFamilyViewModel addFamilyInformationPersonWithParmas:dic FinishedBlock:^(ResponseObject *response) {
             [[XKLoadingView shareLoadingView]hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            FamilyObject  *f = [FamilyObject mj_objectWithKeyValues:response.Result];
            
            HealthRecordController *chect;
             HealthExamineController *chect1;
            for (UIViewController *control in self.navigationController.viewControllers) {
                
                if ([control isKindOfClass:[HealthRecordController class]]) {
                    
                    chect=(HealthRecordController *)control;
                }else  if ([control isKindOfClass:[HealthExamineController class]]) {
                    
                    chect1=(HealthExamineController *)control;
                }
                
            }
            
            if (!chect && !chect1) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else  if (chect)
            {
                [self.navigationController popToViewController:chect animated:YES];
            }
            else  if (chect1)
            {
                [self.navigationController popToViewController:chect1 animated:YES];
            }
            
            
            NSLog(@"318%@",f);
            
         
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}
- (IBAction)addFamilyAction:(id)sender {
    
    [self addFamilyResultWithNetWorking];
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