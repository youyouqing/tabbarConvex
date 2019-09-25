//
//  XKSingleCheckMultipleCommonPresResultHeadView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSingleCheckMultipleCommonPresResultHeadView.h"

@implementation XKSingleCheckMultipleCommonPresResultHeadView

-(void)awakeFromNib
{

    [super awakeFromNib];
    
    
     self.statusImgOne.image = [UIImage imageNamed:@""];
     self.statusImgTwo.image = [UIImage imageNamed:@""];
     self.statusImgThree.image = [UIImage imageNamed:@""];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setMode:(ExchinereportModel *)mode
{
    
    _mode = mode;
    
    
    
//    [self.scopebtn setTitle:[NSString stringWithFormat:@"理想范围：%@",self.mode.ReferenceValue] forState:UIControlStateNormal];

    
    
    
}
-(void)setModeArr:(NSArray *)modeArr
{
    
    _modeArr = modeArr;
    
    for (int i = 0; i<modeArr.count; i++) {
        
        ExchinereportModel *mod =   modeArr[i];
        
        
        if (i == 0) {
            
            self.scopeOneLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];
            
            self.nameOneLab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];

            [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataOneBtn exchineReportModel:mod  statusImg:self.statusImgOne];
            
            
        }
        else if (i == 1 )
        {
            
            self.scopeTwoLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];

            self.nameTwolab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];

            [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataTwoBtn exchineReportModel:mod statusImg:self.statusImgTwo];
            
            
        }
        else if ( i ==2 )
        {
            
            
            self.scopeThreeLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];
            self.nameThreeLab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];

            
           [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataThreeBtn exchineReportModel:mod statusImg:self.statusImgThree];
            
        }
    }
    
    
    
}
-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
    if ([PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
        nameStr = [NSString stringWithFormat:@"收缩压"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
        nameStr = [NSString stringWithFormat:@"舒张压"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"RHR"]) {
        nameStr = [NSString stringWithFormat:@"心率"];
    }

    return nameStr;
}

////1偏高2正常3偏低
-(void)becomeStatus:(NSInteger) ParameterStatus  ButtonImage:(UIButton *)btn exchineReportModel:(ExchinereportModel *) model  statusImg:(UIImageView *)statusImg{

    if (ParameterStatus == 1) {
        
//        [btn setImage:[UIImage imageNamed:@"result_high_q"] forState:UIControlStateNormal];
         statusImg.image = [UIImage imageNamed:@"result_high_q"];
        [btn setTitleColor:[UIColor colorWithHexString:@"FF7342"] forState:UIControlStateNormal];
//        btn.titleLabel.textColor = [UIColor colorWithHexString:@"FF7342"];
    }
    if (ParameterStatus == 2) {
        statusImg.image = [UIImage imageNamed:@""];
//        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btn.titleLabel.textColor = [UIColor whiteColor];

    }
    if (ParameterStatus == 3) {
         statusImg.image = [UIImage imageNamed:@"result_low"];
//        [btn setImage:[UIImage imageNamed:@"result_low"] forState:UIControlStateNormal];
//        btn.titleLabel.textColor = [UIColor colorWithHexString:@"F3C331"];
        [btn setTitleColor:[UIColor colorWithHexString:@"F3C331"] forState:UIControlStateNormal];
        
    }
    
    NSLog(@"ExchinereportModel:%@",btn.backgroundColor);


}
-(void)stopAninmayion;
{
    [self.activiViewOne stopAnimating];
    [self.activiViewOne setHidesWhenStopped:YES];
    
    
    [self.activiTwo stopAnimating];
    [self.activiTwo setHidesWhenStopped:YES];
    
    
    
    [self.activiThree stopAnimating];
    [self.activiThree setHidesWhenStopped:YES];
    
    
 
    
}
-(void)startAnimation;
{
    
    [self.activiViewOne startAnimating];
    
    
    [self.activiTwo startAnimating];
    
    
    [self.activiThree startAnimating];
    
    
    [self.dataOneBtn setTitle:@"" forState:UIControlStateNormal];
    
    
    [self.dataTwoBtn setTitle:@"" forState:UIControlStateNormal];
    
    
    
    [self.dataThreeBtn setTitle:@"" forState:UIControlStateNormal];
    
//    [self.dataFourBtn setTitle:@"" forState:UIControlStateNormal];
    
    
}
- (IBAction)againAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(AgainV:)]) {
        [self.delegate AgainV:self];
    }
    
    
}
@end
