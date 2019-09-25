//
//  CheckHeaderResultView.m
//  NewEquipmentCheck
//
//  Created by xiekang on 2017/8/16.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CheckHeaderResultView.h"
#import "HeartLive.h"
#define kBorderWith 1

@interface CheckHeaderResultView ()
{
    UIImageView* _endPoint;//检测位置过程中添加一个点
    BOOL is_rep;
    
    
    CALayer* imageLayer;//绘制波形图
    
    NSMutableArray *points;
}
@property (weak, nonatomic) IBOutlet UIView *topCircleView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, assign) NSInteger number;//移动5个点   再偏移
@property (nonatomic , strong) HeartLive *refreshMoniterView;
@property (nonatomic , strong) HeartLive *translationMoniterView;
@property (weak, nonatomic) IBOutlet UIView *OxygenView;


@property (nonatomic,strong)CAShapeLayer *shapeLayer;
//底部的背景图
@property (weak, nonatomic) IBOutlet UIView *bottomLowView;


@property (nonatomic,strong)CAShapeLayer *preLayer;

@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@property (weak, nonatomic) IBOutlet UIView *showView;

/**
 脂肪率
 */
@property (weak, nonatomic) IBOutlet UILabel *sLvLab;


@property (weak, nonatomic) IBOutlet UIButton *scopebtn;

@end

@implementation CheckHeaderResultView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    
    self.shapeLayer=[CAShapeLayer layer];
    
    self.shapeLayer.frame=CGRectMake(0, 0, 187, 187);
    
    UIBezierPath *path3=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 187, 187)];
    
    self.shapeLayer.fillColor=[[UIColor clearColor]CGColor];
    
    self.shapeLayer.strokeColor=[[UIColor whiteColor]CGColor];
    
    self.shapeLayer.lineWidth=2;
    
    self.shapeLayer.strokeStart=0.0;
    
    self.shapeLayer.strokeEnd=1.0;
    
    self.shapeLayer.path=path3.CGPath;
    
    [self.showView.layer addSublayer:self.shapeLayer];
    
    is_rep = YES;
    // [self detectingCourse];
    
    
    self.lineView.hidden = YES;
    
    imageLayer = [CALayer layer];
    imageLayer.frame = self.OxygenView.layer.bounds;
    imageLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.OxygenView.layer addSublayer:imageLayer];
    
    
    [self.OxygenView addSubview:self.refreshMoniterView];
    

    
}
- (HeartLive *)refreshMoniterView
{
    if (!_refreshMoniterView) {
        CGFloat xOffset = 0;
        _refreshMoniterView = [[HeartLive alloc] initWithFrame:CGRectMake(xOffset, 20, CGRectGetWidth(self.OxygenView.frame) - 2 * xOffset, 104)];
        _refreshMoniterView.backgroundColor = [UIColor clearColor];
    }
    return _refreshMoniterView;
}

- (HeartLive *)translationMoniterView
{
    if (!_translationMoniterView) {
        CGFloat xOffset = 0;
        _translationMoniterView = [[HeartLive alloc] initWithFrame:CGRectMake(xOffset, CGRectGetMaxY(self.refreshMoniterView.frame) + 10, CGRectGetWidth(self.OxygenView.frame) - 2 * xOffset, 104)];
        _translationMoniterView.backgroundColor = [UIColor clearColor];;
    }
    return _translationMoniterView;
}
-(void)setMode:(ExchinereportModel *)mode
{

    _mode = mode;
    
    self.BMILab.text = mode.Unit;

    [self.scopebtn setTitle:[NSString stringWithFormat:@"理想范围：%@",mode.ReferenceValue] forState:UIControlStateNormal];
   
    
    if (self.mode.ParameterStatus == 1) {
        self.scoreLab.text = @"偏高";
        
//        self.backgroundColor = [UIColor colorWithHexString:@"FF7342"];
        self.topCircleView.backgroundColor = [UIColor colorWithHexString:@"FF7342"];
        
    }
    if (self.mode.ParameterStatus == 2) {
        self.scoreLab.text = @"正常";
//          self.backgroundColor = [UIColor colorWithHexString:@"25D352"];
         self.topCircleView.backgroundColor = [UIColor colorWithHexString:@"25D352"];
    }

    if (self.mode.ParameterStatus == 3) {
        self.scoreLab.text = @"偏低";
//        self.backgroundColor = [UIColor colorWithHexString:@"F3C331"];
         self.topCircleView.backgroundColor = [UIColor colorWithHexString:@"F3C331"];
    }

    if ([self.mode.Unit isEqualToString:@"%"]) {
        self.oxygenBottomView.backgroundColor = self.topCircleView.backgroundColor;
        
        
        
    }else
        self.oxygenBottomView.backgroundColor = [UIColor whiteColor];
    self.OxygenView.backgroundColor = self.oxygenBottomView.backgroundColor;
//    self
    self.refreshMoniterView.backgroundColor = self.oxygenBottomView.backgroundColor;
}

-(void)detectingCourse{
    
    //用于显示结束位置的小点
    _endPoint = [[UIImageView alloc] init];
    
    _endPoint.frame = CGRectMake((self.showView.bounds.size.width-187)/2.0+187-10, (self.showView.bounds.size.height-187)/2.0+187/2.0-10, 20,20);
    
    _endPoint.image = [UIImage imageNamed:@"morningAndNight_dot"];
    
    [self.showView addSubview:_endPoint];
 
    CAKeyframeAnimation *path=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //矩形的中心就是圆心
    CGRect rect=CGRectMake((self.showView.bounds.size.width-187)/2.0, (self.showView.bounds.size.height-187)/2.0, 187, 187);
    path.duration=1;
    //绕此圆中心转
    path.path=CFAutorelease(CGPathCreateWithEllipseInRect(rect, NULL));
    path.calculationMode=kCAAnimationPaced;
    path.rotationMode=kCAAnimationRotateAuto;
    path.repeatCount = 10000;
    //    pat
    [_endPoint.layer addAnimation:path forKey:@"round"];
    
}

/**
 转圈动画  开始停止
 */
- (void)TouchCircleAndHide {
    is_rep = !is_rep;
    if (is_rep) {
        [_endPoint removeFromSuperview];
    }else{
        [self detectingCourse];
       
        
        
    }
}
//隐藏停止动画
- (void)StopCircleAninmationAndHide {
    [UIView animateWithDuration:0.5 animations:^{
        [self.refreshMoniterView removeFromSuperview];
        
         self.lineView.hidden = NO;
    }];

    [_endPoint removeFromSuperview];
 
}
/**
 再来一次

 @param sender <#sender description#>
 */
- (IBAction)againAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(AgainC:)]) {


        [self.delegate AgainC:self];
    }
    
    
}


-(void)setDataSource:(NSArray *)dataSource
{

    _dataSource = dataSource;
    
    
    [self timerRefresnFun];
}

#pragma mark -
#pragma mark - 哟

//刷新方式绘制
- (void)timerRefresnFun
{
    [[PointContainer sharedContainer] addPointAsRefreshChangeform:[self bubbleRefreshPoint]];
    [[PointContainer sharedContainer] addPointAsRefreshChangeform:[self bubbleRefreshPoint]];
    [[PointContainer sharedContainer] addPointAsRefreshChangeform:[self bubbleRefreshPoint]];
    [[PointContainer sharedContainer] addPointAsRefreshChangeform:[self bubbleRefreshPoint]];
    
    
    [self.refreshMoniterView fireDrawingWithPoints:[PointContainer sharedContainer].refreshPointContainer pointsCount:[PointContainer sharedContainer].numberOfRefreshElements];
    
}

//平移方式绘制
- (void)timerTranslationFun
{
    [[PointContainer sharedContainer] addPointAsTranslationChangeform:[self bubbleTranslationPoint]];
    
    [self.translationMoniterView fireDrawingWithPoints:[[PointContainer sharedContainer] translationPointContainer] pointsCount:[[PointContainer sharedContainer] numberOfTranslationElements]];
    
    //    printf("当前元素个数:%2d->",[PointContainer sharedContainer].numberOfElements);
    //    for (int k = 0; k != [PointContainer sharedContainer].numberOfElements; ++k) {
    //        printf("(%4.0f,%4.0f)",[PointContainer sharedContainer].pointContainer[k].x,[PointContainer sharedContainer].pointContainer[k].y);
    //    }
    //    putchar('\n');
    
}
#pragma mark -
#pragma mark - DataSource
- (CGPoint)bubbleRefreshPoint
{
    static NSInteger dataSourceCounterIndex = -1;
    dataSourceCounterIndex ++;
    dataSourceCounterIndex %= [self.dataSource count];
    
    
    NSInteger pixelPerPoint = 1;
    static NSInteger xCoordinateInMoniter = 0;
    
    CGPoint targetPointToAdd = (CGPoint){xCoordinateInMoniter,[self.dataSource[dataSourceCounterIndex] integerValue] * 0.3 };
    xCoordinateInMoniter += pixelPerPoint;
    xCoordinateInMoniter %= (int)(CGRectGetWidth(self.translationMoniterView.frame));
    
    NSLog(@"吐出来的点:%@",NSStringFromCGPoint(targetPointToAdd));
    return targetPointToAdd;
}

- (CGPoint)bubbleTranslationPoint
{
    static NSInteger dataSourceCounterIndex = -1;
    dataSourceCounterIndex ++;
    dataSourceCounterIndex %= [self.dataSource count];
    
    
    NSInteger pixelPerPoint = 1;
    static NSInteger xCoordinateInMoniter = 0;
    
    CGPoint targetPointToAdd = (CGPoint){xCoordinateInMoniter,[self.dataSource[dataSourceCounterIndex] integerValue] * 0.3 };
    xCoordinateInMoniter += pixelPerPoint;
    xCoordinateInMoniter %= (int)(CGRectGetWidth(self.translationMoniterView.frame));
    
    //    NSLog(@"吐出来的点:%@",NSStringFromCGPoint(targetPointToAdd));
    return targetPointToAdd;
}

- (void)changeDataSource
{
    self.number ++;
    if (self.number > 6) {
        self.number = 0;
    }
    
}

@end
