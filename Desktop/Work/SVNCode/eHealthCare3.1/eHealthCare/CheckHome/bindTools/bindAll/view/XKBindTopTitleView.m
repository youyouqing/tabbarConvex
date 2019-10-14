//
//  XKBindTopTitleView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBindTopTitleView.h"

@interface XKBindTopTitleView ()

/**
 去绑定
 */
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

/**
 设备名
 */
@property (weak, nonatomic) IBOutlet UILabel *toolNameLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
@implementation XKBindTopTitleView
#pragma mark  初始化数据
-(void)awakeFromNib
{

    [super awakeFromNib];
    
    self.buyBtn.layer.cornerRadius = self.buyBtn.frame.size.height/2.0;
    
    
    self.buyBtn.clipsToBounds = YES;
    
    self.buyBtn.layer.borderWidth = 1.f;
    
    self.buyBtn.layer.borderColor = kMainColor.CGColor;
    

}
#pragma mark  代理
- (IBAction)buyToolAction:(id)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(bindTopTitleBuyTools)]) {
        
        [self.delegate bindTopTitleBuyTools];
        
    }
    
}
-(void)setDeviceDetailMod:(XKDeviceProductMod *)deviceDetailMod
{

    _deviceDetailMod = deviceDetailMod;
    
    
    self.toolNameLab.text = deviceDetailMod.ProductName;
    
    
     [self.imgView sd_setImageWithURL:[NSURL URLWithString:_deviceDetailMod.ImgUrl] placeholderImage:[UIImage imageNamed:@"moren"]];
    
    
    
}
@end