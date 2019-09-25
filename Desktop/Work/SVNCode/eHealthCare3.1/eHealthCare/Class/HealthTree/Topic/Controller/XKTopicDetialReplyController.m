//
//  XKTopicDetialReplyController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicDetialReplyController.h"
#import "XKTopicDetialReplyFirstCommentCell.h"
#import "XKTopicDetialReplySecondeCommentCell.h"
#import "XKInformationCancelView.h"

@interface XKTopicDetialReplyController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,XKTopicDetialReplyFirstCommentCellDelegate,XKTopicDetialReplySecondeCommentCellDelegate,XKInformationCancelViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *commentTable;

/**
 txt视图容器
 */
@property (weak, nonatomic) IBOutlet UIView *txtContainerView;

/**
 文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txtFaild;

/**
 数据源
 */
@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 当前数据页数下标
 */
@property (nonatomic,assign) NSInteger pageIndex;

/**
 一级评论标志
 */
@property (nonatomic,assign) NSInteger firstBrand;

/**
 二级评论标志
 */
@property (nonatomic,assign) NSInteger secondeBrand;

/**
 一级评论的保存
 */
@property (nonatomic,strong) XKFirstCommtentModel *saveFirst;

/**二级评论的保存*/
@property (nonatomic,strong) XKSecondeCommtentModel *saveSeconde;

/**
 评论输入框
 */
@property (strong, nonatomic)  XKInformationCancelView *backView;

@property (weak, nonatomic) IBOutlet UIView *keyContainerV;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;

/**
 二级标示
 */
@property (nonatomic,assign) BOOL isSecond;

@end

@implementation XKTopicDetialReplyController

- (XKInformationCancelView *)backView
{
    if (_backView == nil) {
        
        _backView = [[NSBundle mainBundle]loadNibNamed:@"XKInformationCancelView" owner:nil options:nil].firstObject;
        _backView.left = 0;
        _backView.top = 0.5;
        _backView.width = self.view.frame.size.width;
        _backView.height = 60.5f;
        _backView.isTopic = YES;

    }
    return _backView;
}

//实现接收到通知时的操作
-(void) keyBoardChange:(NSNotification *)note

{
    //获取键盘弹出或收回时frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //获取键盘弹出所需时长
    float duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //添加弹出动画
    [UIView animateWithDuration:duration animations:^{
        self.keyContainerV.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - (KScreenHeight));
        
        if (keyboardFrame.origin.y == KScreenHeight) {
            
            self.backView.cancelBtn.hidden = YES;
            
            self.backView.sureBtn.hidden = YES;
            
            self.bottomCons.constant = 60.5f;
            
            self.backView.myTextViewTop.constant = 10;
            
            self.backView.textViewLabTop.constant = 20.f;
            
            self.firstBrand =1;
            self.isSecond = NO;
            self.secondeBrand = 1;
            self.backView.textViewLal.text = @"我也说一句~";
        }
        else
        {
            
            if (self.firstBrand == 1 && self.secondeBrand == 1) {//直接显示回复评论人
                self.backView.textViewLal.text = [NSString stringWithFormat:@"回复：%@",self.firstModel.NickName];
                
                if (self.firstModel.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID && self.isSecond == NO) {
                    self.backView.textViewLal.text = @"我也说一句~";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
                    });
                    return ;
                }
            }
            
            self.backView.cancelBtn.hidden = NO;
            
            self.backView.sureBtn.hidden = NO;
            
            self.bottomCons.constant = 146.5f;
            
            self.backView.myTextViewTop.constant = 47;
            
            self.backView.textViewLabTop.constant = 52;
            
            
        }
        
        
    }];
    
}

#pragma mark   xkInformationDelegate
- (void)cancelForClicked;
{
    [self.view endEditing:YES];
    
    self.backView.textViewLal.hidden = NO;
    
    self.backView.textViewLal.text = @"我也说一句～";
}

- (void)sureForClickedAction:(NSString *)topicString;
{
    
    //    if (topicString.length<=0) {
    //        [IanAlert alertError:@"请输入数据" length:1.0];
    //        return;
    //    }
    
    [self updateComment:topicString];
    
    self.firstBrand =1;
    self.secondeBrand = 1;
//    self.backView.textViewLal.hidden = NO;
//    self.backView.myTextView.text = @"";
//    //        [self bringSubviewToFront:self.myTextView];
//    //        [self bringSubviewToFront:self.textViewLal];
//    [self.backView.myTextView resignFirstResponder];
//    [self.backView.txtField resignFirstResponder];
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableViewTopCons.constant = (PublicY);
    self.myTitle = @"回复详情";
    
    self.backView.delegate = self;
    
    self.commentTable.backgroundColor = [UIColor getColor:@"f2f2f2"];
    
//    self.txtFaild.delegate = self;
    
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    
    self.commentTable.tableFooterView = [UIView new];
    
    self.commentTable.showsVerticalScrollIndicator = NO;
    self.commentTable.showsHorizontalScrollIndicator = NO;
    
    //预设cell高度
    self.commentTable.estimatedRowHeight = 100;
    
    //打开自动计算行高
    self.commentTable.rowHeight = UITableViewAutomaticDimension;
    
    [self.commentTable registerNib:[UINib nibWithNibName:@"XKTopicDetialReplyFirstCommentCell" bundle:nil] forCellReuseIdentifier:@"Onecell"];
    
    [self.commentTable registerNib:[UINib nibWithNibName:@"XKTopicDetialReplySecondeCommentCell" bundle:nil] forCellReuseIdentifier:@"Twocell"];
    
    self.pageIndex = 1;
    
    self.firstBrand = 1;
    
    self.isSecond = NO;
    
    self.secondeBrand = 1;
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.commentTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTopics)];
    //        // 自动改变透明度
    //        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    [self.topicTable.mj_header beginRefreshing];
    
    self.commentTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreTopics)];
    
    [self loadData:1 withIsFresh:YES];
    
//    [self.commentTable sendSubviewToBack:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];//健康监听通知
    
    [self.keyContainerV addSubview:self.backView];
    
    self.backView.width = CGRectGetWidth(self.keyContainerV.frame);
    
    //去掉评论是按钮键盘的完成
    self.backView.myTextView.inputAccessoryView = [UIView new];
    
    //改变系统线条颜色
    [self.commentTable setSeparatorColor:[UIColor getColor:@"d8d8d8"]];
}

#pragma mark - 事件处理
- (void)_loadNewTopics
{
    
    [self loadData:1 withIsFresh:NO];
    
}

- (void)_loadMoreTopics
{
    
    [self loadData:2 withIsFresh:NO];
    
}

#pragma mark   请求数据变更
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=8;
    
    if (mothed==1) {//刷新
        
        pageSize= 8;//self.dataArray.count>8?self.dataArray.count:8;
        self.pageIndex = 1;
    }else{//加载更多
        
        pageSize=8;
        
        self.pageIndex++;
        
    }
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"906" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TopicID":@(self.currentModel.TopicID),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"CommentID":@(self.firstModel.ReplyID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize),@"TypeID":@(1)} success:^(id json) {
        
        NSLog(@"906-----%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            NSArray *arr =  [XKSecondeCommtentModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.dataArray = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.dataArray = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.dataArray addObjectsFromArray:arr];
                }
                
            }
            
            
            [self.commentTable reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.commentTable reloadData];
            });
            
            [self.commentTable.mj_header endRefreshing];
            // 结束刷新
            [self.commentTable.mj_footer endRefreshing];
            
            
            if (self.dataArray.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.commentTable.mj_footer endRefreshingWithNoMoreData];
                
                if (self.pageIndex > 1) {
                    self.pageIndex --;
                }
                
            }
            
            
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            [self.commentTable.mj_header endRefreshing];
            // 结束刷新
            [self.commentTable.mj_footer endRefreshing];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        [self.commentTable.mj_header endRefreshing];
        // 结束刷新
        [self.commentTable.mj_footer endRefreshing];
    }];
    
    
}

/**
 点赞功能的代理方法
 */
-(void)detailChangeTopicDataSoure:(XKFirstCommtentModel *)model{
    
    self.firstModel = model;
    
}

/**
 一级评论的代理方法
 */
-(void)commtentFistReply:(XKFirstCommtentModel *)firstModel{
    
    [self.backView.myTextView becomeFirstResponder];
    
    self.saveFirst = firstModel;
    
    self.firstBrand = 2;
    
    self.isSecond = NO;
    
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复：%@",firstModel.NickName];
    
}

/**
 二级评论的代理方法
 */
-(void)sendSecondeCommendMsg:(XKSecondeCommtentModel *)model{
    
    self.isSecond = YES;
    
    [self.backView.myTextView becomeFirstResponder];
    
    self.saveSeconde = model;
    
    self.secondeBrand = 2;
    
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复：%@",model.RNickName];
    
    
}

/**
 文本视图return视图的监听事件
 */
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    [self updateComment:textField.text];
//    
//    self.firstBrand =1;
//    self.secondeBrand = 1;
//    
//    textField.text = @"";
//    
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 提交评论
 */
-(void)updateComment:(NSString *)content{
    
    if ([content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0) {
        
        ShowErrorStatus(@"既然来了、留个💗情再走吧" );
        [[XKLoadingView shareLoadingView] hideLoding];
        return;
        
    }
    
    if (content.length >50) {
     
        ShowErrorStatus(@"您的💗情也太多了吧！" );
        [[XKLoadingView shareLoadingView] hideLoding];
        return;
        
    }
    
     NSDictionary *dict;
        
     if(self.secondeBrand == 2){
        NSLog(@"对话");
        dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(1),@"TopicID":@(self.firstModel.ReplyID),@"ParentID":@(self.saveSeconde.ReplyID),@"TotalID":@(self.currentModel.TopicID),@"ReplyContent":content,@"ReplyImgUrl":@""};
    }else{
      dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(1),@"TopicID":@(self.firstModel.ReplyID),@"ParentID":@(self.firstModel.ReplyID),@"TotalID":@(self.currentModel.TopicID),@"ReplyContent":content,@"ReplyImgUrl":@""};
    }
    
    NSLog(@"%@",dict);
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    //获取首页健康计划、热门话题数据
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"903" parameters:dict success:^(id json) {
        
        NSLog(@"%@",json);
        
        [[XKLoadingView shareLoadingView] hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
         
            ShowSuccessStatus(@"回复成功");
            self.backView.textViewLal.text = @"我也说一句～";
            [self loadData:1 withIsFresh:YES];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"评论失败"];
        }
        
    } failure:^(id error) {
        [[XKLoadingView shareLoadingView] errorloadingText:@"评论失败"];
        NSLog(@"%@",error);
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        
        return self.dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        XKTopicDetialReplyFirstCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Onecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.firstModel;
        
        return cell;
    }else{
        XKTopicDetialReplySecondeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Twocell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArray[indexPath.row];
        cell.delegate = self;
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.05;
    }else{
        return 0.05;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.05;
    
}

@end
