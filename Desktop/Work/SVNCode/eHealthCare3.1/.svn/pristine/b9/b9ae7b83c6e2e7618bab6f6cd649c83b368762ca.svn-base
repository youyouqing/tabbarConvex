

//
//  GuideView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "GuideView.h"
#import "LoginViewModel.h"
#import "GuideQuestion.h"
@interface GuideView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIScrollView *guideScrollView;//引导页scrollview
@property (nonatomic, strong) NSMutableArray *questionArr;//前引导页问题
@property (nonatomic, strong) NSMutableArray *singleQuestionArr;//前引导页问题
@property (nonatomic, strong) NSMutableArray *get_weigh_array;
@property (nonatomic, strong) NSMutableArray *get_high_array;
@property (nonatomic, strong)UILabel *contentBirthdayLab;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *QuestionAnswerList;//装在数组的问题的所有选项
@property (nonatomic, strong)UIButton *skipbutton;
@end

@implementation GuideView
{
    NSMutableDictionary *save_dic;
    NSNumber *_selectedArea;
    NSNumber *_selected_weigh;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSLog(@"--main_data---%@",[user objectForKey:@"main_data"]);
        save_dic = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor clearColor];
        _QuestionAnswerList = [NSMutableArray arrayWithCapacity:0];
        [self loadGuideData];
    }
    return self;
}

// 添加子控件
- (void)setupSubviews
{
   
    
    _guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _guideScrollView.backgroundColor =[UIColor clearColor];
    _guideScrollView.bounces = NO;
    _guideScrollView.showsHorizontalScrollIndicator = NO;
    _guideScrollView.showsVerticalScrollIndicator = NO;
    _guideScrollView.delegate = self;
    _guideScrollView.pagingEnabled = YES;
    _guideScrollView.scrollEnabled = NO;
    [self addSubview:_guideScrollView];
    _guideScrollView.contentSize = CGSizeMake(KScreenWidth * self.questionArr.count, KScreenHeight);
    
    
    
    self.skipbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipbutton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.skipbutton.titleLabel.font = Kfont(15);
    [self.skipbutton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipbutton setTitleColor:[UIColor getColor:@"B3BBC4"] forState:UIControlStateNormal];
    [self.skipbutton addTarget:self action:@selector(hiddenGuidePage:) forControlEvents:UIControlEventTouchUpInside];
    self.skipbutton.layer.cornerRadius = KHeight(45)/2.0;
    self.skipbutton.frame = CGRectMake(_guideScrollView.frame.size.width - KWidth(106),  KHeight(15), KWidth(106), KHeight(45));
    [self addSubview:self.skipbutton];
    
    for (int i = 1; i < self.questionArr.count + 1; i++) {
        
       
        if (i == self.questionArr.count )
        {
            
            UILabel *nameLab = [[UILabel alloc]init];
            nameLab.text = @"感谢您，已对您有初步了解";
            nameLab.textColor = kMainTitleColor;
            nameLab.font = [UIFont boldSystemFontOfSize:20];
            nameLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1),  KHeight(101), KScreenWidth, KHeight(20));
            nameLab.textAlignment = NSTextAlignmentCenter;
            [_guideScrollView addSubview:nameLab];
            
            
            UILabel *contentLab = [[UILabel alloc]init];
            contentLab.text = @"我们为您定制以下健康计划，请选择最想加入的计划";
            contentLab.textColor = kMainTitleColor;
            contentLab.font = Kfont(14);
            contentLab.textAlignment = NSTextAlignmentCenter;
            contentLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1), CGRectGetMaxY(nameLab.frame)+CGRectGetHeight(nameLab.frame)+KHeight(15),KScreenWidth, KHeight(20));
            [_guideScrollView addSubview:contentLab];
            

            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:kMainColor];
            button.titleLabel.font = [UIFont systemFontOfSize:18.0];
             button.tag = 9801;
            [button setTitle:@"开始我的健康之旅" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(hiddenGuidePage:) forControlEvents:UIControlEventTouchUpInside];
            
            button.layer.cornerRadius = KHeight(45)/2.0;
            
            button.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+(KScreenWidth / 2 - KWidth(130)), KScreenHeight - KHeight(103), KWidth(260), KHeight(45));
            [_guideScrollView addSubview:button];
            
            
            
            
        }
        if (i == 1) {
            
            UIImageView *guidePageView = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-KWidth(303))/2.0,KHeight(71) , KWidth(303), KHeight(81))];
            guidePageView.image = [UIImage imageNamed:@"iv_question_robot"];
            [_guideScrollView addSubview:guidePageView];
            
            
            UILabel *contentLab = [[UILabel alloc]init];
            contentLab.text = @"您的性别是？";
            contentLab.textColor = kMainTitleColor;
            contentLab.font =  [UIFont boldSystemFontOfSize:20 * KScreenWidth / 375];
            contentLab.textAlignment = NSTextAlignmentCenter;
            contentLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1),CGRectGetHeight(guidePageView.frame)+CGRectGetMaxY(guidePageView.frame)+KHeight(83), KScreenWidth, KHeight(20));
            [_guideScrollView addSubview:contentLab];
            
            
            
            UIButton *yesbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            yesbutton.tag = 10000;
            yesbutton.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [yesbutton setTitle:@"是" forState:UIControlStateNormal];
            [yesbutton addTarget:self action:@selector(yesbuttonSelect:) forControlEvents:UIControlEventTouchUpInside];
            [yesbutton setImage:[UIImage imageNamed:@"iv_question_man"] forState:UIControlStateNormal];
            yesbutton.layer.cornerRadius = KHeight(45)/2.0;
            yesbutton.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+ KWidth(49), CGRectGetHeight(contentLab.frame)+CGRectGetMaxY(contentLab.frame)+KHeight(41), KWidth(115), KHeight(115));
            [_guideScrollView addSubview:yesbutton];
            
            
            UIButton *NObutton = [UIButton buttonWithType:UIButtonTypeCustom];
            NObutton.tag = 10001;
            [NObutton setImage:[UIImage imageNamed:@"iv_question_female"] forState:UIControlStateNormal];
            
            NObutton.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [NObutton setTitle:@"否" forState:UIControlStateNormal];
            [NObutton addTarget:self action:@selector(yesbuttonSelect:) forControlEvents:UIControlEventTouchUpInside];
            NObutton.layer.cornerRadius = KHeight(45)/2.0;
            
            NObutton.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+KScreenWidth  - KWidth(115)-KWidth(49), CGRectGetHeight(contentLab.frame)+CGRectGetMaxY(contentLab.frame)+KHeight(41), KWidth(115), KHeight(115));
            [_guideScrollView addSubview:NObutton];
            
            
            UILabel *manLab = [[UILabel alloc]init];
            manLab.text = @"男";
            manLab.textColor = kMainTitleColor;
            manLab.font = Kfont(15);
            manLab.textAlignment = NSTextAlignmentCenter;
            manLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+ KWidth(49),CGRectGetHeight(yesbutton.frame)+CGRectGetHeight(contentLab.frame)+CGRectGetMaxY(contentLab.frame)+KHeight(41)+KHeight(10), KWidth(106), KHeight(20));
            [_guideScrollView addSubview:manLab];
            
            
            UILabel *womanLab = [[UILabel alloc]init];
            womanLab.text = @"女";
            womanLab.textColor = kMainTitleColor;
            womanLab.font = Kfont(15);
            womanLab.textAlignment = NSTextAlignmentCenter;
            womanLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+KScreenWidth  - KWidth(106)-KWidth(49),CGRectGetHeight(yesbutton.frame)+CGRectGetHeight(contentLab.frame)+CGRectGetMaxY(contentLab.frame)+KHeight(41)+KHeight(10), KWidth(106), KHeight(20));
            [_guideScrollView addSubview:womanLab];
        }
        
        if (i == 2||i == 3)
        {
            UILabel *nameLab = [[UILabel alloc]init];
            nameLab.text = @"您的出生日期是？";
            nameLab.textColor = kMainTitleColor;
            nameLab.font = [UIFont boldSystemFontOfSize:20 * KScreenWidth / 375];;
            nameLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1),  KHeight(101), KScreenWidth, KHeight(20));
            nameLab.textAlignment = NSTextAlignmentCenter;
            [_guideScrollView addSubview:nameLab];
            if (i == 2) {
                 nameLab.text = @"您的出生日期是？";
                self.contentBirthdayLab = [[UILabel alloc]init];
                self.contentBirthdayLab.text = @"1990年1月1日";
                self.contentBirthdayLab.textColor = kMainColor;
                self.contentBirthdayLab.font = Kfont(17);
                self.contentBirthdayLab.textAlignment = NSTextAlignmentCenter;
                self.contentBirthdayLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1), CGRectGetMaxY(nameLab.frame)+CGRectGetHeight(nameLab.frame)+KHeight(41),KScreenWidth, KHeight(20));
                [_guideScrollView addSubview:self.contentBirthdayLab];
                UIDatePicker *datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(_guideScrollView.frame.size.width * (i - 1), (KScreenHeight-316)/2.0+KHeight(40), KScreenWidth, 316)];
                datepicker.tag = 1111+i;
                [datepicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
                [datepicker setTimeZone:[NSTimeZone timeZoneWithName:@"zh_CN"]];
//                [datepicker setValue:[UIColor colorWithRed:60/255.0 green:201/255.0 blue:219/255.0 alpha:1.0] forKey:@"textColor"];
                
                //定义最大日期为当前日期
                [datepicker setMaximumDate:[NSDate date]];
                //定义最小日期
                NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
                [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
                NSDate *minDate = [formatter_minDate dateFromString:@"1900-01-01"];
                [datepicker setMinimumDate:minDate];//设置有效最小日期，但是其他还是会显示
                
                
                NSDate *defaultDate = [formatter_minDate dateFromString:@"1990-01-01"];
                
                [datepicker setDate:defaultDate animated:YES];//设置当前显示的时间
                datepicker.datePickerMode = UIDatePickerModeDate;//类型
                [datepicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
                [_guideScrollView addSubview:datepicker];
                
                 [save_dic setValue:@"1990年01月01日" forKey:@"birthday"];
            }else if (i == 3){
                 nameLab.text = @"您的身高体重是？";
                UIPickerView *pickview = [[UIPickerView  alloc]initWithFrame:CGRectMake(_guideScrollView.frame.size.width * (i - 1), (KScreenHeight-316)/2.0+KHeight(40), KScreenWidth, 316)];
                pickview.delegate = self;
                pickview.dataSource = self;
                
                [_guideScrollView addSubview:pickview];
               UILabel *heightLab = [[UILabel alloc]init];
                heightLab.text = @"身高(cm)";
                heightLab.textColor = kMainColor;
                heightLab.font = Kfont(17);
                heightLab.textAlignment = NSTextAlignmentCenter;
                heightLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1), CGRectGetMaxY(nameLab.frame)+CGRectGetHeight(nameLab.frame)+KHeight(41),KScreenWidth/2.0, KHeight(20));
                [_guideScrollView addSubview:heightLab];
                
                
                UILabel *weightLab = [[UILabel alloc]init];
                weightLab.text = @"体重(kg)";
                weightLab.textColor = kMainColor;
                weightLab.font = Kfont(17);
                weightLab.textAlignment = NSTextAlignmentCenter;
                weightLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+KScreenWidth/2.0, CGRectGetMaxY(nameLab.frame)+CGRectGetHeight(nameLab.frame)+KHeight(41),KScreenWidth/2.0, KHeight(20));
                [_guideScrollView addSubview:weightLab];
                
                [pickview selectRow:50 inComponent:0 animated:NO];
                
                [pickview selectRow:50 inComponent:1 animated:NO];
//                [save_dic setValue:[NSString stringWithFormat:@"%@ %@",@"150",@"53"] forKey:@"weight"];
                
                [save_dic setValue:[NSString stringWithFormat:@"%@",@"150"] forKey:@"height"];
                [save_dic setValue:[NSString stringWithFormat:@"%@",@"53"] forKey:@"weight"];
            }
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:kMainColor];
            button.titleLabel.font = [UIFont systemFontOfSize:18.0];
            [button setTitle:@"继续" forState:UIControlStateNormal];
            button.tag = 10000+i;
            [button addTarget:self action:@selector(yesOrNO:) forControlEvents:UIControlEventTouchUpInside];
            _guideScrollView.userInteractionEnabled=YES;
            button.layer.cornerRadius = KHeight(45)/2.0;
            
            button.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+(KScreenWidth / 2 - KWidth(53)), KScreenHeight - KHeight(103), KWidth(106), KHeight(45));
            [_guideScrollView addSubview:button];
            
        }
        if (i>3&&i<self.questionArr.count)
        {
            
            UIImageView *guidePageView = [[UIImageView alloc]initWithFrame:CGRectMake(_guideScrollView.frame.size.width * (i - 1),KHeight(71) , KWidth(375), KHeight(375))];
            GuideQuestion *quesMod = self.questionArr[i - 1];
            [guidePageView sd_setImageWithURL:[NSURL URLWithString:quesMod.QuestionImg] placeholderImage:[UIImage imageNamed:@"iv_question_examination"]];
//         @[@"iv_question_robot",@"",@"",@"iv_question_examination",@"iv_question_breakfast",@"iv_question_sports",@"iv_question_drink",@""];
            [_guideScrollView addSubview:guidePageView];
//            NSArray *map_arr = @[@"您每年是否定期体检？",@"您每天是否在早晨9点吃完早餐？",@"您每天是否运动1小时以上",@"您每天是否饮水3000毫升"];
            
            UILabel *contentLab = [[UILabel alloc]init];
            contentLab.text = quesMod.QuestionContent;
            contentLab.textColor = kMainTitleColor;
            contentLab.font = [UIFont boldSystemFontOfSize:20];
            contentLab.textAlignment = NSTextAlignmentCenter;
            contentLab.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1),KHeight(71)+KHeight(375)+KHeight(20), KScreenWidth, KHeight(20));
            [_guideScrollView addSubview:contentLab];
            
            
            
            UIButton *yesbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            yesbutton.tag = 20000+i;
            [yesbutton setBackgroundColor:kMainColor];
            yesbutton.titleLabel.font = [UIFont systemFontOfSize:18.0];
            [yesbutton setTitle:@"是" forState:UIControlStateNormal];
            [yesbutton addTarget:self action:@selector(yesbuttonSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            yesbutton.layer.cornerRadius = KHeight(45)/2.0;
            yesbutton.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+ KWidth(49), KScreenHeight - KHeight(103), KWidth(106), KHeight(45));
            [_guideScrollView addSubview:yesbutton];
            
            
            UIButton *NObutton = [UIButton buttonWithType:UIButtonTypeCustom];
            NObutton.tag = 30000+i;
            
            [NObutton setBackgroundColor:kMainColor];
            NObutton.titleLabel.font = [UIFont systemFontOfSize:18.0];
            [NObutton setTitle:@"否" forState:UIControlStateNormal];
            [NObutton addTarget:self action:@selector(yesbuttonSelect:) forControlEvents:UIControlEventTouchUpInside];
            NObutton.layer.cornerRadius = KHeight(45)/2.0;
            
            NObutton.frame = CGRectMake(_guideScrollView.frame.size.width * (i - 1)+KScreenWidth  - KWidth(106)-KWidth(49), KScreenHeight - KHeight(103), KWidth(106), KHeight(45));
            [_guideScrollView addSubview:NObutton];
            
        }

    }
    
}
//选择你传的计划PlanID
-(void)selectBtn:(UIButton *)sender
{
//    用户选择的健康计划编号，多个用逗号拼接
    NSInteger tag =   sender.tag - 1234;
    sender.selected = !sender.selected;
   
        
        for (int j = 0;j<sender.subviews.count;j++) {
            UIView *check = sender.subviews[j];
            if ([check isKindOfClass:[UIImageView class]]&&check.tag == tag+191919) {
                 UIImageView *checkImage = (UIImageView *)check;
                 if (sender.selected == YES) {
                    
                     checkImage.hidden = NO;
                }else
                     checkImage.hidden = YES;
        }
    }
}
//开启我的健康之路。 进入登录页面
-(void)hiddenGuidePage:(UIButton *)sender
{
    if (sender.tag == 9801) {
         [save_dic setValue:@"1" forKey:@"IsSkip"];//是否跳过 0、跳过 1、未跳过
    }else
         [save_dic setValue:@"0" forKey:@"IsSkip"];

    NSMutableString *medStr=[[NSMutableString alloc]initWithCapacity:0];
    for (int j=0;j<self.btnArray.count;j++) {
        UIButton  *btn = self.btnArray[j];
          NSLog(@"---btn:%@",btn.titleLabel.text);
        for (int k=0;k<self.singleQuestionArr.count;k++) {
            GuideQuestion *quesMod = self.singleQuestionArr[k];
            if ([quesMod.PlanNameNo isEqualToString:btn.titleLabel.text]||[quesMod.PlanNameYes isEqualToString:btn.titleLabel.text]) {
                if (btn.selected) {
                    NSLog(@"---quesMod.GuideQuestionID:%li",quesMod.PlanIDYes);
                    if (medStr.length>0) {
                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDYes]];
                    }else
                        [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDYes]];
                    //             [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDNo]];
                }
               
            }
        }
        
       
    }
    [save_dic setValue:medStr.length>0?medStr:@"" forKey:@"PlanID"];
  
    //    @[@{@"GuideQuestionID":@0,@"QuestionAnswerID":@0}]
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:save_dic forKey:@"main_data"];
    NSLog(@"---save_dic:%@",save_dic);
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:@"lastVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    WEAKSELF
    [UIView animateWithDuration:1.5 animations:^{
       
    }completion:^( BOOL finish){
        if(weakSelf.hideGuideViewBlock)
        {
            weakSelf.hideGuideViewBlock();
        }
        weakSelf.guideScrollView.alpha = 0;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self removeFromSuperview];
    }];
}


#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x <= 0){
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (currentPage == self.questionArr.count )
    {
        [self hiddenGuidePage:nil];
    }
    NSLog(@"%d",currentPage);
}
#pragma mark yesbuttonSelect
-(void)yesbuttonSelect:(UIButton *)btn
{
    self.skipbutton.hidden = NO;
    if (btn.tag == 10000) {
        //男
        [save_dic setValue:@"man" forKey:@"sex"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth, 0)];
        
    }else if(btn.tag == 10001){
        //女
        [save_dic setValue:@"wowen" forKey:@"sex"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth, 0)];
    }else if (btn.tag == 20004){
        //定期体检 yes
        [save_dic setValue:@"yes" forKey:@"check"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*4, 0)];
        
    }else if (btn.tag == 30004){
        //定期体检 no
        [save_dic setValue:@"no" forKey:@"check"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*4, 0)];
        
    }else if (btn.tag == 20005){
        //9点前吃早饭 yes
        [save_dic setValue:@"yes" forKey:@"eat"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*5, 0)];
        
    }else if (btn.tag == 30005){
        //9点前吃早饭 no
        [save_dic setValue:@"no" forKey:@"eat"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*5, 0)];
        
    }else if (btn.tag == 20006){
        //每天运动1小时以上 yes
        [save_dic setValue:@"yes" forKey:@"sport"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*6, 0)];
        
    }else if (btn.tag == 30006){
        //每天运动1小时以上 no
        [save_dic setValue:@"no" forKey:@"sport"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*6, 0)];
        
    }else if (btn.tag == 20007){
        //是否饮水3000毫升 yes
        [save_dic setValue:@"yes" forKey:@"drink"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*7, 0)];
        
    }else if (btn.tag == 30007){
        //是否饮水3000毫升 no
        [save_dic setValue:@"no" forKey:@"drink"];
        
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*7, 0)];

      }
  
    
    if ((btn.tag - 20000)==(self.questionArr.count - 1)||(btn.tag - 30000)==(self.questionArr.count - 1)) {
        
         self.skipbutton.hidden = YES;
        NSUserDefaults *userOne = [NSUserDefaults standardUserDefaults];
        [userOne setObject:save_dic forKey:@"main_data"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSLog(@"--main_data---%@",[user objectForKey:@"main_data"]);
        NSMutableDictionary *tempDic = [user objectForKey:@"main_data"];
//        NSMutableString *medStr=[[NSMutableString alloc]initWithCapacity:0];
        self.btnArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *tempArrQuestionAnswerList = [NSMutableArray arrayWithCapacity:0];
        for (int j = 0; j< self.singleQuestionArr.count; j++) {
              NSMutableDictionary *tempQuestionAnswerDic = [[NSMutableDictionary alloc]init];
            GuideQuestion *quesMod =  self.singleQuestionArr[j];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = j+1234;
            button.titleLabel.font = [UIFont systemFontOfSize:15.0];
//             if (medStr.length==0) {
            if ([tempDic[@"check"] isEqualToString:@"yes"] && quesMod.Sort == 1) {
                [button setTitle:quesMod.PlanNameYes forState:UIControlStateNormal];
                if (quesMod.PlanIDYes>0) {
//                     [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDYes]];
                   
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"1" forKey:@"QuestionAnswerID"];
                //            j+2000+4
            }else  if ([tempDic[@"check"] isEqualToString:@"no"] && quesMod.Sort == 1)
            {
                [button setTitle:quesMod.PlanNameNo forState:UIControlStateNormal];
                if (quesMod.PlanIDNo>0) {
//                    [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDNo]];
                    
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"0" forKey:@"QuestionAnswerID"];
            }
            
            if ([tempDic[@"sport"] isEqualToString:@"yes"]  && quesMod.Sort == 3) {
                [button setTitle:quesMod.PlanNameYes forState:UIControlStateNormal];
               //quesMod.PlanIDYes PlanIDNo
                if (quesMod.PlanIDYes>0) {
//                    if (medStr.length>0) {
//                         [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDYes]];
//                    }else
//                         [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDYes]];
                   
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"1" forKey:@"QuestionAnswerID"];
            }
            else  if ([tempDic[@"sport"] isEqualToString:@"no"] && quesMod.Sort == 3)
            {
                [button setTitle:quesMod.PlanNameNo forState:UIControlStateNormal];
               
                if (quesMod.PlanIDNo>0) {
//                    if (medStr.length>0) {
//                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDNo]];
//                    }else
//                   [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDNo]];//quesMod.PlanIDYes PlanIDNo
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"0" forKey:@"QuestionAnswerID"];
            }
            if ([tempDic[@"eat"] isEqualToString:@"yes"] && quesMod.Sort == 2) {
                [button setTitle:quesMod.PlanNameYes forState:UIControlStateNormal];
               
                
                if (quesMod.PlanIDYes>0) {
                
//                    if (medStr.length>0) {
//                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDYes]];
//                    }else
//                        [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDYes]];
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"1" forKey:@"QuestionAnswerID"];
            }else if ([tempDic[@"eat"] isEqualToString:@"no"] && quesMod.Sort == 2)
            {
                [button setTitle:quesMod.PlanNameNo forState:UIControlStateNormal];
            
                if (quesMod.PlanIDNo>0) {
//                    if (medStr.length>0) {
//                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDNo]];
//                    }else
//                        [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDNo]];//quesMod.PlanIDYes PlanIDNo
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"0" forKey:@"QuestionAnswerID"];
            }
            if ([tempDic[@"drink"] isEqualToString:@"yes"] && quesMod.Sort == 4) {
                [button setTitle:quesMod.PlanNameYes forState:UIControlStateNormal];
            
                if (quesMod.PlanIDYes>0) {
//                    if (medStr.length>0) {
//                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDYes]];
//                    }else
//                        [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDYes]];
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"1" forKey:@"QuestionAnswerID"];
            }else if ([tempDic[@"drink"] isEqualToString:@"no"] && quesMod.Sort == 4)
            {
                [button setTitle:quesMod.PlanNameNo forState:UIControlStateNormal];
//                [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDNo]];//quesMod.PlanIDYes PlanIDNo
                if (quesMod.PlanIDNo>0) {
//                    if (medStr.length>0) {
//                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",quesMod.PlanIDNo]];
//                    }else
//                        [medStr appendString:[NSString stringWithFormat:@"%li",quesMod.PlanIDNo]];//quesMod.PlanIDYes PlanIDNo
                }
                [tempQuestionAnswerDic setValue:@(quesMod.GuideQuestionID) forKey:@"GuideQuestionID"];//PlanIDYes
                [tempQuestionAnswerDic setValue:@"0" forKey:@"QuestionAnswerID"];
            }
              [tempArrQuestionAnswerList addObject:tempQuestionAnswerDic];
            


            NSLog(@"button.titleLabel.text---%@",button.titleLabel.text);
            if (button.titleLabel.text.length>0&&![button.titleLabel isKindOfClass:[NSNull class]]) {//  只有文字存在的时候才会加入计划,后台确定不是所有问题都有计划
                [button setTitleColor:kMainTitleColor  forState:UIControlStateNormal];
                [button setTitleColor:kMainColor  forState:UIControlStateSelected];
                //            [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                //            [button setImage:[UIImage imageNamed:@"iv_question_select"] forState:UIControlStateSelected];
                button.imageEdgeInsets = UIEdgeInsetsMake(0, -KWidth(40), 0, 0);
                [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
                button.layer.cornerRadius = KHeight(45)/2.0;
                button.layer.borderColor = [UIColor getColor:@"95A2B3"].CGColor;
                button.layer.borderWidth = .5f;
                //button文字的偏移量
                button.titleEdgeInsets = UIEdgeInsetsMake(0,  -(button.imageView.frame.origin.x+button.imageView.frame.size.width), 0, 0);
                //button图片的偏移量
                button.imageEdgeInsets = UIEdgeInsetsMake(0, -(button.imageView.frame.origin.x ), 0, button.imageView.frame.origin.x);
                button.frame = CGRectMake(_guideScrollView.frame.size.width * (self.questionArr.count - 1)+(KScreenWidth / 2 - KWidth(130)), KHeight(73)+ KHeight(166)+j*(KHeight(45)+KHeight(10)), KWidth(260), KHeight(45));
                
                [_guideScrollView addSubview:button];
                UIImageView *checkImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iv_question_select"] highlightedImage:[UIImage imageNamed:@"iv_question_select"]];
                checkImage.frame = CGRectMake(KWidth(19), (KHeight(45)-KWidth(15))/2.0, KWidth(15), KWidth(15));
                checkImage.tag = 191919+j;
                checkImage.hidden = YES;
                [button addSubview:checkImage];
                 [self.btnArray addObject:button];
                
               
            }
           
        }
      
         [save_dic setValue:tempArrQuestionAnswerList forKey:@"QuestionAnswerList"];
    }
    
}
-(void)yesOrNO:(UIButton *)btn
{
    if (btn.tag == 10002) {
      
        [save_dic setValue: self.contentBirthdayLab.text forKey:@"birthday"];
        
        //出声日期继续
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*2, 0)];
        
    }else{
        [save_dic setValue:[NSString stringWithFormat:@"%@",_selectedArea?_selectedArea:@"150"] forKey:@"height"];
        [save_dic setValue:[NSString stringWithFormat:@"%@",_selected_weigh?_selected_weigh:@"53"] forKey:@"weight"];
        //升高继续
        [_guideScrollView setContentOffset:CGPointMake(KScreenWidth*3, 0)];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 2;

}
-(NSMutableArray *)get_high_array
{
    if (!_get_high_array) {
        _get_high_array = [[NSMutableArray alloc]init];
      
        for (int i=100;i<200;i++){
            [_get_high_array addObject:[NSNumber numberWithInt:i]];
        }
       
    }
    return _get_high_array;
    
}

-(NSMutableArray *)get_weigh_array
{
     if (!_get_weigh_array) {
        _get_weigh_array = [NSMutableArray array];
        for (int i=3;i<150;i++){
        [_get_weigh_array addObject:[NSNumber numberWithInt:i]];
        }
     }
    return _get_weigh_array;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {

        return self.get_high_array.count;

    }
     else
    return self.get_weigh_array.count;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        NSNumber *num = self.get_high_array[row];
        return [NSString stringWithFormat:@"%@",num];
    }else
    {
        
        NSNumber *num = self.get_weigh_array[row];
        return [NSString stringWithFormat:@"%@",num];
    }
   

}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel){
//        pickerLabel = [[UILabel alloc] init];
////        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        [pickerLabel setTextColor:[UIColor getColor:@"2C4667"]];
//        [pickerLabel setFont:[UIFont boldSystemFontOfSize:35]];
//    }
//    // Fill the label text here
//    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
//    return pickerLabel;
//}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {

        _selectedArea = self.get_high_array[row];

    }else{
        _selected_weigh = self.get_weigh_array[row];
    }
}
- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDate *date = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyy年MM月dd日"];
    NSLog(@"----%@",[dateFormatter stringFromDate:date]);
    self.contentBirthdayLab.text = [dateFormatter stringFromDate:date];
   
}
-(void)loadGuideData{
    
    NSDictionary *dic = @{@"Token":@" ",
                          };
    
    [LoginViewModel GuideQuestionLoginWithParams:dic FinishedBlock:^(ResponseObject *response) {
        

        if (response.code == CodeTypeSucceed) {
            //**推送--这个方法是设置别名和tag 可省
            NSArray *questionArr = [GuideQuestion mj_objectArrayWithKeyValuesArray:response.Result];
            GuideQuestion *mod = [[GuideQuestion alloc]init];
            self.questionArr = [NSMutableArray arrayWithCapacity:0];
            [self.questionArr addObject:mod];
             [self.questionArr addObject:mod];
             [self.questionArr addObject:mod];
            [self.questionArr addObjectsFromArray:questionArr];
             [self.questionArr addObject:mod];
            self.singleQuestionArr = [NSMutableArray arrayWithArray:questionArr];
// @[@"iv_question_robot",@"",@"",@"iv_question_examination",@"iv_question_breakfast",@"iv_question_sports",@"iv_question_drink",@""];
 
            [self setupSubviews];
            NSLog(@"146---------:%@",response.Result);
        }else {
            
            ShowErrorStatus(response.msg);
            
        }
    }];
    
}

@end
