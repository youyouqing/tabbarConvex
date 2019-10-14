//
//  MessagePublicCell.m
//  eHealthCare
//
//  Created by xiekang on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessagePublicCell.h"
@interface MessagePublicCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLal;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet UILabel *textLal;
@property (weak, nonatomic) IBOutlet UIButton *messageNumLal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numWidthCons;

@end
@implementation MessagePublicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageV.layer.cornerRadius = self.imageV.frame.size.height/2;
    self.imageV.clipsToBounds = YES;
    
    self.messageNumLal.layer.cornerRadius = self.messageNumLal.frame.size.height/2;
    self.messageNumLal.clipsToBounds = YES;
    self.messageNumLal.backgroundColor = ORANGECOLOR;
    self.messageNumLal.hidden = NO;
}

-(void)setNewNotice:(NewWikiModel *)NewNotice
{
    _NewNotice = NewNotice;
    _timeLal.text = NewNotice.CreateTime;
    if (NewNotice.ReadNum <= 0) {
        _numWidthCons.constant = 0;
    }else if(NewNotice.ReadNum > 9){
        _numWidthCons.constant = 30;
    }else{
        _numWidthCons.constant = 20;
    }
    
    if (NewNotice.ReadNum > 0) {//大于零的时候才显示
        [_messageNumLal setTitle:[NSString stringWithFormat:@"%li",NewNotice.ReadNum] forState:UIControlStateNormal];
    }
    _imageV.image = [UIImage imageNamed:NewNotice.imageName];//[UIImage imageNamed:@"icon_meaasge_gonggao"];
    _titleLal.text = NewNotice.TitleName;
    
    _textLal.text = NewNotice.NoticeTitle;
    
    if (NewNotice.tagSwith == 2) {
          _textLal.text = NewNotice.MessageTitle;
    }
   else if (NewNotice.tagSwith == 3) {
        _textLal.text = NewNotice.TopicTitle;
    }
   else  if (NewNotice.tagSwith == 1) {
    _textLal.text = NewNotice.NoticeTitle;
    _timeLal.text = NewNotice.NoticeTime;
    
            if (NewNotice.NoticeNoReadNum <= 0) {
                _numWidthCons.constant = 0;
            }else if(NewNotice.NoticeNoReadNum > 9){
                _numWidthCons.constant = 30;
            }else{
                _numWidthCons.constant = 20;
            }
       
            if (NewNotice.NoticeNoReadNum > 0) {//大于零的时候才显示
                [_messageNumLal setTitle:[NSString stringWithFormat:@"%li",NewNotice.NoticeNoReadNum] forState:UIControlStateNormal];
            }
    }
   else  if (NewNotice.tagSwith == 4) {
        _textLal.text = NewNotice.FamilyAddTitle;
    }
  
  
    
  
    
}
-(void)setNewWikiMessage:(NewWikiModel *)NewWikiMessage
{
//    _NewWikiMessage = NewWikiMessage;
//
//            _imageV.image = [UIImage imageNamed:NewWikiMessage.imageName];//[UIImage imageNamed:@"icon_meaasge_gonggao"];
//    _titleLal.text = NewWikiMessage.TitleName;
//
//    _textLal.text = NewWikiMessage.MessageTitle;
//    _timeLal.text = NewWikiMessage.CreateTime;
//
//    if (NewWikiMessage.ReadNum <= 0) {
//        _numWidthCons.constant = 0;
//    }else if(NewWikiMessage.ReadNum > 9){
//        _numWidthCons.constant = 30;
//    }else{
//        _numWidthCons.constant = 20;
//    }
//
//    if (NewWikiMessage.ReadNum > 0) {//大于零的时候才显示
//        [_messageNumLal setTitle:[NSString stringWithFormat:@"%li",NewWikiMessage.ReadNum] forState:UIControlStateNormal];
//    }
    
}
-(void)setNewTopicMessage:(NewWikiModel *)NewTopicMessage
{
//    _NewTopicMessage = NewTopicMessage;
//
//            _imageV.image = [UIImage imageNamed:NewTopicMessage.imageName];//[UIImage imageNamed:@"icon_meaasge_gonggao"];
//    _titleLal.text = NewTopicMessage.TitleName;
//
//    _textLal.text = NewTopicMessage.TopicTitle;
//    _timeLal.text = NewTopicMessage.CreateTime;
//
//    if (NewTopicMessage.ReadNum <= 0) {
//        _numWidthCons.constant = 0;
//    }else if(NewTopicMessage.ReadNum > 9){
//        _numWidthCons.constant = 30;
//    }else{
//        _numWidthCons.constant = 20;
//    }
//
//    if (NewTopicMessage.ReadNum > 0) {//大于零的时候才显示
//        [_messageNumLal setTitle:[NSString stringWithFormat:@"%li",NewTopicMessage.ReadNum] forState:UIControlStateNormal];
//    }
    
}


-(void)setNewHealthNotice:(NewHealthNoticeMod *)NewHealthNotice
{
//    _NewHealthNotice = NewHealthNotice;
//
//    _imageV.image = [UIImage imageNamed:NewHealthNotice.imageName];//[UIImage imageNamed:@"icon_meaasge_gonggao"];
//    _titleLal.text = NewHealthNotice.TitleName;
//
//    _textLal.text = NewHealthNotice.NoticeTitle;
//    _timeLal.text = NewHealthNotice.NoticeTime;
//
//    if (NewHealthNotice.NoticeNoReadNum <= 0) {
//        _numWidthCons.constant = 0;
//    }else if(NewHealthNotice.NoticeNoReadNum > 9){
//        _numWidthCons.constant = 30;
//    }else{
//        _numWidthCons.constant = 20;
//    }
//
//    if (NewHealthNotice.NoticeNoReadNum > 0) {//大于零的时候才显示
//        [_messageNumLal setTitle:[NSString stringWithFormat:@"%li",NewHealthNotice.NoticeNoReadNum] forState:UIControlStateNormal];
//    }
    
}
-(void)setNewFamilyAddMessage:(NewFamilyAddMessagMod *)NewFamilyAddMessage
{
//    _NewFamilyAddMessage = NewFamilyAddMessage;
//
//    _imageV.image = [UIImage imageNamed:NewFamilyAddMessage.imageName];//[UIImage imageNamed:@"icon_meaasge_gonggao"];
//    _titleLal.text = NewFamilyAddMessage.TitleName;
//
//    _textLal.text = NewFamilyAddMessage.FamilyAddTitle;
//    _timeLal.text = NewFamilyAddMessage.CreateTime;
//
//    if (NewFamilyAddMessage.ReadNum <= 0) {
//        _numWidthCons.constant = 0;
//    }else if(NewFamilyAddMessage.ReadNum > 9){
//        _numWidthCons.constant = 30;
//    }else{
//        _numWidthCons.constant = 20;
//    }
//
//    if (NewFamilyAddMessage.ReadNum > 0) {//大于零的时候才显示
//        [_messageNumLal setTitle:[NSString stringWithFormat:@"%li",NewFamilyAddMessage.ReadNum] forState:UIControlStateNormal];
//    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end