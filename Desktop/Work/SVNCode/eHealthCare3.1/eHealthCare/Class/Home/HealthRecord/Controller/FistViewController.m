//
//  FistViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//挥拳

#import "FistViewController.h"
#import "SensoryResultViewController.h"
#import "HomeViewController.h"
@interface FistViewController ()
{
    ///计时
    int count;
    
    int score;
}
///倒计时图片
@property (nonatomic, strong) UIImageView *timeImgView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *countDownTimeLabel;

@end

@implementation FistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    score = 0;
    
    [self createUI];
    
    [self startCountDown];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_timer) {
        [self cancelTimer];
    }
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];

  

    UIImageView *photoImage = [[UIImageView alloc]init];
    
    photoImage.image = [UIImage imageNamed:@"iv_dalishi"];
    
    [self.view addSubview:photoImage];
    
    //设置约束
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth,KScreenWidth*928.0/750.0 ));
    }];
    
    //提示文字
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.text = @"手握手机，做用力挥拳动作，挥拳速度越快、频率越高、力量越大、得分越高。";
    tipLabel.font = Kfont(16);
    tipLabel.textColor = kMainTitleColor;
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:tipLabel];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(photoImage.mas_bottom).mas_offset(KHeight(48));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(44), KHeight(45)));
    }];
    
    //倒计时
    UILabel *countDownTimeLabel = [[UILabel alloc]init];
    
    countDownTimeLabel.textColor = kMainColor;
    countDownTimeLabel.font = Kfont(20);
    
    [self.view addSubview:countDownTimeLabel];
    self.countDownTimeLabel = countDownTimeLabel;
    
    [countDownTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(- KHeight(49));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(20));
    }];
    
    //大倒计时图片
    self.timeImgView = [[UIImageView alloc]init];
    self.timeImgView.image = [UIImage imageNamed:@"shakeNum_5"];
    [self.view addSubview:self.timeImgView];
//    [self showTitleAndBackButtonWithoutNavigation:self.myTitle];
    [self.view bringSubviewToFront:self.headerView];
}
-(void)popToUpViewController
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[HomeViewController class]])
        {
            HomeViewController *test = (HomeViewController *)controller;
            [self.navigationController popToViewController:test animated:YES];
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Private Methoud

///开始倒计时
- (void)startCountDown
{
    [self showDoneWithNum:5];
    //1
    [UIView animateWithDuration:1.0 animations:^{
        [self imageShowingCountDownImage];
    } completion:^(BOOL finished) {
        
        [self showDoneWithNum:4];
        //2
        [UIView animateWithDuration:1.0 animations:^{
            
            [self imageShowingCountDownImage];
        } completion:^(BOOL finished) {
            
            [self showDoneWithNum:3];
            //3
            [UIView animateWithDuration:1.0 animations:^{
                [self imageShowingCountDownImage];
                
            } completion:^(BOOL finished) {
                [self showDoneWithNum:2];
                //4
                [UIView animateWithDuration:1.0 animations:^{
                    [self imageShowingCountDownImage];
                    
                } completion:^(BOOL finished) {
                    [self showDoneWithNum:1];
                    //5
                    [UIView animateWithDuration:1.0 animations:^{
                        [self imageShowingCountDownImage];
                        
                    } completion:^(BOOL finished) {
                        [self showDoneWithNum:5];
                        self.timeImgView.alpha = 0;
                        
                        //开启十秒倒计时
                        [self startTimer];
                    }];
                }];
            }];
        }];
    }];
}

///让倒计时图片展示
-(void)imageShowingCountDownImage
{
    self.timeImgView.alpha = 0;
    [self.timeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth / 2.5, KScreenWidth / 2.5));
    }];
}

///显示倒计时图片
-(void)showDoneWithNum:(NSInteger)num
{
    [self.timeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth / 4, KScreenWidth / 4));
    }];
   
    self.timeImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"shakeNum_%ld",(long)num]];
    [UIView animateWithDuration:0.2 animations:^{
        self.timeImgView.alpha = 1;
    }];
}

///摇一摇开始
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    score++;
}

///摇一摇结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    score++;
}

///测评结束去测评结果页面
- (void)goToResultViewController
{
    [self cancelTimer];
    
    SensoryResultViewController *result = [[SensoryResultViewController alloc]initWithType:pageTypeNoNavigation];
    
    result.score = score * 2;
    result.myTitle = @"大力士测试报告";
    result.testType = sensoryTypeFist;
    
    [self.navigationController pushViewController:result animated:YES];
}

#pragma mark Timer
- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFinish) userInfo:nil repeats:YES];
    count = 10;
}

- (void)timerFinish
{
    count--;
    NSLog(@"%ld",(long)count);
    self.countDownTimeLabel.text = [NSString stringWithFormat:@"%d秒",count];
    if (count <= 0 ) {
      
        self.countDownTimeLabel.text = @"10秒";
       
        [self goToResultViewController];
        
    }
}

- (void)cancelTimer
{
    [_timer invalidate];
    _timer = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
