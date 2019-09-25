//
//  XKMianMessageCellSelf.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMianMessageCellSelf.h"
#import "XKTopicHotDetialController.h"
#import "XKMessageInputeView.h"
@interface XKMianMessageCellSelf ()
{
    
    NSInteger typeID;
    
}
/**
 容器视图
 */
@property (weak, nonatomic) IBOutlet UIView *contianerView;

/**
 标签背景
 */
@property (weak, nonatomic) IBOutlet UIView *labCover;

/**
 标签
 */
@property (weak, nonatomic) IBOutlet UILabel *lab;

/**
 查看按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;

/**
 影藏的文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txt;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property (nonatomic,strong) XKMessageInputeView *xkInpute;

/**
 查看元话题按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *replectBtn;

@end

@implementation XKMianMessageCellSelf

-(XKMessageInputeView *)xkInpute{
    
    if (!_xkInpute) {
        
        _xkInpute = [[[NSBundle mainBundle] loadNibNamed:@"XKMessageInputeView" owner:self options:nil] firstObject];
        _xkInpute.left = 0;
        _xkInpute.top = 0;
        _xkInpute.width = KScreenWidth;
        _xkInpute.height = 64;
        
    }
    
    return _xkInpute;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contianerView.layer.cornerRadius = 5;
    self.contianerView.layer.masksToBounds = YES;
    
    self.labCover.layer.cornerRadius = 7;
    self.labCover.layer.masksToBounds = YES;
    
    self.lookBtn.layer.cornerRadius = 15;
    self.lookBtn.layer.masksToBounds = YES;
    self.lookBtn.layer.borderWidth = .5f;
    self.lookBtn.layer.borderColor = kMainColor.CGColor;
    [self.lookBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    [self.txt setInputAccessoryView:self.xkInpute];

}

/**
 查看元话题
 */
- (IBAction)lookAction:(id)sender {
    
    NSLog(@"查看元话题");
    
    if ([self.delegate respondsToSelector:@selector(clickLookBtn:)]) {
        [self.delegate clickLookBtn:self.model];
    }
}
/**
 评论按钮的点击
 */
- (IBAction)commentAction:(id)sender {
    NSLog(@"点击");
    
    
    if (self.model.ReplyerID == [UserInfoTool getLoginInfo].MemberID) {
        
        return;
    }
    
        /*1、话题   2、资讯*/
    [self.txt becomeFirstResponder];
    [self.xkInpute.txt becomeFirstResponder];
    
    
    typeID = 0;
    if (self.model.ReplySelect == 1) {
        typeID = 1;
    }
    if (self.model.ReplySelect == 0) {
        typeID = 2;
    }
    
    if ([self.delegate respondsToSelector:@selector(clickCommentBtn:typeID:xkMineReplyModTex:)]) {
        [self.delegate clickCommentBtn:self.model typeID:typeID xkMineReplyModTex:self.xkInpute.txt];
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setModel:(XKMineReplyMod *)model
{
    _model = model;
    
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",model.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSString *oneStr ;
   
    oneStr = [NSString stringWithFormat:@"%@",[Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]]];
        
    self.timeLab.text = oneStr;
        
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:model.ReplyContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.ReplyContent length])];
    [self.lab setAttributedText:attri];
//    self.lab.text = model.ReplyContent;
    
    
    if (model.ReplySelect == 0) {
        
        [self.lookBtn setTitle:@"查看原文章" forState:UIControlStateNormal];
    }
    
    if (model.ReplySelect == 1) {
        [self.lookBtn setTitle:@"查看原话题" forState:UIControlStateNormal];
    }
    
}

-(void)dealloc
{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
