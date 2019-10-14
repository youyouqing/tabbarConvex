//
//  EPluseFooterView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "EPluseFooterView.h"
@interface EPluseFooterView ()
@property (weak, nonatomic) IBOutlet UIView *trajecView;

@property (weak, nonatomic) IBOutlet UIView *trajecViewTwo;


@property (weak, nonatomic) IBOutlet UIView *trajecViewThree;

@property (weak, nonatomic) IBOutlet UIView *trajecViewFour;

@property (weak, nonatomic) IBOutlet UIView *smTrajectView;
@property (weak, nonatomic) IBOutlet UIView *smTrajectViewTwo;
@property (weak, nonatomic) IBOutlet UIView *smTrajectViewThree;
@property (weak, nonatomic) IBOutlet UIView *smTrajectViewFour;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewTwoWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewThreeWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewFoureWidth;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranLabCenterX;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranTwoLabCenterX;


@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoDataLab;
@property (weak, nonatomic) IBOutlet UILabel *threeDataLab;
@property (weak, nonatomic) IBOutlet UILabel *fourDataLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *twoConditionLab;
@property (weak, nonatomic) IBOutlet UILabel *threeConditionLab;
@property (weak, nonatomic) IBOutlet UILabel *fourCondtionLab;

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoTbn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FourBtn;
@property (weak, nonatomic) IBOutlet UILabel *testTimeLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTTrailCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTrailCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnThreeTrailCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnFourTrailCons;
@property (weak, nonatomic) IBOutlet UILabel *middleOneLab;
@property (weak, nonatomic) IBOutlet UILabel *middleTwoLab;
@property (weak, nonatomic) IBOutlet UILabel *middleThreeLab;
@property (weak, nonatomic) IBOutlet UILabel *middleFourLab;
@property (weak, nonatomic) IBOutlet UILabel *middleFiveLab;
@end
@implementation EPluseFooterView

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
    
    
    self.trajecViewFour.layer.borderColor = [UIColor getColor:@"DAE4EB"].CGColor;
    self.trajecViewFour.layer.borderWidth = .5f;
    self.trajecViewFour.layer.cornerRadius = 6;
    self.trajecViewFour.layer.masksToBounds = YES;
    
    
    self.smTrajectView.layer.cornerRadius = 4;
    self.smTrajectView.layer.masksToBounds = YES;
    self.smTrajectViewTwo.layer.cornerRadius = 4;
    self.smTrajectViewTwo.layer.masksToBounds = YES;
    self.smTrajectViewThree.layer.cornerRadius = 4;
    self.smTrajectViewThree.layer.masksToBounds = YES;
    self.smTrajectViewFour.layer.cornerRadius = 4;
    self.smTrajectViewFour.layer.masksToBounds = YES;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, self.backView.frame.size.height) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3, 3)];
    maskLayer.frame = corPath.bounds;
    maskLayer.path=corPath.CGPath;
    self.backView.layer.mask=maskLayer;
    [self.oneBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.twoTbn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.threeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.FourBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
  
    if (IS_IPHONE5) {
        self.trajectViewWidth.constant = self.trajectViewTwoWidth.constant = self.trajectViewThreeWidth.constant = self.trajectViewFoureWidth.constant = KWidth(142);
    }
    else
    {
          self.trajectViewWidth.constant = self.trajectViewTwoWidth.constant = self.trajectViewThreeWidth.constant =  self.trajectViewFoureWidth.constant =KWidth(152);
//        self.smTranLabCenterX.constant = KWidth(152)/3.0-10;
//         self.smTranTwoLabCenterX.constant =-( KWidth(152)/3.0)+10;
    }
    self.smTranLabCenterX.constant   = self.trajectViewWidth.constant/3.0-10;
    self.smTranTwoLabCenterX.constant =-(self.trajectViewWidth.constant/3.0)+10;
}
-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
  
    if ([PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
        nameStr = [NSString stringWithFormat:@"高密度脂蛋白"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
        nameStr = [NSString stringWithFormat:@"低密度脂蛋白"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
        nameStr = [NSString stringWithFormat:@"甘油三酯"];
    }
    if ([PhysicalItemIdentifier isEqualToString:@"BF_004"]||[PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
        nameStr = [NSString stringWithFormat:@"总胆固醇"];
    }
    return nameStr;
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
-(void)setPhysicalModeld:(NSArray *)PhysicalModeld
{
    _PhysicalModeld = PhysicalModeld;
//      唯一标识（TC对应体温；BP_001对应舒张压；BP_002对应收缩压，（RHR、ECG_001）对应脉率；BO对应血氧，BG_001对应餐后2小时血糖；BG_002对应空腹血糖；BG_003对应随机血糖；BF_001对应低密度脂蛋白胆固醇；BF_002对应高密度脂蛋白胆固醇；BF_003对应甘油三酯；BF_004对应总胆固醇；HG对应身高；WG对应体重）
    Dateformat *dateFor = [[Dateformat alloc] init];
    self.fourCondtionLab.text = self.threeConditionLab.text = self.twoConditionLab.text = self.conditionLab.text = @"未检测";

    for ( PhysicalList *model in PhysicalModeld) {
        NSString *name =  [self nameTitleLabWithPhysicalItemIdentifier:model.PhysicalItemIdentifier];
        if (name.length<=0) {
           continue;
        }
        self.testTimeLab.text = [NSString stringWithFormat:@"上次测量：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy-MM-dd HH:mm"]];
           CGFloat centerX = 0;
        if ([self.oneLab.text containsString:name]) {
            self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
             self.conditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
//            bubble_jiance_normal bubble_jiance_high
            if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
                 [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
                 centerX =  (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue])/( [self.middleOneLab.text floatValue]);
             
            }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
                 centerX =  (self.trajectViewWidth.constant/2.0)+ (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue]-[self.middleOneLab.text floatValue])/( [self.middleOneLab.text floatValue]);
                 [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
            }else{
                 centerX =    (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue])/( [self.middleOneLab.text floatValue]);
                 [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
            }


           
//            self.btnTTrailCons.constant = -(self.trajectViewWidth.constant)+centerX-23;
            UIBezierPath *path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
            
            CAShapeLayer *layer2=[CAShapeLayer layer];
            
            layer2.frame=CGRectMake(0, 0, centerX,8);
            
            layer2.fillColor = [self.conditionLab.textColor CGColor];
            
            layer2.path=path2.CGPath;
            
            [self.smTrajectView.layer addSublayer:layer2];
            if (centerX>=self.trajectViewWidth.constant) {
                self.btnTTrailCons.constant = self.trajectViewWidth.constant-23;
            }else
            self.btnTTrailCons.constant = centerX- 23;;
            [self.oneBtn setTitle:model.TypeParameter forState:UIControlStateNormal];
            
        }
        if ([self.twoDataLab.text containsString:name]) {
              self.twoConditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
           self.twoConditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
            if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
                
                centerX =  (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue])/( [self.middleTwoLab.text floatValue]);
                [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
            }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
                [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
                
                centerX =   (self.trajectViewWidth.constant/2.0)+ (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue]- [self.middleTwoLab.text floatValue])/( [self.middleTwoLab.text floatValue]);
            }else{
                
                centerX =    (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue])/( [self.middleTwoLab.text floatValue]);
                [self.twoTbn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
            }
              [self.twoTbn setTitle:model.TypeParameter forState:UIControlStateNormal];
            
            
            if (centerX>=self.trajectViewWidth.constant) {
                self.btnTrailCons.constant = self.trajectViewWidth.constant-23;
            }else
            self.btnTrailCons.constant =centerX-23;
            UIBezierPath *path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
            
            CAShapeLayer *layer2=[CAShapeLayer layer];
            
            layer2.frame=CGRectMake(0, 0, centerX,8);
            
            layer2.fillColor = [self.twoConditionLab.textColor CGColor];
            
            layer2.path=path2.CGPath;
            
            [self.smTrajectViewTwo.layer addSublayer:layer2];
        }
        if ([self.threeDataLab.text containsString:name]) {
              self.threeConditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
             self.threeConditionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
            if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
                [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
                
                centerX =  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue])/( [self.middleThreeLab.text floatValue]);
//                self.btnThreeTrailCons.constant = -(self.trajectViewWidth.constant)+centerX-23;
            }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
                [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
                 centerX =  (self.trajectViewWidth.constant/3.0*2)+  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue]-[self.middleFourLab.text floatValue])/([self.middleFourLab.text floatValue]- [self.middleThreeLab.text floatValue]);
              
//                self.btnThreeTrailCons.constant = -(self.trajectViewWidth.constant)+centerX-23;
            }else{
                   centerX =  (self.trajectViewWidth.constant/3.0)+  (self.trajectViewWidth.constant/3.0)*([model.TypeParameter floatValue]- [self.middleThreeLab.text floatValue])/([self.middleFourLab.text floatValue]- [self.middleThreeLab.text floatValue]);
//                self.btnThreeTrailCons.constant = -(self.trajectViewWidth.constant)+centerX-23;
                [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
            }
               [self.threeBtn setTitle:model.TypeParameter forState:UIControlStateNormal];
            
            UIBezierPath *path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
            
            CAShapeLayer *layer2=[CAShapeLayer layer];
            
            layer2.frame=CGRectMake(0, 0, centerX,8);
            
            layer2.fillColor = [ self.threeConditionLab.textColor CGColor];
            
            layer2.path=path2.CGPath;
            if (centerX>=self.trajectViewWidth.constant) {
                self.btnThreeTrailCons.constant = self.trajectViewWidth.constant-23;
            }else
             self.btnThreeTrailCons.constant = centerX-23;
            [self.smTrajectViewThree.layer addSublayer:layer2];
        }
        if ([self.fourDataLab.text containsString:name]) {
              self.fourCondtionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
            self.fourCondtionLab.textColor = [UIColor getColor:[self getStatus:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]]];
            if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==1) {
                [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_low"] forState:UIControlStateNormal];
                  centerX =  (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue])/( [self.middleFiveLab.text floatValue]);
                
            }else  if ( [self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]==2) {
                [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_high"] forState:UIControlStateNormal];
                
                  centerX = (self.trajectViewWidth.constant/2.0)+ (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue]-[self.middleFiveLab.text floatValue])/( [self.middleFiveLab.text floatValue]);
            }else{
                
                [self.FourBtn setBackgroundImage:[UIImage imageNamed:@"bubble_jiance_normal"] forState:UIControlStateNormal];
                  centerX =  (self.trajectViewWidth.constant/2.0)*([model.TypeParameter floatValue])/( [self.middleFiveLab.text floatValue]);
            }
              [self.FourBtn setTitle:model.TypeParameter forState:UIControlStateNormal];
            
            
            
            if (centerX>=self.trajectViewWidth.constant) {
                self.btnFourTrailCons.constant = self.trajectViewWidth.constant-23;
            }else
            self.btnFourTrailCons.constant = centerX-23;
            UIBezierPath *path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, centerX, 8)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(centerX, 8*0.5)];
            
            CAShapeLayer *layer2=[CAShapeLayer layer];
            
            layer2.frame=CGRectMake(0, 0, centerX,8);
            
            layer2.fillColor = [self.fourCondtionLab.textColor CGColor];
            
            layer2.path=path2.CGPath;
            
            [self.smTrajectViewFour.layer addSublayer:layer2];
            
        }
    }
    
}
@end