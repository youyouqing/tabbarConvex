//
//  HealthPlanView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthPlanView.h"

@implementation HealthPlanHead

-(id)init
{
    self = [super init];
    if(self){
        
        _itemWidth = 0;
        _itemFont = Kfont(14);
        _textColor = kMainTitleColor;
        _selectedColor = kMainColor;
        _linePercent = 0.3;
        _lineHieght = 2;
    }
    return self;
}

@end

/******************HealthPlanHead和HealthPlanView的分割线******************/

static int ButtonTag = 100;

@interface HealthPlanView ()
{
    ///当前页码
    NSInteger _currentIndex;
    
    ///按钮宽度
    float _buttonSpace;
    float _headViewHeight;
    float _lineWidth;
}

///顶部分类栏数据
@property (nonatomic, strong) NSArray *dataArray;

///子视图
@property (nonatomic, strong) NSArray *subVCArray;

///滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;

///当前所在位置的下标线
@property(nonatomic, strong) UIView *line;

@end

@implementation HealthPlanView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.tapAnimation = YES;
    }
    return self;
}

#pragma mark Setter
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    if(!_headView){
        NSLog(@"请先设置HeadView");
        return;
    }
    
    float x = 0;
    float y = 0;
    float width = _headView.itemWidth;
    float height = CGRectGetHeight(self.frame);
    
    for (int i = 0; i < titleArray.count; i++)
    {
        x = _headView.itemWidth * i;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        
        button.tag = ButtonTag + i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:_headView.textColor forState:UIControlStateNormal];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        if (_isPublicFont == YES) {
            button.titleLabel.font = _headView.itemFont;
        }else
            button.titleLabel.font = Kfont(17);
        
        [button addTarget:self action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        if(i == 0)
        {
            [button setTitleColor:_headView.selectedColor forState:UIControlStateNormal];
            _currentIndex = 0;
            
            //按钮下面的下划ž
            self.line = [[UIView alloc] initWithFrame:CGRectMake(_headView.itemWidth * (1 - _headView.linePercent)/2.0, CGRectGetHeight(self.frame) - _headView.lineHieght, _headView.itemWidth * _headView.linePercent, _headView.lineHieght)];
            _line.backgroundColor = _headView.selectedColor;
            [self addSubview:_line];
        }
    }
    
    self.contentSize = CGSizeMake(width * titleArray.count, height);
}


#pragma mark Action

-(void)itemButtonClicked:(UIButton*)button
{
    //接入外部效果
    _currentIndex = button.tag - ButtonTag;
    
    if(_tapAnimation){
        
        //有动画，由call is scrollView 带动线条，改变颜色
        
        
    }else{
        
        //没有动画，需要手动瞬移线条，改变颜色
        [self changeItemColor:_currentIndex];
        [self changeLine:_currentIndex];
    }
    
    [self changeScrollOfSet:_currentIndex];
    
    if(self.ItemHasBeenClickBlcok){
        self.ItemHasBeenClickBlcok(_currentIndex,_tapAnimation);
    }
    
    
}


#pragma mark - Private Method

//改变文字焦点
-(void)changeItemColor:(NSInteger)index
{
    for (int i = 0; i < _titleArray.count; i++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:i + ButtonTag];
        [button setTitleColor:_headView.textColor forState:UIControlStateNormal];
        
        if(button.tag == index + ButtonTag)
        {
            [button setTitleColor:_headView.selectedColor forState:UIControlStateNormal];
        }
    }
}

//改变线条位置
-(void)changeLine:(float)index
{
    CGRect rect = _line.frame;
    rect.origin.x = index*_headView.itemWidth + _headView.itemWidth*(1-_headView.linePercent)/2.0;
    _line.frame = rect;
}


//向上取整
- (NSInteger)changeProgressToInteger:(float)x
{
    float max = _titleArray.count;
    float min = 0;
    
    NSInteger index = 0;
    
    if(x< min+0.5){
        
        index = min;
        
    }else if(x >= max-0.5){
        
        index = max;
        
    }else{
        
        index = (x+0.5)/1;
    }
    
    return index;
}


//移动ScrollView
-(void)changeScrollOfSet:(NSInteger)index
{
    float  halfWidth = CGRectGetWidth(self.frame)/2.0;
    float  scrollWidth = self.contentSize.width;
    
    float leftSpace = _headView.itemWidth*index - halfWidth + _headView.itemWidth/2.0;
    
    if(leftSpace<0){
        leftSpace = 0;
    }
    if(leftSpace > scrollWidth - 2 * halfWidth){
        leftSpace = scrollWidth - 2 * halfWidth;
    }
    [self setContentOffset:CGPointMake(leftSpace, 0) animated:YES];
}

#pragma mark - Public Methoud
-(void)moveToIndex:(float)x
{
    [self changeLine:x];
    NSInteger tempIndex = [self changeProgressToInteger:x];
    
    if(tempIndex != _currentIndex)
    {
        //保证在一个item内滑动，只执行一次
        [self changeItemColor:tempIndex];
    }
    _currentIndex = tempIndex;
}

-(void)endMoveToIndex:(float)x
{
    [self changeLine:x];
    [self changeItemColor:x];
    _currentIndex = x;
    
    [self changeScrollOfSet:x];
}
@end