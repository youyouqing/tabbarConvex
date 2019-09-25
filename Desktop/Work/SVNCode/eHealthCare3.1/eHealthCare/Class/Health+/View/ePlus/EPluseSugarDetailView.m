//
//  EPluseSugarDetailView.m
//  eHealthCare
//
//  Created by John shi on 2019/3/1.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import "EPluseSugarDetailView.h"
@interface EPluseSugarDetailView ()

@property (weak, nonatomic) IBOutlet UILabel *oneLab;

@property (weak, nonatomic) IBOutlet UILabel *TwoLab;
@property (weak, nonatomic) IBOutlet UILabel *ThreeDataLab;
@property (weak, nonatomic) IBOutlet UIView *noDataViewone;
@property (weak, nonatomic) IBOutlet UIView *noDataTwo;
@property (weak, nonatomic) IBOutlet UIView *noDataThree;

@end
@implementation EPluseSugarDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
//      [self.dataLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withBigImpactFont:12 withNeedchangeText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withSmallImpactFont:12 dainmaicColor:[UIColor getColor:@"B9C4D6"] excisionColor:[UIColor getColor:@"B9C4D6"]] ];
//        [self.dataLabThree setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withBigImpactFont:12 withNeedchangeText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withSmallImpactFont:12 dainmaicColor:[UIColor getColor:@"B9C4D6"] excisionColor:[UIColor getColor:@"B9C4D6"]] ];
//      [self.dataLabTwo setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withBigImpactFont:12 withNeedchangeText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withSmallImpactFont:12 dainmaicColor:[UIColor getColor:@"B9C4D6"] excisionColor:[UIColor getColor:@"B9C4D6"]] ];
    
    
    
}
-(void)setPhysicalMod:(NSArray *)PhysicalMod
{
    _PhysicalMod = PhysicalMod;
   
    for ( PhysicalList *model in PhysicalMod) {
        
       if ( [model.PhysicalItemIdentifier containsString:@"BG_"]) //PhysicalItemName
        {//
            NSString *name =  [self nameTitleLabWithPhysicalItemIdentifier:model.PhysicalItemIdentifier];
            
        
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
//         [self.testThreeTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_low_timebackground"] forState:UIControlStateNormal];
        self.conditionLabThree.textColor =   self.dataLabThree.textColor =   self.ThreeDataLab.textColor = [UIColor getColor:@"FF7510"];//
        self.ThreeDataLab.backgroundColor = [UIColor getColor:@"FFE4D1"];
          self.backViewThree.backgroundColor = [UIColor getColor:@"FFF9F3"];
//        [self.testThreeTimeBtn setTitleColor:[UIColor getColor:@"FF6C00"]  forState:UIControlStateNormal];

    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
        self.ThreeDataLab.backgroundColor = [UIColor getColor:@"FFD0D7"];
        self.conditionLabThree.textColor =   self.dataLabThree.textColor =   self.ThreeDataLab.textColor = [UIColor getColor:@"FD4A65"];//
          self.backViewThree.backgroundColor = [UIColor getColor:@"FFF2F4"];
//         [self.testThreeTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_high_timebackground"] forState:UIControlStateNormal];
//          [self.testThreeTimeBtn setTitleColor:[UIColor getColor:@"FD4A65"]  forState:UIControlStateNormal];
    }else{
           self.backViewThree.backgroundColor = [UIColor getColor:@"F5FFFE"];
       self.conditionLabThree.textColor =    self.dataLabThree.textColor =   self.ThreeDataLab.textColor = [UIColor getColor:@"47A9D6"];//
        self.ThreeDataLab.backgroundColor = [UIColor getColor:@"C0EBFF"];
//         [self.testThreeTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_background"] forState:UIControlStateNormal];
//        [self.testThreeTimeBtn setTitleColor:[UIColor getColor:@"119AAB"]  forState:UIControlStateNormal];

    }
     Dateformat *dateFor = [[Dateformat alloc] init];
    [self.testThreeTimeBtn setTitle:[NSString stringWithFormat:@"测量时间：\n%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy/MM/dd HH:mm"]] forState:UIControlStateNormal];
    if (model.TypeParameter.length>0) {
        self.noDataThree.hidden = YES;
          [self.dataLabThree setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits]  withBigImpactFont:30 withNeedchangeText:model.PhysicalItemUnits withSmallImpactFont:10 dainmaicColor:self.dataLabThree.textColor excisionColor:self.dataLabThree.textColor] ];
    }
  else
      self.noDataThree.hidden = NO;
//
//        [self.dataLabThree setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withBigImpactFont:14 withNeedchangeText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withSmallImpactFont:14 dainmaicColor:[UIColor getColor:@"B9C4D6"] excisionColor:[UIColor getColor:@"B9C4D6"]] ];
    
    
}
-(void)getTwoLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.conditionLabTwo.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.conditionLabTwo.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
//         [self.testTwoTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_low_timebackground"] forState:UIControlStateNormal];
        self.backViewTwo.backgroundColor = [UIColor getColor:@"FFF9F3"];
        self.conditionLabTwo.textColor =   self.dataLabTwo.textColor =   self.TwoLab.textColor = [UIColor getColor:@"FF7510"];//
        self.TwoLab.backgroundColor = [UIColor getColor:@"FFE4D1"];
//         [self.testTwoTimeBtn setTitleColor:[UIColor getColor:@"FF6C00"]  forState:UIControlStateNormal];
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
           self.TwoLab.backgroundColor = [UIColor getColor:@"FFD0D7"];
           self.conditionLabTwo.textColor =    self.dataLabTwo.textColor =   self.TwoLab.textColor = [UIColor getColor:@"FD4A65"];//
           self.backViewTwo.backgroundColor = [UIColor getColor:@"FFF2F4"];
//          [self.testTwoTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_high_timebackground"] forState:UIControlStateNormal];
//         [self.testTwoTimeBtn setTitleColor:[UIColor getColor:@"FD4A65"]  forState:UIControlStateNormal];
    }else{
       self.conditionLabTwo.textColor =  self.dataLabTwo.textColor =   self.TwoLab.textColor = [UIColor getColor:@"47A9D6"];//
        self.TwoLab.backgroundColor = [UIColor getColor:@"C0EBFF"];
          self.backViewTwo.backgroundColor = [UIColor getColor:@"F5FFFE"];
//        [self.testTwoTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_background"] forState:UIControlStateNormal];
//        [self.testTwoTimeBtn setTitleColor:[UIColor getColor:@"119AAB"]  forState:UIControlStateNormal];

    }
    Dateformat *dateFor = [[Dateformat alloc] init];
    [self.testTwoTimeBtn setTitle:[NSString stringWithFormat:@"测量时间：\n%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy/MM/dd HH:mm"]] forState:UIControlStateNormal];
      if (model.TypeParameter.length>0) {
         [self.dataLabTwo setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits]  withBigImpactFont:30 withNeedchangeText:model.PhysicalItemUnits withSmallImpactFont:10 dainmaicColor:self.dataLabTwo.textColor excisionColor:self.dataLabTwo.textColor] ];
         self.noDataTwo.hidden = YES;
        }
        else
              self.noDataTwo.hidden = NO;
//        [self.dataLabTwo setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withBigImpactFont:14 withNeedchangeText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withSmallImpactFont:14 dainmaicColor:[UIColor getColor:@"B9C4D6"] excisionColor:[UIColor getColor:@"B9C4D6"]] ];
}
-(void)getOneLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.conditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    //            bubble_jiance_normal bubble_jiance_high
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
    self.conditionLab.textColor =    self.dataLab.textColor =   self.oneLab.textColor = [UIColor getColor:@"FF7510"];
        self.oneLab.backgroundColor = [UIColor getColor:@"FFE4D1"];
          self.backView.backgroundColor = [UIColor getColor:@"FFF9F3"];
//         [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_low_timebackground"] forState:UIControlStateNormal];
//         [self.testTimeBtn setTitleColor:[UIColor getColor:@"FF6C00"]  forState:UIControlStateNormal];
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
      self.conditionLab.textColor =   self.dataLab.textColor =   self.oneLab.textColor = [UIColor getColor:@"FD4A65"];
        self.oneLab.backgroundColor = [UIColor getColor:@"FFD0D7"];  //0DA99D
         self.backView.backgroundColor = [UIColor getColor:@"FFF2F4"];
//         [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_high_timebackground"] forState:UIControlStateNormal];
//         [self.testTimeBtn setTitleColor:[UIColor getColor:@"FD4A65"]  forState:UIControlStateNormal];
    }else{
          self.backView.backgroundColor = [UIColor getColor:@"F5FFFE"];
       self.conditionLab.textColor =  self.dataLab.textColor =   self.oneLab.textColor = [UIColor getColor:@"47A9D6"];//
        self.oneLab.backgroundColor = [UIColor getColor:@"C0EBFF"];
//        [self.testTimeBtn setBackgroundImage:[UIImage imageNamed:@"iv_xuetang_background"] forState:UIControlStateNormal];
//         [self.testTimeBtn setTitleColor:[UIColor getColor:@"119AAB"]  forState:UIControlStateNormal];
    }
    Dateformat *dateFor = [[Dateformat alloc] init];
    [self.testTimeBtn setTitle:[NSString stringWithFormat:@"测量时间：\n%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy/MM/dd HH:mm"]] forState:UIControlStateNormal];
      if (model.TypeParameter.length>0) {
          self.noDataViewone.hidden = YES;

       [self.dataLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ %@",model.TypeParameter,model.PhysicalItemUnits]  withBigImpactFont:30 withNeedchangeText:model.PhysicalItemUnits withSmallImpactFont:10 dainmaicColor:self.dataLab.textColor excisionColor:self.dataLab.textColor] ];
    }
    else
         self.noDataViewone.hidden = NO;
//    [self.dataLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withBigImpactFont:14 withNeedchangeText:[NSString stringWithFormat:@"%@",@"暂无数据，请测量"]  withSmallImpactFont:14 dainmaicColor:[UIColor getColor:@"B9C4D6"] excisionColor:[UIColor getColor:@"B9C4D6"]] ];
    
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
    if ([PhysicalItemIdentifier isEqualToString:@"BG_001"]) {
        nameStr = [NSString stringWithFormat:@"餐后两小时"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BG_002"]) {
        nameStr = [NSString stringWithFormat:@"空腹血糖"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BG_003"]) {
        nameStr = [NSString stringWithFormat:@"随机血糖"];
    }
    return nameStr;
}
- (IBAction)testEmptySugarAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(EPluseSugarDetailViewbuttonClick:)]) {
        [self.delegate EPluseSugarDetailViewbuttonClick:1];
    }
}
- (IBAction)testAfterMealAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(EPluseSugarDetailViewbuttonClick:)]) {
        [self.delegate EPluseSugarDetailViewbuttonClick:2];
    }
}
- (IBAction)testSugarAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(EPluseSugarDetailViewbuttonClick:)]) {
        [self.delegate EPluseSugarDetailViewbuttonClick:3];
    }
}

@end
