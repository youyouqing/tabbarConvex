//
//  XKHealthIntegralTaskCell.m
//  eHealthCare
//
//  Created by mac on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//健康积分任务列表表格子视图cell

#import "XKHealthIntegralTaskCell.h"

@interface XKHealthIntegralTaskCell ()

/*任务标签*/
@property (weak, nonatomic) IBOutlet UILabel *taskTitleLab;

/**
 奖励携康币多少标签
 */
@property (weak, nonatomic) IBOutlet UILabel *kangValueLab;

/**
 是否完成标志图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *completeImg;

/**表示k值图片*/
@property (weak, nonatomic) IBOutlet UIImageView *kimg;

/*奖励k值多少*/
@property (weak, nonatomic) IBOutlet UILabel *kValueLab;

/**
 表示康币图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *kangImg;
/**最大视图容器*/
@property (weak, nonatomic) IBOutlet UIView *taskContianerView;

/**最大的容器视图*/
@property (weak, nonatomic) IBOutlet UIView *bigBackView;

@end

@implementation XKHealthIntegralTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bigBackView.layer.cornerRadius = 5;
    self.bigBackView.layer.masksToBounds = YES;
}

/**
 重写每日任务数据源set方法
 */
-(void)setDailyModel:(XKHealthIntergralDailyQuestListModel *)dailyModel{
    _dailyModel = dailyModel;
    self.taskTitleLab.text = _dailyModel.TaskTitle;
//    self.kangImg.hidden = NO;
    self.kangValueLab.hidden = YES;
    self.kValueLab.textColor = [UIColor getColor:@"30e1a1"];
    self.kimg.image = [UIImage imageNamed:@"icon_k"];
    self.kValueLab.text = [NSString stringWithFormat:@"x%li",_dailyModel.KValue];
//    self.kangValueLab.text = [NSString stringWithFormat:@"x%li",_dailyModel.KCurrency];
    self.taskContianerView.backgroundColor = [UIColor clearColor];
    if (dailyModel.Iscomplete == 1) {
        self.completeImg.image = [UIImage imageNamed:@"iv_gohealth_complete"];
         self.taskContianerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    }else{
        self.completeImg.image = [UIImage imageNamed:@"icon_list_arrow"];
        self.taskContianerView.backgroundColor = [UIColor clearColor];
    }
    
}

/**
 重写每日福利任务数据源set方法
 */
-(void)setPlanModel:(XKXKHealthIntergralDailyPlanHealthDetailListModel *)planModel{
    _planModel = planModel;
    self.taskTitleLab.text = _planModel.WelfareTaskTitle;
//    self.kangImg.hidden = YES;
    self.kangValueLab.hidden = YES;
    self.kValueLab.textColor = [UIColor getColor:@"F2D61B"];
    self.kimg.image = [UIImage imageNamed:@"icon_k"];
    self.kValueLab.text = [NSString stringWithFormat:@"x%li",_planModel.KCurrency];
    self.taskContianerView.backgroundColor = [UIColor clearColor];
    if (planModel.Iscomplete == 1) {
        self.completeImg.image = [UIImage imageNamed:@"iv_gohealth_complete"];
        self.taskContianerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    }else{
        self.completeImg.image = [UIImage imageNamed:@"icon_list_arrow"];
        self.taskContianerView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end