//
//  AddFamilyCollectionReusableView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AddFamilyCollectionReusableView.h"

@implementation AddFamilyCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.CustomBtn.clipsToBounds = YES;
    self.CustomBtn.layer.cornerRadius = 3.f;
}
- (IBAction)customAction:(id)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(CustomActionTools)]) {
        
        [self.delegate CustomActionTools];
        
    }
    
}

@end
