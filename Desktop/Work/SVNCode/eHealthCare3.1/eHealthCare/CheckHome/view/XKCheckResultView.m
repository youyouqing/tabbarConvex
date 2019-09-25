//
//  XKCheckResultView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKCheckResultView.h"
@interface XKCheckResultView ()
{

    UIImageView* _endPoint;//检测位置过程中添加一个点
    BOOL is_rep;
}
@property (nonatomic,strong)CAShapeLayer *shapeLayer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLabTopCons;

@property (nonatomic,strong)CAShapeLayer *preLayer;
@property (weak, nonatomic) IBOutlet UILabel *centerLabText;

@property (weak, nonatomic) IBOutlet UIView *showView;
@end
@implementation XKCheckResultView
/**
 再来一次

 @param sender againAction
 */
- (IBAction)againAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(Again:)]) {
        [self.delegate Again:self];
    }
    
    
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.centerLabTopCons.constant = ((PublicY)-40)-2;
    self.centerLabText.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    self.shapeLayer=[CAShapeLayer layer];
    
    self.shapeLayer.frame=CGRectMake(0, 0, 187, 187);
    
    UIBezierPath *path3=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 187, 187)];
    
    self.shapeLayer.fillColor=[[UIColor clearColor]CGColor];
    
    self.shapeLayer.strokeColor=[[UIColor whiteColor]CGColor];
    
    self.shapeLayer.lineWidth=2;
    
    self.shapeLayer.strokeStart=0.0;
    
    self.shapeLayer.strokeEnd=1.0;
    
    self.shapeLayer.path=path3.CGPath;
    
    [self.showView.layer addSublayer:self.shapeLayer];
    
     // [self detectingCourse];
     is_rep = YES;
    
     self.fatLabOne.text = @"--";
     self.fatLabTwo.text = @"--";
     self.fatLabThree.text = @"--";
     self.fatLabFour.text = @"--";
     self.fatLabFive.text = @"--";
     self.fatLabSix.text = @"--";
     self.fatLabSeven.text = @"--";
     self.fatLabEight.text = @"--";
     self.fatLabNine.text = @"--";
     self.fatLabTen.text = @"--";
     self.fatLabElev.text = @"--";
     self.fatLabTwel.text = @"--";
    
    
    
     self.statusImgOne.image = [UIImage imageNamed:@""];
     self.statusImgTwo.image = [UIImage imageNamed:@""];
     self.statusImgThree.image = [UIImage imageNamed:@""];
     self.statusImgFour.image = [UIImage imageNamed:@""];
     self.statusImgFive.image = [UIImage imageNamed:@""];
     self.statusImgSeven.image = [UIImage imageNamed:@""];
     self.statusImgEight.image = [UIImage imageNamed:@""];
     self.statusImgNine.image = [UIImage imageNamed:@""];
     self.statusImgSix.image = [UIImage imageNamed:@""];
     self.statusImgTen.image = [UIImage imageNamed:@""];
     self.statusImgElev.image = [UIImage imageNamed:@""];
     self.statusImgTwel.image = [UIImage imageNamed:@""];
    
    
    self.sLvLab.hidden = YES;
    self.scoreLab.hidden = YES;
    self.BMILab.hidden = YES;
    
}
-(void)setModeArr:(NSArray *)modeArr
{
    
    _modeArr = modeArr;
    
    for (int i = 0; i<modeArr.count; i++) {
        
        ExchinereportModel *statusModel =   modeArr[i];
        //        NSString *jugeStr = @"偏高";
        /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
//       if (statusModel.ParameterStatus == 1) {
//           [self nameTitleLabWithPhysicalItemIdentifier:statusModel];
//
//         }
//        if (statusModel.ParameterStatus == 2) {
//            [self nameTitleLabWithPhysicalItemIdentifier:statusModel];
//        }
//        if (statusModel.ParameterStatus == 3) {
//            [self nameTitleLabWithPhysicalItemIdentifier:statusModel];
//           
//        }
//        if (statusModel.ParameterStatus ==4) {
//            [self nameTitleLabWithPhysicalItemIdentifier:statusModel];
//        }
//        if (statusModel.ParameterStatus == 5) {
            [self nameTitleLabWithPhysicalItemIdentifier:statusModel];
        
            
//        }
    
    }
    
}
-(NSString *)nameTitleLabWithPhysicalItemIdentifier:(ExchinereportModel *)statusModel
{
    NSString *nameStr;
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
        
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabOne exchineReportModel:statusModel statusImg:self.statusImgOne];
        //            self.fatLabOne.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
        
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
        //            self.BMIKgLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
      
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.BMIKgLab exchineReportModel:statusModel statusImg:nil];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
        //            self.slvkgLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
        
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.slvkgLab exchineReportModel:statusModel statusImg:nil];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
        //            self.fatLabTwo.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabTwo exchineReportModel:statusModel statusImg:self.statusImgTwo];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
        //            self.fatLabThree.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabThree exchineReportModel:statusModel statusImg:self.statusImgThree];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
        //            self.fatLabFour.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabFour exchineReportModel:statusModel statusImg:self.statusImgFour];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
        //            self.fatLabSix.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabSix exchineReportModel:statusModel statusImg:self.statusImgSix];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
        //            self.fatLabFive.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabFive exchineReportModel:statusModel statusImg:self.statusImgFive];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
        //            self.fatLabEight.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabEight exchineReportModel:statusModel statusImg:self.statusImgEight];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
        //            self.fatLabNine.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabNine exchineReportModel:statusModel statusImg:self.statusImgNine];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
        //            self.fatLabSeven.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabSeven exchineReportModel:statusModel statusImg:self.statusImgEight
         ];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
        //            self.fatLabTen.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabTen exchineReportModel:statusModel statusImg:self.statusImgTen];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
        //            self.fatLabElev.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabElev exchineReportModel:statusModel statusImg:self.statusImgElev];
    }
    if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
        //            self.fatLabTwel.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
        [self becomeStatus:statusModel.ParameterStatus ButtonImage:self.fatLabTwel exchineReportModel:statusModel statusImg:self.statusImgTwel];
    }

    
    return nameStr;
}

////1偏高2正常3偏低
-(void)becomeStatus:(NSInteger) ParameterStatus  ButtonImage:(UILabel *)lab exchineReportModel:(ExchinereportModel *) model  statusImg:(UIImageView *)statusImg{
    NSString *jugeStr = @"正常";
    

    if (ParameterStatus == 1) {
        
        //        [btn setImage:[UIImage imageNamed:@"result_high_q"] forState:UIControlStateNormal];
        statusImg.image = [UIImage imageNamed:@"result_high_q"];
        lab.textColor = [UIColor colorWithHexString:@"FF7342"];
        jugeStr = @"偏高";
    }
    if (ParameterStatus == 2) {
        statusImg.image = [UIImage imageNamed:@""];
         jugeStr = @"正常";
         lab.textColor = [UIColor whiteColor];
    }
    if (ParameterStatus == 3) {
        statusImg.image = [UIImage imageNamed:@"result_low"];

         jugeStr = @"偏低";
         lab.textColor = [UIColor colorWithHexString:@"F3C331"];
    }
    if (ParameterStatus == 4) {
        statusImg.image = [UIImage imageNamed:@"result_high_q"];
       jugeStr = @"超重";
         lab.textColor = [UIColor colorWithHexString:@"FF7342"];
    }
    if (ParameterStatus == 5) {
        statusImg.image = [UIImage imageNamed:@"result_high_q"];
        lab.textColor = [UIColor colorWithHexString:@"FF7342"];
        jugeStr = @"肥胖";
    }
   
    if ([model.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
        
        
        self.scoreLab.text = [NSString stringWithFormat:@"你的体重%@",jugeStr];
        self.scoreLab.textColor = lab.textColor;
    }
    
}
-(void)setMode:(ExchinereportModel *)mode
{
    
    _mode = mode;
//    [self.scopebtn setTitle:[NSString stringWithFormat:@"理想范围：%@",self.mode.ReferenceValue] forState:UIControlStateNormal];
    if (self.mode.ParameterStatus == 1) {
        self.scoreLab.text = @"偏高";
        
    }
    if (self.mode.ParameterStatus == 2) {
        self.scoreLab.text = @"正常";
        
    }
    
    if (self.mode.ParameterStatus == 3) {
        self.scoreLab.text = @"偏低";
        
    }
    
    if (self.mode.ParameterStatus == 1) {
        self.scoreLab.text = @"偏高";
        
      
        self.scoreLab.textColor = [UIColor colorWithHexString:@"FF7342"];
        
    }
    if (self.mode.ParameterStatus == 2) {
        self.scoreLab.text = @"正常";
        self.scoreLab.textColor = [UIColor colorWithHexString:@"25D352"];
    }
    
    if (self.mode.ParameterStatus == 3) {
        self.scoreLab.text = @"偏低";
        self.scoreLab.textColor = [UIColor colorWithHexString:@"F3C331"];
    }

    
}

-(void)detectingCourse{
    
    //用于显示结束位置的小点
    _endPoint = [[UIImageView alloc] init];
    
    _endPoint.frame = CGRectMake((self.showView.bounds.size.width-187)/2.0+187-10, (self.showView.bounds.size.height-187)/2.0+187/2.0-10, 20,20);
    
    _endPoint.image = [UIImage imageNamed:@"morningAndNight_dot"];
    
    [self.showView addSubview:_endPoint];
    
    //    _endPoint.hidden = true;
    
    
    CAKeyframeAnimation *path=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //矩形的中心就是圆心
    CGRect rect=CGRectMake((self.showView.bounds.size.width-187)/2.0, (self.showView.bounds.size.height-187)/2.0, 187, 187);
    path.duration=1;
    //绕此圆中心转
    path.path=CFAutorelease(CGPathCreateWithEllipseInRect(rect, NULL));
    path.calculationMode=kCAAnimationPaced;
    path.rotationMode=kCAAnimationRotateAuto;
    path.repeatCount = 10000;
    //    pat
    [_endPoint.layer addAnimation:path forKey:@"round"];
    
}

//按钮 点击  是否开始旋转和隐藏

- (void)TouchCircleAndHide {
    is_rep = !is_rep;
    if (is_rep) {
        [_endPoint removeFromSuperview];
    }else{
        [self detectingCourse];
    }
}
//隐藏停止动画
- (void)StopCircleAninmationAndHide;
{

    [_endPoint removeFromSuperview];
}
@end
