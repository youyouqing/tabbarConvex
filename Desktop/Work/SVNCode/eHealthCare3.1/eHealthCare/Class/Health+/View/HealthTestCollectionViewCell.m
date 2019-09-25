//
//  HealthTestCollectionViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthTestCollectionViewCell.h"
@interface HealthTestCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *isCollectBtn;


@end
@implementation HealthTestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.nameLab.font = Kfont(15);
    self.detailLab.font = Kfont(14);
    self.BeginTestBtn.backgroundColor = [UIColor getColor:@"03C7FF"];
    self.backView.layer.shadowColor =[UIColor colorWithRed:93/255.0 green:148/255.0 blue:164/255.0 alpha:0.13].CGColor;
    
    
    self.backView.layer.shadowOpacity = 1;
    self.backView.layer.shadowRadius = 5.f;
    self.backView.layer.shadowOffset = CGSizeMake(0, 2);
    //dzc todo 11.18 (KScreenWidth-5-18*2)/      158/246
    
    self.backView.layer.cornerRadius = 5;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, (KScreenWidth-5-18*2)/2, ((KScreenWidth-5-18*2)/2*190/158.0)+5)      byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft     cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}
- (IBAction)beginTest:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthTestCollectionViewCellJoinAction:)]) {
        
        [self.delegate HealthTestCollectionViewCellJoinAction:self];
    }
    
    
}
- (IBAction)isCollectAction:(id)sender {
    
    NSLog(@"点赞按钮功能的实现");
    NSInteger isCollect = 1;
    if (_listMod.IsCollect == 1) {//已经点赞
        isCollect = 0;
    }else{
         isCollect = 1;
    }
    {//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        //获取首页健康计划、热门话题数据
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"949" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"WikiID":@(self.listMod.SetCategoryId),@"CollectFlag":@(isCollect)} success:^(id json) {
            
            NSLog(@"%@",json);
            [[XKLoadingView shareLoadingView] hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                if (self.listMod.IsCollect == 1) {//已经点赞
                    //点赞成功 更换点赞按钮图片
                    self.isCollectBtn.selected = NO;
                    
                    //1.点赞数量加一
                    self.listMod.CollectCount--;
                    
                    //2.更换是否点赞的参数
                    self.listMod.IsCollect = 0;
                }else{
                    //点赞成功 更换点赞按钮图片
                    self.isCollectBtn.selected = YES;
                    
                    //1.点赞数量加一
                    self.listMod.CollectCount++;
                    
                    //2.更换是否点赞的参数
                    self.listMod.IsCollect = 1;
                }
               
                
                self.countLab.text = [NSString stringWithFormat:@"%li",self.listMod.CollectCount];
               
                
                if ([self.delegate respondsToSelector:@selector(HealthTestdetailChangeDataSoure:)]) {
                    [self.delegate HealthTestdetailChangeDataSoure:self.listMod];
                }
                
                
            }else{
                
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);
            
        }];
        
    }
    
    
}
-(void)setListMod:(CheckListModel *)listMod{
    _listMod = listMod;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:listMod.SetImgUrl] placeholderImage:[UIImage imageNamed:@"iv_zice_suolvetu"]];;
    self.nameLab.text = listMod.SetCategoryName;
    self.detailLab.text = [NSString stringWithFormat:@"%li人已测",listMod.TestCount];
    if (listMod.IsCollect == 1) {
        self.isCollectBtn.selected = YES;
    }else
        self.isCollectBtn.selected = NO;
    self.countLab.text = [NSString stringWithFormat:@"%li",listMod.CollectCount];
}

@end
