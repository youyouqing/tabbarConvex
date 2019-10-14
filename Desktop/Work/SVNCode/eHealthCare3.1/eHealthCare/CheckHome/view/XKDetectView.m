//
//  XKDetectView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKDetectView.h"


@interface XKDetectView ()





@end

@implementation XKDetectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    
//    self.unbindBtn.layer.borderWidth = 0.5;
//    self.unbindBtn.layer.borderColor = kMainColor.CGColor;

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.unbindBtn.frame.size.width, self.unbindBtn.frame.size.height)      byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft    cornerRadii:CGSizeMake(3, 3)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.unbindBtn.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.unbindBtn.layer.mask = maskLayer;
    
    _unbindBtn.hidden = YES;
    
}

- (IBAction)unbindAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(dectUnableBind:)]) {
        [self.delegate dectUnableBind:@""];
    }
    
}



@end