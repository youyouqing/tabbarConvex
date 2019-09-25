//
//  InformationCollectionViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "InformationCollectionViewCell.h"
@interface InformationCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UILabel *collectLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backWidthCons;

@end
@implementation InformationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.backgroundColor = [UIColor whiteColor];
    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, (KScreenWidth-25*2-10)/2-10, ((KScreenWidth-25*2-10)/2.0)*248/158.0) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//    maskLayer.frame = corPath.bounds;
//    maskLayer.path=corPath.CGPath;
//    self.iconImage.layer.mask=maskLayer;
//
//    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
//    UIBezierPath *corPath2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, (KScreenWidth-25*2-10)/2-10, ((KScreenWidth-25*2-10)/2.0)*248/158.0) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//    maskLayer2.frame = corPath2.bounds;
//    maskLayer2.path=corPath2.CGPath;
//    self.backView.layer.mask=maskLayer2;
    

    self.backWidthCons.constant = KWidth(158);
    self.backView.layer.shadowColor = [UIColor colorWithRed:93/255.0 green:148/255.0 blue:164/255.0 alpha:0.13].CGColor;
    self.backView.layer.shadowOpacity = 1;
    self.backView.layer.shadowRadius = 5.f;
    self.backView.layer.shadowOffset = CGSizeMake(0, 2);
    self.contentLab.textColor = [UIColor getColor:@"6E6E6E"];
    
    self.backView.layer.cornerRadius = 5;
    
    
//    CGSizeMake((KScreenWidth-25*2-10)/2, ((KScreenWidth-25*2-10)/2.0)*246/158.0+5);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, (KScreenWidth-25*2-10)/2.0, ((KScreenWidth-25*2-10)/2.0*122/158.0))      byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft     cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =  self.iconImage.bounds;//CGRectMake(0, 0, (KScreenWidth-25*2-10)/2.0, ((KScreenWidth-25*2-10)/2.0*246/158.0)+5);
    maskLayer.path = maskPath.CGPath;
    self.iconImage.layer.mask = maskLayer;
}
-(void)setWikiListModel:(XKNewModel *)WikiListModel
{
    
    _WikiListModel = WikiListModel;
    self.contentLab.text = WikiListModel.WikiName;//WikiListModel.Content;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:WikiListModel.ImgUrl] placeholderImage:[UIImage imageNamed:@"iv_index_information_default"]];
    
//   [DateformatTool DateFormatWithDate:[NSString stringWithFormat:@"%@",WikiListModel.PublishTime] withFormat:@"YYYY-MM-dd"];
    
    self.timeLab.text = WikiListModel.PublishTime;//[DateformatTool ymdStringFromString:[DateformatTool dateFromString:WikiListModel.PublishTime]];
   
    [self.readBtn setTitle:[NSString stringWithFormat:@" %li",WikiListModel.VisitCount] forState:UIControlStateNormal];

    [self.numBtn setTitle:[NSString stringWithFormat:@" %li",WikiListModel.DiscussCount] forState:UIControlStateNormal];
    
    self.collectLab.text = [NSString stringWithFormat:@"%li",WikiListModel.FavorCount];
    if (WikiListModel.CollectFlag == 1) {
        self.collectBtn.selected = YES;
    }
    else
        self.collectBtn.selected = NO;
    
}
- (IBAction)collectAction:(id)sender {
    
    NSInteger collect =  !self.collectBtn.selected;
    //>0?_mod.WikiID:_mod.ID。ID 和 _mod.WikiID两个。 ID一起用。因为模型混乱防止这个不在用另外一个
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"911" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"WikiID":@(_WikiListModel.ID),@"CollectFlag":@(collect)} success:^(id json) {
        
        NSLog(@"911-----%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            
            
            if (collect) {
                self.WikiListModel.FavorCount++;
                ShowSuccessStatus(@"收藏成功");
            }
            else{
                 self.WikiListModel.FavorCount--;
                 ShowSuccessStatus(@"取消收藏成功");
            }
          
             self.collectLab.text = [NSString stringWithFormat:@"%li",self.WikiListModel.FavorCount];
            
            self.collectBtn.selected = collect;
//            if ([self.delegate respondsToSelector:@selector(changeHotTopicChildDataSoure:)]) {
//                [self.delegate changeHotTopicChildDataSoure:self.model];//话题切换数据了
//            }
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        
    }];
    
    
}
@end
