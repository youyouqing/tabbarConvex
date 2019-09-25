//
//  XKMessageInputeView.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMessageInputeView.h"

@interface XKMessageInputeView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *txtContianerview;

@end

@implementation XKMessageInputeView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.txtContianerview.layer.cornerRadius = 5;
    self.txtContianerview.layer.masksToBounds = YES;
    
    self.txt.delegate = self;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"willHideXKInputeBorad" object:textField];
    return YES;
    
}

@end
