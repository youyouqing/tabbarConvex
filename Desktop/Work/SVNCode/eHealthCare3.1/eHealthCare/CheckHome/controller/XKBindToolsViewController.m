//
//  XKBindToolsViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBindToolsViewController.h"
#import"XKBindToolTableViewCell.h"
#import "XKBindEquipmentViewController.h"
#import "XKDeviceDetailMod.h"
#import "XKDeviceMod.h"
#import "XKShopUrlViewController.h"
#import "XKValidationAndAddScoreTools.h"
@interface XKBindToolsViewController ()<XKBindToolTableViewCellDelegate>
@property (nonatomic,strong)NSArray *dataBigArray;
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation XKBindToolsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor getColor:@"f2f2f2"];
    [self.view addSubview:self.tableView];
    self.extendedLayoutIncludesOpaqueBars = YES;
   
    self.myTitle = [NSString stringWithFormat:@"%@绑定",self.myTitle];
    self.tableView.backgroundColor=[UIColor colorWithHexString:@"f2f2f2"];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKBindToolTableViewCell" bundle:nil] forCellReuseIdentifier:@"XKBindToolTableViewCell"];
    
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%i%li",@"XKDeviceMod",@([UserInfoTool getLoginInfo].MemberID ),(long)self.style]]) {
        NSArray *dic1 = (NSArray *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%i%li",@"XKDeviceMod",@([UserInfoTool getLoginInfo].MemberID ),(long)self.style]];
        
        [self loadDataWithDBOrRequest:dic1];
        
    }//网络环境差的情况下就本地数据
    [self loadData];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataBigArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKBindToolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKBindToolTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XKBindToolTableViewCell" owner:self options:nil]lastObject];
    }
    cell.model = self.dataBigArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark   数据加载
-(void)loadData{
        
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    //,@"Mobile":[UserInfoTool getLoginInfo].Mobile
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"DeviceID":@(self.DeviceID)};
    
    [NetWorkTool postAction:checkHomeGetDeviceBindListUrl params:dic finishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        

       [[XKLoadingView shareLoadingView] hideLoding];
        
        if (response.code == CodeTypeSucceed)
        {
            
        

            [self loadDataWithDBOrRequest:response.Result];
            [[EGOCache globalCache] setObject:response.Result forKey:[NSString stringWithFormat:@"%@%i%li",@"XKDeviceMod",[UserInfoTool getLoginInfo].MemberID,(long)self.style]];
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
    
}
-(void)loadDataWithDBOrRequest:(NSArray *)dic1{

    self.dataBigArray = [XKDeviceMod objectArrayWithKeyValuesArray:dic1];
    [self.tableView reloadData];

}
-(void)bindView:(XKBindToolTableViewCell *)cell;
{
    XKBindEquipmentViewController *bind = [[XKBindEquipmentViewController alloc]initWithType:pageTypeNormal];
    bind.model = cell.model;
    bind.style = self.style;
    bind.myTitle = self.myTitle;
    [self.navigationController pushViewController:bind animated:YES];
    
}
/**
 跳转到商场页去购买设备
 
 @param sender <#sender description#>
 */
-(void)buyTools:(XKBindToolTableViewCell *)cell;
{
    XKShopUrlViewController *shop = [[XKShopUrlViewController alloc]initWithType:pageTypeNormal];
    shop.ShopUrl = cell.model.HpptUrl;
    [self.navigationController pushViewController:shop animated:YES];
    
    
}



@end