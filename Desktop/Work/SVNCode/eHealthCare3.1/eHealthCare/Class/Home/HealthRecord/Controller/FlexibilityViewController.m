//
//  FlexibilityViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "FlexibilityViewController.h"
#import "SensoryResultViewController.h"

#import "SXViewAdditions.h"

@interface FlexibilityViewController () <UIGestureRecognizerDelegate>
{
    NSTimer *_timer;
    
    ///得分
    int count;
    
    ///判断是否跳转到结果界面
    BOOL isToResult;
    
    ///手指触点一
    CGPoint pointOne;
    
    ///手指触点二
    CGPoint pointTwo;
    
    ///手指触点数
    NSInteger touchNum;
}
///倒计时label
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation FlexibilityViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isToResult = NO;
    count = 0;
    touchNum = 0;
    if (self.imageArray.count > 0) {
        [self.imageArray removeAllObjects];
    }
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
     self.view.backgroundColor = kMainColor;
    [self showTitleAndBackButtonWithoutNavigation:self.myTitle];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.text = @"双手食指轻触屏幕，并尽力保持";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    tipLabel.font = Kfont(16);
    
    [self.view addSubview:tipLabel];
    
    CGSize maxTipSize = CGSizeMake(KWidth(16), CGFLOAT_MAX);
    CGSize expectTipSize = [tipLabel sizeThatFits:maxTipSize];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(16), expectTipSize.height));
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    
    timeLabel.font = Kfont(30);
    timeLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(tipLabel.mas_top).mas_offset(- KHeight(20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(30));
    }];
    
    //双击手势
    UITapGestureRecognizer *tapDouble = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTapDouble:)];
    tapDouble.numberOfTapsRequired = 1;
    tapDouble.delegate = self;
    tapDouble.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapDouble];
}

#pragma mark Action
- (void)pressTapDouble:(UITapGestureRecognizer *)guster
{
    if (!isToResult) {
        [self goToResultViewController];
    }
}


#pragma mark Timer
- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFinish) userInfo:nil repeats:YES];
    count = 0;
}

- (void)timerFinish
{
    count++;
    NSLog(@"%d",count);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d",count];
    
    if (count >= 15)
    {
        [self goToResultViewController];
    }
    
    UIImageView *imageOne = (UIImageView *)[self.imageArray firstObject];
    UIImageView *imageTwo = (UIImageView *)[self.imageArray lastObject];
    [self startAnimationWith:imageOne withPoint:pointOne];
    [self startAnimationWith:imageTwo withPoint:pointTwo];
    
}

- (void)cancelTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark Private Methoud
///启动动画
-(void)startAnimationWith:(UIImageView *)img withPoint:(CGPoint)point
{    
    [UIView animateWithDuration:0.95 animations:^{
        img.alpha = 0;
        img.frame = CGRectMake(0, 0, KWidth(160), KWidth(160));
        img.center = point;
        
    } completion:^(BOOL finished) {
        img.frame = CGRectMake(0, 0, KWidth(50), KWidth(50));
        img.center = point;
        img.alpha = 1;
    }];
}

///测评结束去测评结果页面
- (void)goToResultViewController
{
    [self cancelTimer];
    isToResult = YES;
    
    SensoryResultViewController *result = [[SensoryResultViewController alloc]initWithType:pageTypeNoNavigation];
    
    result.score = count * 100 / 15;
    result.myTitle = @"柔韧度测试报告";
    result.testType = sensoryTypeFlexibility;
    
    [self.navigationController pushViewController:result animated:YES];
}

#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    touchNum++;
    
    //获取当前的触摸点
    CGPoint currentPoint = [touch locationInView:self.view];
    if (touchNum <= 2) {
        if (touchNum == 1) {
            pointOne = currentPoint;
        }else{
            pointTwo = currentPoint;
        }
        
        if (touchNum == 2) {
            
            for (int i = 0; i < 2; i++) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KWidth(50), KWidth(50))];
                
                if (i == 0) {
                    imageView.center = pointOne;
                }else{
                    imageView.center = pointTwo;
                }
                imageView.image = [UIImage imageNamed:@"checkCircle"];
                imageView.clipsToBounds = YES;
                
                [self.view addSubview:imageView];
                [self.imageArray addObject:imageView];
                
            }
            
            [self startTimer];
        }
    }
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!isToResult) {
        [self goToResultViewController];
    }
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