//
//  SportCenterDestinaView.m
//  eHealthCare
//
//  Created by John shi on 2018/11/17.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "SportCenterDestinaView.h"
@interface SportCenterDestinaView ()
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *borderBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *textInputLab;

@property (weak, nonatomic) IBOutlet UITextField *textDistanceText;

@end
@implementation SportCenterDestinaView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.centerView.layer.cornerRadius=10;
    self.centerView.layer.masksToBounds=YES;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5;
    
    self.sureBtn.layer.masksToBounds=YES;
    self.borderBtn.layer.borderWidth = 0.5;
    self.borderBtn.layer.borderColor = kMainColor.CGColor;
    self.sureBtn.layer.cornerRadius=self.sureBtn.frame.size.height/2.0;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _textDistanceText.leftViewMode = UITextFieldViewModeAlways;
    _textDistanceText.leftView = leftview;
    _textDistanceText.layer.borderWidth=1.0f;
    _textDistanceText.layer.cornerRadius=5.f;
    _textDistanceText.layer.borderColor=kMainColor.CGColor;
    
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
//注销通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    
}
- (IBAction)closeAction:(id)sender {
    [self removeFromSuperview];
    
    self.textDistanceText.text = @"";
    
}
- (IBAction)completeAction:(id)sender {
    if ([self.textDistanceText.text isEqualToString:@"0"]) {
        ShowErrorStatus(@"请输入正确的目标距离");
        return;
    }
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(SportCenterDestinaViewCompleteClick:)]) {
        [self.delegate SportCenterDestinaViewCompleteClick:self.textDistanceText.text];
    }
    self.textDistanceText.text = @"";
}
@end
