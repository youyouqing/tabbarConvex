//
//  XKTopicDetialReplyFirstCommentCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicDetialReplyFirstCommentCell.h"

@interface XKTopicDetialReplyFirstCommentCell ()

/**
 点赞按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *priseBtn;

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

@implementation XKTopicDetialReplyFirstCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImg.layer.cornerRadius = 12.5;
    self.iconImg.layer.masksToBounds = YES;
    
}

-(void)setModel:(XKFirstCommtentModel *)model{
    
    _model = model;
    
    if (_model.IsPraise == 1) { //已经点赞
        [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];
    }else{//未点赞
        [self.priseBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    
    [self.priseBtn setTitle:[NSString stringWithFormat:@" %li",_model.PraiseScount] forState:UIControlStateNormal];
    
    if (_model.HeadImg.length > 0) {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }else{
        self.iconImg.image = [UIImage imageNamed:@"defaultHead"];
    }
    
    self.nameLab.text = _model.NickName;
    
    [self.commentBtn setTitle:[NSString stringWithFormat:@" %li",_model.ReplyScount] forState:UIControlStateNormal];
    
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",_model.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    self.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
    
    self.contentLab.text = _model.ReplyContent;
    
    [self layoutIfNeeded];
    
}

/**
 点赞按钮功能的实现
 */
- (IBAction)priseAction:(id)sender {
    NSLog(@"点赞按钮功能的实现");
    if (_model.IsPraise == 1) {//已经点赞  返回
        return;
    }else{//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        //获取首页健康计划、热门话题数据
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"904" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"ReplyID":@(self.model.ReplyID),@"TypeID":@(1)} success:^(id json) {
            
            NSLog(@"%@",json);
            [[XKLoadingView shareLoadingView] hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
              
                //点赞成功 更换点赞按钮图片
                [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];
                
                //1.点赞数量加一
                self.model.PraiseScount++;
                [self.priseBtn setTitle:[NSString stringWithFormat:@"%li",self.model.PraiseScount] forState:UIControlStateNormal];
                
                //2.更换是否点赞的参数
                self.model.IsPraise = 1;
                
                if ([self.delegate respondsToSelector:@selector(detailChangeTopicDataSoure:)]) {
                    [self.delegate detailChangeTopicDataSoure:self.model];
                }
                
            }else{
               
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);
            
        }];
        
    }
    
}
/**
 评论功能的实现
 */
- (IBAction)commentAction:(id)sender {
    NSLog(@"评论功能的实现");
    
    if (self.model.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(commtentFistReply:)]) {
        [self.delegate commtentFistReply:self.model];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end