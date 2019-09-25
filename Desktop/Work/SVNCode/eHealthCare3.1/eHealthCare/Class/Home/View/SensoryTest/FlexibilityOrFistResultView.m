//
//  FlexibilityOrFistResultView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "FlexibilityOrFistResultView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
static const CGFloat markerRadius = 4.f; // 光标直径
static const CGFloat animationTime = 2;//动画时间

@interface FlexibilityOrFistResultView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer; //进度条颜色
@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度

//@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
//@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@property (nonatomic, strong) UIImageView *tipImage;//标识图片 区分柔韧度和挥拳测试
@property (nonatomic, strong) UILabel *tipLabel;//标识文字 区分柔韧度和挥拳测试

@property (nonatomic, strong) UILabel *scoreLabel;//显示分数

@end

@implementation FlexibilityOrFistResultView

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    
    if (self) {
        self.size = size;
        self.circelRadius = self.size.width - KWidth(20);
        self.lineWidth = 3.f;
//        self.stareAngle = 0;
//        self.endAngle = 2* M_PI;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self addSubview:self.tipImage];
    
    [self.tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(30));
        make.left.mas_equalTo(self.mas_centerX).mas_offset(- KWidth(48));
        make.size.mas_equalTo(CGSizeMake(KWidth(21), KHeight(26)));
    }];
    
    [self addSubview:self.tipLabel];
    CGSize maxTipLabelSize = CGSizeMake(CGFLOAT_MAX, KHeight(18));
    CGSize expectTipLabelSize = [self.tipLabel sizeThatFits:maxTipLabelSize];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.tipImage.mas_right).mas_offset(KWidth(3));
        make.centerY.mas_equalTo(self.tipImage.mas_centerY);
        make.size.mas_equalTo(expectTipLabelSize);
    }];
    
    
    UILabel *scoreLabel = [[UILabel alloc]init];
    
    scoreLabel.font = Kfont(60);
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.tipImage.mas_bottom).mas_offset(KHeight(45));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(KHeight(60));
    }];
    
    UILabel *fullScoreLabel = [[UILabel alloc]init];
    
    fullScoreLabel.text = @"满分100分";
    fullScoreLabel.textColor = [UIColor whiteColor];
    fullScoreLabel.font = Kfont(16);
    
    [self addSubview:fullScoreLabel];
    [fullScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(scoreLabel.mas_bottom).mas_offset(KHeight(45));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(KHeight(16));
    }];
    
    [self drawArcProgressView];
}

//绘制圆弧
- (void)drawArcProgressView
{
    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.size.width / 2, self.size.height / 2)
                                                        radius:(self.circelRadius - self.lineWidth) / 2
                                                    startAngle:(CGFloat) - M_PI_2
                                                      endAngle:(CGFloat) - M_PI_2+2* M_PI
                                                     clockwise:YES];
    
    //进度底色
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomLayer.strokeColor = [UIColor getColor:@"51B2F9"].CGColor;
    self.bottomLayer.opacity = 1;
    self.bottomLayer.lineCap = kCALineCapButt;
    self.bottomLayer.lineWidth = self.lineWidth;
    self.bottomLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    self.progressLayer.lineCap = kCALineCapButt;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    [self.bottomLayer setMask:self.progressLayer];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[UIColor whiteColor].CGColor,
                                   (id)[UIColor whiteColor].CGColor,
                                   (id)[UIColor whiteColor].CGColor,
                                   (id)[UIColor whiteColor].CGColor,
                                   nil]];
    [self.gradientLayer setLocations:@[@1, @1, @1, @1]];
    [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
    [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.gradientLayer setMask:self.progressLayer];
    
    [self.layer addSublayer:self.gradientLayer];
    
    // 240 是用整个弧度的角度之和 |-200| + 20 = 220
    [self createAnimationWithStartAngle:- M_PI_2
                               endAngle:- M_PI_2+2* M_PI];
}

#pragma mark - Animation

//设置圆弧边框的起点和重点
- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
{
    // 设置动画属性
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = animationTime;
    pathAnimation.repeatCount = 1;
    
    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
    CGPathAddArc(path, &transform, self.size.width / 2, self.size.height / 2, (self.circelRadius - markerRadius / 2) / 2, startAngle, endAngle, NO);
    pathAnimation.path = path;
    CGPathRelease(path);
}

// 弧形动画
- (void)circleAnimation
{
    // 复原
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:animationTime];
    self.progressLayer.strokeEnd = self.score / 100.0;
    [CATransaction commit];
}


#pragma mark Setter
- (void)setScore:(int)score
{
    [self setScore:score animated:YES];
}

- (void)setScore:(int)score animated:(BOOL)animated
{
    _score = score;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",score];

    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(circleAnimation) userInfo:nil repeats:NO];
    
    [self createAnimationWithStartAngle:(CGFloat) - M_PI_2
                               endAngle:(CGFloat)(- M_PI_2 + (score/100) * 2 * M_PI)];
    
//    [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
//                               endAngle:degreesToRadians(self.stareAngle + 220 * score / 100)];
}

- (UIImageView *)tipImage
{
    if (!_tipImage) {
        
        _tipImage = [[UIImageView alloc]init];
    }
    
    if (_viewType == viewTypeFlexibility)
    {
        _tipImage.image = [UIImage imageNamed:@"icon_rourendu_result"];
    }else
    {
        _tipImage.image = [UIImage imageNamed:@"icon_dalishi_result"];
    }
    return _tipImage;
}
-(void)setViewType:(viewType)viewType
{
    
    _viewType = viewType;
    
    if (_viewType == viewTypeFlexibility)
    {
        _tipImage.image = [UIImage imageNamed:@"icon_rourendu_result"];
         _tipLabel.text = @"柔韧分数";
    }else
    {
        _tipImage.image = [UIImage imageNamed:@"icon_dalishi_result"];
        _tipLabel.text = @"挥拳分数";
    }
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.font = Kfont(18);
        _tipLabel.textColor = [UIColor whiteColor];
    }
    
    if (_viewType == viewTypeFlexibility)
    {
        _tipLabel.text = @"柔韧分数";
    }else
    {
        _tipLabel.text = @"挥拳分数";
    }
    return _tipLabel;
}
@end
