//
//  SubmitFootView.m
//  eHealthCare
//
//  Created by xiekang on 16/12/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SubmitFootView.h"
@interface SubmitFootView ()

@end

@implementation SubmitFootView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.weiXinView setTarget:self action:@selector(clickSelect:)];
    [self.zhiFuBaoView setTarget:self action:@selector(clickSelect:)];
    self.paySelect = 0;
}

-(void)clickSelect:(ClickBackView *)view
{
    if (view.tag == 200) {
        //微信选中
        self.paySelect = 2;
        NSLog(@"微信");
        self.zhifubaoBtnIconV.image = [UIImage imageNamed:@"radio_nomal"];
        self.weixinBtnIconV.image = [UIImage imageNamed:@"radio_selected"];
    }else{
        //支付宝选中
        self.paySelect = 1;
        NSLog(@"支付宝");
        self.weixinBtnIconV.image = [UIImage imageNamed:@"radio_nomal"];
        self.zhifubaoBtnIconV.image = [UIImage imageNamed:@"radio_selected"];
    }
}

-(void)setModel:(SubmitDataModel *)model
{
    if (model.PayMethod == 1) {
        [self clickSelect:_zhiFuBaoView];
    }else if (model.PayMethod == 2){
        [self clickSelect:_weiXinView];
    }
}

@end
