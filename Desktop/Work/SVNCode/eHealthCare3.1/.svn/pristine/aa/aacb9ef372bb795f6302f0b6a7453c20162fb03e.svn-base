//
//  XKProvinceCell.m
//  eHealthCare
//
//  Created by mac on 16/12/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKProvinceCell.h"

@interface XKProvinceCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightCons;


@end

@implementation XKProvinceCell

-(void)setAddress:(XKScreenAddrees *)address{
    _address=address;
    self.titleLab.text=_address.CodeName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLab.textColor=kThemeColor;
    self.lineView.backgroundColor=kLineColor;
    self.lineHeightCons.constant=0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.backgroundColor=[UIColor getColor:@"f3f3f3"];
        self.titleLab.textColor=NAVICOLOR;
    }else{
        self.backgroundColor=[UIColor clearColor];
        self.titleLab.textColor=kThemeColor;
    }

}

@end
