//
//  XKMorningCircleView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMorningCircleView.h"
#define degreeToRadians(X) (M_PI*(X)/180.0)
@interface XKMorningCircleView()
{

   UIImageView* _endPoint;//在终点位置添加一个点
}

@property (weak, nonatomic) IBOutlet UIView *backBottomView;


@property (nonatomic,strong)CAShapeLayer *shapeLayer;

@property (nonatomic,strong)CAShapeLayer *layer1;

@property (nonatomic,strong)CAShapeLayer *preLayer;



/**
 背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *circleImage;

@end
@implementation XKMorningCircleView


-(void)awakeFromNib
{
    
    [super awakeFromNib];
    //底部背景阴影
    self.backBottomView.layer.cornerRadius=232/2.0;
    
    self.backBottomView.layer.masksToBounds=YES;
    
    self.circleImage.layer.cornerRadius=212/2.0;
    self.circleImage.image = [UIImage imageNamed:@"bg_plus_timebg"];
    self.circleImage.layer.masksToBounds=YES;
    
    self.shapeLayer=[CAShapeLayer layer];
    
    self.shapeLayer.frame=CGRectMake(0, 0, 212, 212);
    
    UIBezierPath *path3=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 212, 212)];
    //
    //底部背景阴影一圈阴影色view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:1];
    self.shapeLayer.fillColor=[[UIColor clearColor]CGColor];
    
    self.shapeLayer.strokeColor=[[UIColor clearColor]CGColor];
    
    self.shapeLayer.lineWidth=6;
    
    self.shapeLayer.strokeStart=0.0;
    
    self.shapeLayer.strokeEnd=1.0;
    
    self.shapeLayer.path=path3.CGPath;
    
    [self.circleImage.layer addSublayer:self.shapeLayer];
    //底部背景阴影一圈白色
    self.layer1=[CAShapeLayer layer];
    
    self.layer1.frame=CGRectMake(0, 0, 212, 212);
    
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(212/2.0, 212/2.0) radius:212 / 2 startAngle:(-0.5f*M_PI) endAngle:degreeToRadians(270) clockwise:YES];//[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 212, 212)];//
    
    self.layer1.fillColor=[[UIColor clearColor]CGColor];
    
    self.layer1.strokeColor=[[UIColor whiteColor] CGColor];
    
    self.layer1.lineWidth=8;
    
    self.layer1.strokeStart=0;
    
    self.layer1.strokeEnd=0;
   
    self.layer1.path=path.CGPath;
    
    [self.circleImage.layer addSublayer:self.layer1];

    
    //用于显示结束位置的小点
    _endPoint = [[UIImageView alloc] init];
    _endPoint.frame = CGRectMake(212/2.0, 1, 20,20);//    _endPoint.hidden = true;
    _endPoint.image = [UIImage imageNamed:@"morningAndNight_dot"];
  
    [self.backBottomView addSubview:_endPoint];
    
}
-(void)setProgress:(float)progress
{
    _progress = progress;
    _layer1.strokeEnd = progress;
    [self updateEndPoint];
  
}

//更新小点的位置
-(void)updateEndPoint
{
    //转成弧度
    CGFloat angle = M_PI*2*_progress;
    float radius = (self.backBottomView.bounds.size.width-20)/2.0;
    int index = (angle)/M_PI_2;//用户区分在第几象限内
    float needAngle = angle - index*M_PI_2;//用于计算正弦/余弦的角度
    float x = 0,y = 0;//用于保存_dotView的frame
    switch (index) {
        case 0:
            NSLog(@"第一象限");
            x = radius + sinf(needAngle)*radius;
            y = radius - cosf(needAngle)*radius;
            break;
        case 1:
            NSLog(@"第二象限");
            x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break;
        case 2:
            NSLog(@"第三象限");
            x = radius - sinf(needAngle)*radius;
            y = radius + cosf(needAngle)*radius;
            break;
        case 3:
            NSLog(@"第四象限");
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break;
            
        default:
            break;
    }
    
    //更新圆环的frame
    CGRect rect = _endPoint.frame;
    rect.origin.x = x + 1;
    rect.origin.y = y + 1;
    _endPoint.frame = rect;
    //移动到最前
    [self.circleImage bringSubviewToFront:_endPoint];
    _endPoint.hidden = false;
    if (_progress == 0 || _progress == 1) {
        _endPoint.hidden = true;
    }
}
/**
 播放暂停

 @param sender
 */
- (IBAction)pauseAction:(id)sender {
    
    self.pauseBtn.selected = !self.pauseBtn.selected;
    if (_delegate && [self.delegate respondsToSelector:@selector(pauseAndBeginMusic:)]) {
        [self.delegate pauseAndBeginMusic:self.pauseBtn.selected];
    }

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
