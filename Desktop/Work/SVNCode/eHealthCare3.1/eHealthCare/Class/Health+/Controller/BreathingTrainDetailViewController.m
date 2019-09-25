//
//  BreathingTrainDetailViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/30.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BreathingTrainDetailViewController.h"
#import "CADisplayLineImageView.h"
#import "XKBackButton.h"
#import "JX_GCDTimerManager.h"
@interface BreathingTrainDetailViewController ()
{

    NSTimer *temp_time;//daojishi倒计时
    BOOL isShowTimeImg;
    
    NSInteger count;
    
    int temp_a;
    int tempA ;//临时存储呼气速率变量
    BOOL is_huqi;
    UIButton *leftBackBtn;
    CADisplayLineImageView *displayImageView;//加载GIF图
}
@property (nonatomic, strong) NSTimer *timer;//倒计时
@property (nonatomic,assign) int timeCount;


@property (nonatomic,assign) int keepTimeOne;//计时一次
/**
 呼吸背景
 */
@property (weak, nonatomic) UIImageView *breathImage;

/**
 开始   倒计时   再来一次
 */
@property (weak, nonatomic) UIButton *startTimeBtn;

/**
 呼气  吸气
 */
@property (weak, nonatomic) UILabel *breathLab;

/**
 时间
 */
@property (weak, nonatomic) UILabel *timeLal;
@end
@implementation BreathingTrainDetailViewController
static NSString * const myTimer = @"MyTimer";

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.keepTimeOne = 1;

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [temp_time invalidate];
    temp_time = nil;
    self.keepTimeOne = 1;
}

#pragma mark UI
- (void)createUI
{
    [self judgeJMHRank];
    
    self.breathLab.hidden = YES;
    
    self.timeLal.hidden = YES;
    self.keepTimeOne = 1;
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BreathTrain_bgIamge"]];
    
    backImage.userInteractionEnabled = YES;
    
    [self.view addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    self.backViewImage = backImage;
    [self loadCADisplayLineImageView:@"bg_plus_hxzx.gif"];
    UIImageView *breathImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BreathTrain_breatheout"]];
    
    [backImage addSubview:breathImage];
    self.breathImage = breathImage;
    [breathImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(157));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(131), KWidth(131)));
    }];
    
    UIButton *startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [startTimeBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startTimeBtn.titleLabel.font = Kfont(20);
    [startTimeBtn addTarget:self action:@selector(beginOrAgainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backImage addSubview:startTimeBtn];
    self.startTimeBtn = startTimeBtn;
    [startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(breathImage);
        
    }];
    
    UILabel *breathLab = [[UILabel alloc]init];
    
    breathLab.text = @"吸气";
    breathLab.hidden = YES;
    breathLab.textColor = [UIColor whiteColor];
    breathLab.textAlignment = NSTextAlignmentCenter;
    breathLab.font = Kfont(18);
    
    [backImage addSubview:breathLab];
    self.breathLab = breathLab;
    
    [breathLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(breathImage);
    }];
    
    UILabel *timeLal = [[UILabel alloc]init];
    
    timeLal.text = @"00:00";
    timeLal.font = Kfont(16);
    timeLal.hidden = YES;
    timeLal.textAlignment = NSTextAlignmentCenter;
    timeLal.textColor = [UIColor whiteColor];
    
    [backImage addSubview:timeLal];
    self.timeLal = timeLal;
    
    [timeLal mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(breathImage.mas_centerY).mas_offset(KHeight(24));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(131), KHeight(24)));
    }];
    
    [self backImageAction];
     self.breathImage.transform = CGAffineTransformMakeScale( 1.8, 1.8);
    
}

//背景动态图
-(void)loadCADisplayLineImageView:(NSString *)imageName
{
    displayImageView = [[CADisplayLineImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [displayImageView setCenter:CGPointMake(displayImageView.center.x, displayImageView.center.y)];
    [self.backViewImage addSubview:displayImageView];
    [displayImageView setImage:[CADisplayLineImage imageNamed:imageName]];
    
}

//返回按钮
-(void)backImageAction{
    
    leftBackBtn = [XKBackButton backBtn:@"icon_back_white"];
    leftBackBtn.hidden = YES;
    [self.view addSubview:leftBackBtn];
    [leftBackBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(12);
        make.top.mas_equalTo((PublicY) - 42);
        make.width.height.mas_equalTo(40);
    }];

}



#pragma mark Action
-(void)clickBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Action
//初级训练  中级训练   高级训练
-(void)judgeJMHRank{
    
    _timeCount = _trainTime*60.0;
    count = _jmhRank;

}

/**
 开始再来一次
 @param sender 按钮
 */
- (void)beginOrAgainAction:(id)sender
{
  
    leftBackBtn.hidden = NO;
    leftBackBtn.hidden = YES;
    if (temp_time == nil&&self.keepTimeOne == 1) {
        self.keepTimeOne = 2;
        temp_time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(temp) userInfo:nil repeats:YES];
        
        temp_a = 3;
        self.startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:40];
        [self.startTimeBtn setTitle:[NSString stringWithFormat:@"%d",temp_a] forState:UIControlStateNormal];
        self.startTimeBtn.hidden = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openTimer];

            [UIView animateWithDuration:self->count animations:^{
                self.breathImage.transform = CGAffineTransformMakeScale( 1.8, 1.8);
            }];
        });
    }
    
    
    
}
-(void)temp
{
    [self.startTimeBtn setTitle:[NSString stringWithFormat:@"%d",--temp_a] forState:UIControlStateNormal];
    if (temp_a <= 0) {
        //TODO  销毁定时器
        [temp_time invalidate];
        temp_time = nil;
        [self.startTimeBtn setTitle:@"" forState:UIControlStateNormal];
        return;
    }
    
}
#pragma mark   计时器
-(void)openTimer
{
    leftBackBtn.hidden = YES;
    self.startTimeBtn.hidden = YES;
    self.breathLab.hidden = NO;
    
    self.timeLal.hidden = NO;
 
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tenTimeDone) userInfo:nil repeats:YES];
    __weak typeof(self) weakSelf = self;
    [[JX_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:myTimer
                                                           timeInterval:1.0
                                                                  queue:dispatch_get_main_queue()
                                                                repeats:YES
                                                          fireInstantly:NO
                                                                 action:^{
                                                                     [weakSelf tenTimeDone];
                                                                 }];

    tempA = 0;

}

-(void)tenTimeDone
{
      _timeCount --;
    int minutes = _timeCount / 60;
    int seconds = _timeCount%60;
    
    NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
    
    self.timeLal.text = strTime;
    if ([NSString isPureInt:tempA/(double)count]) {
        if ([self isJO:tempA/(double)count]) {
            //奇数   吸气
            is_huqi = !is_huqi;
            
            self.breathLab.text = @"吸气";
            [UIView animateWithDuration:count animations:^{
                self.breathImage.transform = CGAffineTransformMakeScale( 1, 1);
                
            }];
        }else{
            //偶数 呼气
            is_huqi = !is_huqi;
            
            self.breathLab.text = @"呼气";
            [UIView animateWithDuration:count animations:^{
                self.breathImage.transform = CGAffineTransformMakeScale( 1.8, 1.8);
            }];
            
            
        }
    }
    NSLog(@"%d---%@",tempA, [NSString stringWithFormat:is_huqi?@"吸气":@"呼气"]);
    tempA++;
    if (_timeCount <= 0 ) {
        XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
        [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(3)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(3)} isPopView:YES];
        self.timeLal.text = [NSString stringWithFormat:@"%.2d:00",(long)_trainTime];
        //        [self.timer invalidate];
        //        self.timer = nil;
        [self.timer invalidate];
        [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:myTimer];
        
        self.breathImage.transform = CGAffineTransformMakeScale( 1.8, 1.8);
        [self.startTimeBtn setTitle:@"再来一次" forState:UIControlStateNormal];
        self.startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:20.f];
        self.startTimeBtn.hidden = NO;
        self.breathLab.hidden = YES;
        self.timeLal.hidden = YES;
        leftBackBtn.hidden = NO;
        
        [self judgeJMHRank];
        leftBackBtn.hidden = YES;
        //  leftBackBtn.hidden = NO;
        self.keepTimeOne = 1;
    }
}

//判断奇偶
-(BOOL)isJO:(int)num
{
    int a=num % 2;
    if (a==0)
    {
        return true;
    }
    return false;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    leftBackBtn.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"-----------view dealloc-------------");
}
@end
