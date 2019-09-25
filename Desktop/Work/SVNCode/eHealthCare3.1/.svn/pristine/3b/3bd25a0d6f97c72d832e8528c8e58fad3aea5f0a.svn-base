//
//  JudgeReportController.m
//  eHealthCare
//
//  Created by xiekang on 16/12/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JudgeReportController.h"
#import "JudgeReportCell.h"
#import "CheckResult.h"
#import "TestResultViewController.h"

@interface JudgeReportController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (nonatomic, strong) UIImageView *nullImgeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (strong, nonatomic) NSMutableArray *headViewDataArray;

/**
 控制当前页的下标
 */
@property (nonatomic,assign)NSInteger pageIndex;

@property (nonatomic,strong)NSMutableArray *resultArray;

@end

@implementation JudgeReportController
-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KScreenWidth /2.15, KScreenWidth /2.15, KScreenWidth /2.15)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
        _nullImgeView.image = [UIImage imageNamed:@"none_dataImage"];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.pageIndex=1;
  
    self.topCons.constant = PublicY;
  
    [self.mytable registerNib:[UINib nibWithNibName:@"JudgeReportCell" bundle:nil] forCellReuseIdentifier:@"JudgeReportCell"];
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.resultArray=[NSMutableArray arrayWithCapacity:0];
    
    self.mytable.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.mytable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    
    [self loadData:1 withisFresh:YES];
    
    self.mytable.showsVerticalScrollIndicator=NO;
    self.mytable.showsHorizontalScrollIndicator=NO;
    self.mytable.separatorColor=[UIColor clearColor];
    
}

-(void)freshLoad{
    
    [self loadData:1 withisFresh:NO];
    
}

-(void)moreLoad{
    
    [self loadData:2 withisFresh:NO];
    
}
/**加载数据的方法 1.下拉刷新 2.上啦加载更多**/
-(void)loadData:(NSInteger)mothed withisFresh:(BOOL) isf{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger size=8;
    
    if (mothed==1) {//刷新
        
        if (self.resultArray.count==0) {
            
            size=8;
            
        }else{
            
            size=self.resultArray.count;
            
        }
        
    }else{//加载更多
        
        size=8;
        
        self.pageIndex++;
        
    }
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    //获取资讯列表的信息
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"138" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(size)} success:^(id json) {
        
        NSLog(@"138-%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
             
            [[XKLoadingView shareLoadingView] hideLoding];
            
            if (mothed==2) {
                
                if (self.resultArray.count>=[[json objectForKey:@"Rows"] integerValue]&&self.pageIndex>1) {
                    
                    self.pageIndex--;
                    
                    [self.mytable.mj_header endRefreshing];
                    // 结束刷新
                    [self.mytable.mj_footer endRefreshing];
                    
                }else{
                    
                    self.pageIndex=1;
                    
                }
                
            }
            
            NSArray *list=[CheckResult objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
             self.headViewDataArray = [NSMutableArray arrayWithArray:[json objectForKey:@"Result"]];
            if (mothed==1) {
                
                self.resultArray=(NSMutableArray *)list;
                
            }else{
                
                [self.resultArray addObjectsFromArray:list];
                
            }
            
            [self.view addSubview:self.nullImgeView];
            [self.mytable reloadData];
            
            [self.mytable.mj_header endRefreshing];
            // 结束刷新
            [self.mytable.mj_footer endRefreshing];
            
            if (self.resultArray.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.mytable.mj_header endRefreshing];
                // 结束刷新
                [self.mytable.mj_footer endRefreshing];
                
                [self.mytable.mj_footer endRefreshingWithNoMoreData];
                
            }else{
                
                self.mytable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
                
            }
        
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.resultArray.count==0) {
        self.nullImgeView.alpha = 1;
    }else{
        self.nullImgeView.alpha = 0;

    }
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JudgeReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JudgeReportCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.result=self.resultArray[indexPath.row];
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    XKResultViewController *resultCon=[[XKResultViewController alloc]init];
//    resultCon.msgModel=self.resultArray[indexPath.row];
//    resultCon.isOriginal=NO;
//    [self.navigationController pushViewController:resultCon animated:YES];
//    ReadyTestViewController *test = [[ReadyTestViewController alloc]initWithType:pageTypeNormal];
//
//    test.myTitle = @"健康自测";
//
    
    CheckResult *mod = self.resultArray[indexPath.row];
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    if (mod.listModel.IsCorporeity == 1) {
         web.urlString = [NSString stringWithFormat:@"%@&AnswerID=%li",kHealthTestNineTypeResultUrl,mod.AnswerID];
    }else
         web.urlString = [NSString stringWithFormat:@"%@&TestSetId=%li&AnswerID=%li",kHealthTestResultUrl,mod.listModel.SetCategoryId,mod.AnswerID];
   
   
    web.myTitle = @" ";
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
  
//    TestResultViewController *result = [[TestResultViewController alloc]initWithType:pageTypeNormal];
//    result.myTitle = @"健康自测";
//    CheckResult *mod = self.resultArray[indexPath.row];
////    for (NSDictionary *dic in self.headViewDataArray)
////    {
////        NSString *cateGoryName = dic[@"SetCategoryName"];
////        if ([mod.SetCategoryName isEqualToString:cateGoryName])
////        {
//            result.dataDic = [mod mj_keyValues] ;//dic;//
////        }
////    }
//    NSLog(@"健康自测:%@",result.dataDic);
//    [self.navigationController pushViewController:result animated:YES];
}


@end
