//
//  HomeAnswerView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/7.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HomeAnswerView.h"

@interface HomeAnswerView ()
{
    NSString *_testTitleKeyName;
    NSString *_answerArrayKeyName;
    NSString *_choseButtonTitleKeyName;
    NSString *_questionIDKeyName;
    NSString *_questionOptionIDKeyName;
}
///答题进度条
@property (nonatomic, strong) UIProgressView *progress;

///答题进度
@property (nonatomic, strong) UILabel *progressLabel;

///测试标题
@property (nonatomic, strong) UILabel *testTitle;

///上一题
@property (nonatomic, strong) UIButton *backButton;

///当前位于第几题
@property (nonatomic, assign) NSInteger indexQuestion;

///做题结果(存储选了哪些选项)
@property (nonatomic, strong) NSMutableArray *commitArray;

///选项按钮数组
@property (nonatomic, strong) NSMutableArray *choseButtonArray;

@end

static NSInteger ChoseButtonTag = 20000;

@implementation HomeAnswerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indexQuestion = 0;
        [self createUI];
        self.commitArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

#pragma mark UI
- (void)createUI
{
    //进度条
    UIProgressView *progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    progress.tintColor = ORANGECOLOR;
    progress.trackTintColor = [UIColor colorWithRed:240/255. green:250/255. blue:255/255. alpha:1];
    progress.progress = 0;
    
    [self addSubview:progress];
    
    self.progress = progress;
    
    [progress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(KHeight(20));
    }];
    
    //进度情况
    UILabel *progressLabel = [[UILabel alloc]init];
    
    progressLabel.textColor = COLOR(114, 155, 155, 1);
    progressLabel.textAlignment = NSTextAlignmentRight;
    progressLabel.font = Kfont(12);
    
    [progress addSubview:progressLabel];
    self.progressLabel = progressLabel;
    
    [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(- KWidth(18));
        make.height.mas_equalTo(KHeight(12));
        make.centerY.mas_equalTo(progress.mas_centerY);
    }];
}

//添加选项按钮以及加载数据
- (void)addAnswerChoseButtonAndLoadData
{
    NSDictionary *dic = [self.dataArray objectAtIndex:self.indexQuestion];
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]] && subview.tag >= 100 && subview.tag != 8888 && ![subview isEqual:self.backButton]) {
            [subview removeFromSuperview];
        }
    }
    //标题
    if (!self.testTitle)
    {
        UILabel *testTitle = [[UILabel alloc]init];
        
        testTitle.font = Kfont(16);
        testTitle.text = dic[_testTitleKeyName];
        testTitle.textAlignment = NSTextAlignmentCenter;
        testTitle.numberOfLines = 0;
        testTitle.lineBreakMode = NSLineBreakByCharWrapping;
        
        [self addSubview:testTitle];
        self.testTitle = testTitle;
        
        CGSize maxTitleSize = CGSizeMake(KScreenWidth - KWidth(88), CGFLOAT_MAX);
        CGSize expectTitleSize = [testTitle sizeThatFits:maxTitleSize];
        
        [testTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.progress.mas_bottom).mas_offset(KHeight(36));
            make.size.mas_equalTo(expectTitleSize);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }else
    {
        self.testTitle.text = dic[_testTitleKeyName];
    }
   
    
    //进度
    self.progressLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.indexQuestion + 1,self.dataArray.count];
    
    //如果是第一题隐藏 '上一题' 按钮
    if (self.indexQuestion != 0)
    {
        self.backButton.hidden = NO;
    }else
    {
        self.backButton.hidden = YES;
    }
    
    NSArray *answerArray = dic[_answerArrayKeyName];
 
    for (int i = 0; i < answerArray.count; i++)//只有2个数据的时候
    {
        if (self.choseButtonArray.count == answerArray.count)
        {
            UIButton *button = self.choseButtonArray[i];
            [button setTitle:answerArray[i][_choseButtonTitleKeyName] forState:UIControlStateNormal];

        }else
        {
            for (UIButton *button in self.choseButtonArray)
            {
                [button removeFromSuperview];
            }
            
            //选项按钮
            UIButton *choseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            choseButton.tag = ChoseButtonTag + i;
            [choseButton setTitle:answerArray[i][_choseButtonTitleKeyName] forState:UIControlStateNormal];
            [choseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            choseButton.backgroundColor = kMainColor;
            choseButton.titleLabel.font = Kfont(16);
            
            choseButton.titleLabel.numberOfLines = 0;
            choseButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
            
            CGSize maxChoseButtonSize = CGSizeMake(KWidth(275), CGFLOAT_MAX);
            CGSize expectChoseButtonSize = [choseButton.titleLabel sizeThatFits:maxChoseButtonSize];
            if (expectChoseButtonSize.height > KHeight(62))
            {
                choseButton.titleLabel.font = Kfont(16 * expectChoseButtonSize.height / 62);
            }
            
            [choseButton addTarget:self action:@selector(choseTheAnswer:) forControlEvents:UIControlEventTouchUpInside];
           
            
            [self addSubview:choseButton];
            
            [self.choseButtonArray addObject:choseButton];
            
            [choseButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self.testTitle.mas_bottom).mas_offset(KHeight(36) + i * KHeight(72));
                make.size.mas_equalTo(CGSizeMake(KWidth(275), KHeight(62)));
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
            
            choseButton.layer.borderWidth = 0.3f;
            choseButton.layer.borderColor = kMainColor.CGColor;
            choseButton.layer.cornerRadius = 10;
            choseButton.layer.masksToBounds = YES;
            
            //添加 上一题 按钮
            if (i == answerArray.count - 1)
            {
                UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [backButton setTitle:@"上一题" forState:UIControlStateNormal];
                [backButton setTitleColor:kMainColor forState:UIControlStateNormal];
                backButton.titleLabel.font = Kfont(16);
                
                [backButton addTarget:self action:@selector(goBackToThePastQuestion) forControlEvents:UIControlEventTouchUpInside];
                backButton.hidden = YES;
                
                [self addSubview:backButton];
                self.backButton = backButton;
                
                [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.mas_offset(-KHeight(40));
                    make.size.mas_equalTo(CGSizeMake(KWidth(275), KHeight(62)));
                    make.centerX.mas_equalTo(self.mas_centerX);
                }];
                
                backButton.layer.borderWidth = 0.3f;
                backButton.layer.borderColor = kMainColor.CGColor;
                backButton.layer.cornerRadius = 10;
                backButton.layer.masksToBounds = YES;
            }
        }
        
    }
}

#pragma mark Action
//点击了选项
- (void)choseTheAnswer:(UIButton *)button
{
    //是否已经插入数据
    BOOL hasInsert = NO;
  
    //现将选择的选项信息加入到 提交数组 里
    if (self.indexQuestion<=self.dataArray.count-1) {
        
        NSDictionary *dic = self.dataArray[self.indexQuestion];
        NSArray *answerArray = dic[_answerArrayKeyName];
        NSLog(@"answerArray-----%@",answerArray);
        NSDictionary *optionDic = [answerArray objectAtIndex:button.tag - ChoseButtonTag];
         NSLog(@"-已经插入数据--%li-_%li",button.tag,ChoseButtonTag);
        NSDictionary *insertDic = [NSDictionary dictionary];
        if (self.isCorporeity)
        {
            insertDic = @{@"QuestionID":dic[_questionIDKeyName],
                          @"QuestionOptionID":optionDic[_questionOptionIDKeyName],
                          @"OptionScore":optionDic[@"OptionScore"],
                          @"QuestionType":dic[@"QuestionType"]};
            
        }else
        {
            insertDic = @{@"QuestionID":dic[_questionIDKeyName],
                          @"QuestionOptionID":optionDic[_questionOptionIDKeyName],
                          @"OptionScore":optionDic[@"OptionScore"]};
        }
        if (self.commitArray.count > 0)
        {
            NSArray *copyCommitArray = [NSArray arrayWithArray:self.commitArray];
            for (NSDictionary *pastDic in copyCommitArray)
            {
                if ([insertDic[@"QuestionID"] integerValue] == [pastDic[@"QuestionID"] integerValue])
                {
                    [self.commitArray removeObject:pastDic];
                    [self.commitArray addObject:insertDic];
                    hasInsert = YES;
                }
            }
            
            if (!hasInsert)
            {
                [self.commitArray addObject:insertDic];
            }
            
        }else
        {
            [self.commitArray addObject:insertDic];
        }
    }
   

  
    
    //判断是否是最后一题
    if (self.indexQuestion == self.dataArray.count - 1)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(testFinish:)])
        {
            [self.delegate testFinish:[NSArray arrayWithArray:self.commitArray]];
        }
        
    }else
    {
        self.indexQuestion++;
        
        float progress = (float)(self.indexQuestion + 1) / self.dataArray.count;
        [self.progress setProgress:progress animated:YES];
        
        [self nextQuestion];
    }
}

//返回上一题
- (void)goBackToThePastQuestion
{
    if (self.indexQuestion > 0)
    {
        self.indexQuestion --;
        [self addAnswerChoseButtonAndLoadData];
        
        float progress = (float)(self.indexQuestion + 1) / self.dataArray.count;
        [self.progress setProgress:progress animated:YES];
    }else
    {
        self.backButton.hidden = YES;
    }
}

//下一题
- (void)nextQuestion
{
    [self addAnswerChoseButtonAndLoadData];
}

//根据检测类型赋予对应的keyName
- (void)suitTypeTestForKeyName
{
    //由于体质检测和非体质检测 从后台拿到数据的字段不一样 所以采取以下措施
    _testTitleKeyName = self.isCorporeity ? @"Question": @"QuestionContent";
    
    _answerArrayKeyName = self.isCorporeity ? @"NineOptions": @"QuestionOptions";
    
    _choseButtonTitleKeyName = self.isCorporeity ? @"NineOptionName": @"OptionName";
    
    _questionIDKeyName = self.isCorporeity ? @"TestNineQuestionId": @"QuestionID";
    
    _questionOptionIDKeyName = self.isCorporeity ? @"NineOptionID": @"OptionID";
}

#pragma mark setter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self suitTypeTestForKeyName];
    [self addAnswerChoseButtonAndLoadData];
}

@end