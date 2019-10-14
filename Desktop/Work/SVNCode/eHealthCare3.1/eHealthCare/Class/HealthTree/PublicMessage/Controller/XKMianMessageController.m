//
//  XKMianMessageController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMianMessageController.h"
#import "XKMianMessageCellOther.h"
#import "XKMianMessageCellSelf.h"
#import "XKMianMessageTitleView.h"
#import "XKMineReplyMod.h"
#import "XKTopicHomeController.h"
#import "XKInfomationViewController.h"
#import "XKTopicHotDetialController.h"
#import "XKInformationDetail.h"
@interface XKMianMessageController ()<XKMianMessageCellSelfDelegate,XKMianMessageTitleViewDelegate,XKMianMessageCellOtherDelegate>
{

    NSInteger selectedTag;
    NSInteger xkMineReplyModID;
    
    UITextField *xkMineReplyModText;

}
@property (nonatomic,strong) XKMianMessageTitleView *titileView;

@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic , strong) NSMutableArray * infoArr;

@property (nonatomic, strong) UIImageView *nullImgeView;

@property (nonatomic , strong)XKMineReplyMod *XKMineReplyMod;
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation XKMianMessageController
/**
 懒加载空数据展示图片
 */
-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
        _nullImgeView.image = [UIImage imageNamed:@"none"];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}

-(NSMutableArray *)infoArr
{
    
    if (!_infoArr) {
        _infoArr = [[NSMutableArray alloc]init];
    }
    return _infoArr;
    
}
-(XKMianMessageTitleView *)titileView{
    
    if (!_titileView) {
        _titileView = [[[NSBundle mainBundle] loadNibNamed:@"XKMianMessageTitleView" owner:self options:nil] firstObject];
        _titileView.x = (KScreenWidth - 200)/2.0;
        _titileView.y = ((PublicY)-40);
        _titileView.width = 200;
        _titileView.height = 30;
        _titileView.delegate = self;
    }
    return _titileView;
}
-(void)clickBtn:(NSInteger)viewTag;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });

    selectedTag = viewTag;
    
     self.pageIndex=1;
    
    [self loadData:1 withIsFresh:YES selectedTag:selectedTag];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });

}
-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });

}
-(UITableView *)tableView
{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kbackGroundGrayColor;
        _tableView.estimatedRowHeight = 110;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.separatorColor=[UIColor clearColor];
        
    }
    return _tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.pageIndex=1;
    self.XKMineReplyMod = [[XKMineReplyMod alloc]init];
    
     [self.view addSubview: self.tableView];
    [self.view addSubview: self.titileView];
    
    if (self.isTopic == 1) {//1是话题。  0是咨询
        selectedTag = 0;
        
    
    }else
    {
        
        selectedTag = 1;
    }
    self.pageIndex=1;
    self.titileView.tagSege.selectedSegmentIndex = selectedTag;
    [self loadData:1 withIsFresh:YES selectedTag:selectedTag];
  
    [self.tableView registerNib:[UINib nibWithNibName:@"XKMianMessageCellOther" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XKMianMessageCellSelf" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    [self.leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    [self loadData:1 withIsFresh:YES selectedTag:selectedTag];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:@"willHideXKInputeBorad" object:nil];
    
    [self.view addSubview:self.nullImgeView];
    self.nullImgeView.alpha = 0;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
-(void)clickBack
{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)freshLoad{
    
    [self loadData:1 withIsFresh:NO selectedTag:selectedTag];
    
}

-(void)moreLoad{
    
    [self loadData:2 withIsFresh:NO selectedTag:selectedTag];
    
}
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf selectedTag:(NSInteger)selecte
{
    self.nullImgeView.alpha = 0;
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=10;
    
    if (mothed==1) {//刷新
        
        pageSize=10;//self.infoArr.count>0?self.infoArr.count:8;
        self.pageIndex = 1;
        
    }else{//加载更多
        
        pageSize=10;
        
        self.pageIndex++;
        
    }
    NSString *urlString = [[NSString alloc]init];
    
    
    if (selecte == 0) {
        urlString = @"923";
    }
    else
      urlString = @"924";
    
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:urlString parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"923:924-%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            
            NSArray *arr =  [XKMineReplyMod objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.infoArr = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.infoArr = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.infoArr addObjectsFromArray:arr];
                }
                
            }
            
            if (self.infoArr.count == 0) {
                self.nullImgeView.alpha = 1;
            }else{
                self.nullImgeView.alpha = 0;
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            
            if (self.infoArr.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                
                if (self.pageIndex >1) {
                    self.pageIndex -- ;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XKMineReplyMod *model = self.infoArr[indexPath.row];
    model.ReplySelect = selectedTag;
    if (model.ReplyType == 3) {
        XKMianMessageCellSelf *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    else
    {
    
        XKMianMessageCellOther *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    
    
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });
    
}

-(void)clickLookBtn:(XKMineReplyMod *)model;{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });
    if (model.ReplySelect == 0) {
        
        XKInformationDetail *plan=[[XKInformationDetail alloc]init];
        plan.mod = [[XKWiKIInfoModel alloc]init];
        plan.mod.LinkUrl = model.LinkUrl;
        plan.mod.WikiID = model.ID;
        [self.navigationController pushViewController:plan animated:YES];
        
    }
    if (model.ReplySelect == 1) {
        XKTopicHotDetialController *topic = [[XKTopicHotDetialController alloc]init];
        
        topic.modelID = model.ID;
        [self.navigationController pushViewController:topic animated:YES];
        
        
    }
    

}


-(void)hide:(NSNotification *) noti{

//    NSDictionary *dict = noti.object;

    xkMineReplyModText =  noti.object;
    
    [self upgateComment];

}

- (void)upgateComment{
    
    if (xkMineReplyModText.text.length <= 0) {
//        [IanAlert alertError:@"请输入数据" length:1.0f];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        });
        
        return;
    }
    
    NSInteger TopicID = 0;
    NSInteger ParentID = 0;
    if (xkMineReplyModID == 1) {//话题
        TopicID = self.XKMineReplyMod.ReplyID;
        if (self.XKMineReplyMod.ReplyType ==1) {//1、别人回复我的二级评论
            ParentID = self.XKMineReplyMod.ReplyID;
            TopicID = self.XKMineReplyMod.TopicID;
        }else if (self.XKMineReplyMod.ReplyType == 2){//2、别人回复我发表的话题，
            ParentID = self.XKMineReplyMod.ReplyID;
            TopicID = self.XKMineReplyMod.ReplyID;
        }else if (self.XKMineReplyMod.ReplyType ==3){//3、我发表的话题
            ParentID = 0;
            TopicID = self.XKMineReplyMod.ID;
            return;//返回不让自己产品对自己的话题评论产生回复
        }
    }else{//咨询
        TopicID = self.XKMineReplyMod.TopicID;
    }

    [ProtosomaticHttpTool protosomaticPostWithURLString:@"903" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TopicID":@(TopicID),@"ParentID":@(self.XKMineReplyMod.ReplyID),@"TotalID":@(self.XKMineReplyMod.ID),@"ReplyContent":xkMineReplyModText.text,@"TypeID":@(xkMineReplyModID),@"ReplyImgUrl":@""} success:^(id json) {
        
        NSLog(@"%@",json);
        [[XKLoadingView shareLoadingView] hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            
           ShowSuccessStatus(@"回复成功");
            

            [self loadData:1 withIsFresh:NO selectedTag:selectedTag];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"评论失败"];
        }
        
        
    } failure:^(id error) {
        [[XKLoadingView shareLoadingView] errorloadingText:@"评论失败"];
        NSLog(@"%@",error);
        
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    });
    
    
}

-(void)clickCommentBtn:(XKMineReplyMod *)model typeID:(NSInteger)typeID xkMineReplyModTex:(UITextField *)xkMineReplyModTex;
{
    self.XKMineReplyMod  = model;
    
     /*1、话题   2、资讯*/
    xkMineReplyModID = typeID;
    

    
}

@end