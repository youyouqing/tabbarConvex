//
//  XKInformationDetail.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "XKInformationDetail.h"
#import "TopicCell.h"
#import "MHComment.h"
#import "MHCommentFrame.h"
#import "XKWikiDetailMod.h"
#import "XKInformationDetailController.h"
#import "XKInformationCancelView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "XKInfoEntityMod.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "XKValidationAndAddScoreTools.h"
CGFloat const TitilesViewY = 0;
CGFloat const TitilesViewH = 0;
/** 最大字数 */
NSInteger const CommentMaxWords  = 300  ;
@interface XKInformationDetail ()<UITableViewDelegate,UITableViewDataSource,XKInformationCancelViewDelegate,TopicCellDelegate,UIWebViewDelegate>
{
    NSInteger CommentReplyID;
    NSInteger CommentParentID;
}
/**
 星星收藏按钮
 */
@property (strong, nonatomic)UIButton *starbtn;


/**
 网页
 */
@property (strong, nonatomic)  UIWebView *usWeb;

/** 上一次的偏移值 */
@property (nonatomic , assign) CGFloat lastContentOffsetY;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


/** MHTopicFrame 模型 */
@property (nonatomic , strong) NSMutableArray *topicFrames;

@property (nonatomic,assign)NSInteger pageIndex;

/**
 底部试图容器
 */
@property (weak, nonatomic) IBOutlet UIView *infoView;
/**
 回复 确定 试图
 */
@property (strong, nonatomic)  XKInformationCancelView *backView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopCons;
@property (nonatomic , strong)XKInfoEntityMod *entitlrMod;
@property (nonatomic, assign) float webViewHeight;
@end

@implementation XKInformationDetail
- (NSMutableArray *)topicFrames
{
    if (_topicFrames == nil) {
        _topicFrames = [[NSMutableArray alloc] init];
    }
    return _topicFrames;
}

- (XKInformationCancelView *)backView
{
    if (_backView == nil) {
      
        _backView = [[NSBundle mainBundle]loadNibNamed:@"XKInformationCancelView" owner:nil options:nil].firstObject;
        _backView.x = 0;
        _backView.y = 0.5;
        _backView.width = self.tableView.frame.size.width;
        _backView.height = 60;
        _backView.delegate = self;
        _backView.isTopic = NO;
    }
    return _backView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     self.automaticallyAdjustsScrollViewInsets = false;
    
     self.myTitle = @"资讯详情";
    self.tableViewTopCons.constant = PublicY;
     self.pageIndex=1;
    
     self.entitlrMod = [[XKInfoEntityMod alloc]init];
    
     [self _setup];
  
   
    
    // 初始化子控件
    [self _setupTableView];
  
    
    [self.infoView addSubview:self.backView];
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    // 请求数据放在这里 [self loadData];
    [self loadData:1 withIsFresh:NO];
    

    
    //去掉评论是按钮键盘的完成
    self.backView.myTextView.inputAccessoryView = [UIView new];
  
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTapBySureBtn)];
//    
//    [self.view addGestureRecognizer:tap];
    
    //改变系统线条颜色
    [self.tableView setSeparatorColor:[UIColor getColor:@"d8d8d8"]];
 


}
-(void)removeTapBySureBtn
{

    [self.view endEditing:YES];
    


}

#define headWebHeight 80.0f
#define interval 10.0f
#pragma mark -  初始化数据，假数据
- (NSInteger) mh_randomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}
-(void)freshLoad{
    
    [self loadData:1 withIsFresh:NO];
    
}

-(void)moreLoad{
    
    [self loadData:2 withIsFresh:NO];
    
}

#pragma mark   request
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf
{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=10;
    
    if (mothed==1) {//刷新
        
        pageSize=10;//self.topicFrames.count>=8?self.topicFrames.count:
        
        self.pageIndex = 1;
        
    }else{//加载更多
        
        pageSize=10;
        
        self.pageIndex++;
        
    }
    
    
    NSLog(@"%li----pageIndex-----%li",self.pageIndex,mothed);

      //>0?_mod.WikiID:_mod.ID。ID 和 _mod.WikiID两个。 ID一起用。因为模型混乱防止这个不在用另外一个
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"910" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TopicID":@(_mod.WikiID>0?_mod.WikiID:_mod.ID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"910%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
           
            if (isf) {
                
               [[XKLoadingView shareLoadingView] hideLoding];
                
            }
            
           
            self.entitlrMod =  [XKInfoEntityMod objectWithKeyValues:[json objectForKey:@"Result"][@"WikiDetailEntity"]];
            self.starbtn.selected = self.entitlrMod.isCollect;
            
//            self.currentModel = [XKTopicModel objectWithKeyValues:[json objectForKey:@"Result"][@"TopicDetailEntity"]];
            
            NSArray *arr1 =  [MHTopic objectArrayWithKeyValuesArray:[json objectForKey:@"Result"][@"FirstCommentList"]];
          
            
            
            NSMutableArray *bigArr = [[NSMutableArray alloc]init];
            for (int i =0; i<arr1.count; i++) {
                MHTopic *topic = arr1[i];
                 NSArray *arr2 =   topic.SecondCommentList;
                for (NSInteger j = 0; j<arr2.count; j++) {
                    MHComment *comment = arr2[j];
                    
                    [topic.comments addObject:comment];
                }
                
                [bigArr addObject:[self _topicFrameWithTopic:topic]];
                
            }
            
            
            if (mothed==1) {
                
                
                      self.topicFrames = bigArr;
               
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.topicFrames = bigArr;
                    
                }else{
                    
                    [self.topicFrames addObjectsFromArray:bigArr];
                }
                
            }
            
            
            CommentReplyID  = _mod.WikiID;
            
            CommentParentID = 0;
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            
            if (self.topicFrames.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                
                
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
- (MHTopicFrame *)_topicFrameWithTopic:(MHTopic *)topic
{
    MHTopicFrame *topicFrame = [[MHTopicFrame alloc] init];
    // 传递微博模型数据，计算所有子控件的frame
    topicFrame.topic = topic;
    
    return topicFrame;
}
#pragma mark - 初始化
- (void)_setup
{

    self.usWeb = [[UIWebView alloc]initWithFrame:CGRectZero];
    
    NSString *urlStr=[NSString stringWithFormat:@"%@",_mod.LinkUrl];
    
    self.usWeb.delegate=self;
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self.usWeb loadRequest:request];
    self.usWeb.scrollView.showsHorizontalScrollIndicator = NO;
    self.usWeb.scrollView.scrollEnabled = NO;
    
    
//    [self.usWeb.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

}

//移除观察者

-(void)dealloc

{
    
//    [self.usWeb.scrollView removeObserver:self
    
//                                     forKeyPath:@"contentSize" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    CGFloat height1 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
    CGFloat wid = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth;"] floatValue];
    webView.frame = CGRectMake(0, 0, KScreenWidth, height1);//*[UIScreen mainScreen].bounds.size.width/wid

    
    UIScrollView *tempView = (UIScrollView *)[webView.subviews objectAtIndex:0];
    
    tempView.scrollEnabled = NO;
//    self.tableView.tableHeaderView.frame = webView.frame;
 
    NSLog(@"123让人%f---%f----", height1,wid);
    
    

    NSString *JS=@"getBodyHeight()"; //准备执行的js代码

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
          CGFloat height2 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
        
         NSLog(@"height2%f----", height2);
         [[XKLoadingView shareLoadingView]hideLoding];
    });
    
    NSString *JSAler = [self.usWeb stringByEvaluatingJavaScriptFromString:JS];
    webView.height = [JSAler floatValue];
     [self.tableView reloadData];
   
    NSLog(@"问问%f----%f", webView.scrollView.contentSize.height,webView.frame.size.height);
   
//    webView.backgroundColor = [UIColor redColor];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[XKLoadingView shareLoadingView] hideLoding];
}

#pragma mark - 设置子控件

- (void)_setupTableView
{
    
    self.starbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.starbtn setImage:[UIImage imageNamed:@"collect2"]  forState:UIControlStateSelected];
    [self.starbtn setImage:[UIImage imageNamed:@"collect"]  forState:UIControlStateNormal];
   
    
    [self.starbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [btn2 setImage:[UIImage imageNamed:@"share"]  forState:UIControlStateNormal];
  
    
    [btn2 addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    
   
    [self.headerView addSubview:self.starbtn];
    [self.headerView addSubview:btn2];
    [self.starbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-12-50);
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(40);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(40);
    }];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
}
//实现接收到通知时的操作

-(void) keyBoardChange:(NSNotification *)note

{
    if (self.backView.myTextView.text.length ==  0) {
        self.backView.textViewLal.hidden = NO;
    }
    else
        self.backView.textViewLal.hidden = YES;
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
            
            
           
        }
        
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicFrames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
//   _usWeb.scrollView.contentSize.height
     return _usWeb.frame.size.height;
//    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.01;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:self.usWeb.frame];
    
   
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.usWeb];
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-10, KScreenWidth, 10)];
    view1.backgroundColor = [UIColor getColor:@"f7f7f7"];
    [view addSubview:view1];
    
    return view;
    ;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHTopicFrame *topicFrame = self.topicFrames[indexPath.row];
   
    if (topicFrame.tableViewFrame.size.height==0) {
        return topicFrame.height+topicFrame.tableViewFrame.size.height+20;
    }
    else  if (topicFrame.topic.comments.count>3){
        return topicFrame.height+topicFrame.tableViewFrame.size.height+30+35;/**  话题垂直方向间隙 */
    }
    else{
        return topicFrame.height+topicFrame.tableViewFrame.size.height+20+5;/**  话题垂直方向间隙 */
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"topicCellId";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //    cell.textLabel.text = [NSString stringWithFormat:@"%@ **  %zd" , self.title , indexPath.row];
    MHTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    cell.topicFrame = topicFrame;
    cell.delegate = self;
    cell.infoTableView =tableView;
    cell.cellId = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    [self removeTapBySureBtn];
    
    
}



- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != self.tableView) {
        return;
    }
    
    
}
#pragma mark - MHTopicCellDelegate
- (void) topicCell:(TopicCell *)topicCell  didSelectMore:(NSInteger )indexPathSection;
{

    XKInformationDetailController *con  = [[XKInformationDetailController alloc]initWithType:pageTypeNormal];
    MHTopicFrame *topicFrame = self.topicFrames[indexPathSection];
  
    con.TopicID = _mod;
    con.topic =topicFrame.topic;
    con.changeThumbIsPraise = ^(NSInteger isPraise){
        topicCell.thumbBtn.selected = YES;
        
      
      
        [topicCell.thumbBtn setTitle:[NSString stringWithFormat:@"%li",isPraise] forState:UIControlStateNormal];
       
       

    };
    [self.navigationController pushViewController:con animated:YES];

}
- (void)topicCellForClickedThumbAction:(TopicCell *)topicCell
{

    MHTopic *topic = topicCell.topicFrame.topic;
  
    if (topic.IsPraise == 1) {//已经点赞  返回
        NSLog(@"---点击👍按钮---");
        return;
    }else{//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        //获取首页健康计划、热门话题数据
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"904" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"ReplyID":@(topic.ReplyID),@"TypeID":@(4)} success:^(id json) {
            
            NSLog(@"%@",json);
            [[XKLoadingView shareLoadingView] hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                 ShowSuccessStatus(@"点赞成功");
                 topicCell.thumbBtn.selected = YES;
               
//                //1.点赞数量加一
                topic.PraiseScount+=1;
                [topicCell.thumbBtn setTitle:[NSString stringWithFormat:@"%li",topic.PraiseScount] forState:UIControlStateNormal];
//                
//                //2.更换是否点赞的参数
                 topic.IsPraise = 1;
                
                
            }else{
                  [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);
            
        }];
        
    }

}

- (void)topicCellForClickedMoreAction:(TopicCell *)topicCell
{

    NSLog(@"---点击更多按钮---");
    MHTopicFrame *topicFrame = topicCell.topicFrame;
    
    [self.backView.myTextView becomeFirstResponder];
//    [self.backView.txtField becomeFirstResponder];
    self.backView.myTextView.text = @"";
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复:%@",topicCell.nicknameLable.text];
    
 
    CommentReplyID  = topicFrame.topic.ReplyID;
    
     CommentParentID = CommentReplyID;
    
}


- (void) topicCell:(TopicCell *)topicCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHTopicFrame *topicFrame = topicCell.topicFrame;
    MHCommentFrame *commentFrame = topicFrame.commentFrames[indexPath.row];
    
    [self.backView.myTextView becomeFirstResponder];
//    [self.backView.txtField becomeFirstResponder];
    self.backView.myTextView.text = @"";
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复: %@",commentFrame.comment.RNickName];
    NSLog(@"--点击回复--");
    
    
   CommentReplyID  = topicFrame.topic.ReplyID;
    
   CommentParentID = commentFrame.comment.ReplyID;
    
}
#pragma mark   xkInformationDelegate
- (void)cancelForClicked;
{
    [self.view endEditing:YES];
    
    CommentReplyID  = _mod.WikiID;
    
    CommentParentID = 0;

}
-(void)popToUpViewController
{
    if (_didRefreshPageBlock) {
        _didRefreshPageBlock(YES);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)sureForClickedAction:(NSString *)topicString;
{
//    self.backView.textViewLal.hidden = NO;
//    self.backView.myTextView.text = @"";
//    //        [self bringSubviewToFront:self.myTextView];
//    //        [self bringSubviewToFront:self.textViewLal];
//    [self.backView.myTextView resignFirstResponder];
//    [self.backView.txtField resignFirstResponder];
    if (topicString.length<=0) {
        ShowErrorStatus(@"请输入数据");
        return;
        
    }
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
   

    [ProtosomaticHttpTool protosomaticPostWithURLString:@"903" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TopicID":@(CommentReplyID),@"ParentID":@(CommentParentID),@"TotalID":@(_mod.WikiID>0?_mod.WikiID:_mod.ID),@"ReplyContent":topicString,@"TypeID":@(2),@"ReplyImgUrl":@""} success:^(id json) {
        
        NSLog(@"%@",json);
        [[XKLoadingView shareLoadingView] hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {

            
            if (CommentParentID == 0) {
                ShowSuccessStatus(@"评论成功");
            }
            else
             ShowSuccessStatus(@"回复成功");
           
            XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
            [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(17)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(17)} isPopView:YES];
            
            self.backView.textViewLal.text = @"我也说一句～";
           
            
          
//
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            NSDictionary *dic = [user objectForKey:@"mineInfo"];
//            NSArray *arr1 =  self.topicFrames;
//            if (CommentParentID == 0) {
//                MHTopic *topic = [[MHTopic alloc] init];
//                topic.IsPraise = 0;
//                topic.PraiseScount = 0;
//                topic.ReplyScount = 0;
//                NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//                NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//                topic.ReplyTime = a;
//                topic.NickName = dic[@"Result"][@"NickName"];
//                topic.HeadImg = dic[@"Result"][@"HeadImg"];
//                topic.ReplyContent = topicString;
//                topic.ReplyID = CommentParentID;
//                
//                topic.SecondCommentList = @[];
//                topic.comments = [[NSMutableArray alloc]init];
//                
//                [self.topicFrames insertObject:[self _topicFrameWithTopic:topic] atIndex:0];
//                
//                CommentReplyID  = _mod.WikiID;
//                
//                CommentParentID = 0;
//
//                
//                [self.tableView reloadData];
//                
//                return ;
//            }
//
//            for (int i =0; i<arr1.count; i++) {
//              
//                
//              
//                 MHTopicFrame *topicFrame = arr1[i];
//                
//                  MHTopic *topic1 = topicFrame.topic ;
//                
//                
//               if (CommentParentID == topic1.ReplyID) {
//                
//                    MHComment *comment = [[MHComment alloc] init];
//                    comment.HeadImg = dic[@"Result"][@"HeadImg"];
//                    comment.CNickName = topic1.NickName;
//                    comment.RNickName = dic[@"Result"][@"NickName"];;
//                    comment.ReplyContent = topicString;
//                    comment.ParentID = CommentReplyID;
//                    comment.ReplyID = CommentReplyID;
//                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//                    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//                    comment.ReplyTime = a;
//
//
//                    [topic1.comments insertObject:comment atIndex:0];
//                    
//                     [self.topicFrames replaceObjectAtIndex:i withObject:[self _topicFrameWithTopic:topic1] ];
//                   
//                   CommentReplyID  = _mod.WikiID;
//                   
//                   CommentParentID = 0;
//                     [self.tableView reloadData];
//                   return;
//
//                }
//               
//              
//                
//            }
//
//            for (int i =0; i<arr1.count; i++) {
//                
//                
//                
//                MHTopicFrame *topicFrame = arr1[i];
//                
//                MHTopic *topic1 = topicFrame.topic ;
//                NSInteger tag = 0;
//                      for (int j =0; j<topicFrame.commentFrames.count; j++){
//                          MHCommentFrame *commentFrame = topicFrame.commentFrames[j];
//                          
//                          if (CommentParentID == commentFrame.comment.ReplyID) {
//                              MHComment *comment = [[MHComment alloc] init];
//                              comment.HeadImg = dic[@"Result"][@"HeadImg"];
//                              comment.CNickName =  commentFrame.comment.RNickName;
//                              comment.RNickName = dic[@"Result"][@"NickName"];;
//                              comment.ReplyContent = topicString;
//                              comment.ParentID = commentFrame.comment.ParentID;
//                              comment.ReplyID = topicFrame.topic.ReplyID;
//                              NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//                              NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//                              comment.ReplyTime = a;
//                              
//                              
//                               [topic1.comments insertObject:comment atIndex:0];
//                                [self.topicFrames replaceObjectAtIndex:i withObject:[self _topicFrameWithTopic:topic1] ];
//                              tag = 5;
//                              break;
//                              
//                          }
//                          
//                      }
//                      
//                if (tag == 5) {
//                    break;
//                }
//                      
//               
//                
//                
//                
//            }
            CommentReplyID  = _mod.WikiID;
            
            CommentParentID = 0;
            [self loadData:1 withIsFresh:YES];

            
            
            
          
            
//            [self.tableView reloadData];
            
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
        }
        
        
    } failure:^(id error) {
        [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
        NSLog(@"%@",error);
        
    }];

    
    


}


#pragma mark   分享   收藏

-(void)click:(UIButton *)button
{
    NSInteger collect =  !self.starbtn.selected;
      //>0?_mod.WikiID:_mod.ID。ID 和 _mod.WikiID两个。 ID一起用。因为模型混乱防止这个不在用另外一个
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"911" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"WikiID":@(_mod.WikiID>0?_mod.WikiID:_mod.ID),@"CollectFlag":@(collect)} success:^(id json) {
        
        NSLog(@"%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            
            
            if (collect) {
                
                ShowSuccessStatus(@"收藏成功");
            }
            else
                ShowSuccessStatus(@"取消收藏成功");
            
            self.starbtn.selected = collect;
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        
    }];
    
    
    
    
}
/*分享*/
-(void)clickRight
{
    UIImage *tempImage = [self getImage];
    tempImage =[self imageCompressForSize:tempImage targetSize:CGSizeMake(100, 100)];
    NSArray *imageArray = @[tempImage];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.mod.WikiName images:imageArray url:[NSURL URLWithString:self.mod.LinkUrl] title:self.mod.WikiName type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil
                                 items:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                               
                           case SSDKResponseStateBegin:
                           {
                               
                               //                               [IanAlert showLoading:@"分享中..." allowUserInteraction:NO];
                               break;
                           }
                           case SSDKResponseStateSuccess:
                           {
                               //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                               if (platformType == SSDKPlatformTypeFacebookMessenger)
                               {
                                   break;
                               }
                               XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
                               [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(18)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(18)} isPopView:YES];
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               else
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               break;
                           }
                           case SSDKResponseStateCancel:
                           {
                               //                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                               //                                                                                   message:nil
                               //                                                                                  delegate:nil
                               //                                                                         cancelButtonTitle:@"确定"
                               //                                                                         otherButtonTitles:nil];
                               //                               [alertView show];
                               
                               break;
                           }
                           default:
                               break;
                       }
                       
                       if (state != SSDKResponseStateBegin)
                       {
                           [IanAlert hideLoading];
                       }
                       
                   }];
    }
    
}

- (UIImage *)getImage {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenWidth, [UIApplication sharedApplication].keyWindow.height), NO, 0);  //NO，YES 控制是否透明
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}

-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
