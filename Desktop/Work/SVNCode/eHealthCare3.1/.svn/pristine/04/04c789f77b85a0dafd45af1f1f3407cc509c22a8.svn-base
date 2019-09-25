//
//  XKFollowRecordCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKFollowRecordCell.h"
@interface XKFollowRecordCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *contextLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UIView *lineImg;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *backGroundViewLine;

@end

@implementation XKFollowRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self drawDashLine:_lineImg lineLength:3 lineSpacing:3 lineColor:[UIColor getColor:@"d8d8d8"]];

    self.backGroundViewLine.layer.borderWidth = .5f;
    
    self.backGroundViewLine.layer.borderColor = [UIColor getColor:@"d8d8d8"].CGColor;
    
}

-(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:.5f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,KScreenWidth-60, 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
-(void)setModel:(XKFollowModel *)model
{
    _model = model;
    
    
    self.nameLab.text = model.Name;
    
    
    self.conditionLab.text = model.ProjectTypeName;
    
    
//    self.contextLab.text = model.FollowUpProjectResult;
    
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:model.FollowUpProjectResult];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.FollowUpProjectResult length])];
    [self.contextLab setAttributedText:attri];
    
    
    Dateformat *dat = [[Dateformat alloc]init];
    
    self.createTimeLab.text =  [NSString stringWithFormat:@"下次随访时间：%@",[dat DateFormatWithDate:[NSString stringWithFormat:@"%li",model.NextFollowUpTime] withFormat:@"YYYY-MM-dd"]];
    
    
    self.timeLab.text =   [NSString stringWithFormat:@"%@",[dat DateFormatWithDate:[NSString stringWithFormat:@"%li",model.FollowUpTime] withFormat:@"YYYY-MM-dd"]];//[dat DateFormatWithDate:[NSString stringWithFormat:@"下次随访时间：%li",model.NextFollowUpTime] withFormat:@"YYYY-MM-dd"];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
