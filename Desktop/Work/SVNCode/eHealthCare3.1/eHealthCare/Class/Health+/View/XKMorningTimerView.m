//
//  XKMorningTimerView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMorningTimerView.h"

@interface XKMorningTimerView()
{

    NSArray *teamsArr;
    
    NSInteger selectTime;//选中的时间
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *beginBtn;

@end

@implementation XKMorningTimerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 初始化数据
 */
-(void)awakeFromNib
{

    [super awakeFromNib];
    
    teamsArr = [NSArray arrayWithObjects:@"5分钟",@"10分钟",@"20分钟",@"30分钟",@"40分钟",@"45分钟",@"1小时",@"2小时", nil];
    
    
    self.cancelBtn.layer.cornerRadius = 20;
    self.cancelBtn.layer.borderWidth = .5f;
    self.cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.beginBtn.layer.cornerRadius = 20;
    self.beginBtn.layer.borderWidth = .5f;
    self.beginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    selectTime = 3;
    [self.pickerView selectRow:3  inComponent:0  animated:YES];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return teamsArr.count;
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    
    return [teamsArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  
    selectTime = row;
    NSLog(@"didSelectRow%d",selectTime);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height <= 1)
        {
            singleLine.backgroundColor = [UIColor whiteColor];
        }
    }
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [pickerLabel setTextColor:[UIColor whiteColor]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (IBAction)cancelAction:(id)sender {
    
    if (_delegate && [self.delegate respondsToSelector:@selector(cancelSelectTime)]) {
        [self.delegate cancelSelectTime];
    }
    
}

/**
 开始按钮

 @param sender <#sender description#>
 */
- (IBAction)beginAction:(id)sender {
//    teamsArr = [NSArray arrayWithObjects:@"5分钟",@"10分钟",@"20分钟",@"30分钟",@"40分钟",@"45分钟",@"1小时",@"2小时", nil];
    int selectTimeWithTime = 30*60;
    switch (selectTime) {
        case 0:
            selectTimeWithTime =  5*60;
            break;
        case 1:
            selectTimeWithTime =  10*60;
            break;
        case 2:
            selectTimeWithTime =  20*60;
            break;
        case 3:
            selectTimeWithTime =  30*60;
            break;
        case 4:
            selectTimeWithTime =  40*60;
            break;
        case 5:
            selectTimeWithTime =  45*60;
            break;
        case 6:
            selectTimeWithTime =  60*60;
            break;
        case 7:
            selectTimeWithTime =  120*60;
            break;
        default:
            break;
    }
    if (_delegate && [self.delegate respondsToSelector:@selector(checkSelectTime:)]) {
        [self.delegate checkSelectTime:selectTimeWithTime];
    }
    
}


@end
