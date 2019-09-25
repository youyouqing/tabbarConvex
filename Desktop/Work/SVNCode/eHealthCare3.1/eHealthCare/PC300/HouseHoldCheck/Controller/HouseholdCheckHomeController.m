//
//  HouseholdCheckHomeController.m
//  PC300
//
//  Created by jamkin on 2017/4/18.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import "HouseholdCheckHomeController.h"
#import "HouseholdCheckHomeCell.h"
#import "HouseholdModel.h"
#import "XKDectingViewController.h"
#import "XKMultifunctionCheckHomeCell.h"
#import "XKBindToolsViewController.h"
#import "XKMultiFunctionCheckResultController.h"
#import "XKHouseHoldModel.h"

#import "XKValidationAndAddScoreTools.h"
static NSString *householdCheckHomeCellId=@"householdCheckHomeCell";

@interface HouseholdCheckHomeController ()
//<BluetoothConnectionToolDelegate>

/**
 首页数据源
 */
@property (nonatomic,strong)NSArray *dataArray;

/**
 蓝牙工具
 */
@property (nonatomic,strong)BluetoothConnectionTool *bc;

/**
 蓝牙连接状态
 */
//@property (nonatomic,assign)NSInteger connectionStatus;


@property (nonatomic,strong)NSArray *dataBigArray;


@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation HouseholdCheckHomeController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitle=@"居家检测";
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor=[UIColor getColor:@"f2f2f2"];
     [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HouseholdCheckHomeCell" bundle:nil] forCellReuseIdentifier:householdCheckHomeCellId];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKMultifunctionCheckHomeCell" bundle:nil] forCellReuseIdentifier:@"XKMultifunctionCheckHomeCell"];
    
    self.tableView.separatorColor=[UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%zi",@"XKHouseHoldModel",[UserInfoTool getLoginInfo].MemberID]]) {
        NSArray *arr = (NSArray *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%zi",@"XKHouseHoldModel",[UserInfoTool getLoginInfo].MemberID]];
         self.dataBigArray = [XKHouseHoldModel mj_objectArrayWithKeyValuesArray:arr];
        [self.tableView reloadData];
        
    }

    [self loadData];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.bc =  [BluetoothConnectionTool sharedInstanceTool];
    
    NSLog(@"--****************-tool*********-----%@",self.bc);
    [self.bc disconnectDevice];
}

-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loadData{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];//,@"Mobile":[UserInfoTool getLoginInfo].Mobile
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"808" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID)}  success:^(id json) {
        
        NSLog(@"808%@",json);
        
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            self.dataBigArray = [XKHouseHoldModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            [[EGOCache globalCache] setObject:[json objectForKey:@"Result"] forKey:[NSString stringWithFormat:@"%@%zi",@"XKHouseHoldModel",[UserInfoTool getLoginInfo].MemberID]];
            
            [self.tableView reloadData];
        }else{
            
            NSLog(@"操作失败");
            [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
            
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        
        [[XKLoadingView shareLoadingView] errorloadingText:error];
        
    }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataBigArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        XKMultifunctionCheckHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKMultifunctionCheckHomeCell" forIndexPath:indexPath];
        
      
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//           XKHouseHoldModel *model=self.dataBigArray[indexPath.row];
     
//        cell.XKHouseHoldModel=model;
        return cell;
        
    }
    else
    {
        HouseholdCheckHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:householdCheckHomeCellId forIndexPath:indexPath];
        
        XKHouseHoldModel *model=self.dataBigArray[indexPath.row-1];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.XKHouseHoldModel=model;
        
        return cell;
    
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 151;
    }
    return 128;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *v=[[UIView alloc]init];
    
    v.backgroundColor=[UIColor getColor:@"F2F2F2"];
    
    return v;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v=[[UIView alloc]init];
    
    v.backgroundColor=[UIColor getColor:@"F2F2F2"];
    
    return v;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
         XKMultiFunctionCheckResultController *connection=[[XKMultiFunctionCheckResultController alloc]initWithType:pageTypeNormal];
        
        [self.navigationController pushViewController:connection animated:YES];
        
    }else{
    
            XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];

            XKHouseHoldModel *hmodel= self.dataBigArray[indexPath.row-1];
        
            connection.style = hmodel.DeviceClass;
        
            connection.model = hmodel;
          
            [self.navigationController pushViewController:connection animated:YES];

    }
    
    
}


@end
