//
//  EPluseWeightView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "EPluseWeightView.h"
@interface EPluseWeightView ()

@property (weak, nonatomic) IBOutlet UILabel *oneLab;

@property (weak, nonatomic) IBOutlet UILabel *TwoLab;
@property (weak, nonatomic) IBOutlet UILabel *ThreeDataLab;

@end
@implementation EPluseWeightView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, self.backView.frame.size.height) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3, 3)];
//    maskLayer.frame = corPath.bounds;
//    maskLayer.path=corPath.CGPath;
//    self.backView.layer.mask=maskLayer;
    
}
-(void)setPhysicalMod:(NSArray *)PhysicalMod
{
    _PhysicalMod = PhysicalMod;
     Dateformat *dateFor = [[Dateformat alloc] init];
    for ( PhysicalList *model in PhysicalMod) {
      
//        if ([model.PhysicalItemIdentifier isEqualToString:@"WG"]){
//            Dateformat *dateFor = [[Dateformat alloc] init];
//
//            [self.testTimeBtn  setTitle:[NSString stringWithFormat:@"上次测量：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy-MM-dd HH:mm"]] forState:UIControlStateNormal] ;
//
//            self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
//            self.dataLab.text = model.TypeParameter?(model.TypeParameter):@"-";
//
////     [format DateFormatWithDate:model.TestTime withFormat:@"yyyy/MM/dd" ]
//
//            self.conditionLab.textColor = self.dataLab.textColor =  [UIColor getColor:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]];
//
//            self.conditionLab.hidden = (model.ExceptionFlag == 1)?(YES):((model.ParameterName)?(YES):(NO));
//        }
        
        if (([model.PhysicalItemIdentifier containsString:@"BP_"]||[model.PhysicalItemIdentifier isEqualToString:@"ECG"]||[model.PhysicalItemIdentifier isEqualToString:@"RHR"]))//PhysicalItemName
        {//
            NSString *name =  [self nameTitleLabWithPhysicalItemIdentifier:model.PhysicalItemIdentifier];
            
            [self.testTimeBtn setTitle:[NSString stringWithFormat:@"测量时间：\n%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy/MM/dd HH:mm"]] forState:UIControlStateNormal];
            if ([self.oneLab.text containsString:name]) {
                [self getOneLine:model centerX:0];
                
            }
            else if ([self.TwoLab.text containsString:name]) {
                [self getTwoLine:model centerX:0];
            }
            else if ([self.ThreeDataLab.text containsString:name]) {
                [self getThreeLine:model centerX:0];
            }
            continue;
        }

        
    }
   
//    if ( [UIColor isTheSameColor2:self.conditionLabTwo.textColor anotherColor:[UIColor getColor:@"FF7510"]] &&[UIColor isTheSameColor2:self.conditionLab.textColor anotherColor:[UIColor getColor:@"FF7510"]] &&[UIColor isTheSameColor2:self.conditionLabThree.textColor anotherColor:[UIColor getColor:@"FF7510"]] ) {
//        [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_low_timebackground"] forState:UIControlStateNormal];
//       [self.testTimeBtn setTitleColor:[UIColor getColor:@"FF6C00"] forState:UIControlStateNormal];
//    }
//    else  if ( [UIColor isTheSameColor2:self.conditionLabTwo.textColor anotherColor:[UIColor getColor:@"FD4A65"]] &&[UIColor isTheSameColor2:self.conditionLab.textColor anotherColor:[UIColor getColor:@"FD4A65"]] &&[UIColor isTheSameColor2:self.conditionLabThree.textColor anotherColor:[UIColor getColor:@"FD4A65"]] ) {
//        [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_high_timebackground"] forState:UIControlStateNormal];
//         [self.testTimeBtn setTitleColor:[UIColor getColor:@"FD4A65"] forState:UIControlStateNormal];
//    }else
//    {
//        [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_timebackground"] forState:UIControlStateNormal];
//           [self.testTimeBtn setTitleColor:[UIColor getColor:@"16AA9F"] forState:UIControlStateNormal];
//        
//    }
}
-(NSString *)getStatus:(NSInteger)status{
    if (status == 1) {
        
        
        return @"FFD0D7";
    }else if (status == 2)
    {
        
        return @"FFD0D7";
    }
    else  if (status == 3)
    {
        return @"FFD0D7";
    }
    else
    {
        
        return @"BCFFEE";
    }
}
-(void)getThreeLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.conditionLabThree.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.conditionLabThree.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
       self.conditionLabThree.textColor =  self.dataLabThree.textColor =   self.ThreeDataLab.textColor = [UIColor getColor:@"FF7510"];
       self.ThreeDataLab.backgroundColor = [UIColor getColor:@"FFE4D1"];
       self.backViewThree.backgroundColor = [UIColor getColor:@"FFF9F3"];
      
        
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
        self.ThreeDataLab.backgroundColor = [UIColor getColor:@"FFD0D7"];
       self.conditionLabThree.textColor =   self.dataLabThree.textColor =  self.ThreeDataLab.textColor  = [UIColor getColor:@"FD4A65"];//
      self.backViewThree.backgroundColor = [UIColor getColor:@"FFF2F4"];
    }else{
       self.backViewThree.backgroundColor = [UIColor getColor:@"F5FFFE"];
        self.conditionLabThree.textColor =  self.dataLabThree.textColor =   self.ThreeDataLab.textColor = [UIColor getColor:@"0DA99D"];//
        self.ThreeDataLab.backgroundColor = [UIColor getColor:@"BCFFEE"];
    }
    
//    self.dataLabThree.text = [NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits];
 [self.dataLabThree setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits]  withBigImpactFont:30 withNeedchangeText:model.PhysicalItemUnits withSmallImpactFont:10 dainmaicColor:self.dataLabThree.textColor excisionColor:self.dataLabThree.textColor] ];
}
-(void)getTwoLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.conditionLabTwo.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.conditionLabTwo.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
        self.backViewTwo.backgroundColor = [UIColor getColor:@"FFF9F3"];

         self.conditionLabTwo.textColor = self.dataLabTwo.textColor =   self.TwoLab.textColor = [UIColor getColor:@"FF7510"];
          self.TwoLab.backgroundColor = [UIColor getColor:@"FFE4D1"];
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
         self.TwoLab.backgroundColor = [UIColor getColor:@"FFD0D7"];
        self.conditionLabTwo.textColor = self.dataLabTwo.textColor =   self.TwoLab.textColor = [UIColor getColor:@"FD4A65"];//
         self.backViewTwo.backgroundColor = [UIColor getColor:@"FFF2F4"];
    }else{
        self.conditionLabTwo.textColor =  self.dataLabTwo.textColor =   self.TwoLab.textColor = [UIColor getColor:@"0DA99D"];//
        self.TwoLab.backgroundColor = [UIColor getColor:@"BCFFEE"];
           self.backViewTwo.backgroundColor = [UIColor getColor:@"F5FFFE"];
       
    }
//   self.dataLabTwo.text = [NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits];
     [self.dataLabTwo setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits]  withBigImpactFont:30 withNeedchangeText:model.PhysicalItemUnits withSmallImpactFont:10 dainmaicColor:self.dataLabTwo.textColor excisionColor:self.dataLabTwo.textColor] ];
   
}
-(void)getOneLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.conditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    //            bubble_jiance_normal bubble_jiance_high
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
       self.conditionLab.textColor =   self.dataLab.textColor =   self.oneLab.textColor = [UIColor getColor:@"FF7510"];
         self.oneLab.backgroundColor =  [UIColor getColor:@"FFE4D1"];
        [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_low_timebackground"] forState:UIControlStateNormal];
        
        self.backView.backgroundColor = [UIColor getColor:@"FFF9F3"];
        
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
      self.conditionLab.textColor =  self.dataLab.textColor =   self.oneLab.textColor = [UIColor getColor:@"FD4A65"];
       self.oneLab.backgroundColor = [UIColor getColor:@"FFD0D7"];
          [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_high_timebackground"] forState:UIControlStateNormal];
        
          self.backView.backgroundColor = [UIColor getColor:@"FFF2F4"];
    }else{
        
          self.backView.backgroundColor = [UIColor getColor:@"F5FFFE"];
        
       self.conditionLab.textColor =  self.dataLab.textColor =   self.oneLab.textColor = [UIColor getColor:@"0DA99D"];//
       self.oneLab.backgroundColor = [UIColor getColor:@"BCFFEE"];
        [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_timebackground"] forState:UIControlStateNormal];
    }
    
    
//  self.dataLab.text = [NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits];
  
     [self.dataLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits]  withBigImpactFont:30 withNeedchangeText:model.PhysicalItemUnits withSmallImpactFont:10 dainmaicColor:self.dataLab.textColor excisionColor:self.dataLab.textColor] ];
}
-(NSInteger)getColorStr:(NSString *)typeValue minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue ExceptionFlag:(NSInteger)ExceptionFlag;
{
//    if (ExceptionFlag == 0) {
//        if ([typeValue floatValue] < minValue) {
//
//
//            return @"FFD0D7";
//        }else  if ([typeValue floatValue]> maxValue)
//        {
//
//            return @"FFD0D7";
//        }
//        else
//            return @"FFD0D7";
//    }else
//    {
//        return @"BCFFEE";
//
//    }
    if (ExceptionFlag == 0) {// 1  2 3 4
        if ([typeValue floatValue] < minValue) {
            
            
            return 1;//@"FFD36D";  di
        }else  if ([typeValue floatValue]> maxValue)
        {
            
            return 2;//@"FF4564"; gao
        }
        else
            return 3;//@"B3BBC4"; weijiance
    }else
    {
        return 4;//@"07DD8F";  zhengchang
        
    }
}
-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
    if ([PhysicalItemIdentifier isEqualToString:@"WG"]) {
        nameStr = [NSString stringWithFormat:@"体重"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BP_002"]||[PhysicalItemIdentifier isEqualToString:@"LBP_002"]) {
        nameStr = [NSString stringWithFormat:@"收缩压"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BP_001"]||[PhysicalItemIdentifier isEqualToString:@"LBP_001"]) {
        nameStr = [NSString stringWithFormat:@"舒张压"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"RHR"]||[PhysicalItemIdentifier isEqualToString:@"ECG_001"]) {
        nameStr = [NSString stringWithFormat:@"脉率"];
    }
    return nameStr;
}
- (IBAction)GotestAction:(id)sender {
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(EPluseWeightViewBloodPressurebuttonClick)]) {
        [self.delegate EPluseWeightViewBloodPressurebuttonClick];
    }
}
@end