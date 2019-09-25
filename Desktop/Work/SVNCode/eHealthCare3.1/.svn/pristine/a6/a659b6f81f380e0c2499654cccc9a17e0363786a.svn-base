//
//  XKInfoDetailView.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInfoDetailView.h"
@interface XKInfoDetailView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

@property (weak, nonatomic) IBOutlet UIButton *talkBtn;

@end

@implementation XKInfoDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    _iconImage.layer.cornerRadius = 30*.5f;
    // 这样写比较消耗性能
    _iconImage.layer.masksToBounds = YES;
    
    
}
- (IBAction)likeAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellForMoreLikeClicked:XKInfoDetailView:)]) {
        
        [self.delegate topicCellForMoreLikeClicked:self.topic  XKInfoDetailView:self];
    }
  
    
}
- (IBAction)talkAction:(id)sender {
    NSLog(@"talkMore");
    if (self.topic.ReplyerMemberID ==  [UserInfoTool getLoginInfo].MemberID) {
        
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellForClickedRow:XKInfoDetailView:)]) {
        
        [self.delegate topicCellForClickedRow:self.topic  XKInfoDetailView:self];
    }

    
}

-(void)setTopic:(MHTopic *)topic
{

    _topic = topic;
    
    
    _nameLab.text = topic.NickName;
    
  
    
    
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",topic.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    

    NSString *timeStr= [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
   
    _createTime.text = timeStr;
    
    
    _dataLab.text = topic.ReplyContent;
    
    
    if (topic.IsPraise == 1) { //已经点赞
        self.likeBtn.selected = YES;
    }else{//未点赞
        self.likeBtn.selected = NO;
    }
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %li",topic.PraiseScount] forState:UIControlStateNormal];
   
    
    // 更多
   
    [self.talkBtn setTitle:[NSString stringWithFormat:@" %li",topic.ReplyScount] forState:UIControlStateNormal];

    if (topic.HeadImg.length > 0) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:topic.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }else{
        self.iconImage.image = [UIImage imageNamed:@"defaultHead"];
    }

    

}
@end
