//
//  SportMessageView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportMessageView.h"

#import "CountdownButton.h"

@interface SportMessageView ()

//开始按钮
@property (nonatomic, strong) CountdownButton *startButton;

///暂停按钮
@property (nonatomic, strong) UIButton *pauseButton;

///结束完成按钮
@property (nonatomic, strong) CountdownButton *finishButton;

@end

@implementation SportMessageView

- (instancetype)initWithType:(sportCommonType)sportType
{
    self = [super init];
    
    if (self)
    {
        [self createUI];
        self.sportType = sportType;
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor blackColor];
    
    //运动类型标识
//    UIImageView *sportImage = [[UIImageView alloc]init];
//
//    [self addSubview:sportImage];
//    [sportImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(KHeight(10));
//        make.left.mas_equalTo(KWidth(12));
//        make.size.mas_equalTo(CGSizeMake(KWidth(24), KHeight(30)));
//    }];
    
    UILabel *sportLabel = [[UILabel alloc]init];
    
    sportLabel.font = Kfont(16);
    sportLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:sportLabel];
//    [sportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(sportImage.mas_top);
//        make.left.mas_equalTo(sportImage.mas_right).mas_offset(KWidth(6));
//        make.size.mas_equalTo(CGSizeMake(KWidth(55), KHeight(30)));
//    }];
    
    //设置对应类型图片和文字
    if (self.sportType == sportTypeRun)
    {
//        sportImage.image = [UIImage imageNamed:@"sport_run"];
        sportLabel.text = @"跑步";
        
    }else
    {
//        sportImage.image = [UIImage imageNamed:@"sport_bike"];
        sportLabel.text = @"骑行";
    }
    
    //里程数
    UILabel *distance = [[UILabel alloc]init];
    
    distance.font = Kfont(40);
    distance.textColor = [UIColor whiteColor];
    distance.text = @"0.00";
    distance.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:distance];
    self.distance = distance;
    
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(40));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, KHeight(40)));
        
    }];
    
    //时长 时速 消耗能量
    NSArray *titleArray = @[@"总计时间",@"平均配速(min/mk)",@"消耗热量(kcal)"];
    for (int i = 0; i < 3; i++)
    {
        UILabel *label = [[UILabel alloc]init];
        
        label.font = Kfont(14);
        label.textColor = GRAYCOLOR;//[UIColor colorWithRed:124/255. green:162/255. blue:145/255. alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleArray[i];
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(distance.mas_bottom).mas_offset(KHeight(14));
            make.left.mas_equalTo(i * KScreenWidth / 3);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth / 3, KHeight(14)));
        }];
    }
    
    //显示耗时
    MZTimerLabel *timerLabel = [[MZTimerLabel alloc]init];

    timerLabel.font = Kfont(25);
    timerLabel.textColor = [UIColor whiteColor];
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.text = @"00:00:00";

    [self addSubview:timerLabel];
    self.timerLabel = timerLabel;

    [timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(distance.mas_bottom).mas_offset(KHeight(28));
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth / 3, KHeight(25)));
    }];

    //速度
    UILabel *avgSpeed = [[UILabel alloc]init];
    
    avgSpeed.font = Kfont(25);
    avgSpeed.textColor = [UIColor whiteColor];
    avgSpeed.textAlignment = NSTextAlignmentCenter;
    avgSpeed.text = @"00'00''";
    
    [self addSubview:avgSpeed];
    self.avgSpeed = avgSpeed;
    
    [avgSpeed mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(timerLabel.mas_top);
        make.left.mas_equalTo(KScreenWidth / 3);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth / 3, KHeight(25)));
    }];
    
    //能量消耗
    UILabel *EnergyLabel = [[UILabel alloc]init];
    
    EnergyLabel.font = Kfont(25);
    EnergyLabel.textColor = [UIColor whiteColor];
    EnergyLabel.textAlignment = NSTextAlignmentCenter;
    EnergyLabel.text = @"0.0";
    
    [self addSubview:EnergyLabel];
    self.EnergyLabel = EnergyLabel;
    
    [EnergyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(timerLabel.mas_top);
        make.left.mas_equalTo(KScreenWidth / 3 * 2);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth / 3, KHeight(25)));
    }];
    
    //开始按钮
    CountdownButton *startButton = [CountdownButton buttonWithType:UIButtonTypeCustom];
    
    [startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startButton.titleLabel.font = Kfont(18);
    startButton.backgroundColor = GREENCOLOR;
    startButton.size = CGSizeMake(KWidth(100), KWidth(100));
    
    startButton.progressColor = [UIColor whiteColor];
    startButton.progressTrackColor = GREENCOLOR;
    startButton.progressWidth = 5.0f;
    
    [self addSubview:startButton];

    startButton.layer.cornerRadius = startButton.size.width / 2;
    
    startButton.layer.masksToBounds = YES;
    self.startButton = startButton;
    
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo( - KHeight(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(100), KWidth(100)));
    }];
    
    //暂停按钮
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    pauseButton.backgroundColor = kMainColor;
    [pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pauseButton.titleLabel.font = Kfont(18);
    [pauseButton addTarget:self action:@selector(pauseAction) forControlEvents:UIControlEventTouchUpInside];
    
    pauseButton.size = CGSizeMake(KWidth(100), KWidth(100));
    pauseButton.layer.cornerRadius = pauseButton.size.width / 2;
    
    pauseButton.layer.masksToBounds = YES;
    
    [self addSubview:pauseButton];
    self.pauseButton = pauseButton;
    
    [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(KWidth(25));
        make.bottom.mas_equalTo( - KHeight(10));
        make.size.mas_equalTo(CGSizeMake(KWidth(100), KWidth(100)));
    }];
    
    //结束按钮
    CountdownButton *finishButton = [CountdownButton buttonWithType:UIButtonTypeCustom];
    
    finishButton.backgroundColor = [UIColor redColor];
    [finishButton setTitle:@"长按结束" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishButton.titleLabel.font = Kfont(18);
    [finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchDown];
    [finishButton addTarget:self action:@selector(finishActionBreak:) forControlEvents:UIControlEventTouchUpInside];
    
    finishButton.size = CGSizeMake(KWidth(100), KWidth(100));
    finishButton.layer.cornerRadius = finishButton.size.width / 2;
    
    finishButton.layer.masksToBounds = YES;
    
    finishButton.progressColor = [UIColor whiteColor];
    finishButton.progressTrackColor = [UIColor redColor];
    finishButton.progressWidth = 5.0f;
    
    [self addSubview:finishButton];
    self.finishButton = finishButton;
    
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo( - KWidth(25));
        make.bottom.mas_equalTo( - KHeight(10));
        make.size.mas_equalTo(CGSizeMake(KWidth(100), KWidth(100)));
    }];
}

#pragma mark Action
- (void)startAction:(CountdownButton *)sender
{
    [sender startWithDuration:3.0f block:^(CGFloat time) {
        NSLog(@"当前时间: %f", time);
        [sender setTitle:[NSString stringWithFormat:@"%.0f",(3 - time)] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        NSLog(@"倒计时结束");
        [sender setTitle:@"开始" forState:UIControlStateNormal];
        if (self.delegate && [self.delegate respondsToSelector:@selector(sportStart)])
        {
            [self.delegate sportStart];
        }
    }];
    
}

- (void)pauseAction
{
    self.pauseButton.selected = !self.pauseButton.selected;
    [self.pauseButton setTitle:self.pauseButton.selected ?@"继续":@"暂停" forState:UIControlStateNormal];
    
    if (self.pauseButton.selected) {
        [self.timerLabel pause];
    }else
    {
        [self.timerLabel start];
        self.timerLabel.text = self.sumTime.text;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sportPauseOrReStart:)])
    {
        [self.delegate sportPauseOrReStart:self.pauseButton.selected ?YES:NO];
    }
}

- (void)finishAction:(CountdownButton *)sender
{
    [sender resume];
    [sender startWithDuration:3.0f block:^(CGFloat time) {
        NSLog(@"当前时间: %f", time);
    } completion:^(BOOL finished) {
        NSLog(@"倒计时结束");
        if (self.delegate && [self.delegate respondsToSelector:@selector(sportFinish)])
        {
            [self.delegate sportFinish];
        }
    }];
    
}

- (void)finishActionBreak:(CountdownButton *)sender
{
    [sender pause];
}

@end
