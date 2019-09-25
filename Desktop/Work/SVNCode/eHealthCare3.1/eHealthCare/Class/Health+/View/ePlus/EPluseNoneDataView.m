//
//  EPluseNoneDataView.m
//  eHealthCare
//
//  Created by John shi on 2019/3/1.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import "EPluseNoneDataView.h"

@implementation EPluseNoneDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)goTestBtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(EPluseNoneDataViewButtonClick:)]) {
        [self.delegate EPluseNoneDataViewButtonClick:self.titleBtn.titleLabel.text];
    }
}

@end
