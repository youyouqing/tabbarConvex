//
//  XKLineViewOne.m
//  eHealthCare
//
//  Created by jamkin on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKLineViewOne.h"

@implementation XKLineViewOne

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor=COLOR(216, 216, 216, 1);
    
}

-(void)layoutSubviews{
    
    self.height=0.5;
    
}

@end
