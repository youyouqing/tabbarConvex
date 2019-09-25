//
//  ShowPlaceHolderView.m
//  eHealthCare
//
//  Created by John shi on 2018/12/5.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "ShowPlaceHolderView.h"

@implementation ShowPlaceHolderView

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
    
    self.examintBtn.layer.cornerRadius = 45/2.0;
    self.examintBtn.clipsToBounds = YES;
    [self layoutIfNeeded];
}


- (IBAction)GoExamineAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(placeHodlerImageButtonClick)]) {
        [self.delegate placeHodlerImageButtonClick];
    }
    
    
}

@end
