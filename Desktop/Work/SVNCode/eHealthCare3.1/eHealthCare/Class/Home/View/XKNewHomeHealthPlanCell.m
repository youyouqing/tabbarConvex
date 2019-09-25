//
//  XKNewHomeHealthPlanCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKNewHomeHealthPlanCell.h"
@interface XKNewHomeHealthPlanCell ()
@property (weak, nonatomic) IBOutlet UIView *BackSingleView;
@property (weak, nonatomic) IBOutlet UIImageView *circleOneImage;


@property (weak, nonatomic) IBOutlet UIImageView *circleTwoImage;
/**
 视图1距离头部的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewOneTopCons;
/**
 视图1高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewOneHeightCons;
/**
 视图1
 */
@property (weak, nonatomic) IBOutlet UIView *viewOne;
/**
 视图2的头部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTwoTopCons;
/**
 视图2的高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTwoHeightCons;

/**
 视图2
 */
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
/**
 添加计划按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addBtn;


/**
 去完成按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *filishBtn;

/**
 健康计划标题标签
 */
@property (weak, nonatomic) IBOutlet UILabel *planTitlLab;

/**
 健康计划内容标签
 */
@property (weak, nonatomic) IBOutlet UILabel *planContentLab;

/**
 健康计划第几天标签
 */
@property (weak, nonatomic) IBOutlet UILabel *planDayLab;
/**
 计划配图
 */
@property (weak, nonatomic) IBOutlet UIImageView *palnImg;

@end

@implementation XKNewHomeHealthPlanCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.viewOne.layer.cornerRadius = 5;
    self.viewOne.layer.masksToBounds = YES;
//    self.viewOne.backgroundColor = kMainColor;
//    self.viewOne.backgroundColor = [UIColor getColor:@"03baff"];
    
    self.viewTwo.layer.cornerRadius = 5;
    self.viewTwo.layer.masksToBounds = YES;
//    self.viewTwo.backgroundColor = kMainColor;
//    self.viewTwo.backgroundColor = [UIColor getColor:@"03baff"];
    
    self.addBtn.backgroundColor = [UIColor getColor:@"30E2FC"];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.layer.cornerRadius = 16;
    self.addBtn.layer.masksToBounds = YES;
    
    
    self.filishBtn.backgroundColor = [UIColor whiteColor];
    [self.filishBtn setTitleColor:[UIColor getColor:@"03baff"] forState:UIControlStateNormal];
    self.filishBtn.layer.cornerRadius = 16;
    self.filishBtn.layer.masksToBounds = YES;
    
    self.palnImg.layer.cornerRadius = 55/2;
    self.palnImg.layer.masksToBounds = YES;
    
    
    self.circleOneImage.clipsToBounds = YES;
    
    self.circleOneImage.layer.cornerRadius = self.circleOneImage.height/2.0;
    
    self.circleTwoImage.clipsToBounds = YES;
    
    self.circleTwoImage.layer.cornerRadius = self.circleTwoImage.height/2.0;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, KHeight(126)) byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = CGRectMake(0, 0, KScreenWidth-12, KHeight(126));
//    maskLayer.path = maskPath.CGPath;
//    _BackSingleView.layer.mask = maskLayer;
    
 
}

-(void)setModel:(XKHomePlanModel *)model{
    
    _model = model;
    
    self.planTitlLab.text = _model.PlanTitle;
    self.planContentLab.text = [NSString stringWithFormat:@"/%@~~/",_model.TodayContent];
    self.planDayLab.text = [NSString stringWithFormat:@"第 %li 天",_model.CurrrentDays];
    
    [self.palnImg sd_setImageWithURL:[NSURL URLWithString:_model.PlanLogo] placeholderImage:[UIImage imageNamed:@"pic_plan1"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setIsEmpty:(NSInteger)isEmpty{
    
    _isEmpty = isEmpty;
    
    //还原首页健康计划数据
    self.viewOne.hidden = NO;
    self.viewTwo.hidden = NO;
    self.viewTwoTopCons.constant = 0;
    self.viewTwoHeightCons.constant = 100;
    self.viewOneTopCons.constant = 0;
    self.viewOneHeightCons.constant = 100;
    
    if (_isEmpty) { //空  显示上个视图
        self.viewTwoTopCons.constant = 0;
        self.viewTwoHeightCons.constant = 0;
        self.viewTwo.hidden = YES;
        

        
        
        self.circleTwoImage.hidden = YES;
        
        
        self.circleOneImage.hidden = YES;
    }else{//不为空  显示下个视图
        self.viewOneTopCons.constant = 0;
        self.viewOneHeightCons.constant = 0;
        self.viewOne.hidden = YES;
        

        
        self.circleTwoImage.hidden = NO;
        
        
        self.circleOneImage.hidden = NO;
    }
    
}

/**
 去添加按钮的点击事件
 */
- (IBAction)addAction:(id)sender {
    
    NSLog(@"去添加健康计划");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XKNewHomeHealthPlanCellbuttonClick)]) {
        [self.delegate XKNewHomeHealthPlanCellbuttonClick];
    }
    
}
/**
 去完成按钮的点击事件
 */
- (IBAction)filishAction:(id)sender {
   

    XKHomePlanModel *model = self.model;

//     XKPlanDayViewController *con = [[XKPlanDayViewController alloc]init];
//    con.planCompletTag = 200;
//    con.planMainId = model.PlanMainID;
//
//   [[self parentController].navigationController pushViewController:con animated:YES];

    
}

@end
