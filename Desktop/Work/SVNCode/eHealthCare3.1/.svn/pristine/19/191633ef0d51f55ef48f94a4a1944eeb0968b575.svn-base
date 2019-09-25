//
//  HealthTreeHeaderView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthTreeHeaderView.h"
#import <CoreMotion/CoreMotion.h>
#import "UICountingLabel.h"
@interface HealthTreeHeaderView ()
{
    
    
    CAShapeLayer *layer2;//步数的图层路径layer
}
@property (weak, nonatomic) IBOutlet UILabel *xuesuLab;
@property (weak, nonatomic) IBOutlet UILabel *kangBiLab;
@property (nonatomic, strong) CMPedometer *pedometer;//记步器
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *temperLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *HotLab;
@property (weak, nonatomic) IBOutlet UIButton *MessageBtn;

@property (weak, nonatomic) IBOutlet UILabel *xuesuDataLab;
@property (weak, nonatomic) IBOutlet UILabel *kangBiDataLab;
@property (weak, nonatomic) IBOutlet UICountingLabel *stepCountLab;
@property (weak, nonatomic) IBOutlet UIView *smTrajectView;
@property (weak, nonatomic) IBOutlet UIView *trajectView;
@property (weak, nonatomic) IBOutlet UIButton *GoBtn;
@property (weak, nonatomic) IBOutlet UIButton *RankingBtn;
@property (weak, nonatomic) IBOutlet UIView *stepBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomGoHealthBtnCons;

@end
@implementation HealthTreeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

NSString *distanceStr4;
NSString *distanc4;
float dis4;
int steps4;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.GoBtn.titleLabel.font =  self.RankingBtn.titleLabel.font = [UIFont fontWithName:@"Hobo Std" size:14.f];
    _stepBackView.layer.shadowColor = [UIColor colorWithRed:6/255.0 green:32/255.0 blue:21/255.0 alpha:0.2].CGColor;
    _stepBackView.layer.shadowOffset = CGSizeMake(0,2);
    _stepBackView.layer.shadowOpacity = 1;
    _stepBackView.layer.shadowRadius = 10;
    _stepBackView.layer.cornerRadius = 5;
    
 
    if (is_IPhoneX) {
        self.bottomGoHealthBtnCons.constant = 125;
    }else if (IS_IPHONE6_PLUS)
    {
        self.bottomGoHealthBtnCons.constant = 125;

    }
    else if (IS_IPHONE5||IS_IPHONE4S)
    {
        self.bottomGoHealthBtnCons.constant = 100;
        
    }else if (IS_IPHONE6)
    {
         self.bottomGoHealthBtnCons.constant = 116;

    }
    else
    {
        self.bottomGoHealthBtnCons.constant = 121;
        
    }
    self.trajectView.layer.cornerRadius = 4/2;
    self.trajectView.layer.masksToBounds = YES;
    self.smTrajectView.layer.cornerRadius = 4/2;
    self.smTrajectView.layer.masksToBounds = YES;
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 1.判断计步器是否可用
        if (![CMPedometer isStepCountingAvailable]) {
            
            return;
        }
        
        //统计某天的
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *todayDateStr = [dateFormatter stringFromDate:[NSDate date]];
        
        NSString *beginDateStr = [todayDateStr stringByAppendingString:@"-00-00-00"];
        //字符转日期
        NSDateFormatter *beginDateFormatter = [[NSDateFormatter alloc] init];
        [beginDateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        NSDate *beginDate = [beginDateFormatter dateFromString:beginDateStr];
        //  [NSDate dateWithTimeInterval:-24*60*画60 sinceDate:[NSDate date]];当你的步数有更新的时候，会触发这个方法，这个方法不会和时时返回结果，每次刷新数据大概在一分钟左右
        [self.pedometer startPedometerUpdatesFromDate:beginDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
            
            if (error) {
                NSLog(@"查询有误");
                return;
            }
            
            //距离字符串
            distanceStr4 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
            distanc4=[NSString stringWithFormat:@"%@",pedometerData.distance];
            dis4=[distanc4 floatValue];
            
            steps4 = [distanceStr4 intValue];
            //更新单例里的统计步数
            [SingleTon shareInstance].stepCount = steps4;
            
            [SingleTon shareInstance].disT = dis4;
//            steps4 = 640;
            if (12000 <= steps4&& ![defaults objectForKey:@"todayRecordUpdate"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"StepPlanValue" object:@(12000)];
                
                [defaults setObject:@(1) forKey:@"todayRecordUpdate"];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{//回到主线程刷新
                //发送今日记步信息
//                if ([self.delegate respondsToSelector:@selector(sendStepCellMesage1:)]) {
//
//                    [self.delegate sendStepCellMesage1:steps4];
//                }
                
                NSLog(@"查询有误%i",steps4);
                if (self->layer2) {
                    [self->layer2 removeFromSuperlayer];
                }
                NSInteger maxSteps = 0;
                if (steps4>3000) {
                    maxSteps = 3000;
                }else
                    maxSteps = steps4;
              
                UIBezierPath *path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, (KScreenWidth-33-147-36)/3000*(NSInteger)maxSteps, 4)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight|UIRectCornerBottomLeft | UIRectCornerTopLeft    cornerRadii:CGSizeMake((KScreenWidth-33-147-36)/3000*(NSInteger)maxSteps, 4*0.5)];
                  UIBezierPath *path21=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 0, 4)      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight|UIRectCornerBottomLeft | UIRectCornerTopLeft    cornerRadii:CGSizeMake((KScreenWidth-33-147-36)/3000*(NSInteger)maxSteps, 4*0.5)];
                self->layer2=[CAShapeLayer layer];
                
                self->layer2.frame=CGRectMake(0, 0, (KScreenWidth-33-147-36)/3000*(NSInteger)maxSteps,4/2);
                
                self->layer2.fillColor = [[UIColor getColor:@"40E8B4"] CGColor];
                self->layer2.lineWidth=2;
                self->layer2.path=path2.CGPath;
                
//                layer2.strokeStart=0.0;
                self->layer2.strokeColor = [UIColor getColor:@"40E8B4"].CGColor;
//                 layer2.strokeEnd=0;

                
             
                CABasicAnimation *animation = [CABasicAnimation animation];
                animation.keyPath = @"path";
                animation.duration = 0.5; // 动画时长
                animation.fromValue=(id)path21.CGPath;
                animation.toValue=(id)path2.CGPath;
                //                animation.autoreverses=NO;
                //
                //                animation.fillMode = kCAFillModeForwards;
                //                animation.removedOnCompletion = NO;
                //                animation.repeatCount = 1;
                // 给layer添加动画
              
//                animation.autoreverses=NO;
//
//                animation.fillMode = kCAFillModeForwards;
//                animation.removedOnCompletion = NO;
//                animation.repeatCount = 1;
                // 给layer添加动画
                [self->layer2 addAnimation:animation forKey:nil];
                [self.smTrajectView.layer addSublayer:self->layer2];
                if ((KScreenWidth-33-147-36)/3000*(NSInteger)maxSteps <= 10) {
                    self.manCons.constant = 0;
                    
                    
                    
                }else{

                    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
                        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                            
                            self.stepCountLab.left =  (KScreenWidth-33-147-36)*maxSteps/3000.0-20;
                             self.manCons.constant = -((KScreenWidth-33-147-36)/3000*(NSInteger)maxSteps-5);
                        }];
                    } completion:^(BOOL finished) {
                          self.stepCountLab.left =  (KScreenWidth-33-147-36)*maxSteps/3000.0-20;
                       
                    }];
                }

                 [self.stepCountLab countFrom:0 to:steps4 withDuration:0.5];
            });
            
        }];
        
    });
    
}
- (IBAction)messageAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageDataSoure)]) {
        [self.delegate messageDataSoure];
    }
    
}
- (IBAction)XrunAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goHealthTreeWebUrl:)]) {
        [self.delegate goHealthTreeWebUrl:2];
    }
    
    
}
- (IBAction)healthTreeAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(goHealthTreeWebUrl:)]) {
        [self.delegate goHealthTreeWebUrl:btn.tag];
    }
    
    
}
- (IBAction)goHealthAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goHealthTaskDataSoure)]) {
        [self.delegate goHealthTaskDataSoure];
    }
}
-(void)setHealthData:(HealthData *)HealthData
{
    
    _HealthData = HealthData;
//    self.xuesuLab.text = [NSString stringWithFormat:@"%@",HealthData.CurrentGrade];
//    self.kangBiLab.text =  [NSString stringWithFormat:@"%zi",HealthData.KCurrency];
    if (HealthData.Ranking>=100) {
        [self.RankingBtn setTitle: [NSString stringWithFormat:@"%zi+",HealthData.Ranking] forState:UIControlStateNormal];

    }else
        [self.RankingBtn setTitle: [NSString stringWithFormat:@"%zi",HealthData.Ranking] forState:UIControlStateNormal];

    
    [self.GoBtn setTitle:[NSString stringWithFormat:@"今 %zi K",HealthData.KValue] forState:UIControlStateNormal];
    [self.xuesuBtn sd_setImageWithURL:[NSURL URLWithString:HealthData.GradeLogo] forState:UIControlStateNormal];
    self.xuesuDataLab.text = [NSString stringWithFormat:@"%@",HealthData.CurrentGrade.length>0?HealthData.CurrentGrade:@"未点亮"];
    self.kangBiDataLab.text = [NSString stringWithFormat:@"%zi",HealthData.KCurrency];
//    [self.xuesuBtn setTitle:[NSString stringWithFormat:@"%@",HealthData.CurrentGrade.length>0?HealthData.CurrentGrade:@"未点亮"] forState:UIControlStateNormal];
//     [self.kangbiBtn setTitle:[NSString stringWithFormat:@"%zi",HealthData.KCurrency] forState:UIControlStateNormal];
  
   
    
  
    
   
}
- (IBAction)goSportAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goSportBtnAction)]) {
        [self.delegate goSportBtnAction];
    }
}
@end
