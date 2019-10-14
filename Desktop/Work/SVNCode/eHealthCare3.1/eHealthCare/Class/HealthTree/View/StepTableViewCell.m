//
//  StepTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "StepTableViewCell.h"
#import <CoreMotion/CoreMotion.h>
@interface StepTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *stepBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *backBottomView;

@property (assign, nonatomic)CGFloat progress;
@property (nonatomic, strong) CMPedometer *pedometer;//记步器

@end
@implementation StepTableViewCell
- (void)drawCircle {
    //创建一个layer并添加到self.layer上面去
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.backView.bounds;
    [self.backView.layer addSublayer:layer];
    //创建一个圆
    CGFloat width = CGRectGetWidth(self.backView.bounds);
    CGFloat height = CGRectGetHeight(self.backView.bounds);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, height/2) radius:CGRectGetWidth(self.backView.bounds)/2 startAngle:0 endAngle:2* M_PI clockwise:YES];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = kbackGroundGrayColor.CGColor;
    layer.lineWidth = 10;
    layer.lineCap = kCALineCapRound;
    
  
}
- (void)updateProgressCircle:(float)progress{
    //update progress value
    self.progress = (float) progress;
    //redraw back & progress circles
    //    [self setNeedsDisplay];
    [self drawColorLayer];
    //增加动画
    
}
//设置整个view渐变色
- (void)drawColorLayer {
    if (self.layerCirCle) {
        [self.layerCirCle removeFromSuperlayer];
    }
    self.layerCirCle = [CAShapeLayer layer];
    self.layerCirCle.frame = self.backView.bounds;
    [self.backView.layer addSublayer:self.layerCirCle];
    
    self.layerCirCle.frame = self.backView.bounds;
    self.layerCirCle.lineWidth = 10;
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.backView.bounds.size.width / 2,self.backView.bounds.size.height / 2)
                                                                  radius:CGRectGetWidth(self.backView.bounds)/2.0
                                                              startAngle:(CGFloat) - M_PI_2
                                                                endAngle:(CGFloat)(- M_PI_2 +  2 * M_PI)
                                                               clockwise:YES];
    
    
    self.layerCirCle.path = progressCircle.CGPath;
    self.layerCirCle.fillColor = [UIColor clearColor].CGColor;
    self.layerCirCle.strokeColor = [UIColor getColor:@"07DD8F"].CGColor;
    self.layerCirCle.lineCap = kCALineCapButt;
    
    
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:self.progress];
    pathAnimation.autoreverses=NO;
    
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    [self.layerCirCle addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailLab.font =Kfont(15);
    self.detailLab.textColor = [UIColor getColor:@"B3BBC4"];
    self.stepBtn.backgroundColor = [UIColor getColor:@"03C7FF"];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 4.f;
    self.layer.shadowOffset = CGSizeMake(4, 4);
    self.backgroundColor = kbackGroundGrayColor;//[UIColor getColor:@"edf8ff"];
     [self drawCircle];
    
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (134)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.backBottomView.layer.mask=maskTwoLayer;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    if (![currentDateStr isEqualToString:[NSString stringWithFormat:@"%@",[defaults objectForKey:@"yesterdayDate"]]]) {//保存上一个日期
        [defaults removeObjectForKey:@"todayRecordUpdate"];
        [defaults setObject:currentDateStr forKey:@"yesterdayDate"];
    }
    //记步信息
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 1.判断计步器是否可用
//        if (![CMPedometer isStepCountingAvailable]) {
//            
//            return;
//        }
//        
//        //统计某天的
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *todayDateStr = [dateFormatter stringFromDate:[NSDate date]];
//        
//        NSString *beginDateStr = [todayDateStr stringByAppendingString:@"-00-00-00"];
//        //字符转日期
//        NSDateFormatter *beginDateFormatter = [[NSDateFormatter alloc] init];
//        [beginDateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
//        NSDate *beginDate = [beginDateFormatter dateFromString:beginDateStr];
//        //  [NSDate dateWithTimeInterval:-24*60*画60 sinceDate:[NSDate date]];当你的步数有更新的时候，会触发这个方法，这个方法不会和时时返回结果，每次刷新数据大概在一分钟左右
//        [self.pedometer startPedometerUpdatesFromDate:beginDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
//            
//            if (error) {
//                NSLog(@"查询有误");
//                return;
//            }
//            
//            //距离字符串
//            distanceStr4 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
//            distanc4=[NSString stringWithFormat:@"%@",pedometerData.distance];
//            dis4=[distanc4 floatValue];
//            
//            steps4 = [distanceStr4 intValue];
//            //更新单例里的统计步数
//            [SingleTon shareInstance].stepCount = steps4;
//            
//            [SingleTon shareInstance].disT = dis4;
//            
//            if (12000 <= steps4&& ![defaults objectForKey:@"todayRecordUpdate"]) {
//                
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"StepPlanValue" object:@(12000)];
//                
//                [defaults setObject:@(1) forKey:@"todayRecordUpdate"];
//                
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{//回到主线程刷新
//                //发送今日记步信息
//                if ([self.delegate respondsToSelector:@selector(sendStepCellMesage:)]) {
//                    
//                    [self.delegate sendStepCellMesage:steps4];
//                }
//                NSLog(@"查询有误%i",steps4);
//                
//            });
//            
//        }];
//        
//    });
}
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

//NSString *distanceStr4;
//NSString *distanc4;
//float dis4;
//int steps4;
-(void)setData:(HealthData *)data
{
    
    _data = data;
//    self.stepLab.text = [NSString stringWithFormat:@"%zi",data.StepCount];
}
-(void)setSteps:(int)steps
{
     self.stepLab.text = [NSString stringWithFormat:@"%i",steps];
    if (steps>=3000) {
        self.detailLab.text = @"已完成健康运动目标";
    }else
         self.detailLab.text = @"未完成健康运动目标";
 
    [self updateProgressCircle:(steps/3000.0)];//按照步数10000来算的
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sportbuttonClick)]) {
        [self.delegate sportbuttonClick];
    }
}

@end