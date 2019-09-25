//
//  XKHotTopicTagDhildCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKHotTopicTagDhildCell.h"

@interface XKHotTopicTagDhildCell ()

/**
 描述标签
 */
@property (weak, nonatomic) IBOutlet UILabel *talLab;

@end

@implementation XKHotTopicTagDhildCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.talLab.layer.borderColor = kMainColor.CGColor;
    self.talLab.layer.borderWidth =1;
    
}

-(void)setModel:(XKHealthPlanModel *)model{
    
    _model = model;
    
    self.talLab.text = _model.TypeName;
    self.talLab.layer.borderColor = kMainColor.CGColor;
    self.talLab.layer.borderWidth =1;
    self.talLab.backgroundColor = [UIColor whiteColor];
    self.talLab.textColor = kMainColor;
    if (_model.isSelect) {
        self.talLab.backgroundColor = kMainColor;
        self.talLab.textColor = [UIColor whiteColor];
    }else{
        self.talLab.layer.borderColor = kMainColor.CGColor;
        self.talLab.layer.borderWidth =1;
        self.talLab.backgroundColor = [UIColor whiteColor];
        self.talLab.textColor = kMainColor;
    }
    
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.talLab.backgroundColor = kMainColor;
        self.talLab.textColor = [UIColor whiteColor];
    }else{
        self.talLab.layer.borderColor = kMainColor.CGColor;
        self.talLab.layer.borderWidth =1;
        self.talLab.backgroundColor = [UIColor whiteColor];
        self.talLab.textColor = kMainColor;
    }
    
}

@end
