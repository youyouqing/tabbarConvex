//
//  PublicViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/18.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PublicViewController.h"
#import "MessagePublicCell.h"
#import "NewWikiModel.h"
#import "NewFamilyAddMessagMod.h"
#import "NewHealthNoticeMod.h"
#import "MessagePublicModel.h"
#import "FriendMessageController.h"
#import "XKMianMessageController.h"
@interface PublicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) MessagePublicModel *publicModel;
@property (nonatomic, strong) NSMutableArray *publicDataArr;
@end

@implementation PublicViewController
#pragma mark - 获取数据
-(void)loadPublicFromBase
{
    if ([[EGOCache globalCache] hasCacheForKey:@"messagePublicDic"]) {
        NSDictionary *dic = (NSDictionary *) [[EGOCache globalCache]objectForKey:@"messagePublicDic"];
         self.publicModel = [MessagePublicModel mj_objectWithKeyValues:dic[@"Result"]];
        
        [self dealWithPublicDic];
        
       
    }
}
//处理公告数据
-(void)dealWithPublicDic
{
    self.publicModel.NewNotice.imageName = @"icon_meaasge_gonggao";
    self.publicModel.NewHealthNotice.imageName = @"icon_meaasge_jiankang";
    self.publicModel.NewTopicMessage.imageName = @"icon_meaasge_huati";
    self.publicModel.NewWikiMessage.imageName = @"icon_meaasge_zixun";
    self.publicModel.NewFamilyAddMessage.imageName = @"icon_meaasge_haoyou";
    
    self.publicModel.NewNotice.TitleName = @"系统公告消息";
    self.publicModel.NewHealthNotice.TitleName = @"健康消息";
    self.publicModel.NewTopicMessage.TitleName = @"话题交流信息";
    self.publicModel.NewWikiMessage.TitleName = @"健康资讯消息";
    self.publicModel.NewFamilyAddMessage.TitleName = @"申请添加消息";
    NSMutableArray *tempARR =[NSMutableArray arrayWithArray:@[self.publicModel.NewNotice.NoticeTitle.length>0?self.publicModel.NewNotice:[NSNull null],self.publicModel.NewHealthNotice.NoticeTitle.length>0?self.publicModel.NewHealthNotice:[NSNull null],self.publicModel.NewTopicMessage.TopicTitle.length>0?self.publicModel.NewTopicMessage:[NSNull null],self.publicModel.NewWikiMessage.TopicTitle.length>0?self.publicModel.NewWikiMessage:[NSNull null],self.publicModel.NewFamilyAddMessage.FamilyAddTitle.length>0?self.publicModel.NewFamilyAddMessage:[NSNull null]]];
    
    
    self.publicDataArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0;i<tempARR.count;i++) {
        
        if (![tempARR[i] isKindOfClass:[NSNull class]]) {
            NSMutableDictionary *tempDic =  [tempARR[i] mj_keyValues];
             NewWikiModel *new =  [NewWikiModel mj_objectWithKeyValues:tempDic];
             new.tagSwith = i;
            [self.publicDataArr addObject:new];
        }
    }
    [self.tableView reloadData];
}

-(void)loadPublicData
{
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@1,@"PageSize":@10};
    
    [[XKLoadingView shareLoadingView]showLoadingText:@"努力加载中..."];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"116" parameters:dict success:^(id json) {
        NSLog(@"消息列表--公告系统消息116：%@",json);
           [[XKLoadingView shareLoadingView] hideLoding];
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
         
            
             self.publicModel = [MessagePublicModel mj_objectWithKeyValues:dic[@"Result"]];
            [self dealWithPublicDic];
 
          
            
            //缓存
            [[EGOCache globalCache]setObject:dic forKey:@"messagePublicDic"];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:error];
    }];
}

#pragma mark UI
- (void)createUI
{
    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kbackGroundGrayColor;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessagePublicCell" bundle:nil] forCellReuseIdentifier:@"MessagePublicCell"];
  
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadPublicData];//刷新已经阅读了资讯和话题数据才刷新数据
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"消息";
      [self createUI];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

     self.titleLab.textColor = kMainTitleColor;
    
    self.publicModel = [[MessagePublicModel alloc]init];
//    [self loadPublicFromBase];//读取公告缓存的数据
     [self loadPublicData];
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readRefresh) name:@"ReadRefresh" object:nil];
}
-(void)readRefresh
{
    [self loadPublicData];
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  self.publicDataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        NSString *cellid = @"MessagePublicCell";
        MessagePublicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//   self.publicModel.NewNotice.NoticeTitle.length>0?self.publicModel.NewNotice:[NSNull null],self.publicModel.NewHealthNotice.NoticeTitle.length>0?self.publicModel.NewHealthNotice:[NSNull null],self.publicModel.NewTopicMessage.TopicTitle.length>0?self.publicModel.NewTopicMessage:[NSNull null],self.publicModel.NewWikiMessage.TopicTitle.length>0?self.publicModel.NewWikiMessage:[NSNull null],self.publicModel.NewFamilyAddMessage.FamilyAddTitle.length>0?self.publicModel.NewFamilyAddMessage:[NSNull null]]
    NewWikiModel *tempMode =  self.publicDataArr[indexPath.row];
//    if (self.publicModel.NewNotice.NoticeTitle.length>0&&tempMode.tagSwith == 0 )  {
        cell.NewNotice = tempMode;
          return cell;
//    }
//   else  if (self.publicModel.NewHealthNotice.NoticeTitle.length>0&&tempMode.tagSwith == 1 ){
////         cell.NewHealthNotice = self.publicModel.NewHealthNotice;
//        cell.NewNotice = tempMode;
//         return cell;
//    }
//   else  if (self.publicModel.NewTopicMessage.TopicTitle.length>0&&tempMode.tagSwith == 2 ) {
////         cell.NewWikiMessage = self.publicModel.NewWikiMessage;
//        cell.NewNotice = tempMode;
//         return cell;
//    }
//   else  if (self.publicModel.NewWikiMessage.TopicTitle.length>0&&tempMode.tagSwith == 3 ) {
////         cell.NewTopicMessage = self.publicModel.NewTopicMessage;
//        cell.NewNotice = tempMode;
//         return cell;
//    }
//   else  if (self.publicModel.NewFamilyAddMessage.FamilyAddTitle.length>0&&tempMode.tagSwith == 4 ){
////         cell.NewFamilyAddMessage = self.publicModel.NewFamilyAddMessage;
//        cell.NewNotice = tempMode;
//         cell.lineLab.hidden = YES;
//         return cell;
//   }
    if (self.publicDataArr.count-1==indexPath.row) {

    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.publicModel.NewNotice.NoticeTitle.length>0&&indexPath.row == 0 ) {
        return KHeight(80);
//    }
//    if (self.publicModel.NewHealthNotice.NoticeTitle.length>0&&indexPath.row == 1 ) {
//        return KHeight(80);
//    }
//    if (self.publicModel.NewTopicMessage.TopicTitle.length>0&&indexPath.row == 2 ) {
//       return KHeight(80);
//    }
//    if (self.publicModel.NewWikiMessage.TopicTitle.length>0&&indexPath.row == 3 ) {
//       return KHeight(80);
//    }
//    if (self.publicModel.NewFamilyAddMessage.FamilyAddTitle.length>0&&indexPath.row == 4 ) {
//        return KHeight(80);
//    }
//    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewWikiModel *tempMode =  self.publicDataArr[indexPath.row];
    if (tempMode.tagSwith == 0) {
         NewPublicViewController *publicVC = [[NewPublicViewController alloc]initWithType:pageTypeNormal];
          publicVC.isPublic = YES;
          [self.navigationController pushViewController:publicVC animated:YES];
    }
    if (tempMode.tagSwith == 1) {
        NewPublicViewController *publicVC = [[NewPublicViewController alloc]initWithType:pageTypeNormal];
        publicVC.isPublic = NO;
        [self.navigationController pushViewController:publicVC animated:YES];
    }
    if (tempMode.tagSwith == 2||tempMode.tagSwith == 3) {
       
        XKMianMessageController *VC = [[XKMianMessageController alloc]initWithType:pageTypeNormal];
        VC.isTopic = indexPath.row - 2;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    if (tempMode.tagSwith == 4) {
        FriendMessageController *VC = [[FriendMessageController alloc]initWithType:pageTypeNormal];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return [[UIView alloc]init];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6.f;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
