//
//  GoHealthTopView.m
//  eHealthCare
//
//  Created by John shi on 2018/11/19.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "GoHealthTopView.h"

@implementation GoHealthTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)setScroreModel:(XKHealthIntegralHomdeData *)scroreModel{
//    _scroreModel = scroreModel;
//
//    //1. 为分数标签赋值
//    self.acountLab.text = [NSString stringWithFormat:@"%li",scroreModel.KValue>100?100:scroreModel.KValue];
//
//    //2.为还差多少满100标签赋值
//    self.poorLab.text = [NSString stringWithFormat:@"目标 100 K值，还差 %li K值，加油哦!",100-(scroreModel.KValue > 100?100:scroreModel.KValue)];
//
//}
-(void)setListModel:(XKHealthIntegralTaskListModel *)listModel{
    _listModel = listModel;
    //1. 为分数标签赋值
    self.kValueLab.text = [NSString stringWithFormat:@"%liK",listModel.KValue>100?100:listModel.KValue];
    
   
  
}
@end
