//
//  XKInformationDetailController.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInformationDetailController.h"
#import "XKInformationCancelView.h"
#import "XKInformationDeatilCell.h"
#import "XKInfoDetailView.h"
#import "MHComment.h"
#import "XKInfoMationViewSectionCell.h"
#import "XKValidationAndAddScoreTools.h"
@interface XKInformationDetailController ()<UITableViewDataSource,UITableViewDelegate,XKInformationCancelViewDelegate,XKInfoDetailViewDelegate,XKInformationDeatilCellDelegate>

{
    
    NSInteger CommentReplyID;
    
    NSInteger CommentParentID;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *infoView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;

@property (strong, nonatomic)  XKInformationCancelView *backView;

@property (strong, nonatomic)  XKInfoDetailView *InfoDetailView;

@property (nonatomic,assign)NSInteger pageIndex;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property (nonatomic , strong) NSMutableArray * infoArr;
@end

@implementation XKInformationDetailController
-(NSMutableArray *)infoArr
{
    
    if (!_infoArr) {
        _infoArr = [[NSMutableArray alloc]init];
    }
    return _infoArr;
    
}
- (XKInformationCancelView *)backView
{
    if (_backView == nil) {
        _backView = [[NSBundle mainBundle]loadNibNamed:@"XKInformationCancelView" owner:nil options:nil].firstObject;
        _backView.x = 0;
        _backView.y = 0;
        _backView.width = self.infoView.frame.size.width;
        _backView.height = 60;
        _backView.delegate = self;
        _backView.isTopic = NO;

    }
    return _backView;
}
- (XKInfoDetailView *)InfoDetailView
{
    if (_InfoDetailView == nil) {
        _InfoDetailView = [[NSBundle mainBundle]loadNibNamed:@"XKInfoDetailView" owner:nil options:nil].firstObject;
        _InfoDetailView.x = 0;
        _InfoDetailView.y = 0;
        _InfoDetailView.width = KScreenWidth;
        _InfoDetailView.height = 105;
        _InfoDetailView.delegate = self;
    }
    return _InfoDetailView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"回复详情";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewTopCons.constant = PublicY;
    self.pageIndex = 1;
    
    [self.infoView addSubview:self.backView];


    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.estimatedSectionHeaderHeight = 20;
    
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKInformationDeatilCell" bundle:nil] forCellReuseIdentifier:@"XKInformationDeatilCell"];
    
      [self.tableView registerNib:[UINib nibWithNibName:@"XKInfoMationViewSectionCell" bundle:nil] forCellReuseIdentifier:@"XKInfoMationViewSectionCell"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    self.tableView.estimatedRowHeight = 10.0;
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    [self loadData:1 withIsFresh:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTapBySureBtn)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
    CommentReplyID  = self.topic.ReplyID;
    
    CommentParentID = self.topic.ReplyID;
    
    if (self.topic.ReplyerMemberID ==  [UserInfoTool getLoginInfo].MemberID) {


        self.backView.ReplyerMemberID = self.topic.ReplyerMemberID ;
    }
    //去掉评论是按钮键盘的完成
    self.backView.myTextView.inputAccessoryView = [UIView new];
    
}
-(void)removeTapBySureBtn
{

     [self.backView.myTextView resignFirstResponder];
  
    
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
        self.infoView.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - (KScreenHeight));
        
        if (keyboardFrame.origin.y == KScreenHeight) {
            
            self.backView.cancelBtn.hidden = YES;
            
            self.backView.sureBtn.hidden = YES;
            
            self.backViewHeight.constant = 60.f;
            
            self.backView.myTextViewTop.constant = 10;
            
            self.backView.textViewLabTop.constant = 20.f;
            
        }
        else
        {
            
            
            self.backView.cancelBtn.hidden = NO;
            
            self.backView.sureBtn.hidden = NO;
            
            self.backViewHeight.constant = 144.f;
            
            self.backView.myTextViewTop.constant = 47;
            
            self.backView.textViewLabTop.constant = 55;
            
            if (CommentParentID == self.topic.ReplyID) {

                 self.backView.textViewLal.text = [NSString stringWithFormat:@"回复: %@",self.topic.NickName];
            }
            
        }
        
        
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

   
    self.InfoDetailView.topic = self.topic;
    
    return self.InfoDetailView;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

   return self.infoArr.count;
 
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   

    static NSString *cellID = @"XKInformationDeatilCell";
    XKInformationDeatilCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.comment =  self.infoArr[indexPath.row];
    return cell;


}

#pragma mark   xkInformationDelegate
- (void)cancelForClicked;
{

    [self.backView.myTextView resignFirstResponder];
    
    self.backView.textViewLal.hidden = NO;
    
    CommentReplyID  = self.topic.ReplyID;
    
    CommentParentID = self.topic.ReplyID;
    
    self.backView.ReplyerMemberID = self.topic.ReplyerMemberID ;
  
    
}
#pragma mark XKInformationDeatilCell
- (void)topicCellForClickedMoreAction:(XKInformationDeatilCell *)topicCell didSelectRow:(MHComment *)comment;
{
    /*回复某个人的话题*/
      self.backView.ReplyerMemberID = comment.ReplyerMemberID ;
    
    [self.backView.myTextView becomeFirstResponder];
    
    self.backView.myTextView.text = @"";
    
     self.backView.textViewLal.text = [NSString stringWithFormat:@"回复: %@",topicCell.nameLab.text];
    
    CommentReplyID  = _topic.ReplyID;
    
    CommentParentID = comment.ReplyID;
  

}

/**
 咨询详情回复
 
 @param topic 点赞
 */
- (void)topicCellForClickedRow:(MHTopic *)topic XKInfoDetailView:(XKInfoDetailView *)cell;
{
    [self.backView.myTextView becomeFirstResponder];
    
    self.backView.myTextView.text = @"";
    
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复: %@",cell.nameLab.text];

    
    CommentReplyID  = topic.ReplyID;
    
    CommentParentID = topic.ReplyID;
    self.backView.ReplyerMemberID = self.topic.ReplyerMemberID ;
     NSLog(@"咨询详情回复-ParentID%li-----_topic.ReplyID%li",topic.ReplyID,_topic.ReplyID);
}




- (void)topicCellForMoreLikeClicked:(MHTopic *)topic  XKInfoDetailView:(XKInfoDetailView *)cell;
{
    if (topic.IsPraise == 1) {//已经点赞  返回
        NSLog(@"---点击👍按钮---");
        return;
    }else{//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
      
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"904" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"ReplyID":@(topic.ReplyID),@"TypeID":@(4)} success:^(id json) {
            
            NSLog(@"%@",json);
            [[XKLoadingView shareLoadingView] hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                ShowSuccessStatus(@"点赞成功");
                cell.likeBtn.selected = YES;
//                //
//                //                //1.点赞数量加一
                topic.PraiseScount+=1;
                [cell.likeBtn setTitle:[NSString stringWithFormat:@"%li",topic.PraiseScount] forState:UIControlStateNormal];
//                //
               //2.更换是否点赞的参数
                topic.IsPraise = 1;
                
                
                self.changeThumbIsPraise(topic.PraiseScount);
                
                
            }else{
                [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);
            
        }];
        
    }
    

}

- (void)sureForClickedAction:(NSString *)topicString;
{
//    self.backView.textViewLal.hidden = NO;
//    self.backView.myTextView.text = @"";
//    //        [self bringSubviewToFront:self.myTextView];
//    //        [self bringSubviewToFront:self.textViewLal];
//    [self.backView.myTextView resignFirstResponder];
//    [self.backView.txtField resignFirstResponder];
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
  //>0?_mod.WikiID:_mod.ID。ID 和 _mod.WikiID两个。 ID一起用。因为模型混乱防止这个不在用另外一个
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"903" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TopicID":@(CommentReplyID),@"ParentID":@(CommentParentID),@"TotalID":@(_TopicID.WikiID>0?_TopicID.WikiID:_TopicID.ID),@"ReplyContent":self.backView.myTextView.text,@"TypeID":@(2),@"ReplyImgUrl":@""} success:^(id json) {
        
        NSLog(@"%@",json);
        [[XKLoadingView shareLoadingView] hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            
            ShowSuccessStatus(@"回复成功");
            
            
             self.backView.textViewLal.text = @"我也说一句～";
//            
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            NSDictionary *dic = [user objectForKey:@"mineInfo"];
//
//                
//            if (CommentParentID == self.topic.ReplyID) {
//                    
//                 MHComment *comment = [[MHComment alloc] init];
//                 comment.HeadImg = dic[@"Result"][@"HeadImg"];
//                 comment.CNickName = self.topic.NickName;
//                 comment.RNickName = dic[@"Result"][@"NickName"];;
//                 comment.ReplyContent = topicString;
//                 comment.ParentID = CommentReplyID;
//                 comment.ReplyID = CommentReplyID;
//                 NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//                 NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//                 comment.ReplyTime = a;
//                
//                    
//                   
//                    
//                [self.infoArr insertObject:comment atIndex:0];
//                
//                [self.tableView reloadData];
//                    
//                return ;
//                
//                }
//             NSInteger tag = 0;
//            for (int i =0; i<self.infoArr.count; i++) {
//                
//                
//                
//                
//                     MHComment *commentFrame = self.infoArr[i];
//                    
//                    if (CommentParentID == commentFrame.ReplyID) {
//                        MHComment *comment = [[MHComment alloc] init];
//                        comment.HeadImg = dic[@"Result"][@"HeadImg"];
//                        comment.CNickName =  commentFrame.RNickName;
//                        comment.RNickName = dic[@"Result"][@"NickName"];;
//                        comment.ReplyContent = topicString;
//                        comment.ParentID = commentFrame.ParentID;
//                        comment.ReplyID = commentFrame.ReplyID;
//                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//                        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//                        comment.ReplyTime = a;
//                        
//                        
//                        [self.infoArr insertObject:comment atIndex:0];
//                       
//                        tag = 5;
//                        break;
//                        
//                    }
//                    
//                
//                
//                if (tag == 5) {
//                    break;
//                }
//        }
            
              
            [self loadData:1 withIsFresh:YES];
            CommentReplyID  = self.topic.ReplyID;
            
            CommentParentID = self.topic.ReplyID;
            


        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
        }
        
        
    } failure:^(id error) {
        [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
        NSLog(@"%@",error);
        
    }];
    
}

-(void)freshLoad{
    
    [self loadData:1 withIsFresh:NO];
    
}

-(void)moreLoad{
    
    [self loadData:2 withIsFresh:NO];
    
}

-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf
{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=10;
    
    if (mothed==1) {//刷新
        
        pageSize=10;//self.infoArr.count>8?self.infoArr.count:
        
         self.pageIndex = 1;
        
    }else{//加载更多
        
        pageSize=10;
        
        self.pageIndex++;
        
    }
      //>0?_mod.WikiID:_mod.ID。ID 和 _mod.WikiID两个。 ID一起用。因为模型混乱防止这个不在用另外一个
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"906" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TopicID":@(_TopicID.WikiID>0?_TopicID.WikiID:_TopicID.ID),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize),@"TypeID":@(2),@"CommentID":@(_topic.ReplyID)} success:^(id json) {
        
        NSLog(@"%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            
            NSArray *arr =  [MHComment objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.infoArr = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.infoArr = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.infoArr addObjectsFromArray:arr];
                }
                
            }
//             self.InfoDetailView.topic = self.topic;
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            
            if (self.infoArr.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                if (self.pageIndex > 1) {
                    self.pageIndex --;
                }

            }
            
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        [self.tableView.mj_header endRefreshing];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0.05;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
