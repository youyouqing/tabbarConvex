//
//  XKInforamationCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInforamationCell.h"
@interface XKInforamationCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titlrLab;
//@property (weak, nonatomic) IBOutlet UILabel *numLab;
//@property (weak, nonatomic) IBOutlet UILabel *readLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;



@end
@implementation XKInforamationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setXknewModel:(XKNewModel *)xknewModel{
    
    _xknewModel = xknewModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:xknewModel.ImgUrl] placeholderImage:[UIImage imageNamed:@"img_default"]];

    self.timeLab.text = xknewModel.PublishTime;
    self.titlrLab.text = xknewModel.WikiName.length>0? xknewModel.WikiName:@"   ";
    
    
    [self.numBtn setTitle:[NSString stringWithFormat:@" %li",xknewModel.VisitCount] forState:UIControlStateNormal];
    
    [self.readBtn setTitle:[NSString stringWithFormat:@" %li",xknewModel.DiscussCount] forState:UIControlStateNormal];
    NSLog(@"%@-123-%li",xknewModel.WikiName,xknewModel.VisitCount);
}
-(void)setFavourModel:(XKWiKIInfoModel *)favourModel
{
    _favourModel = favourModel;
    
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_favourModel.HeadImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    //  我的收藏   偷懒公用一个模型
    if (_favourModel.ImgUrl) {
        [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_favourModel.ImgUrl] placeholderImage:[UIImage imageNamed:@"img_default"]];
    }
    
    
    
    Dateformat  *dateF = [[Dateformat alloc] init];
    NSString *s = [dateF DateFormatWithDate:_favourModel.PublishTime withFormat:@"YYYY-MM-dd"];
    self.timeLab.text = s;
    self.titlrLab.text = _favourModel.WikiName.length>0? _favourModel.WikiName:@"   ";
    [self.readBtn setTitle:[NSString stringWithFormat:@" %li",_favourModel.ReplyCount] forState:UIControlStateNormal];
    [self.numBtn setTitle:[NSString stringWithFormat:@" %li",_favourModel.ReadScount] forState:UIControlStateNormal];


}
-(void)setModel:(XKWiKIInfoModel *)model
{
    _model = model;
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_model.HeadImg] placeholderImage:[UIImage imageNamed:@"img_default"]];
    
    //  我的收藏   偷懒公用一个模型
    if (_model.ImgUrl) {
         [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_model.ImgUrl] placeholderImage:[UIImage imageNamed:@"img_default"]];
    }
    Dateformat  *dateF = [[Dateformat alloc] init];
    NSString *s = [dateF DateFormatWithDate:_model.PublishTime withFormat:@"YYYY-MM-dd"];
    self.timeLab.text = _model.PublishTime;
    self.titlrLab.text = _model.WikiName.length>0? _model.WikiName:@"   ";
    [self.readBtn setTitle:[NSString stringWithFormat:@" %li",_model.ReplyScount] forState:UIControlStateNormal];

    [self.numBtn setTitle:[NSString stringWithFormat:@" %li",_model.ReadScount] forState:UIControlStateNormal];
    
    
    NSLog(@"%@---%li----%li",model.WikiName,model.ReplyCount,model.ReplyScount);
 
    
    [self.numBtn setTitle:[NSString stringWithFormat:@" %li",_model.VisitCount] forState:UIControlStateNormal];
    
    [self.readBtn setTitle:[NSString stringWithFormat:@" %li",_model.DiscussCount] forState:UIControlStateNormal];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
