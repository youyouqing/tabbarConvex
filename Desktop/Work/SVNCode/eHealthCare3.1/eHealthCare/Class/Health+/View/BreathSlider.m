//
//  BreathSlider.m
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BreathSlider.h"
#define thumbBound_x 10
#define thumbBound_y 20

@interface BreathSlider ()
@property(nonatomic, strong) UILabel *sliderValueTwoLabel;

@property(nonatomic, assign) CGRect lastBounds;
@end
@implementation BreathSlider{
    CGFloat radius;
}
// 设置最大值
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame)/ 2, KHeight(11) / 2);
}
// 设置最小值
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), KHeight(11));
}

// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), KHeight(11));
}

//解决自定义滑块图片左右有间隙问题
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    
    rect.origin.x = rect.origin.x-10;
    rect.size.width = rect.size.width + 20;
    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    
    _lastBounds = result;
    return result;
}

//解决滑块不灵敏
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *result = [super hitTest:point withEvent:event];
    if (point.x < 0 || point.x > self.bounds.size.width){
        
        return result;
        
    }
    
    if ((point.y >= -thumbBound_y) && (point.y < _lastBounds.size.height + thumbBound_y)) {
        float value = 0.0;
        value = point.x - self.bounds.origin.x;
        value = value/self.bounds.size.width;
        
        value = value < 0? 0 : value;
        value = value > 1? 1: value;
        
        value = value * (self.maximumValue - self.minimumValue) + self.minimumValue;
        [self setValue:value animated:YES];
    }
    return result;
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= _lastBounds.origin.x - thumbBound_x) && (point.x <= (_lastBounds.origin.x + _lastBounds.size.width + thumbBound_x)) && (point.y < (_lastBounds.size.height + thumbBound_y))) {
            result = YES;
        }
        
    }
    return result;
}

-(void)setIsMinute:(BOOL)isMinute{
    _isMinute = isMinute;
    [self addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    self.continuous = YES;// 设置可连续变化
    
    // 当前值label
    self.sliderValueLabel = [[UILabel alloc] init];
    self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
    self.sliderValueLabel.font = [UIFont systemFontOfSize:14];
    self.sliderValueLabel.textColor = [UIColor whiteColor];
    self.sliderValueLabel.backgroundColor = kMainColor;
    self.sliderValueLabel.layer.cornerRadius = 40/2.0;
    self.sliderValueLabel.clipsToBounds = YES;
    self.sliderValueLabel.numberOfLines = 2;
    [self addSubview:self.sliderValueLabel];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView *slideImage = (UIImageView *)[self.subviews lastObject];
        
        //滑块的值
        [self.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //                if (self.titleStyle == TopTitleStyle) {
            //                    make.bottom.mas_equalTo(slideImage.mas_top).offset(-5);
            //                }else{
            //                    make.top.mas_equalTo(slideImage.mas_bottom).offset(5);
            //                }
            make.width.height.offset(40);
            make.centerY.equalTo(slideImage);
            make.centerX.equalTo(slideImage);
        }];
        [self bringSubviewToFront:self.sliderValueLabel];
        
    });
    if (_isMinute == YES) {
        //滑块的响应事件
      
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f\n分", self.value];
       
        
    }else
         self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f\n秒", self.value];
    
}
-(void)setValue:(float)value
{
 
    [super setValue:value];
    if (_isMinute == YES) {
        //滑块的响应事件
        
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f\n分", self.value];
        
        
    }else
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f\n秒", self.value];

    
}

- (void)sliderAction:(UISlider*)slider{
    //    //滑块的值
    if (_isMinute == YES) {
        //滑块的响应事件
        
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f\n分", self.value];
        
        
    }else
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f\n秒", self.value];
    
}


@end
