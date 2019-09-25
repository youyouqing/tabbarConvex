//
//  XKTopicHotChildController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicHotChildController.h"
#import "XKHotTopicTableViewCell.h"
#import "XKAddHotTopicController.h"
#import "XKTopicHotDetialController.h"
#import "XKTopicHotBigView.h"
#import "XKVideoBigView.h"
@interface XKTopicHotChildController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)XKTopicHotBigView *bigPhoto;
/**
 发表话题按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

/**
 话题表格
 */
@property (weak, nonatomic) IBOutlet UITableView *topicTable;

/**
 数据源数组
 */
@property (nonatomic,strong) NSMutableArray *dataBigArr;

/**
 当前页数下标
 */
@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic, strong) UIImageView *nullImgeView;

@end


@implementation XKTopicHotChildController
-(XKTopicHotBigView *)bigPhoto
{
    if (!_bigPhoto) {
        _bigPhoto = [[[NSBundle mainBundle] loadNibNamed:@"XKTopicHotBigView" owner:self options:nil] lastObject];
        _bigPhoto.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
      
    }
    return _bigPhoto;
}
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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topicTable.delegate = self;
    self.topicTable.dataSource = self;
    
    self.topicTable.showsVerticalScrollIndicator = NO;
    self.topicTable.showsHorizontalScrollIndicator = NO;
    
    self.topicTable.tableFooterView = [UIView new];
    
    //预设cell高度
    self.topicTable.estimatedRowHeight = 100;
    
    self.dataBigArr = [NSMutableArray arrayWithCapacity:0];
    
    //打开自动计算行高
    self.topicTable.rowHeight = UITableViewAutomaticDimension;
    
    [self.topicTable registerNib:[UINib nibWithNibName:@"XKHotTopicTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.topicTable.separatorColor = [UIColor getColor:@"d8d8d8"];
    self.pageIndex = 1;
    
    self.topicTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTopics)];
    
    self.topicTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreTopics)];
    
    
    
    [self.view addSubview:self.nullImgeView];
//    self.nullImgeView.alpha = 0;
//    [self loadData:1 withIsFresh:YES];

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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.nullImgeView.alpha = 0;
//    [self loadData:1 withIsFresh:YES];
     NSLog(@"--内存过多----");
//    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
//    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
}

#pragma mark   请求数据变更
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf{
    self.nullImgeView.alpha = 0;
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=8;
    
    if (mothed==1) {//刷新
        
        pageSize=8;//self.dataBigArr.count>0?self.dataBigArr.count:8;
        self.pageIndex = 1;
    }else{//加载更多
        
        pageSize=8;
        
        self.pageIndex++;
        
    }
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];//话题类别编号 未选择分类时为0    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"901" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TopicTypeID":@(self.model.TypeID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"901--%li--------------%@",self.model.TypeID,json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            NSArray *arr =  [XKTopicModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.dataBigArr = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.dataBigArr = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.dataBigArr addObjectsFromArray:arr];
                }
                
            }
            
            if (self.dataBigArr.count == 0) {
                self.nullImgeView.alpha = 1;
            }else{
                self.nullImgeView.alpha = 0;
            }
            
            [self.topicTable reloadData];
            
            [self.topicTable.mj_header endRefreshing];
            // 结束刷新
            [self.topicTable.mj_footer endRefreshing];
            
            
            if (self.dataBigArr.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.topicTable.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            [self.topicTable.mj_header endRefreshing];
            // 结束刷新
            [self.topicTable.mj_footer endRefreshing];
        }
        
    } failure:^(id error) {
        
        NSLog(@"--444444444-----%@",error);
//        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        [self.topicTable.mj_header endRefreshing];
        // 结束刷新
        [self.topicTable.mj_footer endRefreshing];
    }];
    
    
}

-(void)changeHotTopicChildDataSoure:(XKTopicModel *)mdoel{
    
    for (int i= 0; i< self.dataBigArr.count; i++) {
        XKTopicModel *topic = self.dataBigArr[i];
        if (topic == mdoel) {
            [self.dataBigArr replaceObjectAtIndex:i withObject:mdoel];
            [self.topicTable reloadData];
            
            break;
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataBigArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XKHotTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataBigArr[indexPath.row];
    
    cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XKTopicHotDetialController *detail = [[XKTopicHotDetialController alloc] init];
    
    XKTopicModel *model =   self.dataBigArr[indexPath.row];
    detail.modelID =  model.TopicID;
    
    
    detail.didRefreshPageBlock = ^(BOOL isSuccess) {
        if (isSuccess == YES) {
            self.nullImgeView.alpha = 0;
            [self loadData:1 withIsFresh:YES];
        }
    };
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)jumpTopTopicBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
{

    if (publishFlag == 1) {
        
        self.bigPhoto.photoArray = photoArray;
        self.bigPhoto.photoSizeArray = sizeArr;
        self.bigPhoto.currentPage = page;
        [[UIApplication sharedApplication].keyWindow addSubview:self.bigPhoto];
    }else if (publishFlag == 2)
    {
        
        
//        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBigView];
        
    }
//    XKVideoBigView *video = [[[NSBundle mainBundle] loadNibNamed:@"XKVideoBigView" owner:self options:nil] lastObject];
}

/**
 @param sender 发表话题
 */
- (IBAction)clickPublishHotToip:(id)sender {
    
    NSLog(@"发表话题");
  
    XKAddHotTopicController *addTopic = [[XKAddHotTopicController alloc] init];
    
    addTopic.myTitle = @"我要提问";
    
    addTopic.typeArray = self.typeArray;
    addTopic.didRefreshPageBlock = ^(BOOL isSuccess,NSInteger typeId) {
        if (isSuccess == YES) {
            self.nullImgeView.alpha = 0;
            NSLog(@"-发表话题typeId---------%li",typeId);

//            for (XKHealthPlanModel *model in self.typeArray) {
//                if (model.TypeID == typeId) {
//                     self.model.TypeID = typeId;
                    [self loadData:1 withIsFresh:YES];
//                    break;
//                }
//            }

        }
    };
    [self.navigationController pushViewController:addTopic animated:YES];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"--内存过多--在使用SDWebImage加载较多图片造成内存警告时，定期调用--");
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];//在使用SDWebImage加载较多图片造成内存警告时，定期调用
}

@end
