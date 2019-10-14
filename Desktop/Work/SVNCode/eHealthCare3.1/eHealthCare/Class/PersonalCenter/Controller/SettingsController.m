//
//  SettingsController.m
//  eHealthCare
//
//  Created by jamkin on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SettingsController.h"
#import "SettringSwitchCell.h"
#import "SettringArrowCell.h"
#import "SettingLoginOutCell.h"
#import "NewAboutUsViewController.h"
#import "PersonalCenterViewModel.h"
#import "LoginOutView.h"
#import "RemindModel.h"
@interface SettingsController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)NSArray *switchArray;
@property (nonatomic,strong)NSMutableArray *switchRemindArray;
@property (nonatomic,strong)NSArray *arrowArray;

@property (nonatomic,strong)NSArray *loginoutArray;
@property (nonatomic,strong) LoginOutView *footerView;


@property (nonatomic,strong) RemindModel *remind;
@end

@implementation SettingsController

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY));//+NavigationBarHeight+StatusBarHeight
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = kbackGroundGrayColor;
        _tableView.separatorColor=[UIColor clearColor];
        
       
    }
    return _tableView;
}

-(LoginOutView *)footerView{
    if (_footerView == nil) {
        _footerView = [[[NSBundle mainBundle]loadNibNamed:@"LoginOutView" owner:self options:nil]firstObject];
        _footerView.frame = CGRectMake(0, 0, KScreenWidth,KScreenHeight-(7*55)-(PublicY)-6.f);
        _footerView.delegate = self;
    }
    return _footerView;
}
- (void)getHealthRecordHomeResultWithNetWorking:(NSInteger)MemberID//PersonalArchiveViewController
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@(MemberID)};
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [PersonalCenterViewModel getUserHealthRemindSetWithParams:dic FinishedBlock:^(ResponseObject *response) {
        [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed)
        {
            self.remind = [RemindModel mj_objectWithKeyValues:response.Result];
         NSArray *temp=@[@(self.remind.IsWaterRemind),@(self.remind.IsWorkRemind),@(self.remind.IsMedicineRemind),@(self.remind.IsHealthPlanRemind),@(self.remind.IsHealthTreeRemind)];
            self.switchRemindArray = [NSMutableArray arrayWithArray:temp];
           
            [self.tableView reloadData];
            
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}
- (void)inputHealthRecordHomeResultWithNetWorking:(NSInteger)index isOn:(NSInteger)isOn//PersonalArchiveViewController
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"IsWaterRemind":@(self.remind.IsWaterRemind),
                          @"IsWorkRemind":@(self.remind.IsWorkRemind),
                          @"IsMedicineRemind":@(self.remind.IsMedicineRemind),
                          @"IsHealthPlanRemind":@(self.remind.IsHealthPlanRemind),
                           @"IsHealthTreeRemind":@(self.remind.IsHealthTreeRemind)
                          };
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [PersonalCenterViewModel inputtUserHealthRemindSetWithParams:dic FinishedBlock:^(ResponseObject *response) {
        [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed)
        {
            NSLog(@"946-----%@",response.Result);
            NSString *tempStr = @"用户提交健康提醒成功";
            if (index == 0) {
               
                tempStr =  [NSString stringWithFormat:@"喝水提醒功能%@",isOn==1?@"开启":@"关闭"];
            }
            if (index == 1) {
                tempStr = [NSString stringWithFormat:@"用久坐提醒功能%@",isOn==1?@"开启":@"关闭"];
            }
            if (index == 2) {
                tempStr = [NSString stringWithFormat:@"用药提醒功能%@",isOn==1?@"开启":@"关闭"];
            }
            if (index == 3) {
                tempStr = [NSString stringWithFormat:@"健康计划提醒功能%@",isOn==1?@"开启":@"关闭"];
            }
            if (index == 4) {
                tempStr = [NSString stringWithFormat:@"健康树提醒功能%@",isOn==1?@"开启":@"关闭"];
            }
            ShowSuccessStatus(tempStr);
            [self.switchRemindArray replaceObjectAtIndex:index withObject:@(isOn)];
            [self.tableView reloadData];
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.extendedLayoutIncludesOpaqueBars = YES;
     [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    self.switchArray=@[@"喝水提醒功能",@"久坐提醒功能",@"用药提醒功能",@"健康计划提醒",@"健康树消息提醒"];
    
    self.arrowArray=@[@"关于我们",@"给我点评"];
    
    self.loginoutArray=@[@"退出登录"];
    self.switchRemindArray = [NSMutableArray arrayWithArray:@[@(self.remind.IsWaterRemind),@(self.remind.IsWorkRemind),@(self.remind.IsMedicineRemind),@(self.remind.IsHealthPlanRemind),@(self.remind.IsHealthTreeRemind)]];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingLoginOutCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettringSwitchCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SettringArrowCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tableView.tableFooterView = self.footerView;
    [self getHealthRecordHomeResultWithNetWorking:[UserInfoTool getLoginInfo].MemberID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        
        return self.switchArray.count;
        
    }
    else if (section==1){
        
        return self.arrowArray.count;
        
    }else{
        
        return self.loginoutArray.count;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        SettringSwitchCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"SettringSwitchCell" owner:nil options:nil].firstObject;
        }
        cell.msg=self.switchArray[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if (indexPath.row==0) {
         
            cell.lineView.hidden=YES;
            
        }
        cell.switchStatus = [self.switchRemindArray[indexPath.row] integerValue];
        
       
        
        return cell;
        
    }
    else if (indexPath.section==1){
        
        SettringArrowCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        cell.msg=self.arrowArray[indexPath.row];
        
        if (indexPath.row==0) {
            
            cell.lineView.hidden=YES;
            
        }

        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        SettingLoginOutCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        
        cell.msg=self.loginoutArray[indexPath.row];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0.01;
    }else{
        return 6.f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =  [[UIView alloc]init];
    view.backgroundColor = kbackGroundGrayColor;
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =  [[UIView alloc]init];
    view.backgroundColor = kbackGroundGrayColor;
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
        
    
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            
            NewAboutUsViewController *newAbout=[[NewAboutUsViewController alloc]init];
            
            [self.navigationController pushViewController:newAbout animated:YES];
            
//            AboutUsViewController *about = [[AboutUsViewController alloc] init];
//            [self.navigationController  pushViewController:about animated:YES];
        }
        else  if (indexPath.row == 1) {
            
            NSString *itunesurl = @"itms-apps://itunes.apple.com/cn/app/id1164831524?mt=8&action=write-review";
            
            
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清理缓存？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            //清理缓存提示设置tag值
            alertView.tag = 451;
            [alertView show];
        }
    }
    
    

}
- (void)LoginOutViewbuttonClick;
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出登录吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    //退出登录提示设置tag
    alertView.tag = 450;
    [alertView show];
    
}
- (void)openOrCloseButton:(NSInteger)isOn cell:(SettringSwitchCell*)cell;
{
    
//    @"IsWaterRemind":@(self.remind.IsWaterRemind),
//    @"IsWorkRemind":@(self.remind.IsWorkRemind),
//    @"IsMedicineRemind":@(self.remind.IsMedicineRemind),
//    @"IsHealthPlanRemind":@(self.remind.IsHealthPlanRemind),
//    @"IsHealthTreeRemind":@(self.remind.IsHealthTreeRemind)
  
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    if (index.row == 0) {
        self.remind.IsWaterRemind = isOn;
    }
    if (index.row == 1) {
        self.remind.IsWorkRemind = isOn;
    }
    if (index.row == 2) {
         self.remind.IsMedicineRemind = isOn;
    }
    if (index.row == 3) {
        self.remind.IsHealthPlanRemind = isOn;
    }
    if (index.row == 4) {
        self.remind.IsHealthTreeRemind = isOn;
    }
    [self inputHealthRecordHomeResultWithNetWorking:index.row isOn:isOn];
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
    }else{
        
        if (alertView.tag == 450) {
            
                [PersonalCenterViewModel signOutAction];
            
                [self presentLoginView];
            
//            NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
//            
//            [center postNotificationName:@"lignout" object:nil];
        }else if (alertView.tag == 451){
            //***清除缓存功能，还未实现
            [[EGOCache globalCache] clearCache];
            
//            **** 清理沙盒目录缓存
            NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [defatluts dictionaryRepresentation];
            for(NSString *key in [dictionary allKeys]){
                if (![key isEqualToString:@"userMessage"]) {
                    [defatluts removeObjectForKey:key];
                }
                [defatluts synchronize];
            }
            
            //**** 清除sdWebImage内存缓存图片
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            [[[EGOCache alloc] init] clearCache];
           ShowSuccessStatus(@"缓存已全部清理！");
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"lignout" object:nil];
}


//- (UIView *)footerView{
//    if(!_footerView){
//        _footerView = [[UIView alloc]init];
//
//        _footerView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-(2*20+5*55)-64-20);
//
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, _footerView.frame.size.height-30, KScreenWidth, 30)];
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        lab.textAlignment = NSTextAlignmentCenter;
//        lab.font = [UIFont systemFontOfSize:14.f];
//        lab.text = [NSString stringWithFormat:@"当前版本：携康e加%@",appCurVersion];
//        [_footerView addSubview:lab];
//    }
//    return _footerView;
//}
@end