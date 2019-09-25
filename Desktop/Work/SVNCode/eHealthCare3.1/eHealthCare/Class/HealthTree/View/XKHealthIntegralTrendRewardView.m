//
//  XKHealthIntegralTrendRewardView.m
//  eHealthCare
//
//  Created by John shi on 2018/12/6.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "XKHealthIntegralTrendRewardView.h"

@implementation XKHealthIntegralTrendRewardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
////绘制颜色渐变的方法
//-(CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
//    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = view.bounds;
//    //  创建渐变色数组，需要转换为CGColor颜色
//    gradientLayer.colors = @[(__bridge id)[UIColor getColor:fromHexColorStr].CGColor,(__bridge id)[UIColor getColor:toHexColorStr].CGColor];
//    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
//    gradientLayer.startPoint = CGPointMake(1, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
//    //  设置颜色变化点，取值范围 0.0~1.0
//    gradientLayer.locations = @[@0,@1];
//
//    return gradientLayer;
//}

/**画背景线条方法*/
-(void)drawBackLine:(NSInteger) count{
    //7等分每个格子所占宽段
    CGFloat oneWitd = ([UIScreen mainScreen].bounds.size.width-12)/7;
    //每个线条宽度
    CGFloat lineWitd = 0.5;
    //每个线条高度
    CGFloat lineHeight = [UIScreen mainScreen].bounds.size.height*2/5-120;
    //每个线条的y轴初始值
    CGFloat lineStartY = 40;
    //便利画7条条线
    for (int i=0; i<self.dataArray.count; i++) {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2/5);
    lineLayer.fillColor=[[UIColor getColor:@"eaeaea"]CGColor];
    lineLayer.strokeColor=[[UIColor getColor:@"eaeaea"]CGColor];
        lineLayer.lineWidth=lineWitd/2;
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRect:CGRectMake(i*oneWitd+oneWitd/2-0.25, lineStartY, lineWitd, lineHeight)];
        lineLayer.path = linePath.CGPath;
        [self.topDrawView.layer addSublayer:lineLayer];
    }
}

-(void)drawData:(NSArray *)dataArry{
        //7等分每个格子所占宽段
        CGFloat oneWitd = ([UIScreen mainScreen].bounds.size.width-12)/7;
        //每个线条高度
        CGFloat lineHeight = [UIScreen mainScreen].bounds.size.height*2/5-120;
        //每个线条的y轴初始值
        CGFloat lineStartY = 40;
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [[UIColor clearColor]CGColor];
        layer.strokeColor = [[UIColor getColor:@"03C7FF"]CGColor];
        layer.lineWidth = 4;
        layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2/5);
            UIBezierPath *path = [UIBezierPath bezierPath];
            //    NSArray *dataArray = @[@70,@80,@30,@120,@90,@40,@60]; //模拟数据 数组
            for (int i = 0; i < dataArry.count; i ++) {//便利数组画点划线
                XKHealthIntegralKTrendModel *model = self.dataArray[i];
                if (i <= 6) {
                    NSInteger kVa = model.FlowValue;
                    //给显示数据的标签赋值
                    UILabel *lab = self.showLabArray[i];
                    lab.text = [NSString stringWithFormat:@"%li",kVa];
                    
                    if (kVa >= 100) {//判断数值是否大于100 大于100就让其等于100
                        kVa = 100;
                    }
                    //计算每一个点的y值
                    CGFloat one = lineHeight/100;//每一份所占高度
                    CGFloat pointY=(lineHeight+lineStartY) - (kVa*one)+2;
                    //给约束的头部约束赋值
                    NSLayoutConstraint *cons = self.consArray[i];
                    cons.constant = pointY-20;
                    
                    if (i==0) {
                        [path  moveToPoint:CGPointMake(i*oneWitd+oneWitd/2, pointY)];
                    }else{
                        [path addLineToPoint:CGPointMake(i*oneWitd+oneWitd/2, pointY)];
        }
        }
}
layer.path = path.CGPath;
[self.topDrawView.layer insertSublayer:layer atIndex:0];
//    [self.topDrawView.layer addSublayer:layer];

for (int i = 0; i < dataArry.count; i ++) {//便利数组画点划线
    XKHealthIntegralKTrendModel *model = self.dataArray[i];
    if (i <= 6) {
        NSInteger kVa = model.FlowValue;
        if (kVa >= 100) {//判断数值是否大于100 大于100就让其等于100
            kVa = 100;
        }
        //计算每一个点的y值
        CGFloat one = lineHeight/100;//每一份所占高度
        CGFloat pointY=(lineHeight+lineStartY) - (kVa*one); //注：-3 个单位是3.0.8版本调整改变的 原来版本是-5
        CGRect frame = CGRectMake(i*oneWitd+oneWitd/2-5, pointY-3, 10, 10);
        UIBezierPath *path1=[UIBezierPath bezierPathWithOvalInRect:frame];
        CAShapeLayer *layer1=[CAShapeLayer layer];
        layer1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2/5);
        layer1.fillColor=[[UIColor getColor:@"03C7FF"]CGColor];
        layer1.strokeColor=[UIColor getColor:@"03C7FF"].CGColor;
        layer1.lineWidth=3;
        layer1.strokeStart=0.0;
        layer1.strokeEnd=1.0;
        layer1.path=path1.CGPath;
        [self.topDrawView.layer addSublayer:layer1];
        
        //注：-6.5 个单位是3.0.8版本调整改变的 原来版本是-5。这是给他加一圈圈的边缘的影子
        //            CGRect frame2 = CGRectMake(i*oneWitd+oneWitd/2-7.5, pointY-5, 15, 15);
        //            UIBezierPath *path2=[UIBezierPath bezierPathWithOvalInRect:frame2];
        //            CAShapeLayer *layer2=[CAShapeLayer layer];
        //            layer2.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2/5);
        //            layer2.fillColor=[[UIColor clearColor]CGColor];
        //            layer2.strokeColor=[[UIColor getColor:@"03C7FF"] colorWithAlphaComponent:0.3].CGColor;
        //            layer2.lineWidth=4;
        //            layer2.strokeStart=0.0;
        //            layer2.strokeEnd=1.0;
        //            layer2.path=path2.CGPath;
        //            [self.topDrawView.layer addSublayer:layer2];
        
    }
}
}

/**
 展示底部数据的方法
 */
-(void)showBottomData{
    //清空之前的数据
    for (UILabel *lab in self.KArray) {
        lab.text = @"";
    }
    for (UILabel *lab in self.KtimeArray) {
        lab.text = @"";
    }
    NSMutableArray  *dataA2 =(NSMutableArray *)[[self.dataArray reverseObjectEnumerator] allObjects];
    for (NSInteger i=0; i<dataA2.count; i++) {
        XKHealthIntegralKTrendModel *model = dataA2[i];
        UILabel *lab1 = self.KArray[i];
        lab1.text = [NSString stringWithFormat:@"%li",model.FlowValue];
        UILabel *lab = self.KtimeArray[i];
        lab.text = model.strTime1;
    }
    
}

/**
 展示头部视图时间给头部视图赋值
 */
-(void)showTopTime{
    //清空之前的显示数据
    for (UILabel *lab in self.timeArray) {
        lab.text  = @"";
    }
    for (UILabel *lab in self.YtimeArray) {
        lab.text  = @"";
    }
    for (int i=0; i<self.dataArray.count; i++) {
        XKHealthIntegralKTrendModel *model = self.dataArray[i];
        if (i <= 6) {
            UILabel *lab = self.timeArray[i];
            lab.text = model.strTime;
            
            UILabel *lab2 = self.YtimeArray[i];
            lab2.text = model.strTime2;
        }
    }
    
}

/**
 展示头部视图k值的方法的方法
 */
-(void)showTopK{
    //清空之前的显示数据
    for (UILabel *lab in self.showLabArray) {
        lab.text  = @"";
    }
    
    for (int i=0; i<self.dataArray.count; i++) {
        XKHealthIntegralKTrendModel *model = self.dataArray[i];
        if (i <= 6) {
            UILabel *lab = self.showLabArray[i];
            lab.text = [NSString stringWithFormat:@"%li",model.FlowValue];
        }
    }
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.topKValueCons.constant = 6.f;
    self.timeArray = @[[self.topDrawView viewWithTag:1001],[self.topDrawView viewWithTag:1002],[self.topDrawView viewWithTag:1003],[self.topDrawView viewWithTag:1004],[self.topDrawView viewWithTag:1005],[self.topDrawView viewWithTag:1006],[self.topDrawView viewWithTag:1007]];
    
    self.YtimeArray = @[[self.topDrawView viewWithTag:4001],[self.topDrawView viewWithTag:4002],[self.topDrawView viewWithTag:4003],[self.topDrawView viewWithTag:4004],[self.topDrawView viewWithTag:4005],[self.topDrawView viewWithTag:4006],[self.topDrawView viewWithTag:4007]];
    self.KArray = @[[self.bottomDataView viewWithTag:2001],[self.bottomDataView viewWithTag:2002],[self.bottomDataView viewWithTag:2003],[self.bottomDataView viewWithTag:2004],[self.bottomDataView viewWithTag:2005],[self.bottomDataView viewWithTag:2006],[self.bottomDataView viewWithTag:2007]];
    self.KtimeArray = @[[self.bottomDataView viewWithTag:3001],[self.bottomDataView viewWithTag:3002],[self.bottomDataView viewWithTag:3003],[self.bottomDataView viewWithTag:3004],[self.bottomDataView viewWithTag:3005],[self.bottomDataView viewWithTag:3006],[self.bottomDataView viewWithTag:3007]];
    
    //存放标签
    self.showLabArray = @[self.showDataLabOne,self.showDataLabTwo,self.showDataLabThree,self.showDataLabFour,self.showDataLabFive,self.showDataLabSix,self.showDataLabSeven];
    if (IS_IPHONE5) {
        for (UILabel *lab in self.showLabArray) {
            lab.font = [UIFont systemFontOfSize:9];
        }
        
    }
    
    //将标签隐藏起来
    for (UILabel *lab in self.showLabArray) {
        lab.hidden = YES;
    }
    //存放约束
    self.consArray = @[self.showTopConsOne,self.showTopConsTwo,self.showTopConsThree,self.showTopConsFour,self.showTopConsFive,self.showTopConsSix,self.showTopConsSeven];
    
   
    
    
    
    //数据概括圆角效果
    UILabel *lab = [self viewWithTag:999];
    lab.layer.cornerRadius = 5;
    lab.layer.masksToBounds = YES;
    
    
}
-(void)setDataArray:(NSArray *)dataArray
{
    
    _dataArray = dataArray;
    //画背景线条
    [self drawBackLine:self.dataArray.count];
    //showTopTime
    [self showTopK];//展示头部K值
    [self showTopTime];//展示头部时间
    [self showBottomData];//展示底部数据
    
    [self drawData:self.dataArray];//展示线条的方法
    
    //将标签显示出来
    for (UILabel *lab in self.showLabArray) {
        lab.hidden = NO;
    }
    
}
@end
