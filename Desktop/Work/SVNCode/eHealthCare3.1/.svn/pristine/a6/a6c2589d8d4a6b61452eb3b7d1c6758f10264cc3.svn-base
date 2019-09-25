//
//  ClickBackView.m
//  eHealthCare
//
//  Created by xiekang on 16/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ClickBackView.h"

@implementation ClickBackView
{
    id _target;
    SEL _action;
    UIView *backView;
    UILabel *_whiteLal;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
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
