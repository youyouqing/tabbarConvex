//
//  EPluseCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "EPluseCell.h"
#import <CoreMotion/CoreMotion.h>
@interface EPluseCell ()
@property (nonatomic, strong) CMPedometer *pedometer;//记步器

@end

@implementation EPluseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.lienView.backgroundColor=[UIColor getColor:@"EBF0F4"];
    self.sportBtn.layer.cornerRadius = self.sportBtn.frame.size.height/2.0;
    self.sportBtn.layer.masksToBounds = YES;
    self.sportBtn.layer.shadowOffset = CGSizeMake(0,6);
    self.sportBtn.layer.shadowOpacity = 1;
    self.sportBtn.layer.shadowRadius = 9;
    self.sportBtn.layer.shadowColor = [UIColor colorWithRed:3/255.0 green:199/255.0 blue:255/255.0 alpha:0.3].CGColor;
    self.dataLab.font = [UIFont fontWithName:@"Impact" size:30];
     self.titleLabTwo.font = [UIFont fontWithName:@"Impact" size:30];
    
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    //    maskLayer.frame = corPath.bounds;
    //    maskLayer.path=corPath.CGPath;
    //    self.backView.layer.mask=maskLayer;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, self.topBackView.frame.size.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    maskLayer.frame = corPath.bounds;
    maskLayer.path=corPath.CGPath;
    self.topBackView.layer.mask=maskLayer;
    
    
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 117-42) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.bottomBackView.layer.mask=maskTwoLayer;
    
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
            distanceStr3 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
            distanc3=[NSString stringWithFormat:@"%@",pedometerData.distance];
            dis3=[distanc3 floatValue];
            
            steps3 = [distanceStr3 intValue];
            //更新单例里的统计步数
            [SingleTon shareInstance].stepCount = steps3;
             [SingleTon shareInstance].disT = dis3;

            
            if (12000 <= steps3 && ![defaults objectForKey:@"todayRecordUpdate"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"StepPlanValue" object:@(12000)];
                
                [defaults setObject:@(1) forKey:@"todayRecordUpdate"];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{//回到主线程刷新
                //发送今日记步信息
                if ([self.delegate respondsToSelector:@selector(sendStepMesage:)]) {
                    
                    [self.delegate sendStepMesage:steps3];
                }
                NSLog(@"查询有误%i",steps3);
                
            });
            
        }];
        
    });
    
}
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

NSString *distanceStr3;
NSString *distanc3;
float dis3;
int steps3;
-(void)setDataDic:(NSDictionary *)DataDic{
    _DataDic = DataDic;
    
    self.titleLab.text = DataDic[@"remark"];
   
   
    
    if ([DataDic[@"imgw"] isEnptyOrNil:[NSNull null]]== NO) {
//        self.titleLabTwo.text = DataDic[@"remarkw"];
        self.iconImageTwo.image = [UIImage imageNamed:DataDic[@"imgw"]];
    }
    
  
    
    
}
- (IBAction)goEnterMainConAction:(id)sender {
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sportEPluseCellbuttonClick:headline:)]) {
        [self.delegate sportEPluseCellbuttonClick:self.sportBtn.titleLabel.text headline:self.titleLab.text];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
