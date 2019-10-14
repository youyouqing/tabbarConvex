//
//  QuietController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/24.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "QuietController.h"
#import "QuietTableViewCell.h"
#import "MusicTableViewCell.h"
#import "TrainWithMusicViewController.h"
#import "MusicTrainViewModel.h"
#import "MusicTrainModel.h"
#import "XKMusicViewController.h"
@interface QuietController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSMutableArray *dataArr;
@property(strong,nonatomic) UITableView *tableView ;
@property(strong,nonatomic)NSMutableArray *topicArr;
///早安 晚安 正念等数据
@property (nonatomic, strong) NSArray *musicTrainDataArray;
@end

@implementation QuietController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.myTitle = (self.isQuietOrMusic == YES)?@"安静默想":@"自然音乐";
    self.dataArr = (self.isQuietOrMusic == YES)?[NSMutableArray arrayWithArray:@[@"iv_ajmx",@"iv_hjyl",@"iv_znxl",]]:[NSMutableArray arrayWithCapacity:0];//@[@"iv_nature_slqc",@"iv_nature_qtdy",@"iv_nature_dxzc",@"iv_nature_hscr",@"iv_nature_ywql",@"iv_nature_hbmb",@"iv_nature_qgqs",@"iv_nature_xhfw"]
    self.titleLab.textColor = kMainTitleColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view.backgroundColor = kbackGroundGrayColor;
    
    tableView.backgroundColor = kbackGroundGrayColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"QuietTableViewCell" bundle:nil] forCellReuseIdentifier:@"QuietTableViewCell"];
      [tableView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:nil] forCellReuseIdentifier:@"MusicTableViewCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.left.mas_equalTo(0 );
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo( CGRectGetWidth(self.view.frame));
    }];
    tableView.estimatedRowHeight = 110;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self loadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isQuietOrMusic) {
        NSString *cellid = @"QuietTableViewCell";
        QuietTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backImage.image = [UIImage imageNamed:self.dataArr[indexPath.row]];
        return cell;
    }else
    {
        
        NSString *cellid = @"MusicTableViewCell";
        MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backImage.image = [UIImage imageNamed:self.dataArr[indexPath.row]];
        [cell.backImage sd_setImageWithURL:[NSURL URLWithString:self.dataArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"MusicTrain_placeHolderImage"]];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     [self getSuitDataToSuitTypetrainType:indexPath.row topicArr: self.topicArr];
}
-(void)loadData{
    
    
//    ShowNormailMessage(@"正在配置环境，请稍等...");
      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    [MusicTrainViewModel getMorningEverningAndMindfulnessListWithParams:dic FinishedBlock:^(ResponseObject *response) {
//        DismissHud();
           [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            self.musicTrainDataArray = [MusicTrainModel objectArrayWithKeyValuesArray:response.Result];
            self.topicArr = [NSMutableArray array];
            for (MusicTrainModel *dicMod in self.musicTrainDataArray)
            {
                //筛选出TopicDataArray
                if (dicMod.EaseType  == 1 ||dicMod.EaseType  == 2)
                {
                    [ self.topicArr addObject:dicMod];///筛选出了正念训练 安静调节等topic资源
                    if (self.isQuietOrMusic == NO) {
                         [self.dataArr addObject:dicMod.TitleImgUrl];
                    }
                   
                }
            }
            [self.tableView reloadData];
            
            
           
            
        }else{
            ShowErrorStatus(response.msg);
        }
    }];

}
- (void)getSuitDataToSuitTypetrainType:(NSInteger)trainType topicArr:(NSMutableArray *)topicArr;
{
    

    NSMutableArray *topicMArray = [NSMutableArray array];
    

    if (self.isQuietOrMusic) {
        XKMusicViewController *music = [[XKMusicViewController alloc]initWithType:pageTypeNormal];
        for (MusicTrainModel *dicMod in self.musicTrainDataArray)
        {
            //筛选出TopicDataArray
            if (dicMod.EaseType  == 3 && dicMod.MindfulnessType  == trainType+1)
            {
                [topicMArray addObject:dicMod];///筛选出了正念训练 安静调节等topic资源
            }
            
        }
        music.musicArray = topicMArray;
        [self.navigationController pushViewController:music animated:YES];
    }else
    {
        TrainWithMusicViewController *train = [[TrainWithMusicViewController alloc]initWithType:pageTypeNoNavigation];
//        train.TopicDataArray = [NSArray arrayWithArray:topicMArray];
        train.model = topicArr[trainType];
        [self.navigationController pushViewController:train animated:YES];

    }
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