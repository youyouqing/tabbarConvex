//
//  HealthRecordCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordCell.h"
@interface HealthRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *proessLab;
@property (weak, nonatomic) IBOutlet UIButton *sportsBtn;

@end
@implementation HealthRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    
    self.sportsBtn.layer.masksToBounds=YES;
    self.sportsBtn.layer.borderWidth = 0.5;
    self.sportsBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    self.sportsBtn.layer.cornerRadius=self.sportsBtn.frame.size.height/2.0;
    
    self.dataLab.textColor = kMainTitleColor;
    
     self.titleLab.textColor = kMainTitleColor;
    self.proessLab.textColor = [UIColor getColor:@"B3BBC4"];
}
- (IBAction)goAction:(id)sender {
    if ([self.sportsBtn.titleLabel.text containsString:@"去"]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(HealthRecordCellbuttonClick:remind:)]) {
            [self.delegate HealthRecordCellbuttonClick:self.recprdMod.RemindType remind:NO];
        }
    }else if ([self.sportsBtn.titleLabel.text containsString:@"提醒TA"])
    {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(HealthRecordCellbuttonClick:remind:)]) {
            [self.delegate HealthRecordCellbuttonClick:self.recprdMod.RemindType remind:YES];
        }
    }
    else if ([self.sportsBtn.titleLabel.text containsString:@"已服药"])
    {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(HealthRecordCellbuttonClick:remind:)]) {
            [self.delegate HealthRecordCellbuttonClick:self.recprdMod.RemindType remind:NO];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUserMemberID:(NSInteger)userMemberID
{
    _userMemberID = userMemberID;
    
}
-(void)setRecprdMod:(TopRecordModel *)recprdMod
{
    _recprdMod = recprdMod;
    self.titleLab.text =  recprdMod.Title;
    self.dataLab.text = recprdMod.TitleDetail;
    self.proessLab.text = recprdMod.IsOK==1?@"达标":@"未达标";
    self.proessLab.textColor = recprdMod.IsOK==1?[UIColor getColor:@"07DD8F"]:[UIColor getColor:@"B3BBC4"];
     self.sportsBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    //    类型1、运动 2、饮水 3、 服药 4、健康计划 5、休息(休息没有达不达标这一说,故把self.proessLab.text设为空)
    NSString *remindStr = @"";
    if (self.userMemberID == [UserInfoTool getLoginInfo].MemberID) {
        if (recprdMod.IsOK==0) {
            if (recprdMod.RemindType == 1) {
                remindStr = @"去运动";
            }else if (recprdMod.RemindType == 2)
            {
                remindStr = @"去饮水";
            }
            else if (recprdMod.RemindType == 4)
            {
                remindStr = @"去服药";
            }
            else if (recprdMod.RemindType == 3)
            {
                remindStr = @" ";
                self.proessLab.text = @"";
                self.sportsBtn.layer.borderColor = [UIColor clearColor].CGColor;
            }
            else if (recprdMod.RemindType == 5)
            {
                remindStr = @"去工作";
                self.proessLab.text = @"";
               
            }
        }else
        {
            
            if (recprdMod.RemindType == 1) {
                remindStr = @"已完成";
            }else if (recprdMod.RemindType == 2)
            {
                remindStr = @"已饮水";
            }
            else if (recprdMod.RemindType == 4)
            {
                remindStr = @"已服药";
            }
            else if (recprdMod.RemindType == 3)
            {
                remindStr = @" ";
                self.proessLab.text = @"";
                 self.sportsBtn.layer.borderColor = [UIColor clearColor].CGColor;
            }
            else if (recprdMod.RemindType == 5)
            {
                remindStr = @"去工作";
                self.proessLab.text = @"";
                
            }
         
        }
        self.sportsBtn.enabled = YES;
        self.sportsBtn.alpha = 1;
    }else
    {
        remindStr = @"提醒TA";

        if (recprdMod.RemindType == 3)
        {
            remindStr =@"";
            self.proessLab.text = @"";
            self.sportsBtn.layer.borderColor = [UIColor clearColor].CGColor;
        }else
        {
            if (recprdMod.IsOK==0) {
                self.sportsBtn.enabled = YES;
                self.sportsBtn.alpha = 1;
            }else
            {
                
                self.sportsBtn.enabled = NO;
                self.sportsBtn.alpha = 0.2;
            }
            
        }
    }
   
   
    [self.sportsBtn setTitle:remindStr forState:UIControlStateNormal];
    
}
@end