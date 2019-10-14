//
//  XKSingleCheckMultipleCommonResultHeadView.m
//  PC300
//
//  Created by jamkin on 2017/8/16.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import "XKSingleCheckMultipleCommonResultHeadView.h"
#import "ExchinereportModel.h"
@interface XKSingleCheckMultipleCommonResultHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *statusImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgFour;


@end

@implementation XKSingleCheckMultipleCommonResultHeadView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.statusImgOne.image = [UIImage imageNamed:@""];
    self.statusImgTwo.image = [UIImage imageNamed:@""];
    self.statusImgThree.image = [UIImage imageNamed:@""];
     self.statusImgFour.image = [UIImage imageNamed:@""];
    
}

-(void)setExAmineArray:(NSArray *)exAmineArray
{
    _exAmineArray = exAmineArray;
    
    for (int i = 0; i<exAmineArray.count; i++) {
        
        ExchinereportModel *mod =   exAmineArray[i];
//         (BF_004：总胆固醇、BF_002：高密度脂蛋白、BF_001：低密度纸蛋白、BF_003：甘油三酯)
        if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_004"]||[mod.PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
//        if (i == 0) {
            
            self.scopeOneLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];
            
            self.nameOneLab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];
            [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataOneBtn exchineReportModel:mod  statusImg:self.statusImgOne];

         
        }
        else  if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_003"])//if (i == 1 )
        {
        
            self.scopeTwoLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];
             self.nameTwolab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];
            [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataTwoBtn exchineReportModel:mod statusImg:self.statusImgTwo];
        
        
        }
        else  if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_002"])//if ( i ==2 )
        {
        
        
            self.scopeThreeLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];
             self.nameThreeLab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];
            [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataThreeBtn exchineReportModel:mod statusImg:self.statusImgThree];
        
        }
        else  if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_001"])//if ( i ==3 )
        {
            
            
            self.scopeFourLab.text = [NSString stringWithFormat:@"%@%@",mod.ReferenceValue,mod.Unit];
            self.nameFourLab.text = [self nameTitleLabWithPhysicalItemIdentifier:mod.PhysicalItemIdentifier];
            [self becomeStatus:mod.ParameterStatus ButtonImage:self.dataFourBtn exchineReportModel:mod statusImg:self.statusImgFour];
            
        }
        
        
    }


}

-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
    if ([PhysicalItemIdentifier isEqualToString:@"BF_004"]||[PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
        nameStr = [NSString stringWithFormat:@"总胆固醇"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
        nameStr = [NSString stringWithFormat:@"高密度脂蛋白"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
        nameStr = [NSString stringWithFormat:@"低密度脂蛋白"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
        nameStr = [NSString stringWithFormat:@"甘油三酯"];
    }
        return nameStr;
}
-(void)becomeStatus:(NSInteger) ParameterStatus  ButtonImage:(UIButton *)btn exchineReportModel:(ExchinereportModel *) model   statusImg:(UIImageView *)statusImg{
    

    // 1偏高2正常3偏低
    
    if ([model.ParameterName isEqualToString:@"偏高"]) {
        statusImg.image = [UIImage imageNamed:@"result_high_q"];
//          [btn setImage:[UIImage imageNamed:@"result_high_q"] forState:UIControlStateNormal];
         [btn setTitleColor:[UIColor colorWithHexString:@"FF7342"] forState:UIControlStateNormal];
        
    }
    if ([model.ParameterName isEqualToString:@"正常"]) {
         statusImg.image = [UIImage imageNamed:@""];
//          [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if ([model.ParameterName isEqualToString:@"偏低"]) {
         statusImg.image = [UIImage imageNamed:@"result_low"];
//          [btn setImage:[UIImage imageNamed:@"result_low"] forState:UIControlStateNormal];
        
           [btn setTitleColor:[UIColor colorWithHexString:@"F3C331"] forState:UIControlStateNormal];
    }
    NSLog(@"ExchinereportModel:%@",model.ParameterName);
    
}

-(void)stopAninmayion;
{
    [self.activiViewOne stopAnimating];
    [self.activiViewOne setHidesWhenStopped:YES];
    
    
    [self.activiTwo stopAnimating];
    [self.activiTwo setHidesWhenStopped:YES];
    
    
    
    [self.activiThree stopAnimating];
    [self.activiThree setHidesWhenStopped:YES];
    
    
    [self.activiFour stopAnimating];
    [self.activiFour setHidesWhenStopped:YES];

}
-(void)startAnimation;
{

    [self.activiViewOne startAnimating];
   
    
    
    [self.activiTwo startAnimating];
 
    
    
    
    [self.activiThree startAnimating];
   
    
    
    [self.activiFour startAnimating];
    
    
    
    [self.dataOneBtn setTitle:@"" forState:UIControlStateNormal];
    
     [self.dataTwoBtn setTitle:@"" forState:UIControlStateNormal];
    
    
     [self.dataThreeBtn setTitle:@"" forState:UIControlStateNormal];
    
     [self.dataFourBtn setTitle:@"" forState:UIControlStateNormal];
  

}
- (IBAction)againAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(AgainR:)]) {
        [self.delegate AgainR:self];
    }
    
    
}
@end