//
//  XKBindGuideTableViewCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBindGuideTableViewCell.h"
@interface XKBindGuideTableViewCell ()



@property (weak, nonatomic) IBOutlet UILabel *nameLab;


@property (weak, nonatomic) IBOutlet UIImageView *backImage;


@property (weak, nonatomic) IBOutlet UIImageView *equiptImage;


@end
@implementation XKBindGuideTableViewCell
#pragma mark  初始化数据
- (void)awakeFromNib {
    [super awakeFromNib];

    self.dotBtn.layer.cornerRadius = self.dotBtn.frame.size.height/2.0;
    
    
    self.dotBtn.clipsToBounds = YES;

}
-(void)setDeviceDetailMod:(XKDeviceProductMod *)deviceDetailMod
{
    
    _deviceDetailMod = deviceDetailMod;
    
    
    self.nameLab.text = deviceDetailMod.ProductName;
    
    
    [self.equiptImage sd_setImageWithURL:[NSURL URLWithString:_deviceDetailMod.ImgUrl] placeholderImage:[UIImage imageNamed:@"moren"]];
    
    

    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_deviceDetailMod.GuidelinesContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    //    self.dataLab.attributedText = attrStr;
    
    [self.webView loadHTMLString:attrStr.string baseURL:nil];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
