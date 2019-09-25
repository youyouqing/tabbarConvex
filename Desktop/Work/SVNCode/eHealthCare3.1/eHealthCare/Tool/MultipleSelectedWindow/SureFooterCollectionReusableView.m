//
//  SureFooterCollectionReusableView.m
//  MultipleSelectedWindow
//
//  Created by 刘硕 on 2016/12/23.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "SureFooterCollectionReusableView.h"

@implementation SureFooterCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelBtn.clipsToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 25.f;
    
    self.confirmBtn.clipsToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 25.f;
    
    self.ageView.clipsToBounds = YES;
    self.ageView.layer.cornerRadius = 16.f;
    self.ageView.layer.borderColor = [UIColor getColor:@"DEE5EB"].CGColor;
    self.ageView.layer.borderWidth = 0.5f;
}
- (IBAction)confirmClick:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}
- (IBAction)cancelClick:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

@end
