//
//  RunningView.m
//  RCSports
//
//  Created by liveidzong on 9/21/16.
//  Copyright © 2016 SBM. All rights reserved.
//

#import "RunningView.h"
#import "Masonry.h"
@interface RunningView()
{
  /**长按结束按钮计时*/
    NSTimer *longTimer;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gradientViewWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gradientViewHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBackViewWidthCons;
@property(nonatomic,weak)IBOutlet UIView *gradientView;
@property(nonatomic,assign)float progress;
@property (nonatomic, strong) UIButton *handleDemoBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSpaceCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpaceCons;


@end
@implementation RunningView
- (void)drawCircle {
    //创建一个layer并添加到self.layer上面去
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame =  self.gradientView.bounds;
    [self.gradientView.layer addSublayer:layer];
    //创建一个圆
    CGFloat width = self.gradientViewWidthCons.constant;
    CGFloat height = self.gradientViewWidthCons.constant;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, height/2.0) radius:width/2.0 startAngle:0 endAngle:2* M_PI clockwise:YES];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor getColor:@"DCE6EF"].CGColor;
    layer.lineWidth = 10;
    layer.lineCap = kCALineCapRound;
}
-(void)drawMinuteView
{
    UIImageView *nao = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iv_goal_miaobiao"]];
    [_gradientView addSubview:nao];
    CGFloat width = self.gradientViewWidthCons.constant+30;
//    nao.frame = CGRectMake((_gradientView.frame.size.width-width)/2.0, (_gradientView.frame.size.height-width*637.0/750.0)/2.0,width, width*637.0/750.0);
//     nao.frame = CGRectMake(0, 0,width, width);
     nao.frame = CGRectMake(-15, -20,width, width);
    self.minuteCountLab = [[UILabel alloc]init];
    _minuteCountLab.text = [NSString stringWithFormat:@"%.2f",[SportCommonMod shareInstance].totalDistance];//Futura-CondensedExtraBold
    _minuteCountLab.textColor = kMainTitleColor;
    _minuteCountLab.font = Kfont(60);//PingFangSC-Ultralight
    _minuteCountLab.textAlignment = NSTextAlignmentCenter;
    [self.gradientView addSubview:_minuteCountLab];
    [_minuteCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
    }];
    
    
    UILabel *unitLabel = [[UILabel alloc]init];
    unitLabel.text = @"分:秒";
    unitLabel.textColor = kMainTitleColor;
    unitLabel.textAlignment = NSTextAlignmentCenter;
    [self.gradientView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(43);;
        make.centerX.mas_equalTo(0);
    }];
    self.unitLabel = unitLabel;
}
- (void)updateProgressCircle:(float)progress{
    //update progress value
    self.progress = (float) progress;
    [self drawColorLayer];
}
//设置整个view渐变色
- (void)drawColorLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.gradientView.bounds;
    [self.gradientView.layer addSublayer:layer];
    
    layer.frame = self.gradientView.bounds;
    layer.lineWidth = 10;
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.gradientView.bounds.size.width / 2,self.gradientView.bounds.size.height / 2)
                                                                  radius:CGRectGetWidth(self.gradientView.bounds)/2.0
                                                              startAngle:(CGFloat) - M_PI_2
                                                                endAngle:(CGFloat)(- M_PI_2 +  2 * M_PI)
                                                               clockwise:YES];
    
    
    layer.path = progressCircle.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor getColor:@"07DD8F"].CGColor;
    layer.lineCap = kCALineCapButt;
    
    
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:self.progress];
    pathAnimation.autoreverses=NO;
    
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
-(void)awakeFromNib
{
    
    [super awakeFromNib];
    self.backgroundColor = kbackGroundColor;
    _stopBtn.centerColor = [UIColor getColor:@"FFD36D"];
   
    _distanceLB = [[UILabel alloc]init];
    _distanceLB.text = [NSString stringWithFormat:@"%.2f",[SportCommonMod shareInstance].totalDistance];//Futura-CondensedExtraBold
    _distanceLB.textColor = kMainTitleColor;
    _distanceLB.font = Kfont(60);//PingFangSC-Ultralight
    _distanceLB.textAlignment = NSTextAlignmentCenter;
    [self.gradientView addSubview:_distanceLB];
    [_distanceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
    }];
    
    UILabel *unitLabel = [[UILabel alloc]init];
    unitLabel.text = @"目标公里数(公里)";
    unitLabel.textColor = kMainTitleColor;
    unitLabel.textAlignment = NSTextAlignmentCenter;
    [self.gradientView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-40);;
        make.centerX.mas_equalTo(0);
    }];
    
    _timeLB = [[UILabel alloc]init];
    _timeLB.text = @"";
    _timeLB.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:30];
    _timeLB.textColor = kMainTitleColor;
    [self.timeBackView addSubview:_timeLB];
    CGFloat leftwidth = 36;
    if (IS_IPHONE5) {
        leftwidth = 36;
        self.gradientViewWidthCons.constant  = self.gradientViewHeightCons.constant = 230;
    }else if (IS_IPHONE6)
    {
        leftwidth = 51;
        self.gradientViewWidthCons.constant  = self.gradientViewHeightCons.constant = 230;
        
    }else
    {
        leftwidth = 52;
        self.gradientViewWidthCons.constant  = self.gradientViewHeightCons.constant = 290;
    }
    
    
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftwidth);
        make.centerY.mas_equalTo(-15);
    }];
    
   self.unit4Time =[UILabel new];
    self.unit4Time.text = @"分:秒";
    self.unit4Time.textColor = kMainTitleColor;
    self.unit4Time.font= [UIFont fontWithName:@"HelveticaNeue-light" size:16];
    [self.timeBackView addSubview:self.unit4Time];
    [self.unit4Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_timeLB.mas_bottom).mas_equalTo(5);
        make.centerX.mas_equalTo(_timeLB.mas_centerX).mas_equalTo(0);
    }];
    
    _runDistanceLB = [[UILabel alloc]init];
    _runDistanceLB.text = @"00.00";
    _runDistanceLB.textColor = kMainTitleColor;
    _runDistanceLB.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:30];
    [self.timeBackView addSubview:_runDistanceLB];
    [_runDistanceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-leftwidth);
        make.centerY.mas_equalTo(-15);
    }];
    
    UILabel *unit4Speed =[UILabel new];
    unit4Speed.text = @"距离(公里)";
    unit4Speed.textColor = kMainTitleColor;
    unit4Speed.font = [UIFont fontWithName:@"HelveticaNeue-light" size:16];
    [self.timeBackView addSubview:unit4Speed];
    [unit4Speed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_runDistanceLB.mas_bottom).mas_equalTo(5);
        make.centerX.mas_equalTo(_runDistanceLB.mas_centerX).mas_equalTo(0);
    }];
    self.stopBtn.layer.cornerRadius = 74/2.0;
    self.stopBtn.clipsToBounds =  YES;
    [self.stopBtn addTarget:self action:@selector(stopTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
   
    [self.stopBtn addTarget:self action:@selector(stopTouchDown) forControlEvents:UIControlEventTouchDown];
    self.endLab.hidden =self.keepLab.hidden= YES;
    self.keepGoBtn.hidden = self.stopBtn.hidden = YES;
    
}
-(void)setRunDesMinute:(RunningViewCommonType)runDesMinute
{
    _runDesMinute = runDesMinute;
    if (runDesMinute == RunningTypeMinute) {
         [self drawMinuteView];
        self.unit4Time.text = @"平均配速";
    }else
    {
        
         self.unit4Time.text = @"分:秒";
         [self drawCircle];
    }
    
    
}



//当按下按钮以后调用该方法，增加一个延迟。
- (void)stopTouchDown
{
    self.stopBtn.arcBackColor = [UIColor whiteColor];
    self.stopBtn.arcUnfinishColor =[UIColor getColor:@"FFD36D"];
    
    self.stopBtn.percent = 0;
    longTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(longBtnCount) userInfo:nil repeats:YES];
}
//当离开按钮的时候取消所调用的方法
- (void)stopTouchUpInside
{
    [longTimer fire];
    [longTimer invalidate];
    longTimer = NULL;
    self.stopBtn.percent = 0;
    
    
}
-(void)longBtnCount
{
    self.stopBtn.percent +=0.02;
    if (self.stopBtn.percent >= 1) {
        [longTimer invalidate];
        longTimer = NULL;
        if (self.delegate&&[self.delegate respondsToSelector:@selector(stopActionBtn)]) {
            
            [self.delegate stopActionBtn];
        }
    }
}

- (IBAction)keepAction:(id)sender {
    self.bottomBackViewWidthCons.constant = 80;
    self.startBtn.hidden =self.pauseLab.hidden= NO;
    self.keepGoBtn.hidden = self.keepLab.hidden = YES;
    self.stopBtn.hidden =self.endLab.hidden = YES;
    self.startBtn.enabled = YES;
    self.leftBtnSpace.constant = 0;
    self.rightBtnSpace.constant = 0;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(suspendOrunKeep:)]) {
        
        [self.delegate suspendOrunKeep:YES];
    }
}

- (IBAction)continueAction:(id)sender {
    self.bottomBackViewWidthCons.constant = 180;
    self.startBtn.enabled = NO;
    self.keepGoBtn.hidden =self.keepLab.hidden= NO;
    self.stopBtn.hidden = self.endLab.hidden=NO;
     self.startBtn.hidden = self.pauseLab.hidden= YES;

     CGFloat X = 12.5+37;
    if (IS_IPHONE5) {
        self.rightSpaceCons.constant = self.leftSpaceCons.constant = 7;
    }else
        self.rightSpaceCons.constant = self.leftSpaceCons.constant = 25;

    self.leftBtnSpace.constant = -X;
    self.rightBtnSpace.constant = X;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(suspendOrunKeep:)]) {
        
        [self.delegate suspendOrunKeep:NO];
    }
}
- (IBAction)lockAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(lockOrunLockBtn)]) {
        [self.delegate lockOrunLockBtn];
    }
}

- (IBAction)enterTrendAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(enterTrendPage)]) {
        [self.delegate enterTrendPage];
    }
}

@end