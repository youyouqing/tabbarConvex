//
//  XKCircalButton.m
//  eHealthCare
//
//  Created by jamkin on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKCircalButton.h"

@implementation XKCircalButton

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.layer.cornerRadius=15;
    
    self.layer.masksToBounds=YES;
    
    self.backgroundColor=[UIColor whiteColor];
    
    self.layer.borderWidth=1;
    
    self.layer.borderColor=kMainColor.CGColor;
    
    [self setTitleColor:kMainColor forState:UIControlStateNormal];
    
}

-(void)setResponsType:(NSInteger)responsType{
    
    _responsType=responsType;
    
    if (_responsType==1) {
        
        self.backgroundColor=kMainColor;
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        
        self.backgroundColor=[UIColor whiteColor];
        
        self.layer.borderWidth=1;
        
        self.layer.borderColor=kMainColor.CGColor;
        
        [self setTitleColor:kMainColor forState:UIControlStateNormal];
        
        
    }

    
}


@end