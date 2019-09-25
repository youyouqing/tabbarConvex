//
//  DetailReportView.m
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailReportView.h"
@interface DetailReportView()
{
    BOOL isOpen;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textToRightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *textLal;
@property (weak, nonatomic) IBOutlet UILabel *titleLal;

@end
@implementation DetailReportView
{
    id _target;
    SEL _action;
    UIView *backView;
    UILabel *_whiteLal;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.iconBtn addTarget:self action:@selector(clickIcon:) forControlEvents:UIControlEventTouchUpInside];
    self.textLal.adjustsFontSizeToFitWidth = YES;
    self.titleLal.adjustsFontSizeToFitWidth = YES;
}

-(void)setDataModel:(DetailReportModel *)dataModel
{
    _titleLal.text = dataModel.PhysicalItemName;
    if ([dataModel.ExceptionFlag isEqualToString:@"1"] ) {
        _textLal.text = [NSString stringWithFormat:@"%@%@",dataModel.TypeParameter,dataModel.PhysicalItemUnits];
        _textLal.textColor = GRAYCOLOR;
        self.textToRightConstraint.constant = 25;
        self.iconBtn.hidden = YES;
        
    }else{
        NSString *unualStr = dataModel.ExceptionContent;
        if (dataModel.TypeParameter.length > 7) {
            _textLal.text = [NSString stringWithFormat:@"%@ %@",unualStr,dataModel.TypeParameter];
        }else{
            _textLal.text = [NSString stringWithFormat:@"%@ %@%@",unualStr,dataModel.TypeParameter,dataModel.PhysicalItemUnits];
        }
        _textLal.textColor = ORANGECOLOR;
        
        //5s屏幕时，适配屏幕宽度，高/低密度脂蛋白胆固醇 情况下
        if (IS_IPHONE5) {
            if (dataModel.PhysicalItemName.length > 7 ) {
                _textLal.text = [NSString stringWithFormat:@"%@ %@",unualStr,dataModel.TypeParameter];
            }
        }
        
        if (dataModel.suggestArr.count == 0) {
            //**当异常时，建议数组为空，不显现 展开按钮
            self.textToRightConstraint.constant = 25;
            self.iconBtn.hidden = YES;
        }else{
            _textToRightConstraint.constant = 25 + self.iconBtn.width + 0;
            _iconBtn.hidden = NO;
        }
    }
    _iconBtn.tag = dataModel.cellindex + 200;
}

-(void)clickIcon:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickOpenBtn:)]) {
        [self.delegate clickOpenBtn:button.tag - 200];
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
