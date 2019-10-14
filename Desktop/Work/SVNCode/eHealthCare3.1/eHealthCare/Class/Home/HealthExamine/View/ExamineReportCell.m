//
//  ExamineReportCell.m
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ExamineReportCell.h"
@interface ExamineReportCell()


@property (weak, nonatomic) IBOutlet UILabel *usualLal;
@property (weak, nonatomic) IBOutlet UILabel *doneNumLal;
@property (weak, nonatomic) IBOutlet UIView *rightBackView;
@property (weak, nonatomic) IBOutlet UILabel *yearNewLal;
@property (weak, nonatomic) IBOutlet UIImageView *nextImg;

@property (weak, nonatomic) IBOutlet UIImageView *imgMark;


@end
@implementation ExamineReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =  kbackGroundGrayColor;
}

-(void)setExamModel:(ExanubeReportModel *)examModel
{
    Dateformat *dateFor = [[Dateformat alloc] init];
    self.yearNewLal.text =  [NSString stringWithFormat:@"%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",examModel.TestTime] withFormat:@"YYYY-MM-dd"]];

    
    NSString *str = [NSString stringWithFormat:@"异常项：%@ 项",examModel.ExceptionCount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [str rangeOfString:examModel.ExceptionCount];
    [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:23] range:range];
    self.doneNumLal.text = [NSString stringWithFormat:@"检查项：%@项",examModel.CheckCount];
    self.usualLal.text = [NSString stringWithFormat:@"异常项：%@项",examModel.ExceptionCount];
    
    if (examModel.cellIndex== 0 ) {
//        [self.nextImg setImage:[UIImage imageNamed:@"arrow_white"]];
        
        UIColor *unusualtextColor;
        UIColor *backColor;
        if ([examModel.ExceptionCount isEqualToString:@"0"]) {
            unusualtextColor = [UIColor whiteColor];
            backColor = [UIColor getColor:@"07DD8F"];;
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
        }else{
            unusualtextColor = [UIColor yellowColor];
            backColor = [UIColor getColor:@"FF4564"];;
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
        }
       
        self.rightBackView.backgroundColor = [UIColor whiteColor];
       
        self.usualLal.textColor = backColor;
    
      
        
    }else{
   
        self.rightBackView.backgroundColor = [UIColor whiteColor];
        self.rightBackView.layer.borderWidth = 0.7;
        self.rightBackView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        self.usualLal.textColor = [UIColor getColor:@"FF4564"];
        [attr addAttribute:NSForegroundColorAttributeName value:ORANGECOLOR range:range];
    }
//    self.usualLal.attributedText = attr;
    self.yearNewLal.textColor =self.doneNumLal.textColor = kMainTitleColor;;
    self.imgMark.hidden = YES;
    
    if (examModel.IsOverall == 2) {
        
        self.imgMark.hidden = NO;
        
    }else{
        
        self.imgMark.hidden = YES;
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end