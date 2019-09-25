//
//  XKTopicDetialReplySecondeCommentCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicDetialReplySecondeCommentCell.h"

@interface XKTopicDetialReplySecondeCommentCell ()

/**
 评论按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/**
 头像视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

/**
 昵称标签
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

/**
 时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

/**
 内容标签
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation XKTopicDetialReplySecondeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImg.layer.cornerRadius = 12.5;
    self.iconImg.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor getColor:@"f2f2f2"];
    
}

/**
重写数据源set方法
 */
-(void)setModel:(XKSecondeCommtentModel *)model{
    
    _model = model;
    
    if (_model.HeadImg.length > 0) {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }else{
        self.iconImg.image = [UIImage imageNamed:@"defaultHead"];
    }
    
    self.nameLab.text = _model.RNickName;
    
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",_model.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    self.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];

    if ([_model.CNickName isEqualToString:_model.RNickName]) {//评论人和回复人都是自己
        self.contentLab.text = _model.ReplyContent;
    }else{
        NSString *str = [NSString stringWithFormat:@"回复%@：%@",_model.CNickName,_model.ReplyContent];
        
        self.contentLab.attributedText = [NSMutableAttributedString changeLabelWithText:str withBigFont:15 withNeedchangeText:@"回复" withSmallFont:15 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:kMainColor];
    }
    
    [self layoutIfNeeded];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
/**
 评论按钮的点击
 */
- (IBAction)commentAction:(id)sender {
    
    if (self.model.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(sendSecondeCommendMsg:)]) {
        
        [self.delegate sendSecondeCommendMsg:self.model];
        
    }
    
}

@end
