//
//  XKInformationDeatilCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInformationDeatilCell.h"
@interface XKInformationDeatilCell ()


@end
@implementation XKInformationDeatilCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    
    _iconImage.layer.cornerRadius = 30*.5f;
    // 这样写比较消耗性能
    _iconImage.layer.masksToBounds = YES;

    
}
-(void)setComment:(MHComment *)comment
{
    _comment = comment;
    
    
    _nameLab.text = comment.RNickName;
    
    
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",comment.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
   

    _createTime.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
    
    _dataLab.text = comment.ReplyContent;

    if (comment.HeadImg.length > 0) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:comment.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }else{
        self.iconImage.image = [UIImage imageNamed:@"defaultHead"];
    }

    
    if ([comment.CNickName isEqualToString:comment.RNickName]) {//评论人和回复人都是自己
        self.dataLab.text = comment.ReplyContent;
    }else{
        NSString *str = [NSString stringWithFormat:@"回复%@：%@",comment.CNickName,comment.ReplyContent];
        
        self.dataLab.attributedText = [NSMutableAttributedString changeLabelWithText:str withBigFont:15 withNeedchangeText:@"回复" withSmallFont:15 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:kMainColor];
    }
}


- (IBAction)talkAction:(id)sender {
    
    NSLog(@"点击按钮");
    if (self.comment.ReplyerMemberID ==  [UserInfoTool getLoginInfo].MemberID) {
        
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellForClickedMoreAction:didSelectRow:)]) {
        [self.delegate topicCellForClickedMoreAction:self didSelectRow:self.comment];
    }

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end