//
//  PersonalCellHeadView.m
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonalCellHeadView.h"
@interface PersonalCellHeadView()
@end
@implementation PersonalCellHeadView
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
        _whiteLal = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 15)];
        [self addSubview:_whiteLal];
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_whiteLal.frame), frame.size.width, frame.size.height - _whiteLal.frame.size.height)];
        [self addSubview:backView];
        
        _nameLal = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 100, 50)];
        if (IS_IPHONE5) {
            _nameLal.font = [UIFont systemFontOfSize:15.5];
        }else{
            _nameLal.font = [UIFont systemFontOfSize:17];
        }
        _nameLal.text = @"姓名";
        _nameLal.textColor = BLACKCOLOR;
        [backView addSubview:_nameLal];
        
        _extendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendBtn.frame = CGRectMake(KScreenWidth - 11 - 25, 0, 11, 20);
        _extendBtn.centerY = _nameLal.centerY;
//        [_extendBtn setBackgroundColor:[UIColor kMainColor]];
        [backView addSubview:_extendBtn];
        
        CGFloat textWidth = KScreenWidth - 25*2 - _extendBtn.frame.size.width-_nameLal.frame.size.width;
        _textLal = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_extendBtn.frame) - textWidth, 0, textWidth, 50)];
        if (IS_IPHONE5) {
            _textLal.font = [UIFont systemFontOfSize:15];
        }else{
            _textLal.font = [UIFont systemFontOfSize:16];
        }
//        _textLal.backgroundColor = [UIColor blueColor];
        _textLal.textAlignment = NSTextAlignmentRight;
        _textLal.textColor  = GRAYCOLOR;
        _textLal.text = @"未填写";
//        _textLal.adjustsFontSizeToFitWidth = YES;
        [backView addSubview:_textLal];
        
        UILabel *lineLal = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textLal.frame), KScreenWidth - 20, 1.0)];
        lineLal.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [backView addSubview:lineLal];
        
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
