//
//  XKMianMessageCellOther.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMianMessageCellOther.h"
#import "XKTopicHotDetialController.h"
#import "XKInfomationViewController.h"
#import "XKTopicHomeController.h"
#import "XKMessageInputeView.h"
@interface XKMianMessageCellOther ()<UITextFieldDelegate>

/**
 容器视图
 */
@property (weak, nonatomic) IBOutlet UIView *containerVeiw;

/**
 查看按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;

/**
 影藏的文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *textFeil;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic,strong) XKMessageInputeView *xkInpute;

@end

@implementation XKMianMessageCellOther
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

    self.containerVeiw.layer.cornerRadius = 5;
    self.containerVeiw.layer.masksToBounds = YES;
    
    self.lookBtn.layer.cornerRadius = 15;
    self.lookBtn.layer.masksToBounds = YES;
    self.lookBtn.layer.borderWidth = .5f;
    self.lookBtn.layer.borderColor = kMainColor.CGColor;
    [self.lookBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    self.textFeil.delegate = self;
    
    [self.textFeil setInputAccessoryView:self.xkInpute];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.xkInpute.txt.text = textField.text;
    
}

/**
 评论按钮的点击事件
 */
- (IBAction)commentAction:(id)sender {
    NSLog(@"评论按钮");
    if (self.model.ReplyerID == [UserInfoTool getLoginInfo].MemberID) {
        
        return;
    }
    /*1、话题   2、资讯*/
    [self.textFeil becomeFirstResponder];
    [self.xkInpute.txt becomeFirstResponder];
    [self.textFeil resignFirstResponder];
    
    
    self.xkInpute.txt.placeholder = [NSString stringWithFormat:@"回复%@",self.model.ReplyerNick] ;
    
    NSInteger  typeID = 0;
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
-(void)setModel:(XKMineReplyMod *)model
{
    _model = model;
    
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",model.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];

    
    if (model.ReplyType == 1) {
         self.nameLab.attributedText = [NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@ 回复 我：",model.ReplyerNick] withBigFont:15 withNeedchangeText:@"回复" withSmallFont:15 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:kMainColor];
        
    }
    else
    {
      self.nameLab.text = [NSString stringWithFormat:@"%@ :",model.ReplyerNick];;
    
    }
    
    self.contentLab.attributedText = [NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@  %@",model.ReplyContent,[Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]]] withBigFont:15 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]] withSmallFont:10 dainmaicColor:[UIColor blackColor] excisionColor:[UIColor getColor:@"BCBCBC"]];;
    
    
    if (model.ReplySelect == 0) {
        
        [self.lookBtn setTitle:@"查看原文章" forState:UIControlStateNormal];
    }
    
    if (model.ReplySelect == 1) {
        [self.lookBtn setTitle:@"查看原话题" forState:UIControlStateNormal];
    }
    
}

@end
