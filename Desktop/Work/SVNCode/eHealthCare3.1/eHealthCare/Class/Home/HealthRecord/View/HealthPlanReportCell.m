//
//  HealthPlanReportCell.m
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "HealthPlanReportCell.h"

@interface HealthPlanReportCell ()
@property (weak, nonatomic) IBOutlet UIButton *sportsBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *proessLab;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation HealthPlanReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backView.backgroundColor = [UIColor getColor:@"EEFBFE"];
    self.backView.layer.cornerRadius=3;
    self.backView.layer.masksToBounds=YES;
    
    self.sportsBtn.layer.masksToBounds=YES;
    self.sportsBtn.layer.borderWidth = 0.5;
    self.sportsBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    self.sportsBtn.layer.cornerRadius=self.sportsBtn.frame.size.height/2.0;
    
    self.titleLab.textColor = kMainTitleColor;
    self.proessLab.textColor = [UIColor getColor:@"B3BBC4"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPlanListMod:(TopRecordModel *)PlanListMod
{
    _PlanListMod = PlanListMod;
//    self.backView.backgroundColor = [UIColor getColor:@"FCF5F5"];
    self.titleLab.text = PlanListMod.Title;
    self.proessLab.text = [NSString stringWithFormat:@"%i",PlanListMod.IsOK];
    [self.sportsBtn setTitle:@"1" forState:UIControlStateNormal];
//    [self.sportsBtn setTitleColor:[UIColor getColor:@"F67475"] forState:UIControlStateNormal];
    
    
    self.proessLab.text = PlanListMod.IsOK==1?@"已完成":@"今天未完成";
    self.proessLab.textColor = PlanListMod.IsOK==1?[UIColor getColor:@"07DD8F"]:[UIColor getColor:@"B3BBC4"];
    //    类型1、运动 2、饮水 3、 服药 4、健康计划
    NSString *remindStr = @"";
    if (self.userMemberID == [UserInfoTool getLoginInfo].MemberID) {
        if (PlanListMod.IsOK==0) {
                remindStr = @"去完成";
            
        }else
        {
             remindStr = @"去查看";
        }
        self.sportsBtn.enabled = YES;
        self.sportsBtn.alpha = 1;
    }else
    {
        remindStr = @"提醒TA";
        if (PlanListMod.IsOK==0) {
            self.sportsBtn.enabled = YES;
            self.sportsBtn.alpha = 1;
        }else
        {
            
            self.sportsBtn.enabled = NO;
            self.sportsBtn.alpha = 0.2;
        }
        
    }
    [self.sportsBtn setTitle:remindStr forState:UIControlStateNormal];
    
}
- (IBAction)goPlanAction:(id)sender {
    if ([self.sportsBtn.titleLabel.text containsString:@"去"]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(HealthPlanReportCellbuttonClick:remind:)]) {
            [self.delegate HealthPlanReportCellbuttonClick:self.PlanListMod remind:NO];
        }
    }else if ([self.sportsBtn.titleLabel.text containsString:@"提醒TA"])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(HealthPlanReportCellbuttonClick:remind:)]) {
        [self.delegate HealthPlanReportCellbuttonClick:self.PlanListMod remind:YES];
     }
    }
}
@end
