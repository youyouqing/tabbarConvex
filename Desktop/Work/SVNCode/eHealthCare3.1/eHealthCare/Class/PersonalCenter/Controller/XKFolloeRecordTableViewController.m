//
//  XKFolloeRecordTableViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKFolloeRecordTableViewController.h"
#import "XKFollowRecordCell.h"
#import "XKFollowModel.h"
@interface XKFolloeRecordTableViewController ()
@property (nonatomic , strong) NSMutableArray * infoArr;
@property (strong, nonatomic)  UITableView *tableView;


/**
 空白图片
 */
@property(strong,nonatomic)UIImageView *nullImageView;

@property (nonatomic,assign)NSInteger pageIndex;
@end

@implementation XKFolloeRecordTableViewController
-(UIImageView *)nullImageView
{
    if (!_nullImageView) {
        _nullImageView = [[UIImageView alloc]init];
        _nullImageView.frame = CGRectMake(0, 0, KScreenWidth /2.75, KScreenWidth /2.75);
        _nullImageView.image = [UIImage imageNamed:@"none_dataImage"];
        _nullImageView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
    }
    return _nullImageView;
}
-(NSMutableArray *)infoArr
{
    
    if (!_infoArr) {
        _infoArr = [[NSMutableArray alloc]init];
    }
    return _infoArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

     self.pageIndex=1;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor getColor:@"f7f7f7"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKFollowRecordCell" bundle:nil] forCellReuseIdentifier:@"XKFollowRecordCell"];
    
    [self.view addSubview:self.tableView];

    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    
    [self loadData:1 withIsFresh:YES];
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
        
        pageSize=10;//self.infoArr.count>0?self.infoArr.count:8;
        self.pageIndex = 1;
        
    }else{//加载更多
        
        pageSize=10;
        
        self.pageIndex++;
        
    }
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"934" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            
            NSArray *arr =  [XKFollowModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.infoArr = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.infoArr = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.infoArr addObjectsFromArray:arr];
                }
                
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            
            if (self.infoArr.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
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


-(void)back{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.infoArr.count == 0) {
        return KScreenHeight;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (self.infoArr.count == 0) {
        
        UIView *ivew = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [ivew addSubview:self.nullImageView];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-110)/2.0, self.nullImageView.frame.origin.y+self.nullImageView.frame.size.height, 110, 20)];
        
        
        lab.text = @"暂无随访";
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.textColor = [UIColor getColor:@"959595"];
        
        lab.font = [UIFont systemFontOfSize:14.f];
        
        [ivew addSubview:lab];
        
        return ivew;
    }
     return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return self.infoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"XKFollowRecordCell";
    
    XKFollowRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.infoArr[indexPath.row];
    
    return cell;
}




@end
