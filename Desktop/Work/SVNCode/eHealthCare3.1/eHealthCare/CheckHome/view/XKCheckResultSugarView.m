//
//  XKCheckResultSugarView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKCheckResultSugarView.h"

@interface XKCheckResultSugarView ()

/**
  空腹血糖 (FBG)按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *fastBloodGlucoseBtn;

/**
 餐后2小时
 */
@property (weak, nonatomic) IBOutlet UIButton *afterMealBtn;

/**
 随机血糖
 */
@property (weak, nonatomic) IBOutlet UIButton *randomBloodSugarBtn;

/**
 空腹血糖 (FBG)
 */
@property (weak, nonatomic) IBOutlet UILabel *fastingBloodGlucose;


/**
 餐后2 h血糖 (PBG)
 */
@property (weak, nonatomic) IBOutlet UILabel *afterMeal;


/**
 随机血糖
 */
@property (weak, nonatomic) IBOutlet UILabel *randomBloodSugarLab;





@end



@implementation XKCheckResultSugarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
//    self.backView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
//    [self.allBackV1 setTarget:self action:@selector(selectBtn:)];
//    [self.examBackV2 setTarget:self action:@selector(selectBtn:)];
//    [self.phyBackV3 setTarget:self action:@selector(selectBtn:)];
    

    for (int  i= 0 ;i < 3; i++) {
        UIView *selectV = (UIView *)[self viewWithTag:70+i];
        
        if (i != 0) {
            if ([selectV isKindOfClass:[UIButton class]]) {
                UIButton *btn =  (UIButton *)selectV;
                btn.selected = NO;
                
            }else if([selectV isKindOfClass:[UILabel class]])
            {
                UILabel *lab =  (UILabel *)selectV;
                lab.textColor = [UIColor lightGrayColor];
                
            }
            
        }
    }
}

- (IBAction)selectAction:(id)sender {
    

    

    
    UIButton *btn = (UIButton *)sender;
    for (int  i= 0 ;i < 3; i++) {
        UIView *selectV = (UIView *)[self viewWithTag:70+i];
        UIButton *btn =  (UIButton *)selectV;
        btn.selected = NO;
        
    }
    for (int  i= 0 ;i < 3; i++) {
        UILabel *selectL = (UILabel *)[self viewWithTag:80+i];
        selectL.textColor = [UIColor lightGrayColor];
    }
    
    UILabel *selectL = [self viewWithTag:(btn.tag + 10)];
    selectL.textColor = [UIColor blueColor];
    
    if ([self.delegate respondsToSelector:@selector(selectIndex:andName:andIsCloseView:)]) {
        [self.delegate selectIndex:btn.tag- 70+1 andName:nil andIsCloseView:YES];
    }
    
}



-(void)openAllView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    }];
}

-(void)closeAllView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    }];
}

@end