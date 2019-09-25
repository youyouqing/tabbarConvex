//
//  XKHistoryTotalHeadView.m
//  eHealthCare
//
//  Created by jamkin on 2017/4/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKHistoryTotalHeadView.h"

/**
 容器视图
 */
@interface XKHistoryTotalHeadView ()

@property (weak, nonatomic) IBOutlet UIView *bigView;

@property (weak, nonatomic) IBOutlet UIImageView *arrowIcon;

@end

@implementation XKHistoryTotalHeadView
{
    id _target;
    SEL _action;
  
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
//    self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, M_PI);
    
    self.bigView.backgroundColor = kMainColor;
        
}

-(void)setArrowIndex:(NSInteger)arrowIndex{
    
    _arrowIndex = arrowIndex;
    
    if (_arrowIndex == 0) {
        
        self.arrowIcon.image = [UIImage imageNamed:@"arrow3"];
        
    }else{
        
        self.arrowIcon.image = [UIImage imageNamed:@"arrow2"];
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_target && [_target respondsToSelector:_action])
    {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_action withObject:self];
#pragma clang diagnostic pop
        
    }
}



-(void)setTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

@end
