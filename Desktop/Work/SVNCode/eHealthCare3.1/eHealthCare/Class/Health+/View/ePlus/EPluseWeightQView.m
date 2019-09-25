//
//  EPluseWeightQView.m
//  eHealthCare
//
//  Created by John shi on 2019/3/5.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import "EPluseWeightQView.h"

@implementation EPluseWeightQView

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
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, self.backView.frame.size.height) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3, 3)];
    maskLayer.frame = corPath.bounds;
    maskLayer.path=corPath.CGPath;
    self.backView.layer.mask=maskLayer;
    
}
-(void)setPhysicalMod:(NSArray *)PhysicalMod
{
    _PhysicalMod = PhysicalMod;
    
    for ( PhysicalList *model in PhysicalMod) {
        
        if ([model.PhysicalItemIdentifier isEqualToString:@"WG"]){
            Dateformat *dateFor = [[Dateformat alloc] init];
            
            self.testTimeLab.text = [NSString stringWithFormat:@"上次测量：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy-MM-dd HH:mm"]];
            
            self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
            self.dataLab.text = model.TypeParameter?(model.TypeParameter):@"-";
            
            //     [format DateFormatWithDate:model.TestTime withFormat:@"yyyy/MM/dd" ]
            
            self.conditionLab.textColor = self.dataLab.textColor =  [UIColor getColor:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]];
            
            self.conditionLab.hidden = (model.ExceptionFlag == 1)?(YES):((model.ParameterName)?(YES):(NO));
        }
        
    }
    
}
-(NSString *)getColorStr:(NSString *)typeValue minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue ExceptionFlag:(NSInteger)ExceptionFlag;
{
    if (ExceptionFlag == 0) {
        if ([typeValue floatValue] < minValue) {
            
            
            return @"FFD36D";
        }else  if ([typeValue floatValue]> maxValue)
        {
            
            return @"FF4564";
        }
        else
            return @"B3BBC4";
    }else
    {
        return @"07DD8F";
        
    }
    
}
-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(NSString *)PhysicalItemIdentifier
{
    NSString *nameStr;
    if ([PhysicalItemIdentifier isEqualToString:@"WG"]) {
        nameStr = [NSString stringWithFormat:@"体重"];
    }
    return nameStr;
}
@end
