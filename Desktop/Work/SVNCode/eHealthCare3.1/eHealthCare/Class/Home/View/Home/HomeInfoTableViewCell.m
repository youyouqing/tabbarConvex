//
//  HomeInfoTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/12/3.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "HomeInfoTableViewCell.h"
#import "WikiTypeList.h"
@implementation HomeInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// 添加所有子控制器
- (void)setUpAllViewController
{
    for (int i = 0; i < _WikiTypeList1.count; i++){
        WikiTypeList *mode = [_WikiTypeList1 objectAtIndex:i];
        //                        XKPlanTopicController *all = [[XKPlanTopicController alloc] init];
        //                        all.title = mode.CategoryName;
        //                        all.model = model;
        //                        [self addChildViewController:all];
        
    }
    NSInteger widthCount = 0;
    if (_WikiTypeList1.count>=5) {
        widthCount = 5;
    }else{
        widthCount = _WikiTypeList1.count;
    }
//    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
//        *norColor = [UIColor lightGrayColor];
//        *selColor = kMainColor;
//        *titleWidth = [UIScreen mainScreen].bounds.size.width / widthCount;
//    }];
//
//    // 标题渐变
//    // *推荐方式(设置标题渐变)
//    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
//
//    }];
//
//    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
//
//        *isUnderLineEqualTitleWidth = YES;
//    }];
//    self.line.hidden = YES;
//    [self refreshDisplay];
    
    
    
    
    
    
}
@end
