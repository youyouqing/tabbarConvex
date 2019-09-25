//
//  XKManualInputView.m
//  PlayerTest
//
//  Created by xiekang on 2017/10/18.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "XKManualInputView.h"

@interface XKManualInputView ()<UITextFieldDelegate>
{

  int  BloodSugarType;
}
@property (weak, nonatomic) IBOutlet UIView *centerView;

/**
 底部高度图  295   385
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backBottomHeight;

/**
 每个图高度  220   55
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *everyBottomHeight;

/**
 请输入体温值
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


/**
 体温值
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *nameTwoLab;
@property (weak, nonatomic) IBOutlet UILabel *nameThreeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameFourLab;

/**
 确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;



/**
 范围值
 */
@property (weak, nonatomic) IBOutlet UILabel *scopeLab;


@property (weak, nonatomic) IBOutlet UILabel *scopeTwoLab;


@property (weak, nonatomic) IBOutlet UILabel *scopeThreeLab;


@property (weak, nonatomic) IBOutlet UILabel *scopeFourLab;


/**
 手动输入
 */
@property (weak, nonatomic) IBOutlet UITextField *manualText;
@property (weak, nonatomic) IBOutlet UITextField *manualTwoText;
@property (weak, nonatomic) IBOutlet UITextField *manualThreeText;
@property (weak, nonatomic) IBOutlet UITextField *manualFourText;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SugarTopHeight;

/**
 空腹血糖   随机血糖
 */
@property (weak, nonatomic) IBOutlet UIView *sugarBottomView;

@property (weak, nonatomic) IBOutlet UIButton *emptSugarBtn;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sugarTopHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewFourHeight;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UIView *viewFour;

@end


@implementation XKManualInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.sureBtn.layer.cornerRadius = self.sureBtn.frame.size.height/2.0;
    
    
    self.sureBtn.clipsToBounds = YES;
    
    self.centerView.layer.cornerRadius = 8;
    
    
    self.centerView.clipsToBounds = YES;
    
    self.manualText.text = @"";
    self.manualTwoText.text = @"";
    self.manualThreeText.text = @"";
    self.manualFourText.text = @"";
    self.sugarTopHeight.constant = 0;
      _manualText.keyboardType = UIKeyboardTypeNumberPad;
      _manualTwoText.keyboardType = UIKeyboardTypeNumberPad;
      _manualThreeText.keyboardType = UIKeyboardTypeNumberPad;
      _manualFourText.keyboardType = UIKeyboardTypeNumberPad;
    _manualText.delegate = self;
    
    _manualTwoText.delegate = self;
    
    _manualThreeText.delegate = self;
    
    _manualFourText.delegate = self;
    BloodSugarType = 1;
    [_manualText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    [_manualThreeText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    [_manualTwoText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    [_manualFourText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

    self.emptSugarBtn.backgroundColor = [UIColor colorWithHexString:@"3cc9db"];
    [self.emptSugarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    if (self.toolStyle == XKBloodPressureStyleFill) {
//       
//        self.backBottomHeight.constant = 385;
//        self.everyBottomHeight.constant = 220;
//        
//        
//    }else if (self.toolStyle == XKBloodFatStyleFill)
//    {
//    
//       self.backBottomHeight.constant = 385;
//       self.everyBottomHeight.constant = 220;
//    }
//    else
//    {
//        self.backBottomHeight.constant = 295;
//        
//        self.everyBottomHeight.constant = 55;
//     
//    }
    
    

}
-(void)setStyle:(XKDetectStyle)style
{

    _style = style;
    if (self.style == XKDetectBloodTemperatureStyle) {
        [self simplemanaul];
        self.nameLab.text = @"体温值";
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位℃）",self.nameLab.text];
        
         self.manualText.placeholder = @"36-37.2";
        
        self.manualText.text = @"";
          _manualText.keyboardType = UIKeyboardTypeDecimalPad;
        
    }
    if (self.style == XKDetectBloodOxygenStyle) {

        [self simplemanaul];
        
        
        self.nameLab.text = @"血氧值";
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位%%）",self.nameLab.text];
        
         self.manualText.placeholder = @"94-100";
        
//        self.manualText.text = @"";

    }
    if (self.style == XKDetectHemoglobinStyle) {
        
        
    }
    if (self.style == XKDetectDyslipidemiaStyle) {//血脂
        self.viewTwo.hidden = NO;
        self.viewThree.hidden = NO;
        self.viewFour.hidden = NO;
        self.viewTwoHeight.constant = 55;
        self.viewThreeHeight.constant = 55;
        self.viewFourHeight.constant = 55;
        self.sugarBottomView.hidden = YES;
        self.everyBottomHeight.constant = 220;
        self.backBottomHeight.constant = 405.f;
         self.SugarTopHeight.constant = 1.f;
        
        self.nameLab.text = @"总胆固醇";
         self.nameTwoLab.text = @"甘油三酯";
         self.nameThreeLab.text = @"高密度脂蛋白";
         self.nameFourLab.text = @"低密度脂蛋白";
        self.titleLab.text = [NSString stringWithFormat:@"请输入血脂值（单位mmol/L）"];
        
        self.manualText.placeholder = @"<5.2";
        self.manualTwoText.placeholder = @"<1.7";
        self.manualThreeText.placeholder = @">1.0";
        self.manualFourText.placeholder = @"<3.4";
        
        _manualText.keyboardType = UIKeyboardTypeDecimalPad;
        _manualTwoText.keyboardType = UIKeyboardTypeDecimalPad;
        _manualThreeText.keyboardType = UIKeyboardTypeDecimalPad;
        _manualFourText.keyboardType = UIKeyboardTypeDecimalPad;
        
    }
    if (self.style == XKDetectBloodSugarStyle) {
        [self sugarmanaul];
       
        
        
        self.sugarTopHeight.constant = 20;
        self.nameLab.text = @"血糖值";
        
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位%mmol/L）",self.nameLab.text];
        
         self.manualText.placeholder = @"3.9-6.11";//3.61-6.11
        
        _manualText.keyboardType = UIKeyboardTypeDecimalPad;
    }
    if (self.style == XKDetectWeightStyle) {

        
        [self simplemanaul];
        self.nameLab.text = @"体重";
        
        _manualText.keyboardType = UIKeyboardTypeDecimalPad;
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位kg）",self.nameLab.text];
        
        self.manualText.placeholder = @"";

    }
    if (self.style == XKDetectBloodPressureStyle) {
//        self.viewTwo.hidden = YES;
//        self.viewThree.hidden = YES;
        [self doubleManaul];
        self.nameThreeLab.text = @"心率值";
        self.nameLab.attributedText = [NSMutableAttributedString changeLabelWithText:@"收缩压（高压）" withBigFont:18 withNeedchangeText:@"（高压）" withSmallFont:13 dainmaicColor:[UIColor colorWithHexString:@"333333"] excisionColor:[UIColor colorWithHexString:@"959595"]];
        self.nameTwoLab.attributedText = [NSMutableAttributedString changeLabelWithText:@"舒张压（低压）" withBigFont:18 withNeedchangeText:@"（低压）" withSmallFont:13 dainmaicColor:[UIColor colorWithHexString:@"333333"] excisionColor:[UIColor colorWithHexString:@"959595"]];
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位%mmHg）",@"血压值"];
        
         self.manualText.placeholder = @"90-139";
         self.manualTwoText.placeholder = @"60-89";
         self.manualThreeText.placeholder = @"60-100";
        
    }
    if (self.style == XKMutilPCBloodOxygenStyle) {
        
        [self simplemanaul];
        
        self.nameLab.text = @"血氧值";
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位%%）",self.nameLab.text];
        
        self.manualText.placeholder = @"94-100";
        
        self.manualText.text = @"";
        
        
        
    }
    if (self.style == XKMutilPCBloodPressurStyle) {
        
        [self doubleManaul];
        
//        self.nameLab.text = @"收缩压（高压）";
//        self.nameTwoLab.text = @"舒张压（低压）";
        self.nameThreeLab.text = @"心率值";
         self.nameLab.attributedText = [NSMutableAttributedString changeLabelWithText:@"收缩压（高压）" withBigFont:18 withNeedchangeText:@"（高压）" withSmallFont:13 dainmaicColor:[UIColor colorWithHexString:@"333333"] excisionColor:[UIColor colorWithHexString:@"959595"]];
         self.nameTwoLab.attributedText = [NSMutableAttributedString changeLabelWithText:@"舒张压（低压）" withBigFont:18 withNeedchangeText:@"（低压）" withSmallFont:13 dainmaicColor:[UIColor colorWithHexString:@"333333"] excisionColor:[UIColor colorWithHexString:@"959595"]];

        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位%mmHg）",@"血压值"];
        
        self.manualText.placeholder = @"90-139";
        self.manualTwoText.placeholder = @"60-89";
        self.manualThreeText.placeholder = @"60-100";
        

     
        
        
    }
    if (self.style == XKMutilPCTemperatureStyle) {
        
        [self simplemanaul];
        
        self.nameLab.text = @"体温值";
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位℃）",self.nameLab.text];
        
         self.manualText.placeholder = @"36-37.2";
        
        self.manualText.text = @"";
        
        _manualText.keyboardType = UIKeyboardTypeDecimalPad;

        
    }
    if (self.style == XKMutilPCNormalStyle) {
        
        [self simplemanaul];
        
        self.nameLab.text = @"脉率值";
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位次/分）",self.nameLab.text];
        
        self.manualText.placeholder = @"60-100";
        
    }
    if (self.style == XKMutilPCBloodSugarStyle) {
        
        [self sugarmanaul];

         self.sugarTopHeight.constant = 20;
        self.nameLab.text = @"血糖值";
     
        
        self.titleLab.text = [NSString stringWithFormat:@"请输入%@（单位%mmol/L）",self.nameLab.text];
        
        self.manualText.placeholder = @"3.9-6.11";
        
        _manualText.keyboardType = UIKeyboardTypeDecimalPad;
        
        
    }



}

-(void)simplemanaul{

    self.sugarBottomView.hidden = YES;
    self.everyBottomHeight.constant = 55;
    self.viewTwoHeight.constant = 0;
    self.viewThreeHeight.constant = 0;
    self.viewFourHeight.constant = 0;
    self.viewTwo.hidden = YES;
    self.viewThree.hidden = YES;
    self.viewFour.hidden = YES;
    self.backBottomHeight.constant = 295.f;
    self.SugarTopHeight.constant = 1.f;
}
-(void)doubleManaul{

    self.viewFour.hidden = YES;
    self.sugarBottomView.hidden = YES;
    self.viewTwoHeight.constant = 55;
    self.viewThreeHeight.constant = 55;
    self.viewFourHeight.constant = 0;
    self.everyBottomHeight.constant = 165;
    
    if (IS_IPHONE5||IS_IPHONE4S) {
        self.backBottomHeight.constant = 405.f;
    }
    self.backBottomHeight.constant = 385.f;
    self.SugarTopHeight.constant = 1.f;
}


-(void)sugarmanaul{


    self.viewTwo.hidden = YES;
    self.viewThree.hidden = YES;
    self.viewFour.hidden = YES;
    self.sugarBottomView.hidden = NO;
    self.viewTwoHeight.constant = 0;
    self.viewThreeHeight.constant = 0;
    self.viewFourHeight.constant = 0;
    self.everyBottomHeight.constant = 55;
    if (IS_IPHONE5||IS_IPHONE4S) {
        self.backBottomHeight.constant = 315.f;
    }
    self.backBottomHeight.constant = 295.f;
    self.SugarTopHeight.constant = 20.f;
}

- (IBAction)cancelAction:(id)sender {
    
     [self removeFromSuperview];
    
    
    [self emptyAlldata];
    
}

-(void)emptyAlldata{
    self.manualText.text = @"";
    self.manualTwoText.text = @"";
    
    self.manualThreeText.text = @"";
    self.manualFourText.text = @"";


}

- (IBAction)sureAction:(id)sender {
   

   
    BOOL verification =  [self scan:self.style];
    if (verification) {
        
         [self removeFromSuperview];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(selectIndex:manualText:manualTwoText:manualThreeText:manualFourText:sugarTag:)]) {
            [self.delegate selectIndex:self.nameLab.text manualText:self.manualText.text manualTwoText:self.manualTwoText.text manualThreeText:self.manualThreeText.text manualFourText:self.manualFourText.text sugarTag:BloodSugarType];
            
             [self emptyAlldata];
        }

    }
    
    
}
-(BOOL)scan:(XKDetectStyle)style  ;
{
    
    NSString *judgeStr1 = @"";
    NSString *judgeStr2 = @"";
    NSString *judgeStr3 = @"";
     NSString *judgeStr4 = @"";
    if (style == XKDetectBloodPressureStyle||self.style == XKMutilPCBloodPressurStyle) {
        //心率  收缩压  舒张压
        judgeStr1 = @"60-300";
        judgeStr2 = @"30-150";
        judgeStr3 = @"20-200";
        if ([self.manualText.text floatValue] <= 0) {
           

            NSLog(@"收缩压不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"收缩压不能为空或负数"] );
            
            return NO;
        }else if([self.manualTwoText.text floatValue] <= 0) {
            NSLog(@"舒张压不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"舒张压不能为空或负数"] );
            return NO;
        }else if([self.manualThreeText.text floatValue] <= 0) {
            NSLog(@"心率不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"心率不能为空或负数"]);
                      return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"收缩压不在范围30-150内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text] );
            return NO;
        }else if(![self is_betw_judgeStr:judgeStr2 text_value:self.manualTwoText.text]) {

            NSLog(@"舒张压不在范围20-200内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameTwoLab.text] );
           return NO;
        }else if(![self is_betw_judgeStr:judgeStr3 text_value:self.manualThreeText.text]) {
           
            NSLog(@"心率不能不在范围60-300内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameThreeLab.text]);
            return NO;
        }
    }
    if (style == XKDetectBloodOxygenStyle||self.style == XKMutilPCBloodOxygenStyle) {
        judgeStr1 = @"60-100";
        if ([self.manualText.text floatValue] <= 0) {
            NSLog(@"血氧不能为空或负数");
              ShowErrorStatus([NSString stringWithFormat:@"血氧不能为空或负数"] );
            return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"血氧不能在范围60-100内");
              ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text] );
            return NO;
        }
    }
    if (style == XKMutilPCNormalStyle) {
        judgeStr1 = @"20-200";
        if ([self.manualText.text floatValue] <= 0) {
            NSLog(@"脉率不能为空或负数");
             ShowErrorStatus([NSString stringWithFormat:@"脉率不能为空或负数"] );
            return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"脉率不在范围20-200内");
              ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text] );
           return NO;
        }
    }
    if (self.style == XKMutilPCTemperatureStyle||self.style == XKDetectBloodTemperatureStyle) {
        judgeStr1 = @"30-45";
        if ([self.manualText.text floatValue] <= 0) {
            NSLog(@"体温不能为空或负数");
              ShowErrorStatus([NSString stringWithFormat:@"体温不能为空或负数"] );
            return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"体温不在范围30-45内");
              ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text] );
           return NO;
        }
    }
    if (self.style == XKMutilPCBloodSugarStyle||self.style == XKDetectBloodSugarStyle) {
        judgeStr1 = @"1-30";
        if ([self.manualText.text floatValue] <= 0) {
            NSLog(@"血糖不能为空或负数");
             ShowErrorStatus([NSString stringWithFormat:@"血糖不能为空或负数"] );
            return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"血糖不在范围1-30内");
             ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text]);
            return NO;
        }
    }
    if (self.style == XKDetectWeightStyle) {
        
         judgeStr1 = @"0-200";
        
        self.nameLab.text = @"体重";
        if ([self.manualText.text floatValue] <= 0) {
            NSLog(@"体重不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"体重不能为空或负数"]);
            return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"体重不在范围0-200内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text] );
            return NO;
        }

        
    }
    if (self.style == XKDetectDyslipidemiaStyle) {//血脂
        
        judgeStr1 = @"1-10";
        judgeStr2 = @"1-10";
        judgeStr3 = @"1-10";
        judgeStr4 = @"1-10";
        if ([self.manualText.text floatValue] <= 0) {
            
            
            NSLog(@"总胆固醇不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"总胆固醇不能为空或负数"]);
            
           return NO;
        }else if([self.manualTwoText.text floatValue] <= 0) {
            NSLog(@"甘油三酯不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"甘油三酯不能为空或负数"]);
            return NO;
        }else if([self.manualThreeText.text floatValue] <= 0) {
            NSLog(@"高密度脂蛋白胆固醇不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"高密度脂蛋白胆固醇不能为空或负数"] );
            return NO;
        }
        else if([self.manualFourText.text floatValue] <= 0) {
            NSLog(@"低密度脂蛋白胆固醇不能为空或负数");
            ShowErrorStatus([NSString stringWithFormat:@"低密度脂蛋白胆固醇不能为空或负数"] );
            return NO;
        }
        if (![self is_betw_judgeStr:judgeStr1 text_value:self.manualText.text]) {
            NSLog(@"收缩压不在范围30-150内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameLab.text] );
            return NO;
        }else if(![self is_betw_judgeStr:judgeStr2 text_value:self.manualTwoText.text]) {
            
            NSLog(@"舒张压不在范围20-200内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameTwoLab.text]);
            return NO;
        }else if(![self is_betw_judgeStr:judgeStr3 text_value:self.manualThreeText.text]) {
            
            NSLog(@"舒张压不在范围20-200内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameThreeLab.text] );
            return NO;
        }else if(![self is_betw_judgeStr:judgeStr4 text_value:self.manualFourText.text]) {
            
            NSLog(@"心率不能不在范围60-300内");
            ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",self.nameFourLab.text] );
            return NO;
        }

        
        
    }
    NSLog(@"验证通过");
    return YES;
    
}

//判断范围
-(BOOL)is_betw_judgeStr:(NSString *)judgeStr text_value:(NSString *)text_value
{
    NSArray *numArr1 =  [judgeStr componentsSeparatedByString:@"-"];
    float mix = [[numArr1 firstObject] floatValue];
    float max = [[numArr1 lastObject] floatValue];
    float value = [text_value floatValue];
    return (value<=max && value>=mix);
}


-(float)scanInteger:(NSString *)urlString{
    
    NSScanner *scanner = [NSScanner scannerWithString:urlString];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    float number;
    [scanner scanFloat:&number];
    return number;
    
    
}
/*是否在树枝之内*/
-(BOOL)judgeIsSuccess:(float)num1 num2:(float)num2 text:(NSString *)text labPerferenceValue:(NSString *)labPerferenceValue{
    if (text.floatValue >=num1&& text.floatValue <= num2) {
        return YES;
        
    }
    else
        
    {
        ShowErrorStatus([NSString stringWithFormat:@"输入的%@超出范围，请重新输入",labPerferenceValue]);
        return NO;
    }
    
}

#pragma mark   UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
    if (range.length == 1 && string.length == 0) {
        


        return YES;
    }
    //so easy
    else if (textField.text.length >= 4) {
        textField.text = [textField.text substringToIndex:4];
        return NO;
    }

    return YES;
}
- (IBAction)pcSelecAction:(id)sender {
    
    for (UIView *view in self.sugarBottomView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor colorWithHexString:@"3cc9db"] forState:UIControlStateNormal];
        }
    }
    UIButton *button = (UIButton *)sender;
    button.backgroundColor = [UIColor colorWithHexString:@"3cc9db"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     self.manualText.placeholder = @"3.9-6.11";
    if (button.tag == 2000) {
        self.manualText.placeholder = @"3.9-6.11";
      
    }
    else  if (button.tag == 2001)
    {
        self.manualText.placeholder = @"3.9-7.8";
       
    }
    else  if (button.tag == 2002)
    {
        
      
        self.manualText.placeholder = @"3.9-11.0";
       
    }
    BloodSugarType = (int)button.tag -2000+1;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self endEditing:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
