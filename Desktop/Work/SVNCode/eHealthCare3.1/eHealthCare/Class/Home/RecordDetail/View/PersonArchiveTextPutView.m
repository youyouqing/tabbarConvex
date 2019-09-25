//
//  PersonArchiveTextPutView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PersonArchiveTextPutView.h"
@interface PersonArchiveTextPutView ()

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *borderBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *textInputLab;


@end
@implementation PersonArchiveTextPutView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.centerView.layer.cornerRadius=10;
    self.centerView.layer.masksToBounds=YES;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5.f;
    
    self.sureBtn.layer.masksToBounds=YES;
    self.borderBtn.layer.borderWidth = 0.5;
    self.borderBtn.layer.borderColor = kMainColor.CGColor;
    self.borderBtn.layer.cornerRadius = 2.5f;
    self.sureBtn.layer.cornerRadius=self.sureBtn.frame.size.height/2.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - 通知监听键盘
-(void)keyboardWillShow:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        CGRect frame = self.frame;
        frame.origin.y =-130;
        self.frame = frame;
    }];
}
-(void)keyboardWillHide:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        CGRect frame = self.frame;
        frame.origin.y = 0;
        self.frame = frame;
    }];
    
}

-(void)setPopType:(PersonArchiveSingleType)popType
{
    _popType = popType;
    if (popType == 0) {
        self.textInputLab.text = @"请填写关系";
        self.inputDataText.placeholder = @"关系";
    }else
    {
       self.textInputLab.text = @"请填写姓名";
         self.inputDataText.placeholder = @"姓名";
    }
    
}
- (IBAction)closeAction:(id)sender {
    [self removeFromSuperview];
    
     self.inputDataText.text = @"";
    
}
- (IBAction)completeAction:(id)sender {
    
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(PersonArchiveTextPutViewCompleteClick:)]) {
        [self.delegate PersonArchiveTextPutViewCompleteClick:self.inputDataText.text];
    }
    self.inputDataText.text = @"";
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//    [self endEditing:YES];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//注销通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
