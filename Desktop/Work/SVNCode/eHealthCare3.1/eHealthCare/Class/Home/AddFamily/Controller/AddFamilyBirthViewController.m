//
//  AddFamilyBirthViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AddFamilyBirthViewController.h"
#import "AddFamilyBindPhoneViewController.h"
@interface AddFamilyBirthViewController ()
@property (weak, nonatomic) IBOutlet UIButton *relationBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddFamilyBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.relationBtn.clipsToBounds = YES;
    self.relationBtn.layer.cornerRadius = self.relationBtn.frame.size.height/2.0;
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *defaultDate = [formatter_minDate dateFromString:@"1990-01-01"];
    self.model.Birthday = @"1990-01-01";
    [self.datePicker setDate:defaultDate animated:YES];//设置当前显示的时间
    [ self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
}
-(void)dateChanged:(UIDatePicker *)datepicker
{
    NSDate *date = [datepicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    self.model.Birthday = [dateFormatter stringFromDate:date];

}

- (IBAction)addAction:(id)sender {
    AddFamilyBindPhoneViewController *add = [[AddFamilyBindPhoneViewController alloc]initWithType:pageTypeNormal];
    add.model = self.model;
    [self.navigationController pushViewController:add animated:YES];
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
