//
//  HematocrystallinView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HematocrystallinView.h"
#import "BirthDayPickerView.h"
#import "CommonPickerView.h"

@interface HematocrystallinView() <BirthDayPickerViewDelegate,CommonPickerViewDelegate>
{

    NSArray *btnArr;
    
    BOOL openBirthday;//是否打开生日弹窗
    BOOL openHeight;//是否打开身高弹窗
}

/**
 身高弹窗
 */
@property(strong,nonatomic)CommonPickerView *heightPicker;


@property (weak, nonatomic) IBOutlet UIView *centerView;


@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIButton *yearBtn;

@property (weak, nonatomic) IBOutlet UIButton *heightBtn;


@property (weak, nonatomic) IBOutlet UILabel *malelab;


@property (weak, nonatomic) IBOutlet UILabel *femaleLab;

@property (weak, nonatomic) IBOutlet UILabel *heightLab;

@property (weak, nonatomic) IBOutlet UIButton *maleBtn;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;


@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (nonatomic, strong) BirthDayPickerView *datePicker;
@end
@implementation HematocrystallinView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BirthDayPickerView *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 200, KScreenWidth, 200)];
        _datePicker.delegate = self;
//        _datePicker.alpha = 0;
    }
    return _datePicker;
}




/**
 初始化数据
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.sureBtn.layer.cornerRadius = self.sureBtn.frame.size.height/2.0;
    
    
    self.sureBtn.clipsToBounds = YES;
    
    
    self.yearBtn.layer.cornerRadius = 10.0;
    
    
    self.yearBtn.clipsToBounds = YES;
    
    self.heightBtn.layer.cornerRadius = 10;
    
    
    self.heightBtn.clipsToBounds = YES;
    
    self.yearBtn.layer.borderWidth = 0.5;
    self.yearBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.heightBtn.layer.borderWidth = 0.5;
    self.heightBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    self.centerView.layer.cornerRadius = 8;
    
    
    self.centerView.clipsToBounds = YES;
    
    
    btnArr = @[_maleBtn,_femaleBtn];
    
    _maleBtn.selected = YES;
    self.malelab.textColor = kMainColor;
    self.femaleLab.textColor = [UIColor lightGrayColor];
    
    
    NSString *str = @"100-200";
    NSArray *unit = @[@"cm"];
    _heightPicker = [[CommonPickerView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 200, KScreenWidth, 200) scope:str unit:unit];
    _heightPicker.delegate = self;
    
    [self addSubview:_heightPicker];
    [_heightPicker closePicker];
    
    [self addSubview:self.datePicker];
    [self.datePicker closePicker];
    
}


- (IBAction)maleAndFemalAction:(id)sender {
    
    
    UIButton *button = (UIButton *)sender;
    
    for (UIButton *btn in btnArr) {
        btn.selected = NO;
    }
    button.selected = YES;
    
    if (self.maleBtn.selected) {
        self.malelab.textColor = kMainColor;
        self.femaleLab.textColor = [UIColor lightGrayColor];
    }
    if (self.femaleBtn.selected) {
        self.femaleLab.textColor = kMainColor;
        self.malelab.textColor = [UIColor lightGrayColor];
    }
    
}

- (IBAction)birthDayAction:(id)sender {
    
//    if (openBirthday) {
//        
//        self.yearBtn.layer.borderColor = kMainColor.CGColor;
//        [self addSubview:self.datePicker];
//        
//    }
//    else
//    {
//        
//        self.yearBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [self.datePicker removeFromSuperview];
//    
//    }
//    openBirthday = !openBirthday;
    

    [self.datePicker openPicker];
    [_heightPicker closePicker];
    
}
#pragma mark   PickerViewDelegate
-(void)CommonPickerViewChange:(NSString *)dateStr andBtnTitle:(NSString *)title;
{
//    [self.heightBtn setTitle:dateStr forState:UIControlStateNormal];
    self.heightLab.text = dateStr;

}
-(void)birthDayPickerChange:(NSString *)dateStr andBtnTitle:(NSString *)title;
{
    self.dateLab.text = dateStr;
//    [self.yearBtn setTitle:dateStr forState:UIControlStateNormal];

}
- (IBAction)heightPopView:(id)sender {
    
    
//    if (openHeight) {
//        
//        self.heightBtn.layer.borderColor = kMainColor.CGColor;
//        [self addSubview:self.heightPicker];
//    }
//    else
//    {
//        
//         self.heightBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [self.heightPicker removeFromSuperview];
//        
//    }
//    openHeight = !openHeight;
    
    NSLog(@"111");
    [_heightPicker openPicker];
    [self.datePicker closePicker];
    
   
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    
    NSLog(@"开始编辑");

   
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_heightPicker closePicker];
    [self.datePicker closePicker];
}

/**
 取消按钮

 @param sender <#sender description#>
 */
- (IBAction)cancelAction:(id)sender {
    
     [self removeFromSuperview];
    
}
/**
 确定按钮
 
 @param touches <#touches description#>
 @param event <#event description#>
 */
- (IBAction)sureAction:(id)sender {
    if ([self.heightLab.text isEqualToString:@""] ) {
        
        ShowErrorStatus(@"请输入身高");
//        ShowErrorStatus@"请输入身高" length:1.f];
        return;
    }
    else if ([self.dateLab.text isEqualToString:@""])
    {
    
       
            ShowErrorStatus(@"请输入出生年月");
//            ShowErrorStatus@"请输入出生年月" length:1.f];
            return;
       
    }
    
    self.heightBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    [self removeFromSuperview];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectSexIndex:birthdayText:heightText:)]) {
        [self.delegate selectSexIndex:self.maleBtn.selected?@"1":@"0" birthdayText:self.dateLab.text heightText:self.heightLab.text];
        
        [self emptyAlldata];
    }

    
}

/**
 清空数据
 */
-(void)emptyAlldata{
    self.dateLab.text = @"";
    self.heightLab.text = @"";
    
    self.maleBtn.selected = YES;
//        self.malelab.textColor = kMainColor;
//        self.femaleLab.textColor = [UIColor lightGrayColor];
    
    self.femaleBtn.selected = NO;
//        self.femaleLab.textColor = kMainColor;
//        self.malelab.textColor = [UIColor lightGrayColor];
   
    
    
}
@end
