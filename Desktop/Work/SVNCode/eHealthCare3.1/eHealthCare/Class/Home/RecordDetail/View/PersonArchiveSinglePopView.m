//
//  PersonArchiveSinglePopView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PersonArchiveSinglePopView.h"
#import "DictionaryMsg.h"
@interface PersonArchiveSinglePopView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSString *_selectedArea;//选中数据
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *borderBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickview;
@property (nonatomic, strong) NSMutableArray *get_high_array;
@end
@implementation PersonArchiveSinglePopView
-(NSMutableArray *)get_high_array
{
    if (!_get_high_array) {
        _get_high_array = [[NSMutableArray alloc]init];
    }
    return _get_high_array;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (IBAction)completeBtnAction:(id)sender {
    
    [self removeFromSuperview];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(PersonArchiveSinglePopViewSelectItemClick:ArchiveType:)]) {
        [self.delegate PersonArchiveSinglePopViewSelectItemClick:_selectedArea ArchiveType:self.popBottomType];
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.centerView.layer.cornerRadius=3;
    self.centerView.layer.masksToBounds=YES;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=3;
    
    self.sureBtn.layer.masksToBounds=YES;
    self.borderBtn.layer.borderWidth = 0.5;
    self.borderBtn.layer.borderColor = kMainColor.CGColor;
    self.sureBtn.layer.cornerRadius=self.sureBtn.frame.size.height/2.0;
    
    self.bottomView.hidden = NO;
    self.centerView.hidden = YES;
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [formatter_minDate dateFromString:@"1900-01-01"];
    [self.datepicker setMinimumDate:minDate];//设置有效最小日期，但是其他还是会显示
    
    
    NSDate *defaultDate = [formatter_minDate dateFromString:@"1990-01-01"];
    
    [self.datepicker setDate:defaultDate animated:YES];//设置当前显示的时间
    _pickview.dataSource  = self;
    _pickview.delegate = self;
    
    
    
    
}
-(void)setPopBottomType:(ArchiveSingleType)popBottomType
{
    _popBottomType = popBottomType;
    NSLog(@"-popBottomType----%d",popBottomType);
    [self.get_high_array removeAllObjects];
    if (_popBottomType == 2) {
        self.datepicker.hidden = NO;
        [self.datepicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        self.titleLab.text = @"出生年月";
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *defaultDate = [dateFormatter dateFromString:@"1900-01-01"];
        Dateformat *dateF =  [[Dateformat alloc]init];
        _selectedArea = [dateF timeConvertSp:[dateFormatter stringFromDate:defaultDate]];
        
        
        
    }else    if (_popBottomType == 1) {
        self.datepicker.hidden = YES;
        _selectedArea = @"男";
        self.titleLab.text = @"性别";
        [self.get_high_array addObject:@"男"];
        [self.get_high_array addObject:@"女"];
    }else    if (_popBottomType == 3) {
        self.datepicker.hidden = YES;
        self.titleLab.text = @"身高";
       
        
        NSMutableArray *data = [[NSMutableArray alloc]init];
        for (int i=10;i<=300;i++){
            [data addObject:[NSString stringWithFormat:@"%i",i]];
        }
         _selectedArea = @"160";
        [self.get_high_array addObjectsFromArray:data];
        [self.pickview selectRow:150 inComponent:0 animated:YES];
        [self pickerView:self.pickview didSelectRow:150 inComponent:0];
    }else    if (_popBottomType == 4) {
        self.datepicker.hidden = YES;
        self.titleLab.text = @"体重";
        
        NSMutableArray *data = [[NSMutableArray alloc]init];
       
       
        for (int i=3;i<=150;i++){
            [data addObject:[NSString stringWithFormat:@"%i",i]];
        }
         _selectedArea = @"50";
        [self.get_high_array addObjectsFromArray:data];
        [self.pickview selectRow:47 inComponent:0 animated:YES];
        [self pickerView:self.pickview didSelectRow:47 inComponent:0];
    }
    else    if (_popBottomType == 6) {
        self.datepicker.hidden = YES;
        self.titleLab.text = @"您饮酒吗";
        NSMutableArray *data = [[NSMutableArray alloc]init];
        
        for (DictionaryMsg *msg in self.tempSmokeOrDrinkArr) {
            [data addObject:msg.DictionaryName];
            
        }
        DictionaryMsg *msg = self.tempSmokeOrDrinkArr[0];
        _selectedArea = msg.DictionaryName;
        [self.get_high_array addObjectsFromArray:data];
        
    }
    else    if (_popBottomType == 5) {
        self.datepicker.hidden = YES;
        self.titleLab.text = @"您平均每天吸烟的数量";
        NSMutableArray *data = [[NSMutableArray alloc]init];
        for (DictionaryMsg *msg in self.tempSmokeOrDrinkArr) {
            [data addObject:msg.DictionaryName];
            //            [data addObject:@"不吸烟"];
            //            [data addObject:@"吸烟"];
            
        }
        DictionaryMsg *msg = self.tempSmokeOrDrinkArr[0];
        _selectedArea = msg.DictionaryName;
        [self.get_high_array addObjectsFromArray:data];
        
    }
    else    if (_popBottomType == 7) {
        self.datepicker.hidden = YES;
        self.titleLab.text = @"您的血型";
        NSMutableArray *data = [[NSMutableArray alloc]init];
        for (DictionaryMsg *msg in self.tempSmokeOrDrinkArr) {
            [data addObject:msg.DictionaryName];
            
        }
        DictionaryMsg *msg = self.tempSmokeOrDrinkArr[0];
        _selectedArea = msg.DictionaryName;
        [self.get_high_array addObjectsFromArray:data];
        
    }
    if (_popBottomType !=2) {
         [self.pickview reloadAllComponents];
        for (int i = 0;i< self.get_high_array.count;i++) {
            
            NSString *tempStr =  (NSString *)self.get_high_array[i];
            if (self.defaultselectedStr.length>0) {
                if ([tempStr isEqualToString:self.defaultselectedStr]) {
                    [self.pickview selectRow:i inComponent:0 animated:YES];
                    [self pickerView:self.pickview didSelectRow:i inComponent:0];
                }
            }
           
        }
    }
    else
    {
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *defaultDate = [dateFormatter dateFromString:self.defaultselectedStr];
        [self.datepicker setDate:defaultDate animated:YES];//设置当前显示的时间
        
    }
    
    NSLog(@"-pickview----%@",self.get_high_array);
    [self.pickview reloadAllComponents];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_popBottomType == 3||_popBottomType == 4) {
        return 2;
    }else
        return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_popBottomType == 3||_popBottomType == 4) {
        if (component == 0) {
            return  self.get_high_array.count;
        }else
            return 1;
    }else
        return self.get_high_array.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (_popBottomType == 3||_popBottomType == 4) {
        if (component == 0) {
            NSLog(@"-get_high_array----%@",[NSString stringWithFormat:@"%@", self.get_high_array[row]]);
            return [NSString stringWithFormat:@"%@", self.get_high_array[row]];
        }else
        {
            if (_popBottomType == 3) {
                return @"cm";
            }else
                return @"kg";
        }
    }else
        return [NSString stringWithFormat:@"%@", self.get_high_array[row]];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_popBottomType == 3||_popBottomType == 4) {
        if (component == 0) {
            _selectedArea = self.get_high_array[row];
        }
    }else
        _selectedArea = self.get_high_array[row];
    
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UIView *cellView = view;
    UILabel *label = nil;
    if (!cellView) {
        cellView = [[UIView alloc] init];
        label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
    }
    cellView.backgroundColor = [UIColor clearColor];
   
  
   
    if (_popBottomType == 3||_popBottomType == 4) {
         NSLog(@"-get_high_array--111--%@",[NSString stringWithFormat:@"%@", self.get_high_array[row]]);
        if (component == 0) {
              [label setText:[NSString stringWithFormat:@"%@", self.get_high_array[row]]];
              [label setTextAlignment:UITextAlignmentRight];
        }else
        {
            if (_popBottomType == 3) {
                 [label setText:[NSString stringWithFormat:@"cm"]];
            }else
                 [label setText:[NSString stringWithFormat:@"kg"]];
            
              [label setTextAlignment:UITextAlignmentLeft];
        }
        
//        [label setText:[NSString stringWithFormat:@"%@cm", self.get_high_array[row]]];
       
    }else
    {
         [label setText:[NSString stringWithFormat:@"%@", self.get_high_array[row]]];
         [label setTextAlignment:UITextAlignmentCenter];
    }
    
   
    label.backgroundColor = [UIColor clearColor];
    [cellView addSubview:label];
    return cellView;
//    return label;
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDate *date = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"----%@",[dateFormatter stringFromDate:date]);
    Dateformat *dateF =  [[Dateformat alloc]init];
    _selectedArea = [dateF timeConvertSp:[dateFormatter stringFromDate:date]];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
}
@end
