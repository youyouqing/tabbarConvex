//
//  EPluseTemperView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "EPluseTemperView.h"
#define kXXAngleToRadian(angle)  (M_PI / 180.0 * (angle))
@implementation EPluseTemperView

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
    float n = 34.6;
    
    self->circlelabel = [[UILabel alloc]initWithFrame:CGRectMake((248-2)/2, (194-2)/2+3, 2, 2)];
    self->circlelabel.backgroundColor = [UIColor whiteColor];
    [self.TemperatureImage addSubview:self->circlelabel];
    CGPoint p = [self calcCircleCoordinateWithCenter:CGPointMake(self->circlelabel.bounds.origin.x, self->circlelabel.bounds.origin.y) andWithAngle:(36-n)*60+180 andWithRadius:75];
    NSLog(@"------------%f,%f",p.x,p.y);
    //35 -=> (180+60)  36 --> 180   37 ->> 90+60    38 =>60    39 -->0    40  -> -60
    //  (36-n)*60 +180
    
    self.circle      = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0 , 12, 12)];//圆的半径是30  -150----+150
    self.circle.center = CGPointMake(p.x, p.y);
    self.circle.image = [UIImage imageNamed:@"cicreView"];
    [self.TemperatureImage bringSubviewToFront:self.circle];
    [self->circlelabel addSubview:self.circle];

}
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

-(void)setPhysicalMod:(NSArray *)PhysicalMod
{
    _PhysicalMod = PhysicalMod;
    
    for ( PhysicalList *model in PhysicalMod) {
        
        if ([model.PhysicalItemIdentifier isEqualToString:@"TC"]){
            Dateformat *dateFor = [[Dateformat alloc] init];

            self.testTimeLab.text = [NSString stringWithFormat:@"上次测量：%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy-MM-dd HH:mm"]];
            
            self.conditionLab.text = (model.ExceptionFlag == 1)?(@"正常"):((model.ParameterName)?(model.ParameterName):(@"未检测"));
            self.dataLab.text = model.TypeParameter?(model.TypeParameter):@"-";
            self.conditionLab.textColor = self.dataLab.textColor = [UIColor getColor:[self getColorStr:model.TypeParameter minValue:model.MinValue maxValue:model.MaxValue ExceptionFlag:model.ExceptionFlag]];
            if (model.TypeParameter.length>0) {
                if ([model.TypeParameter floatValue] < 35 ||[model.TypeParameter floatValue]  > 40) {
                    return;
                }
                CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(self->circlelabel.bounds.origin.x, self->circlelabel.bounds.origin.y) andWithAngle:(36-([model.TypeParameter floatValue]))*60+180 andWithRadius:75];
                self.circle.center = CGPointMake(point.x, point.y);
            }
            
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
    NSString *nameStr;//TC对应体温
    if ([PhysicalItemIdentifier isEqualToString:@"TC"]) {
        nameStr = [NSString stringWithFormat:@"体温"];
    }
    return nameStr;
}
@end
