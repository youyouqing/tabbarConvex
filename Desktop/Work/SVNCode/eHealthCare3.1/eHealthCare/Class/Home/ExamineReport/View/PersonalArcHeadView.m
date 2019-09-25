//
//  PersonalArcHeadView.m
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonalArcHeadView.h"

@interface PersonalArcHeadView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLal;
@property (weak, nonatomic) IBOutlet UILabel *ageLal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trendBtnHeightCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trendBtnWidthCon;
@property (weak, nonatomic) IBOutlet UILabel *archivelab;
@property (weak, nonatomic) IBOutlet UILabel *normalLab;
@property (weak, nonatomic) IBOutlet UILabel *exceptionLab;

@end
@implementation PersonalArcHeadView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImgView.contentMode  = UIViewContentModeScaleAspectFill;
    for (int i = 0; i<4; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:90+i];
        if (i == 0) {
            [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        //字体适配
        if (IS_IPHONE5) {
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
        }else if (IS_IPHONE6) {
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
        }
        
    }
 
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.trendBtnWidthCon.constant, self.trendBtnHeightCon.constant) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.trendBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.trendBtn.layer.mask = maskLayer1;

}
- (IBAction)clickFourBtn:(id)sender {
    UIButton *button = (UIButton *)sender;//这里使用tag,90~93
    for (int i = 0; i<=4; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:90+i];
        if (i + 90 == button.tag) {
            [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
    
    if ([self.delegate respondsToSelector:@selector(clickHeadBtn:)]) {
        [self.delegate clickHeadBtn:button.titleLabel.text];
    }
    
}

-(void)setModel:(FamilyObject *)model
{

    _model = model;
        if (IS_IPHONE5) {
            _ageLal.font = [UIFont systemFontOfSize:14];
        }else{
            _ageLal.font = [UIFont systemFontOfSize:16];
        }
    
          _ageLal.text = [NSString stringWithFormat:@"%d岁",model.Age];//**有姓名的情况下，年龄无 如何显示
  
    
//        else{
//        //年龄计算
//        Dateformat *dateFor = [[Dateformat alloc]init];
//        NSString *birthYear  = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",model.Birthday] withFormat:@"YYYY"];
//        NSDictionary *timeDic = [dateFor getDateTime];
//        NSInteger age = [[timeDic[@"sumtime"] substringWithRange:NSMakeRange(0, 4)] integerValue] - [birthYear integerValue];
//        _ageLal.text = [NSString stringWithFormat:@"%li 岁", age];
//    }
      NSString *headImag = @"iv_question_man";
        if (model.Sex == 0) {
            headImag = @"iv_question_man";
            self.iconImgView.image = [UIImage imageNamed:@"icon_report_man"];
            self.sexImage.image = [UIImage imageNamed:@"icon_report_man"];
        }else if (model.Sex == 1) {
            headImag = @"iv_question_female";
             self.iconImgView.image = [UIImage imageNamed:@"icon_report_female"];
             self.sexImage.image = [UIImage imageNamed:@"icon_report_female"];
        }
    if (model.FamilyMemberID == [UserInfoTool getLoginInfo].MemberID) {
     
        _nameLal.text = [UserInfoTool getLoginInfo].FullName;//用档案的名字
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:[UserInfoTool getLoginInfo].HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
//        NSString  *ageStr = ([UserInfoTool getLoginInfo].Age >=0)?@"年龄不详":[NSString stringWithFormat:@"%ld 岁",(long)[UserInfoTool getLoginInfo].Age];
//        _ageLal.text = ageStr;
        
    }else
    {
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:model.HeadImg] placeholderImage:[UIImage imageNamed:headImag]];
        
        if (((NSString *)model.FamilyName).length ==0) {
            _nameLal.text = @"";
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",model.FamilyName];
            
            
            
            NSRange range = [str rangeOfString:model.FamilyName];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
            [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:19] range:range];
            _nameLal.attributedText = attr;
        }
        
    }
  
}

-(void)setExanubeReportModel:(ExanubeReportModel *)exanubeReportModel
{
    
    _exanubeReportModel = exanubeReportModel;
    
    self.exceptionLab.text = [NSString stringWithFormat:@"%@",exanubeReportModel.ExceptionCount];
    
     self.archivelab.text = [NSString stringWithFormat:@"%@",exanubeReportModel.CheckCount];
     self.normalLab.text = [NSString stringWithFormat:@"%i",([exanubeReportModel.CheckCount intValue] - [exanubeReportModel.ExceptionCount intValue])];
     Dateformat *dateFor = [[Dateformat alloc] init];
//    体检日期：2017/10/11
    if (exanubeReportModel.TestTime.length>1) {
          [self.trendBtn setTitle:[NSString stringWithFormat:@"体检日期：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",exanubeReportModel.TestTime] withFormat:@"YYYY/MM/dd"]] forState:UIControlStateNormal];
    }
   

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
