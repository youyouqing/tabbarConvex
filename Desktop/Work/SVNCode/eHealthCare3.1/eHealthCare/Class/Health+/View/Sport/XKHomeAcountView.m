//
//  XKHomeAcountView.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKHomeAcountView.h"
#import "XKAcountHistoryViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "SingleTon.h"
@interface XKHomeAcountView ()

@property (nonatomic, strong) CMPedometer *pedometer;//记步器
@property (weak, nonatomic) IBOutlet UIView *sportBackView;

/**
 滚动播放的视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *contentScroller;

/**
 计时器定时滚动内容
 */
@property (nonatomic,strong) NSTimer *countTimer;

/**
 定义属性表示当前展示的页数
 */
@property (nonatomic,assign) NSInteger currentPage;

/**
 柱状图左边的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneleftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoleftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeleftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourleftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fiveleftCons;

//底层柱状图视图属性
@property (weak, nonatomic) IBOutlet UIView *backAcountViewOne;
@property (weak, nonatomic) IBOutlet UIView *backAcountViewSeven;
@property (weak, nonatomic) IBOutlet UIView *backAcountViewTwo;
@property (weak, nonatomic) IBOutlet UIView *backAcountViewThree;
@property (weak, nonatomic) IBOutlet UIView *backAcountViewFour;
@property (weak, nonatomic) IBOutlet UIView *backAcountViewFive;
@property (weak, nonatomic) IBOutlet UIView *backAcountViewSix;

//表层柱状图视图属性
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewOne;
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewTwo;
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewSeven;
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewThree;
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewFour;
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewFive;
@property (weak, nonatomic) IBOutlet UIView *internalAcountViewSix;

//表层柱状图视图距离头部属性
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewOneTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewSevenTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewTwoTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewThreeTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewFourTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewFiveTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *internalAcountViewSixTopCons;

/**
 约束容器
 */
@property (nonatomic,strong) NSArray *consArray;


//描述是标签的视图
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabOne;
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabThree;
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabFour;
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabFive;
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabSix;
@property (weak, nonatomic) IBOutlet UILabel *markTimeLabSeven;

/**
 时间标签容器
 */
@property (nonatomic,strong) NSArray *containerTimeLab;

/**
 消耗能量标签
 */
@property (weak, nonatomic) IBOutlet UILabel *consumptionLab;

/**
 今日步数标签
 */
@property (weak, nonatomic) IBOutlet UIButton *todayAcountlab;

/**
 今日步数描述标签头部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *todayLabTopCons;

/**
 最大步数头部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maxLabTopCons;

/**话题轮播表示是否是减*/
@property (nonatomic,assign) BOOL isRelease;

/**保留今日最新的数据*/
@property (nonatomic,strong) StepModel *step;

@property (weak, nonatomic) IBOutlet UIButton *xRunBtn;

@end

@implementation XKHomeAcountView


/**柱状图的点击事件*/
- (IBAction)operationAction:(UIButton *)sender {
    
    NSLog(@"%li",sender.tag);
    
    XKAcountHistoryViewController *history = [[XKAcountHistoryViewController alloc] initWithType:pageTypeNormal];
    history.step = self.step;
    [[self parentController].navigationController pushViewController:history animated:YES];
    
}
- (IBAction)xRunAction:(id)sender {
    
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    web.urlString = kXRunUrl;
    [[self parentController].navigationController pushViewController:web animated:YES];
    
    
}



/**记不起懒加载*/
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

NSString *distanceStr2;
NSString *distanc2;
float dis2;
int steps2;

-(void)awakeFromNib{
    
    [super awakeFromNib];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 94, 30) byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.xRunBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.xRunBtn.layer.mask = maskLayer1;
    //先给步数赋值
    self.step.StepCount = [SingleTon shareInstance].stepCount;
    
    self.contentScroller.layer.cornerRadius = 16;
    self.contentScroller.layer.borderColor = [UIColor colorWithRed: 226.0 / 255.0 green:226.0 / 255.0 blue:226.0 / 255.0 alpha:1.0].CGColor;
    self.contentScroller.layer.borderWidth = 0.5;
    self.contentScroller.alpha = 1 ;
    
    
    self.sportBackView.layer.cornerRadius = 5.f;
    self.sportBackView.clipsToBounds = YES;
    
    self.contentScroller.pagingEnabled = YES;
    
    self.currentPage = 0;
    
    self.oneleftCons.constant = self.twoleftCons.constant = self.threeleftCons.constant = self.fourleftCons.constant = self.fiveleftCons.constant = (KScreenWidth - 55*2 - 10*2 -7*8)/6;
    
    //剪切视图圆角
    [self cornorCommForView:self.backAcountViewOne];
    [self cornorCommForView:self.backAcountViewTwo];
    [self cornorCommForView:self.backAcountViewThree];
    [self cornorCommForView:self.backAcountViewFour];
    [self cornorCommForView:self.backAcountViewFive];
    [self cornorCommForView:self.backAcountViewSix];
    [self cornorCommForView:self.backAcountViewSeven];
    
    //剪切视图圆角 渲染颜色
    [self cornorCommForViewWithColor:self.internalAcountViewOne];
    [self cornorCommForViewWithColor:self.internalAcountViewTwo];
    [self cornorCommForViewWithColor:self.internalAcountViewThree];
    [self cornorCommForViewWithColor:self.internalAcountViewFour];
    [self cornorCommForViewWithColor:self.internalAcountViewFive];
    [self cornorCommForViewWithColor:self.internalAcountViewSix];
    [self cornorCommForViewWithColor:self.internalAcountViewSeven];
    
    /***
     随意改变头部属性
     */
    self.internalAcountViewOneTopCons.constant = 0;
    self.internalAcountViewTwoTopCons.constant = 0;
    self.internalAcountViewThreeTopCons.constant = 0;
    self.internalAcountViewFourTopCons.constant = 0;
    self.internalAcountViewFiveTopCons.constant = 0;
    self.internalAcountViewSixTopCons.constant = 0;
    self.internalAcountViewSevenTopCons.constant = 0;
    
    self.containerTimeLab = @[self.markTimeLabOne,self.markTimeLabTwo,self.markTimeLabThree,self.markTimeLabFour,self.markTimeLabFive,self.markTimeLabSix,self.markTimeLabSeven];
    
    if (IS_IPHONE5) {
        self.markTimeLabOne.font = [UIFont systemFontOfSize:10];
        self.markTimeLabTwo.font = [UIFont systemFontOfSize:10];
        self.markTimeLabThree.font = [UIFont systemFontOfSize:10];
        self.markTimeLabFour.font = [UIFont systemFontOfSize:10];
        self.markTimeLabFive.font = [UIFont systemFontOfSize:10];
        self.markTimeLabSix.font = [UIFont systemFontOfSize:10];
        self.markTimeLabSeven.font = [UIFont systemFontOfSize:10];
    }
    
    self.consArray = @[self.internalAcountViewOneTopCons,self.internalAcountViewTwoTopCons,self.internalAcountViewThreeTopCons,self.internalAcountViewFourTopCons,self.internalAcountViewFiveTopCons,self.internalAcountViewSixTopCons,self.internalAcountViewSevenTopCons];
    
    //屏幕兼容
    if (IS_IPHONE5) {
        self.maxLabTopCons.constant = 10;
        self.todayLabTopCons.constant = 10;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
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
                    
                    // //不可用也可以查询数据           NSLog(@"%@",error);
                    //             [self loadSetpData];
                    NSLog(@"查询有误");
                    return;
                }
                
                //距离字符串
                distanceStr2 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
                distanc2=[NSString stringWithFormat:@"%@",pedometerData.distance];
                dis2=[distanc2 floatValue];
                steps2 = [distanceStr2 intValue];
                //更新单例里的统计步数
                [SingleTon shareInstance].stepCount = steps2;
                 [SingleTon shareInstance].disT = dis2;
                //发送今日记步信息
                if ([self.delegate respondsToSelector:@selector(sendStepMesage:)]) {
                    if (!self.step) {
                        self.step = [[StepModel alloc] init];
                    }
                    self.step.StepCount = steps2;
                    self.step.KilometerCount = [[NSString stringWithFormat:@"%.2lf",dis2/1000] floatValue];
                    self.step.KilocalorieCount = [[NSString stringWithFormat:@"%.2lf",dis2/1000*65] floatValue];
                    [self.delegate sendStepMesage:self.step];
                     NSLog(@"查询有----%li", self.step.StepCount);
                }
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.todayAcountlab setTitle:[NSString stringWithFormat:@"%i",steps2] forState:UIControlStateNormal];
                    if ((NSInteger)steps2==0) {
                        self.consumptionLab.text=@"今日还没有运动哦!";
                    }
                    
                    if ((NSInteger)steps2>0&&(NSInteger)steps2<2000) {
                        self.consumptionLab.text=@"今日运动不足";
                    }
                    
                    if ((NSInteger)steps2>=2000&&(NSInteger)steps2<4000) {
                        self.consumptionLab.text=@"消耗了2块饼干的热量哦!";
                    }
                    
                    if ((NSInteger)steps2>=4000&&(NSInteger)steps2<6000) {
                        self.consumptionLab.text=@"消耗了一盒薯条的热量哦！";
                    }
                    
                    if ((NSInteger)steps2>=6000&&(NSInteger)steps2<8000) {
                        self.consumptionLab.text=@"消耗了2个炸鸡腿的热量哦！";
                    }
                    if ((NSInteger)steps2>=8000) {
                        self.consumptionLab.text=@"太棒了，你今天已经达到了目标了";
                    }
                    
                });
                
            }];
    });
    
}

//剪切圆角方法
-(void)cornorCommForView:(UIView *)v{
    
    v.layer.cornerRadius = 4;
    v.layer.masksToBounds = YES;
}

//剪切圆角加背景色
-(void)cornorCommForViewWithColor:(UIView *)v{
    
    v.layer.cornerRadius = 4;
    v.layer.masksToBounds = YES;
    
    v.backgroundColor = kMainColor;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor getColor:@"BCF0FF"].CGColor, (__bridge id)[UIColor getColor:@"03C7FF"].CGColor];
    gradientLayer.locations = @[@0.4, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1.0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.frame = CGRectMake(0, 0, 30, 150);//locations 渐变颜色的分割点  到的位置
    [v.layer addSublayer:gradientLayer];
    
    
}

-(void)setModel:(XKSportsHomeModel *)model{
    
    _model = model;
    
    //清楚原有的推荐数据
    for (UIView *v in self.contentScroller.subviews) {
        [v removeFromSuperview];
    }
    
    //设置滚动视图内容大小
    self.contentScroller.contentSize = CGSizeMake(KScreenWidth-(63*2), _model.WikiList.count);
    
    
    //重新展示数据
    for (NSInteger i=0; i<_model.WikiList.count; i++) {
        XKRecommendedWikiModel *modelwike = _model.WikiList[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 32*i, KScreenWidth-(63*2), 32)];
        btn.tag = i+100;
        [btn setTitleColor:[UIColor getColor:@"4a4a4a"] forState:UIControlStateNormal];
        [btn setTitle:modelwike.Title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ActionContent:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentScroller addSubview:btn];
    }
    
    self.currentPage = 0;
    
    //启动计时器
    if (!self.countTimer && _model.WikiList.count > 1) {
        self.countTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeShowData:) userInfo:nil repeats:YES];
    }
    
    //处理时间
    [self dealWithTime];
    
    //处理最近7天数据
    [self dealWithData];
    
    //消耗品处理
    for (XKSportsTypeModel *stype in self.model.modelList) {
        if (stype.PatternType == 1) {
            
            self.consumptionLab.text = @"";
//            [self.todayAcountlab setTitle:[NSString stringWithFormat:@"%li",stype.StepCount] forState:UIControlStateNormal]; //这里不能显示接口数据  否则会出现如 进来先检测到步数 服务器数据下来之后在显示--造成显示本地数据（比较小有跳动的感觉）
            if ((NSInteger)stype.StepCount==0) {
                self.consumptionLab.text=@"今日还没有运动哦!";    }
            
            if ((NSInteger)stype.StepCount>0&&(NSInteger)stype.StepCount<2000) {
                self.consumptionLab.text=@"今日运动不足";
            }
            
            if ((NSInteger)stype.StepCount>=2000&&(NSInteger)stype.StepCount<4000) {
                self.consumptionLab.text=@"消耗了2块饼干的热量哦!";
            }
            
            if ((NSInteger)stype.StepCount>=4000&&(NSInteger)stype.StepCount<6000) {
                self.consumptionLab.text=@"消耗了一盒薯条的热量哦！";
            }
            
            if ((NSInteger)stype.StepCount>=6000&&(NSInteger)stype.StepCount<8000) {
                self.consumptionLab.text=@"消耗了2个炸鸡腿的热量哦！";
            }
            if ((NSInteger)stype.StepCount>=8000) {
                self.consumptionLab.text=@"太棒了，你今天已经达到了目标了";
            }

            
            break;
            
        }
    }
    
    
}

//处理时间的方法
-(void)dealWithTime{
    
    for (int i= 0; i <self.model.TopList.count; i++) {
        
        XKSportsAcountModel *acountModel = self.model.TopList[i];
        
        if (i<=6) {
            UILabel *lab = self.containerTimeLab[i];
            lab.text = acountModel.markTime;
        }
        
    }
    
//    UILabel *lab = self.containerTimeLab[self.containerTimeLab.count-1];
//    lab.text = @"今";测试提出不显示今，只显示数值
    
}

//处理数据方法
-(void)dealWithData{
    CGFloat onceHeight = (CGFloat)150/(CGFloat)8000;
    for (int i= 0; i< self.model.TopList.count; i++) {
        
        XKSportsAcountModel *acountModel = self.model.TopList[i];
        
        if (i<=6) {
            NSLayoutConstraint *cons = self.consArray[i];
            if (acountModel.StepCount >= 8000) {
                cons.constant= 0;
            }else{
                cons.constant = 150-onceHeight*acountModel.StepCount;
            }

        }
        
    }
}

-(void)dealloc{
    
    [self.countTimer invalidate];
    self.countTimer = nil;
    
}

-(void)changeShowData:(NSTimer *)timer{
    
    if (!self.isRelease) {//加
        if (self.currentPage < self.model.WikiList.count-1) {
            self.currentPage ++;
        }else{
            self.isRelease = YES;
            self.currentPage --;
        }
    }else{//减
        if (self.currentPage > 0) {
            self.currentPage --;
        }else{
            self.isRelease = NO;
            self.currentPage ++;
        }
    }
    
    [self.contentScroller setContentOffset:CGPointMake(0, self.currentPage*32) animated:YES];
    
}

/**
 按钮的点击事件
 */
-(void)ActionContent:(UIButton *)btn{
    
    NSInteger dataIndex = btn.tag - 100;
    

    
}

- (IBAction)ActionHistory:(id)sender {
    
    XKAcountHistoryViewController *history = [[XKAcountHistoryViewController alloc] initWithType:pageTypeNormal];
    history.step = self.step;
    
    [[self parentController].navigationController pushViewController:history animated:YES];
    
}

@end