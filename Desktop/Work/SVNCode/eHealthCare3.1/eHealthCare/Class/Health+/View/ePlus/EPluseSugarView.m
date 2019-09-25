//
//  EPluseSugarView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "EPluseSugarView.h"

@interface EPluseSugarView ()

@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoDataLab;
@property (weak, nonatomic) IBOutlet UILabel *threeDataLab;

@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *twoConditionLab;
@property (weak, nonatomic) IBOutlet UILabel *threeConditionLab;


@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoTbn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;

@property (weak, nonatomic) IBOutlet UILabel *testTimeLab;


@property (weak, nonatomic) IBOutlet UILabel *middleOneLab;
@property (weak, nonatomic) IBOutlet UILabel *middleTwoLab;
@property (weak, nonatomic) IBOutlet UILabel *middleThreeLab;
@property (weak, nonatomic) IBOutlet UILabel *middleFourLab;
@property (weak, nonatomic) IBOutlet UILabel *middleFiveLab;
@property (weak, nonatomic) IBOutlet UILabel *middleSixLab;

@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *detailTwoLab;
@property (weak, nonatomic) IBOutlet UILabel *detailThreeLab;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTTrailCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTrailCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnThreeTrailCons;

@property (nonatomic,strong)CAShapeLayer *drawLayer;
@property (nonatomic,strong)CAShapeLayer *drawLayer2;
@property (nonatomic,strong)CAShapeLayer *drawLayer3;
@property (nonatomic,strong)UIBezierPath *path;
@property (nonatomic,strong)UIBezierPath *path3;

@property (nonatomic,strong)UIBezierPath *path2;
@end


@implementation EPluseSugarView

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
    
    self.trajecView.layer.borderColor = [UIColor getColor:@"DAE4EB"].CGColor;
    self.trajecView.layer.borderWidth = .5f;
    self.trajecView.layer.cornerRadius = 6;
    self.trajecView.layer.masksToBounds = YES;
    
    
    self.trajecViewTwo.layer.borderColor = [UIColor getColor:@"DAE4EB"].CGColor;
    self.trajecViewTwo.layer.borderWidth = .5f;
    self.trajecViewTwo.layer.cornerRadius = 6;
    self.trajecViewTwo.layer.masksToBounds = YES;
    
    self.trajecViewThree.layer.borderColor = [UIColor getColor:@"DAE4EB"].CGColor;
    self.trajecViewThree.layer.borderWidth = .5f;
    self.trajecViewThree.layer.cornerRadius = 6;
    self.trajecViewTwo.layer.masksToBounds = YES;
    
    self.smTrajectView.layer.cornerRadius = 4;
    self.smTrajectView.layer.masksToBounds = YES;
    self.smTrajectViewTwo.layer.cornerRadius = 4;
    self.smTrajectViewTwo.layer.masksToBounds = YES;
    self.smTrajectViewThree.layer.cornerRadius = 4;
    self.smTrajectViewThree.layer.masksToBounds = YES;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, self.backView.frame.size.height) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3, 3)];
    maskLayer.frame = corPath.bounds;
    maskLayer.path=corPath.CGPath;
    self.backView.layer.mask=maskLayer;
    if (IS_IPHONE5||IS_IPHONE4S) {
        self.trajectViewWidth.constant = self.trajectViewTwoWidth.constant = self.trajectViewThreeWidth.constant =  KWidth(142);
        
    }else
    {
        self.trajectViewWidth.constant = self.trajectViewTwoWidth.constant = self.trajectViewThreeWidth.constant =  KWidth(152);
    }
    self.smTranLabCenterX.constant = self.smTranThreeLabCenterX.constant = self.smTranFiveLabCenterX.constant =self.trajectViewWidth.constant/3.0-10;
    
    self.smTranSixLabCenterX.constant =  self.smTranFourLabCenterX.constant = self.smTranTwoLabCenterX.constant =-(self.trajectViewWidth.constant/3.0)+10;
    
    [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    
}
-(NSInteger)getColorStr:(NSString *)typeValue minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue ExceptionFlag:(NSInteger)ExceptionFlag;
{
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
-(NSString *)getStatus:(NSInteger)status{
    if (status == 1) {
        
        
        return @"FFD36D";
    }else if (status == 2)
    {
        
        return @"FF4564";
    }
    else  if (status == 3)
    {
        return @"B3BBC4";
    }
    else
    {
        
        return @"07DD8F";
    }
}
-(void)setPhysicalMod:(NSArray *)PhysicalMod
{
    _PhysicalMod = PhysicalMod;
    Dateformat *dateFor = [[Dateformat alloc] init];
    CGFloat centerX = 0;
    self.threeConditionLab.text = self.twoConditionLab.text = self.conditionLab.text = @"未检测";
        if ((self.isSugar == YES)) {
            self.oneLab.text = @"空腹血糖:";
            self.twoDataLab.text = @"餐后2小时血糖:";
            self.threeDataLab.text = @"随机血糖:";
            self.middleOneLab.text = @"3.9";
            self.middleTwoLab.text = @"6.1";
            self.middleThreeLab.text = @"3.9";
            self.middleFourLab.text = @"7.8";
            self.middleFiveLab.text = @"3.9";
            self.middleSixLab.text = @"11.0";
            self.detailLab.hidden = self.detailTwoLab.hidden = self.detailThreeLab.hidden = YES;

             for ( PhysicalList *model in PhysicalMod) {
                 if ( [model.PhysicalItemIdentifier containsString:@"BG_"]) {

                     //             [self.oneBtn setTitle:model.TypeParameter forState:UIControlStateNormal];
                     //            self.conditionLab.text = self.twoConditionLab.text = self.threeConditionLab.text = @"";
                     if (self.drawLayer) {
                         [self.drawLayer removeFromSuperlayer];
                     }
                     if (self.drawLayer2) {
                         [self.drawLayer2 removeFromSuperlayer];
                     }
                     if (self.drawLayer3) {
                         [self.drawLayer3 removeFromSuperlayer];
                     }
                     self.testTimeLab.text =[NSString stringWithFormat:@"上次测量：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy-MM-dd HH:mm"]];
                     NSString *name =  [self nameBGTitleLabWithPhysicalItemIdentifier:model.PhysicalItemIdentifier];
                     if ([self.oneLab.text containsString:name]) {
                         [self getOneLine:model centerX:centerX];
                     }
                     else if ([self.twoDataLab.text containsString:name]) {
                         [self getTwoLine:model centerX:centerX];
                     }
                     else if ([self.threeDataLab.text containsString:name]) {
                         [self getThreeLine:model centerX:centerX];
                     }
                     continue;
                 }
             }
            
        }else
        {
            self.oneLab.text = @"收缩压:";
            self.twoDataLab.text = @"舒张压:";
            self.threeDataLab.text = @"脉率:";
            self.middleOneLab.text = @"90";
            self.middleTwoLab.text = @"139";
            self.middleThreeLab.text = @"60";
            self.middleFourLab.text = @"89";
            self.middleFiveLab.text = @"60";
            self.middleSixLab.text = @"100";
            self.detailLab.hidden = self.detailTwoLab.hidden = self.detailThreeLab.hidden = NO;

            for ( PhysicalList *model in PhysicalMod) {
            if (([model.PhysicalItemIdentifier containsString:@"BP_"]||[model.PhysicalItemIdentifier isEqualToString:@"ECG"]||[model.PhysicalItemIdentifier isEqualToString:@"RHR"]))//PhysicalItemName
            {//
            NSString *name =  [self nameTitleLabWithPhysicalItemIdentifier:model.PhysicalItemIdentifier];

            self.testTimeLab.text = [NSString stringWithFormat:@"上次测量：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy-MM-dd HH:mm"]];
            if ([self.oneLab.text containsString:name]) {
                [self getOneLine:model centerX:centerX];
                
            }
            else if ([self.twoDataLab.text containsString:name]) {
                [self getTwoLine:model centerX:centerX];
            }
            else if ([self.threeDataLab.text containsString:name]) {
                [self getThreeLine:model centerX:centerX];
            }
            continue;
        }
        }
    }
}
-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
    if ([PhysicalItemIdentifier isEqualToString:@"BP_002"]||[PhysicalItemIdentifier isEqualToString:@"LBP_002"]) {
        nameStr = [NSString stringWithFormat:@"收缩压"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BP_001"]||[PhysicalItemIdentifier isEqualToString:@"LBP_001"]) {
        nameStr = [NSString stringWithFormat:@"舒张压"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"RHR"]||[PhysicalItemIdentifier isEqualToString:@"ECG_001"]) {
        nameStr = [NSString stringWithFormat:@"脉率"];
    }
    //    if ([PhysicalItemIdentifier isEqualToString:@"BO"]) {
    //        nameStr = [NSString stringWithFormat:@"血氧"];
    //    }
    //    if ([PhysicalItemIdentifier isEqualToString:@"HG"]) {
    //        nameStr = [NSString stringWithFormat:@"身高"];
    //    }
    
    return nameStr;
}
-(NSString *)nameBGTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
    if ([PhysicalItemIdentifier isEqualToString:@"BG_001"]) {
        nameStr = [NSString stringWithFormat:@"餐后2小时血糖"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BG_002"]) {
        nameStr = [NSString stringWithFormat:@"空腹血糖"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BG_003"]) {
        nameStr = [NSString stringWithFormat:@"随机血糖"];
    }
    return nameStr;
}
-(void)getThreeLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.threeConditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.threeConditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
        [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
        centerX =  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue])/( [self.middleFiveLab.text floatValue]);
        
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
         centerX =  (self.trajectViewWidth.constant/3.0*2)+  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue])-[self.middleSixLab.text floatValue]/([self.middleSixLab.text floatValue]- [self.middleFiveLab.text floatValue]);
      
        [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
    }else{
         centerX =   (self.trajectViewWidth.constant/3.0)+ (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue]- [self.middleFiveLab.text floatValue])/([self.middleSixLab.text floatValue]- [self.middleFiveLab.text floatValue]);
        [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
    }
    [self.threeBtn setTitle:model.TypeParameter forState:UIControlStateNormal];
    
    if (self.drawLayer3) {
        [self.drawLayer3 removeFromSuperlayer];
    }
    self.path3 =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
    
    self.drawLayer3=[CAShapeLayer layer];
    
    self.drawLayer3.frame=CGRectMake(0, 0, centerX,8);
    
    self.drawLayer3.fillColor = [ self.threeConditionLab.textColor CGColor];
    
    self.drawLayer3.path= self.path3.CGPath;
    if (centerX>=self.trajectViewWidth.constant) {
        self.btnThreeTrailCons.constant = self.trajectViewWidth.constant-23;
    }else
    self.btnThreeTrailCons.constant = centerX- 23;;
    [self.smTrajectViewThree.layer addSublayer:self.drawLayer3];
}
-(void)getTwoLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.twoConditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.twoConditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
        
        centerX =  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue])/( [self.middleThreeLab.text floatValue]);
        [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
        [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
          centerX =  (self.trajectViewWidth.constant/3.0*2)+  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue]-[self.middleFourLab.text floatValue])/([self.middleFourLab.text floatValue]- [self.middleThreeLab.text floatValue]);
      
        
    }else{
        centerX =   (self.trajectViewWidth.constant/3.0)+ (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue]- [self.middleThreeLab.text floatValue])/([self.middleFourLab.text floatValue]- [self.middleThreeLab.text floatValue]);
        
        [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
    }
    [self.twoTbn setTitle:model.TypeParameter forState:UIControlStateNormal];
    
    if (self.drawLayer2) {
        [self.drawLayer2 removeFromSuperlayer];
    }
    self.path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
    
    self.drawLayer2=[CAShapeLayer layer];
    
    self.drawLayer2.frame=CGRectMake(0, 0, centerX,8);
    
    self.drawLayer2.fillColor = [self.twoConditionLab.textColor CGColor];
    
    self.drawLayer2.path=self.path2.CGPath;
    if (centerX>=self.trajectViewWidth.constant) {
        self.btnTrailCons.constant = self.trajectViewWidth.constant-23;
    }else
    self.btnTrailCons.constant= centerX- 23;;
    [self.smTrajectViewTwo.layer addSublayer:self.drawLayer2];
}
-(void)getOneLine:(PhysicalList *)model centerX:(CGFloat)centerX{
    
    self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
    self.conditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
    //            bubble_jiance_normal bubble_jiance_high
    if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
        [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
        
        centerX =  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue])/( [self.middleOneLab.text floatValue]);
    }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
        [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
         centerX = (self.trajectViewWidth.constant/3.0*2)+ (self.trajectViewWidth.constant/3.0)*( [model.TypeParameter floatValue]-[self.middleTwoLab.text floatValue])/([self.middleTwoLab.text floatValue]- [self.middleOneLab.text floatValue]);
      
    }else{
        
        [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
          centerX = (self.trajectViewWidth.constant/3.0)+ (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue]- [self.middleOneLab.text floatValue])/([self.middleTwoLab.text floatValue]- [self.middleOneLab.text floatValue]);
       
    }
    
    
    [self.oneBtn setTitle:model.TypeParameter forState:UIControlStateNormal];
    if (self.drawLayer) {
        [self.drawLayer removeFromSuperlayer];
    }
    self.path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
    
    self.drawLayer=[CAShapeLayer layer];
    
    self.drawLayer.frame=CGRectMake(0, 0, centerX,8);
    
    self.drawLayer.fillColor = [self.conditionLab.textColor CGColor];
    
    self.drawLayer.path=self.path.CGPath;
    if (centerX>=self.trajectViewWidth.constant) {
        self.btnTTrailCons.constant = self.trajectViewWidth.constant-23;
    }else
    self.btnTTrailCons.constant = centerX - 23;
    [self.smTrajectView.layer addSublayer:self.drawLayer];
    
}
@end



