//
//  HealthInformationCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthInformationCell.h"

@interface HealthInformationCell()


@property (weak, nonatomic) IBOutlet UILabel *dotLab;


@end


@implementation HealthInformationCell
- (IBAction)goOverAllAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthInformationCellDelegatebuttonClick)]) {
        [self.delegate HealthInformationCellDelegatebuttonClick];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    
    self.goBtn.layer.masksToBounds=YES;
    self.goBtn.layer.borderWidth = 0.5;
    self.goBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    self.goBtn.layer.cornerRadius=self.goBtn.frame.size.height/2.0;
    self.goBtn.hidden = YES;
    
}
-(void)setDataStr:(NSString *)dataStr
{
    _dataStr = dataStr;
    NSArray *a = [self dealPersonStringWith:dataStr];
    NSString *aStr = @"";
    if (a.count>1) {
        aStr = a[1];
    }
    NSString *tempStr= @"";
    if (a.count>=1) {
        tempStr = a[0];
    }
    NSString *dataTempString = aStr.length>0?dataStr:[NSString stringWithFormat:@"%@：无",tempStr];
    if (tempStr.length>0) {
      NSMutableAttributedString *AttributedStr = [NSMutableAttributedString boldChangeLabelWithText:dataTempString withBigFont:15 withNeedchangeText:tempStr excisionColor:kMainTitleColor];
        [self.dataLab setAttributedText:AttributedStr];
    
    }else
     self.dataLab.text =  aStr.length>0?[NSString stringWithFormat:@"%@：无",tempStr]:dataStr;
    
    
    if ([dataStr containsString:@"异常项目"]&&(![aStr isEqualToString:@"0项"])&&aStr.length>0) {
//         self.goBtn.layer.borderColor = [UIColor clearColor].CGColor;
         self.dotLab.backgroundColor =  self.dataLab.textColor = [UIColor getColor:@"F67475"];
    }else
    {
        self.dataLab.textColor = kMainTitleColor;
        self.dotLab.backgroundColor = kMainColor;
//        self.goBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    }
    
}
-(NSArray *)dealPersonStringWith:(NSString *)str
{
    if (str.length == 0||[str isKindOfClass:[NSNull null]]) {
        return @[];
    }
    NSArray *arr = [str componentsSeparatedByString:@"："];
   
  
    return arr;
   
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
