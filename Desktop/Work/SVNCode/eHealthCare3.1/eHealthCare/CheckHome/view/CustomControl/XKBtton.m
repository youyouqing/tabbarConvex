//
//  XKBtton.m
//  eHealthCare
//
//  Created by mac on 16/12/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKBtton.h"

@implementation XKBtton

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.top=0;
    
//    self.height=30;
    
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    
    self.titleLabel.frame=CGRectMake(0, 0, self.bounds.size.width-self.imageView.frame.size.width, self.bounds.size.height);
    
    self.imageView.frame=CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 14, self.bounds.size.width-self.titleLabel.frame.size.width, self.bounds.size.width-self.titleLabel.frame.size.width);
//    [self sizeToFit];
    
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    return CGRectMake( contentRect.size.width-(contentRect.size.width-30), (contentRect.size.height-20)/2, 20, 20);
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    return CGRectMake(0, 0, contentRect.size.width-self.imageView.frame.size.width, contentRect.size.height);
//}


@end
