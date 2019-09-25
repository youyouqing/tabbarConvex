//
//  XKAcountHistoryHeadView.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKAcountHistoryHeadView.h"
#import "XKAcountDiscountSingleView.h"

@interface XKAcountHistoryHeadView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *stepHeightView;

/**
 中心点步数标签
 */
@property (weak, nonatomic) IBOutlet UILabel *centerLab;

/**
 滚动视图用于存放每一天走路统计的视图容器
 */
@property (weak, nonatomic) IBOutlet UIScrollView *acountContainerView;

/**
 要绘制线条的属性
 */
@property (nonatomic,strong) CAShapeLayer *lineLayer;

/**
 要绘制线条的路径
 */
@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic,strong) NSMutableArray *replaceArray;

/**
 用户展示当前展示数据的下标
 */
@property (nonatomic,assign) NSInteger currentIndex;

/**
 有效视图容器数组
 */
@property (nonatomic,strong) NSMutableArray *effectiveVeiwArray;

/**
 占位视图容器数组
 */
@property (nonatomic,strong) NSMutableArray *invalidViewArray;

@end

@implementation XKAcountHistoryHeadView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.acountContainerView.delegate = self;
    
    self.effectiveVeiwArray = [NSMutableArray arrayWithCapacity:0];
    
    self.invalidViewArray = [NSMutableArray arrayWithCapacity:0];
    
}

//重新步数数据源set方法
-(void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    
    //清空之前的子视图
    for (UIView *v in self.acountContainerView.subviews) {
        [v removeFromSuperview];
    }
    
    //清空之前占位的子视图
    for (UIView *v in self.invalidViewArray) {
        [v removeFromSuperview];
    }
    self.invalidViewArray = [NSMutableArray arrayWithCapacity:0];
    
    //最前面空三个位置占位
    for (NSInteger i = 0; i<=2; i++) {
        
        XKAcountDiscountSingleView *acount = [[[NSBundle mainBundle] loadNibNamed:@"XKAcountDiscountSingleView" owner:self options:nil] firstObject];
        acount.x = i*KScreenWidth/7;
        acount.y = KScreenHeight/2-4-55;
        acount.width = KScreenWidth/7;
        acount.height = 55;
        
        [self.acountContainerView addSubview:acount];
        
        [self.invalidViewArray addObject:acount];
        
    }
    
    //给父容器容量的大小
    [self.acountContainerView setContentSize:CGSizeMake(KScreenWidth/7*(dataArray.count+6), KScreenHeight/2-4)];
    
    //清除有限视图数据的view
    for (UIView *v in self.effectiveVeiwArray) {
        [v removeFromSuperview];
    }
    self.effectiveVeiwArray = [NSMutableArray arrayWithCapacity:0];
    //初始化子视图
    for (NSInteger i = 0; i<dataArray.count; i++) {
        
        XKAcountDiscountSingleView *acount = [[[NSBundle mainBundle] loadNibNamed:@"XKAcountDiscountSingleView" owner:self options:nil] firstObject];
        acount.x = i*KScreenWidth/7+KScreenWidth/7*3;
        acount.y = KScreenHeight/2-4-55;
        acount.width = KScreenWidth/7;
        acount.height = 55;
        
        [self.acountContainerView addSubview:acount];
        
        [self.effectiveVeiwArray addObject:acount];
        
    }
    
    //最后面空三个位置占位
    for (NSInteger i = 0; i<=2; i++) {
        
        XKAcountDiscountSingleView *acount = [[[NSBundle mainBundle] loadNibNamed:@"XKAcountDiscountSingleView" owner:self options:nil] firstObject];
        acount.x = i*KScreenWidth/7+KScreenWidth/7*3+dataArray.count*KScreenWidth/7;
        acount.y = KScreenHeight/2-4-55;
        acount.width = KScreenWidth/7;
        acount.height = 55;
        
        [self.acountContainerView addSubview:acount];
        
        [self.invalidViewArray addObject:acount];
        
    }
    
    [self.acountContainerView setContentOffset:CGPointMake((dataArray.count-1)*KScreenWidth/7, 0)];
    
    //强制更新约束
    [self layoutIfNeeded];
   
    //处理数据中大于12000的情况
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i=0;i< _dataArray.count;i++) {
        NSNumber *num = [_dataArray objectAtIndex:i];
        NSInteger acountNum = [num intValue];
        if (acountNum > 12000) {
            acountNum = 12000;
        }
        [array addObject:@(acountNum)];
        
    }
    self.replaceArray = array;
    //绘制线条
    [self drawLineWithData:array];
    
    self.currentIndex = array.count - 1;
    
}

//停下来触发刷新数据的方法
-(void)setCurrentIndex:(NSInteger)currentIndex{
    
    _currentIndex = currentIndex;
    
//    [self parentController].title = @"9月14日";
    
    if (_currentIndex < 0) {
        self.centerLab.text = [NSString stringWithFormat:@"%@",self.dataArray[0]];
        
        StepModel * stModel = self.orgionalArray[0];
       
        
        if ([self.delegate respondsToSelector:@selector(showCurrentDayData:)]) {
            [self.delegate showCurrentDayData:self.orgionalArray[0]];
        }
        if ([self.centerLab.text isEqualToString:@"0"]) {
            self.centerLab.hidden = self.stepHeightView.hidden = YES;
        }else
        {
            self.centerLab.hidden = self.stepHeightView.hidden = NO;
            
        }
        
        return;
    }
    
    if (_currentIndex > self.dataArray.count-1) {
        self.centerLab.text = [NSString stringWithFormat:@"%@",self.dataArray[self.dataArray.count-1]];
        
        StepModel * stModel = self.orgionalArray[self.dataArray.count-1];
        
        if ([self.centerLab.text isEqualToString:@"0"]) {
           self.centerLab.hidden = self.stepHeightView.hidden = YES;
        }else
        {
            self.centerLab.hidden = self.stepHeightView.hidden = NO;
            
        }
        
        
        if ([self.delegate respondsToSelector:@selector(showCurrentDayData:)]) {
            [self.delegate showCurrentDayData:self.orgionalArray[self.orgionalArray.count-1]];
        }
        return;
    }
    
    StepModel * stModel = self.orgionalArray[currentIndex];
    self.centerLab.text = [NSString stringWithFormat:@"%@",self.dataArray[currentIndex]];
    
    if ([self.centerLab.text isEqualToString:@"0"]) {
        self.centerLab.hidden = self.stepHeightView.hidden = YES;
    }else
    {
        self.centerLab.hidden = self.stepHeightView.hidden = NO;
        
    }
    

    
    if ([self.delegate respondsToSelector:@selector(showCurrentDayData:)]) {
        [self.delegate showCurrentDayData:self.orgionalArray[currentIndex]];
    }
}

/**
 简单的绘制线条
 */
-(void)drawLineWithData:(NSMutableArray *)array{
    
    //绘制线条之前 清空之前的线条
    [self.lineLayer removeFromSuperlayer];
    [self.path removeAllPoints];
    
    //初始高度为55 除去日期部分
    CGFloat startHeight = 55;
    //每一步所占比例
    CGFloat onceProportion = (KScreenHeight/2-4-55-64)/12000;
    
    //初始化layer 和绘制路径
    self.lineLayer=[CAShapeLayer layer];
    self.lineLayer.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight/2-4);
    self.path=[UIBezierPath bezierPath];
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger acountNum = [array[i] integerValue];
        //计算绘制点的坐标
        CGFloat pointX = (KScreenWidth/7)*i+(KScreenWidth/7/2)+KScreenWidth/7*3;
        CGFloat pointY = (KScreenHeight/2-4)-(acountNum * onceProportion) - startHeight;
        
        CGPoint point = CGPointMake(pointX, pointY);
        
        if (i == 0) {//第一个点添加
             [self.path moveToPoint:point];
        }else{//否则移动
            [self.path addLineToPoint:point];
        }
    }
    
    self.lineLayer.strokeColor = [UIColor getColor:@"42d8eb"].CGColor;//线条颜色
    
    self.lineLayer.lineWidth=2;//线条宽度
    
    self.lineLayer.fillColor=[UIColor clearColor].CGColor;//线条填充颜色
    
    self.lineLayer.path=self.path.CGPath;//路径赋值
    
    [self.acountContainerView.layer addSublayer:self.lineLayer];//添加图层
    
    //画圆点
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger acountNum = [array[i] integerValue];
        //计算绘制点的坐标
        CGFloat pointX = (KScreenWidth/7)*i+(KScreenWidth/7/2)+KScreenWidth/7*3;
        CGFloat pointY = (KScreenHeight/2-4)-(acountNum * onceProportion) - startHeight;
        
        if (acountNum != 0) {//画圆点
            CGRect frame = CGRectMake(pointX-6, pointY-8, 12, 12);
            
            UIBezierPath *path1=[UIBezierPath bezierPathWithOvalInRect:frame];
            
            CAShapeLayer *layer1=[CAShapeLayer layer];
            
            layer1.frame=self.acountContainerView.frame;
            
            layer1.fillColor=[[UIColor getColor:@"42d8eb"]CGColor];
            
            layer1.strokeColor=[UIColor whiteColor].CGColor;
            
            layer1.lineWidth=3;
            
            layer1.strokeStart=0.0;
            
            layer1.strokeEnd=1.0;
            
            layer1.path=path1.CGPath;
            
            [self.acountContainerView.layer addSublayer:layer1];
            
            
        }
        
    }
    
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    CGPoint contentOffSet = scrollView.contentOffset;
    
    NSInteger count = contentOffSet.x/(KScreenWidth/7);
    
    if (contentOffSet.x - count*KScreenWidth/7>= KScreenWidth/7/2) {
        [UIView animateWithDuration:1.0 animations:^{
          [scrollView setContentOffset:CGPointMake((count+1)*KScreenWidth/7, 0)];
        }];
        self.currentIndex = count+1;
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            [scrollView setContentOffset:CGPointMake(count*KScreenWidth/7, 0)];
        }];
        self.currentIndex = count;
    }
    
    NSLog(@"%li",count);
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint contentOffSet = scrollView.contentOffset;
    
    NSInteger count = contentOffSet.x/(KScreenWidth/7);
    
    if (contentOffSet.x - count*KScreenWidth/7>= KScreenWidth/7/2) {
        [UIView animateWithDuration:1.0 animations:^{
            [scrollView setContentOffset:CGPointMake((count+1)*KScreenWidth/7, 0)];
        }];
        self.currentIndex = count+1;
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            [scrollView setContentOffset:CGPointMake(count*KScreenWidth/7, 0)];
        }];
        self.currentIndex = count;
    }
     NSLog(@"%li",count);
}


/**
 重写数据源
 */
-(void)setOrgionalArray:(NSArray *)orgionalArray{
    
    _orgionalArray = orgionalArray;
    
    //给有效控件赋值
    for (int i=0; i<orgionalArray.count; i++) {
        StepModel *stModel = orgionalArray[i];
        XKAcountDiscountSingleView *countView = self.effectiveVeiwArray.count>0? self.effectiveVeiwArray[i]:nil;
        countView.model = stModel;
    }
    
    //处理前三个占位视图
    [self dealWithPreThreeView:orgionalArray[0]];
    
    //处理后三个占位视图
    [self dealWithNextThreeView:orgionalArray[orgionalArray.count-1]];
}

/**
 处理前三个占位视图的方法
 */
-(void)dealWithPreThreeView:(StepModel *)model{
    
    StepModel *model1 = [[StepModel alloc]init];
    model1.CreateTime = model.CreateTime-24*60*60*1000;
    XKAcountDiscountSingleView *view1 = self.invalidViewArray[0];
    
    StepModel *model2 = [[StepModel alloc]init];
    model2.CreateTime = model1.CreateTime-24*60*60*1000;
    XKAcountDiscountSingleView *view2 = self.invalidViewArray[1];
    view2.model = model2;
    
    StepModel *model3 = [[StepModel alloc]init];
    model3.CreateTime = model2.CreateTime-24*60*60*1000;
    XKAcountDiscountSingleView *view3 = self.invalidViewArray[2];
    
    
    view3.model = model1;
    view1.model = model3;
}

-(void)dealWithNextThreeView:(StepModel *)model{
    
    StepModel *model1 = [[StepModel alloc]init];
    model1.CreateTime = model.CreateTime+24*60*60*1000;
    XKAcountDiscountSingleView *view1 = self.invalidViewArray[3];
    view1.model = model1;
    
    StepModel *model2 = [[StepModel alloc]init];
    model2.CreateTime = model1.CreateTime+24*60*60*1000;
    XKAcountDiscountSingleView *view2 = self.invalidViewArray[4];
    view2.model = model2;
    
    StepModel *model3 = [[StepModel alloc]init];
    model3.CreateTime = model2.CreateTime+24*60*60*1000;
    XKAcountDiscountSingleView *view3 = self.invalidViewArray[5];
    view3.model = model3;
    
}

@end
