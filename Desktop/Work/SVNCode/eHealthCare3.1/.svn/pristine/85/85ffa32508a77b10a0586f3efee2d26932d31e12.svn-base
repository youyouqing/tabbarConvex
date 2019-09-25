//
//  MineSuggestView.m
//  eHealthCare
//
//  Created by xiekang on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MineSuggestView.h"
#import "XKFeedBackTableViewCell.h"
@interface MineSuggestView ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *contextView;
@property (weak, nonatomic) IBOutlet UIView *textBackView;
@property (weak, nonatomic) IBOutlet UILabel *textViewLal;

/*选择意见分类的View*/
@property (weak, nonatomic) IBOutlet UIView *chooseView;
/*取消按钮*/
@property (weak, nonatomic) IBOutlet UIButton *concalBtn;

/*确认取消按钮的宽度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureBtnWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *concalBtnWidthCons;

@property (weak, nonatomic) IBOutlet UITableView *typeTable;

@property (nonatomic,strong)NSArray *feedbackMessage1;

@property (nonatomic,assign)NSInteger type;

@end
@implementation MineSuggestView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    self.contextView.backgroundColor = [UIColor whiteColor];
    self.contextView.layer.cornerRadius = 5;
    self.contextView.clipsToBounds = YES;
    //建议内容的背景设置
    self.textBackView.backgroundColor = [UIColor clearColor];
    self.textBackView.layer.cornerRadius = 5;
    self.textBackView.clipsToBounds = YES;
    self.textBackView.layer.borderColor = kLineColor.CGColor;
    self.textBackView.layer.borderWidth = .5f;
    
    
    //提交按钮
    self.sureBtn.clipsToBounds = YES;
    self.sureBtn.layer.cornerRadius = self.sureBtn.frame.size.height/2;
    self.sureBtn.backgroundColor = kMainColor;
    
    //TextView 设置代理
    self.myTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.chooseView.layer.borderWidth = .5f;
    self.chooseView.layer.borderColor = kLineColor.CGColor;
    self.chooseView.layer.cornerRadius = 5;
    self.chooseView.layer.masksToBounds = YES;
    
    [self.concalBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.concalBtn.layer.borderColor = kMainColor.CGColor;
    self.concalBtn.layer.borderWidth = .5f;
    self.concalBtn.layer.cornerRadius = self.concalBtn.frame.size.height/2;
    self.concalBtn.layer.masksToBounds = YES;
    self.concalBtn.backgroundColor = [UIColor clearColor];
    
    if (IS_IPHONE5) {
        
        self.sureBtnWidthCons.constant = 100;
        
        self.concalBtnWidthCons.constant = 100;
        
    }
    
    self.typeTable.hidden = YES;
    
    self.typeTable.delegate = self;
    self.typeTable.dataSource = self;
    
    self.typeTable.showsVerticalScrollIndicator = NO;
    self.typeTable.showsHorizontalScrollIndicator = NO;
    self.typeTable.tableFooterView = [UIView new];
    self.typeTable.layer.cornerRadius = 5;
    self.typeTable.clipsToBounds = YES;
    [self.typeTable registerNib:[UINib nibWithNibName:@"XKFeedBackTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.feedbackMessage1.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XKFeedBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSDictionary *dict = self.feedbackMessage1[indexPath.row];
    
    cell.nameLab.text = dict[@"FeedbackTypeName"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.feedbackMessage1[indexPath.row];
    
    self.typeLab.text = dict[@"FeedbackTypeName"];
    
    self.type = [dict[@"FeedbackTypeID"] integerValue];
    
    tableView.hidden = YES;
    
}


/**
取消按钮的点击
 */
- (IBAction)concalAcntion:(id)sender {
    
    [self HideView];
    
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

/*选择类型的点击*/
- (IBAction)chooseAction:(id)sender {
    
    self.typeTable.hidden = NO;
    
    self.feedbackMessage1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"feedbackMessage"];
    
    [self.typeTable reloadData];
    
//    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    for (NSDictionary *dict in feedbackMessage) {
//        
//        UIAlertAction *action = [UIAlertAction actionWithTitle:dict[@"FeedbackTypeName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            //            self.typeLab.text = dict[@"FeedbackTypeName"];
//            
//        }];
//        
//        [alertCon addAction:action];
//        
//    }
    
//    [[[UIApplication sharedApplication].keyWindow] presentViewController:alertCon animated:YES completion:nil];
    
    
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

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.myTextView) {
        self.textViewLal.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.myTextView) {
        if (textView.text.length == 0) {
            self.textViewLal.text = @"请输入您的建议";
        }
    }
}

- (IBAction)closeBtn:(UIButton *)sender {
    [self HideView];

}
- (IBAction)sureBtn:(id)sender {
    
    if ([self.typeLab.text isEqualToString:@"请选择反馈类型"]) {
     
         ShowErrorStatus(@"请选择反馈类型");
        return;
        
    }
    
    if (self.myTextView.text.length == 0 || [Judge isEmpty:self.myTextView.text]) {
        ShowErrorStatus(@"反馈信息不能为空");
        return;
    }
    
    NSString *memberid = [NSString stringWithFormat:@"%li",[UserInfoTool getLoginInfo].MemberID];
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":memberid,@"FeedBackContent":self.myTextView.text,@"FeedbackTypeID":@(self.type)};
    [[XKLoadingView shareLoadingView] showLoadingText:@"正在提交..."];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"131" parameters:dict success:^(id json) {
        NSLog(@"131:%@",json);
        [[XKLoadingView shareLoadingView] hideLoding];
        NSDictionary *dic=[json objectForKey:@"Basis"];
        if ([[NSString stringWithFormat:@"%@",dic[@"Status"]] isEqualToString:@"200"]) {
             ShowSuccessStatus(@"提交成功");
            [self HideView];
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"提交失败"];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:error];
    }];
    
}

-(void)HideView
{
    [self endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//注销通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
