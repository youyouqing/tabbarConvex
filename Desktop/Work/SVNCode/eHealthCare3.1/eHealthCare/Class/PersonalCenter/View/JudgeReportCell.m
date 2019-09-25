//
//  JudgeReportCell.m
//  eHealthCare
//
//  Created by xiekang on 16/12/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JudgeReportCell.h"
@interface JudgeReportCell()
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UILabel *textLal;
@property (weak, nonatomic) IBOutlet UILabel *checkLab;

@end
@implementation JudgeReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backV.layer.cornerRadius = 5.0;
    self.backV.layer.borderColor = LINEGRAYCOLOR.CGColor;
    self.backV.layer.borderWidth = 1.0;
    self.backV.clipsToBounds = YES;
    
}

-(void)setResult:(CheckResult *)result{
    
    _result=result;
    
    self.checkLab.text=_result.SetCategoryName;
    
    self.textLal.text=_result.Title;
    
    self.timeLal.text=[self loadTime2:_result.PostDate];
    
    
}

/**通过时间戳返回时间**/
-(NSString *)loadTime2:(long)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"yyyy年MM月dd日"];
    
    return timeStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
