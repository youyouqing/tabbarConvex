//
//  NewTrendHomeController.m
//  eHealthCare
//
//  Created by xiekang on 16/12/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewTrendHomeController.h"
#import "NewTrendHomeCell.h"
#import "TrendNewModel.h"
#import "NewTrendDetailController.h"

@interface NewTrendHomeController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *imgDic;
    NSDictionary *imgGrayDic;
}
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UILabel *tipLal;
@end

@implementation NewTrendHomeController
-(UILabel *)tipLal
{
    if (!_tipLal) {
//        _tipLal = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, KScreenWidth - 100, 120)];
        _tipLal = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2.0-90, (KScreenHeight -64)/2.0 -15 , 180, 30)];
        _tipLal.font = [UIFont systemFontOfSize:15.0];
        _tipLal.clipsToBounds = YES;
        _tipLal.layer.cornerRadius = 5.0;
        _tipLal.textAlignment = NSTextAlignmentCenter;
        _tipLal.textColor = [UIColor whiteColor];
        _tipLal.text = @"无数据，请先进行检测";
        _tipLal.alpha = 0;
        _tipLal.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    }
    return _tipLal;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"趋势图";
    self.dataArr = [[NSMutableArray alloc] init];
    
    [self.mytable registerNib:[UINib nibWithNibName:@"NewTrendHomeCell" bundle:nil] forCellReuseIdentifier:@"NewTrendHomeCell"];
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
    
    //icon图片 ico_sao2_checked  ico_sao2_normal
    imgDic = @{@"11":@"ico_GLU",@"9":@"ico_temperature",@"1":@"ico_weight",@"14":@"ico_BFP_TAG",@"51":@"ico_heartrate",@"10":@"ico_HGB",@"34":@"ico_CHOL_HDL_LDL",@"36":@"ico_CHOL_HDL_LDL",@"37":@"ico_CHOL_HDL_LDL",@"35":@"ico_BFP_TAG",@"12":@"ico_BP",@"181":@"ico_oxy",@"213":@"ico_hematocrystallin",@"214":@"ico_ketone",@"7":@"ico_trioxypurine"};
    
    if (!self.navigationItem.leftBarButtonItem) {//判断是否有返回按钮
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)actionBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取数据
-(void)loadData
{
    
    NSString *memberID = [UserInfoTool getLoginInfo].MemberID;
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,
                         @"MemberID":[NSNumber numberWithInteger:[memberID intValue]]};
    
//    [[XKLoadingView shareLoadingView] showLoadingText:nil];

    [NetWorkTool postAction:checkHomeGetMedicalReportList params:dict finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
//            [[XKLoadingView shareLoadingView] hideLoding];
            self.dataArr = (NSMutableArray *)[TrendNewModel  mj_objectArrayWithKeyValuesArray:response.Result];
            
            for (TrendNewModel *model in self.dataArr) {
                NSString *PhysicalItemID = [NSString stringWithFormat:@"%li",model.PhysicalItemID];
                NSString *img = [self->imgDic objectForKey:PhysicalItemID];
                model.iconImgStr = img;
            }
            [self.mytable reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
        
    }];
//    [ProtosomaticHttpTool protosomaticPostWithURLString:@"314" parameters:dict success:^(id json) {
//        XKLOG(@"趋势指标314：%@",json);
//        NSDictionary *dic=(NSDictionary *)json;
//        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
//            [[XKLoadingView shareLoadingView] hideLoding];
//            self.dataArr = (NSMutableArray *)[TrendNewModel  objectArrayWithKeyValuesArray:dic[@"Result"]];
//
//            for (TrendNewModel *model in self.dataArr) {
//                NSString *PhysicalItemID = [NSString stringWithFormat:@"%li",model.PhysicalItemID];
//                NSString *img = [imgDic objectForKey:PhysicalItemID];
//                model.iconImgStr = img;
//            }
//            [self.mytable reloadData];
//
//        }else{
//            [[XKLoadingView shareLoadingView] errorloadingText:nil];
//        }
//
//    } failure:^(id error) {
//
//        XKLOG(@"%@",error);
//        [[XKLoadingView shareLoadingView] errorloadingText:nil];
//    }];
}

-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTrendHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewTrendHomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TrendNewModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrendNewModel *model = self.dataArr[indexPath.row];
    if (model.TestCount > 0) {
        NewTrendDetailController *vc = [[NewTrendDetailController alloc] init];
        if (model.PhysicalItemID == 11 ) {
             vc.PhysicalItemID = 32;
        }else
        vc.PhysicalItemID = model.PhysicalItemID;
        [self.navigationController  pushViewController:vc animated:YES];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.tipLal.alpha = 0.99;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.2 animations:^{
                self.tipLal.alpha = 1.0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.tipLal.alpha = 0.0;
                }];
            }];
        }];

        [self.view addSubview:self.tipLal];
//        [IanAlert alertSuccess:@"无数据，请先进行检测" length:1.5];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
