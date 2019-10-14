//
//  BreathTrainViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BreathTrainViewController.h"
#import "CADisplayLineImageView.h"
#import "BreathingTrainDetailViewController.h"
#import "BreathSlider.h"
#import "MusicTrainViewModel.h"
@interface BreathTrainViewController ()
{
    NSInteger jmhRank;
}
@property(nonatomic, assign)NSInteger selectTag;
@property(nonatomic, strong)BreathSlider *umberSlider;//设置训练时间
@property(nonatomic, strong)BreathSlider *breathSlider;//呼吸间隔时间
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *breathLab;
@property (weak, nonatomic) IBOutlet UIView *trainTimeView;
@property (weak, nonatomic) IBOutlet UIView *breathView;
@property (weak, nonatomic) IBOutlet UIView *facemoodView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *juniorBtn;
@property (weak, nonatomic) IBOutlet UIButton *mediuBtn;
@property (weak, nonatomic) IBOutlet UIButton *highBtn;
/**
 距离顶部便宜的位置
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iv_arrowheadCenterXCons;
@property(nonatomic, strong) NSArray *btnArr;
@end

@implementation BreathTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectTag = 1;
    [self createUI];
}

#pragma mark UI
- (void)createUI
{
    
    self.view.backgroundColor = kMainColor;
     self.startBtn.hidden = YES;
    self.btnArr = @[self.juniorBtn,self.mediuBtn,self.highBtn];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.contentLab.text = @"";
    self.breathLab.text = @"今天您心情如何";
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.top.mas_equalTo((PublicY) - 42);
        make.width.height.mas_equalTo(40);
    }];
     self.headerView.backgroundColor = kMainColor;

    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
    
    
    
    self.umberSlider = [[BreathSlider alloc] initWithFrame:CGRectMake(20, (self.trainTimeView.frame.size.height-KHeight(40))/2.0+KHeight(11), (KScreenWidth-(2*25))-40, KHeight(40))];
    self.umberSlider.titleStyle = TopTitleStyle;
    self.umberSlider.isMinute = YES;
    //设置最大和最小值
    self.umberSlider.minimumValue = 1;
    self.umberSlider.maximumValue = 15;
     self.umberSlider.minimumTrackTintColor = kMainColor;
    self.umberSlider.maximumTrackTintColor = [UIColor getColor:@"EDF1F7"];//设置滑块线条的颜色（右边）,默认是灰色
    self.umberSlider.thumbTintColor = kMainColor;///设置滑块按钮的颜色
    [self.trainTimeView addSubview:self.umberSlider];
    
    
    
    self.breathSlider = [[BreathSlider alloc] initWithFrame:CGRectMake(20, (self.breathView.frame.size.height-KHeight(40))/2.0+KHeight(11), (KScreenWidth-(2*25))-40, KHeight(40))];
    self.breathSlider.titleStyle = TopTitleStyle;
    self.breathSlider.isMinute = NO;
    //设置最大和最小值
    self.breathSlider.minimumValue = 1;
    self.breathSlider.maximumValue = 15;
    self.breathSlider.minimumTrackTintColor = kMainColor;
    self.breathSlider.maximumTrackTintColor = [UIColor getColor:@"EDF1F7"];//设置滑块线条的颜色（右边）,默认是灰色
    self.breathSlider.thumbTintColor = kMainColor;///设置滑块按钮的颜色
    [self.breathView addSubview:self.breathSlider];
    
    //初级。1/3。中级1。高级5/3
    self.umberSlider.value = self.breathSlider.value =7;
    self.iv_arrowheadCenterXCons.constant = 0;
}
#pragma mark Action
- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBeginAction:(id)sender {
    
    BreathingTrainDetailViewController *breath = [[BreathingTrainDetailViewController alloc]initWithType:pageTypeNoNavigation];
    
   
    breath.jmhRank = self.breathSlider.value;
    breath.trainTime = self.umberSlider.value;
    [self.navigationController pushViewController:breath animated:YES];
}
- (IBAction)facemoodSelectAction:(id)sender {
    
    
    UIButton *btn = (UIButton *)sender;
    jmhRank = btn.tag;
    self.contentLab.text = @"一呼一吸活跃肺部，同时减轻心理压力";
     self.breathLab.text = @"深呼吸训练";
    self.facemoodView.hidden = YES;
    self.startBtn.hidden = NO;
    
    [self loadDataMood];
}
- (IBAction)seniorAndHighSelectAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger selectTag = btn.tag-111;
    for (UIButton *btn in self.btnArr) {
        btn.titleLabel.font = [UIFont systemFontOfSize:20.f];
    }
     btn.titleLabel.font = [UIFont systemFontOfSize:24.f];
//    //滑块的值
//    [self.umberSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_offset(20);
//    }];
//
//    UIImageView *slideImage2 = (UIImageView *)[self.breathSlider.subviews lastObject];
//    //滑块的值
//    [self.breathSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.offset(40);
//        make.centerY.equalTo(slideImage2);
//    }];
    if (selectTag == _selectTag) {
        return;
    }
    
    if (selectTag == 0) {
        self.iv_arrowheadCenterXCons.constant = -((KScreenWidth-(2*25))/3.0);
//        btn.titleLabel.font = [UIFont systemFontOfSize:24.f];
        [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
                
                [self.umberSlider setValue:3 animated:YES];
                [self.breathSlider setValue:3 animated:YES];
//                if (self.breathSlider.isMinute == YES) {
//                    //滑块的响应事件
//
//                    self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n分"];
//
//
//                }else
//                    self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n秒"];
                
            }];
            self.umberSlider.sliderValueLabel.centerX = 3*self.umberSlider.width/15;
            self.breathSlider.sliderValueLabel.centerX = 3*self.umberSlider.width/15;
            
        } completion:^(BOOL finished) {
            
            self.umberSlider.value =self.breathSlider.value = 3;
//            if (self.breathSlider.isMinute == YES) {
//                //滑块的响应事件
//
//                self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n分"];
//
//
//            }else
//                self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n秒"];
        }];
        
        
    }
    if (selectTag == 1) {
        self.iv_arrowheadCenterXCons.constant = 0;
//        btn.titleLabel.font = [UIFont systemFontOfSize:24.f];
        [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
                [self.umberSlider setValue:7 animated:YES];
                [self.breathSlider setValue:7 animated:YES];
//                if (self.breathSlider.isMinute == YES) {
//                    //滑块的响应事件
//
//                    self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n分"];
//
//
//                }else
//                    self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n秒"];
            }];
            self.umberSlider.sliderValueLabel.centerX = 7*self.umberSlider.width/15;
            self.breathSlider.sliderValueLabel.centerX = 7*self.umberSlider.width/15;
            
        } completion:^(BOOL finished) {
            self.umberSlider.value =self.breathSlider.value = 7;
//            if (self.breathSlider.isMinute == YES) {
//                //滑块的响应事件
//
//                self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n分"];
//
//
//            }else
//                self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n秒"];
        }];
        
    }
    if (selectTag == 2) {
        self.iv_arrowheadCenterXCons.constant = ((KScreenWidth-(2*25))/3.0);
       
        [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
                
                [self.umberSlider setValue:15 animated:YES];
                [self.breathSlider setValue:15 animated:YES];
//                if (self.breathSlider.isMinute == YES) {
//                    //滑块的响应事件
//
//                    self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"15\n分"];
//
//
//                }else
//                    self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"15\n秒"];
            }];
            self.umberSlider.sliderValueLabel.centerX = 15*self.umberSlider.width/15;
            self.breathSlider.sliderValueLabel.centerX = 15*self.umberSlider.width/15;
            
        } completion:^(BOOL finished) {
            self.umberSlider.value =self.breathSlider.value = 15;

        }];
        
        
        
    }
    _selectTag = selectTag;
    
    
}
//- (IBAction)seniorAndHighSelectAction:(id)sender {
//    UIButton *btn = (UIButton *)sender;
//    NSInteger selectTag = btn.tag-111;
//    for (UIButton *btn in self.btnArr) {
//        btn.titleLabel.font = [UIFont systemFontOfSize:20.f];
//    }
//    if (selectTag == 0) {
//        self.iv_arrowheadCenterXCons.constant = -((KScreenWidth-(2*25))/3.0);
//        btn.titleLabel.font = [UIFont systemFontOfSize:24.f];
//        [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
//            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
//                [self.umberSlider setValue:3 animated:YES];
//                [self.breathSlider setValue:3 animated:YES];
//                if (self.breathSlider.isMinute == YES) {
//                    //滑块的响应事件
//
//                 self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n分"];
//
//
//                }else
//                   self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n秒"];
//
//            }];
//        } completion:^(BOOL finished) {
//             self.umberSlider.value =self.breathSlider.value = 3;
//            if (self.breathSlider.isMinute == YES) {
//                //滑块的响应事件
//
//                self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n分"];
//
//
//            }else
//                self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"3\n秒"];
//        }];
//
//        [UIView animateWithDuration:0.2 animations:^{
//            UIImageView *slideImage = (UIImageView *)[self.umberSlider.subviews lastObject];
//
//            //滑块的值
//            [self.umberSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////                make.width.height.offset(40);
//                make.centerY.mas_offset(20);
////                make.centerX.equalTo(slideImage);
//            }];
//
//            UIImageView *slideImage2 = (UIImageView *)[self.breathSlider.subviews lastObject];
//
//            //滑块的值
//            [self.breathSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.offset(40);
//                make.centerY.equalTo(slideImage2);
//                make.centerX.equalTo(slideImage2);
//            }];
//
//        } completion:nil];
//    }
//    if (selectTag == 1) {
//        self.iv_arrowheadCenterXCons.constant = 0;
//        btn.titleLabel.font = [UIFont systemFontOfSize:24.f];
//        [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
//            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
//                [self.umberSlider setValue:7 animated:YES];
//                [self.breathSlider setValue:7 animated:YES];
//                if (self.breathSlider.isMinute == YES) {
//                    //滑块的响应事件
//
//                    self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n分"];
//
//
//                }else
//                    self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n秒"];
//            }];
//        } completion:^(BOOL finished) {
//            self.umberSlider.value =self.breathSlider.value = 7;
//            if (self.breathSlider.isMinute == YES) {
//                //滑块的响应事件
//
//                self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n分"];
//
//
//            }else
//                self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"7\n秒"];
//        }];
//        [UIView animateWithDuration:0.2 animations:^{
//            UIImageView *slideImage = (UIImageView *)[self.umberSlider.subviews lastObject];
//
//            //滑块的值
//            [self.umberSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.offset(40);
//                make.centerY.equalTo(slideImage);
//                make.centerX.equalTo(slideImage);
//            }];
//
//            UIImageView *slideImage2 = (UIImageView *)[self.breathSlider.subviews lastObject];
//
//            //滑块的值
//            [self.breathSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.offset(40);
//                make.centerY.equalTo(slideImage2);
//                make.centerX.equalTo(slideImage2);
//            }];
//        } completion:nil];
//    }
//    if (selectTag == 2) {
//        self.iv_arrowheadCenterXCons.constant = ((KScreenWidth-(2*25))/3.0);
//        btn.titleLabel.font = [UIFont systemFontOfSize:24.f];
//        [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeCubicPaced) animations:^{
//            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
//                [self.umberSlider setValue:15 animated:YES];
//                [self.breathSlider setValue:15 animated:YES];
//                if (self.breathSlider.isMinute == YES) {
//                    //滑块的响应事件
//
//                    self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"15\n分"];
//
//
//                }else
//                    self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"15\n秒"];
//            }];
//        } completion:^(BOOL finished) {
//            self.umberSlider.value =self.breathSlider.value = 15;
//            if (self.breathSlider.isMinute == YES) {
//                //滑块的响应事件
//
//                self.umberSlider.sliderValueLabel.text =   self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"15\n分"];
//
//
//            }else
//                self.umberSlider.sliderValueLabel.text =  self.breathSlider.sliderValueLabel.text = [NSString stringWithFormat:@"15\n秒"];
//        }];
//
//
//        [UIView animateWithDuration:0.2 animations:^{
//            UIImageView *slideImage = (UIImageView *)[self.umberSlider.subviews lastObject];
//
//            //滑块的值
//            [self.umberSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.offset(40);
//                make.centerY.equalTo(slideImage);
//                make.centerX.equalTo(slideImage);
//            }];
//
//            UIImageView *slideImage2 = (UIImageView *)[self.breathSlider.subviews lastObject];
//
//            //滑块的值
//            [self.breathSlider.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.offset(40);
//                make.centerY.equalTo(slideImage2);
//                make.centerX.equalTo(slideImage2);
//            }];
//        } completion:nil];
//    }
//
//
//
//}

//#pragma mark BreathingTrainPrepareView Delegate
//- (void)choseTheLevelOfTrain:(BreathingTrainLevel)level
//{
//    BreathingTrainDetailViewController *breath = [[BreathingTrainDetailViewController alloc]initWithType:pageTypeNoNavigation];
//    
//    breath.jmhRank = self.breathSlider.value;
//    breath.trainTime = self.umberSlider.value;
//    [self.navigationController pushViewController:breath animated:YES];
//}
-(void)loadDataMood{
    
//    心情编号 1、酷 2、良好 3、没特别 4、差劲 5、糟透
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                           @"MoodID":@(jmhRank)
                          };
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [MusicTrainViewModel setUserMoodWithParams:dic FinishedBlock:^(ResponseObject *response) {
        [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            NSLog(@"200、成功 500、失败");
          
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
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