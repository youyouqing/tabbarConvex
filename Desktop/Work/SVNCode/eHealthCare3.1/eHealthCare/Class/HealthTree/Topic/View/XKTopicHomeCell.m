//
//  XKTopicHomeCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicHomeCell.h"

@interface XKTopicHomeCell ()

/**
 话题内容标签
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabl;

/**
 话题时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

/**
 话题评论人数标签
 */
@property (weak, nonatomic) IBOutlet UILabel *commentLab;

/**
 话题点赞人数标签
 */
@property (weak, nonatomic) IBOutlet UIButton *priseBtn;


@end

@implementation XKTopicHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

/**重写属性set方法*/
-(void)setModel:(XKTopicModel *)model{
    
    _model = model;
    
    NSString *content = [NSString stringWithFormat:@"【%@】 %@",_model.TopicTypeName,_model.TopicContent];
    
    
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    [self.contentLabl setAttributedText:attri];
    
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_model.CreateTime]] withFormat:@"yyyy-MM-dd"];
    self.timeLab.text = timeStr;
    
    self.commentLab.text = [NSString stringWithFormat:@"已有%li人回答",_model.ReplyScount];
    
    [self.priseBtn setTitle:[NSString stringWithFormat:@" %li",_model.PraiseScount] forState:UIControlStateNormal];

    if (_model.IsPraise == 1) {//已经点赞
        
        [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];
        
    }else{//未点赞
        [self.priseBtn setImage:[UIImage imageNamed:@"likeprise"] forState:UIControlStateNormal];
    }
    
}

/**
 点赞功能的实现
 */
- (IBAction)priseAction:(id)sender {
    
    if (_model.IsPraise == 1) {//已经点赞  返回
        return;
    }else{//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        //获取首页健康计划、热门话题数据
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"904" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"ReplyID":@(self.model.TopicID),@"TypeID":@(1)} success:^(id json) {
            
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
                
                if ([self.delegate respondsToSelector:@selector(changeDataSource:)]) {
                    [self.delegate changeDataSource:self.model];
                }
                
            }else{
              
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);
            
        }];
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
