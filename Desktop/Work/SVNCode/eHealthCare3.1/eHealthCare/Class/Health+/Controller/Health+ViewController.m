//
//  Health+ViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "Health+ViewController.h"
#import "CheerYourselfUpViewController.h"
#import "TrainWithMusicViewController.h"
#import "ShareView.h"
#import "EPluseFooterView.h"
#import "EPluseTemperView.h"
#import "EPluseWeightView.h"
#import "EPluseHeaderView.h"
#import "EPluseCell.h"
#import "EPluseSugarView.h"
#import "NewTrendDetailController.h"
#import "SportViewController.h"
#import "HouseholdCheckHomeController.h"
#import "BasicInfo.h"
#import "PhysicalList.h"
#import "MusicTrainViewModel.h"
#import "HomeInspectionListModel.h"
#import "XKDectingViewController.h"
#import "EPluseSugarDetailView.h"
#import "EPluseHyperlipidemiaView.h"
#import "EPluseNoneDataView.h"
#import <CoreMotion/CoreMotion.h>
@interface Health_ViewController ()
@property (nonatomic, strong) NSArray *PhysicalList;
@property (nonatomic, strong) NSArray *homeArr;//绑定设备ID
///早安 晚安 正念等数据
@property (nonatomic, strong) NSArray *DataArray;
@property (nonatomic, strong) BasicInfo *infoModel;
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) CMPedometer *pedometer;//记步器
@end

@implementation Health_ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self loadHealthData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"健康e加";
    self.titleLab.textColor = kMainTitleColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self createUI];
    NSDictionary *dict1=@{@"img":@"icon_ejia_step",@"remark":@"运动步数（步）",@"viewTag":@"12"};
    NSDictionary *dict2=@{@"img":@"icon_ejia_drink",@"remark":@"喝水记录（ml）",@"viewTag":@"13"};
    NSDictionary *dict3=@{@"img":@"icon_ejia_working",@"remark":@"久坐提醒（h）",@"viewTag":@"12",@"imgw":@"iv_rest",@"remarkw":@"久坐提醒（h）",};
    NSDictionary *dict4=@{@"img":@"iv_rest",@"remark":@"久坐提醒（h）",@"viewTag":@"13"};
     NSDictionary *dict5=@{@"img":@"iv_rest",@"remark":@"体温(℃)",@"viewTag":@"13"};
     NSDictionary *dict6=@{@"img":@"iv_rest",@"remark":@"体重(kg)",@"viewTag":@"13"};
    //数组初始化
    self.DataArray = @[dict1,dict2,dict3,dict5,dict6];
    
  
}
#pragma mark UI
- (void)createUI
{
    
    CGFloat TopY = (PublicY);
 
    if (self.isHealthPluse == NO)
    {
         TopY = 0;
    }else
    {
         TopY = (PublicY);
    }
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, TopY, KScreenWidth, KScreenHeight-(kTabbarHeight)-TopY) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor whiteColor];//kbackGroundGrayColor;
    _tableView.bounces = NO;

    [self.view addSubview:self.tableView];
//    self.tableView.tableHeaderView = self.headView;
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"EPluseCell" bundle:nil] forCellReuseIdentifier:@"EPluseCell"];
  

}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.isHealthPluse == YES){
            return 5   ;
        }else
        return 0;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        NSString *cellid = @"EPluseCell";
        EPluseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"EPluseCell" owner:nil options:nil].firstObject;
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.DataDic = self.DataArray[indexPath.row];
        cell.delegate = self;
        Dateformat *dateFor = [[Dateformat alloc] init];
        NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"YYYY-MM-dd"];
        if (indexPath.row == 0) {
//            cell.dataLab.text = [NSString stringWithFormat:@"%zi",self.infoModel.StepCount];
            cell.titleLabTwo.text = @"";
              if (self.infoModel.StepLastTime>0) {
                  NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",self.infoModel.StepLastTime] doubleValue] / 1000.0;
                  NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
                  
            cell.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
//                  [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",self.infoModel.StepLastTime]] withFormat:@"YYYY-MM-dd"];
              }else
                  cell.timeLab.text = @"";
             [cell.sportBtn setTitle:@"去运动" forState:UIControlStateNormal];
        }
        if (indexPath.row == 1) {
            cell.dataLab.text =  [NSString stringWithFormat:@"%zi",self.infoModel.DrinkWater];
            cell.titleLabTwo.text = @"";
            if (self.infoModel.DrinkWaterLastTime>0) {
                NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",self.infoModel.DrinkWaterLastTime] doubleValue] / 1000.0;
                NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
                
                cell.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
//                  cell.timeLab.text = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",self.infoModel.DrinkWaterLastTime]] withFormat:@"YYYY-MM-dd"];
            }else
                cell.timeLab.text = @"";
          
             [cell.sportBtn setTitle:@"去喝水" forState:UIControlStateNormal];
             return cell;
        }
        if (indexPath.row == 2) {
             [cell.dataLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%.1f 工作",self.infoModel.WorkTime/60.0]  withBigImpactFont:30 withNeedchangeText:@"工作" withSmallImpactFont:15 dainmaicColor:[UIColor getColor:@"4DC1F6"] excisionColor:[UIColor getColor:@"4DC1F6"]] ];
            [ cell.titleLabTwo setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%.1f 休息",self.infoModel.RestTime/60.0]  withBigImpactFont:30 withNeedchangeText:@"休息" withSmallImpactFont:15 dainmaicColor:[UIColor getColor:@"4DC1F6"] excisionColor:[UIColor getColor:@"4DC1F6"]] ];
          
             if (self.infoModel.WorkRestLastTime>0) {
                 
                 NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",self.infoModel.WorkRestLastTime] doubleValue] / 1000.0;
                 NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
                 
                 cell.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
//                cell.timeLab.text = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",self.infoModel.WorkRestLastTime]] withFormat:@"YYYY-MM-dd"];
             }else
                 cell.timeLab.text = @"";
            [cell.sportBtn setTitle:@"去工作" forState:UIControlStateNormal];
             return cell;
        }
        if (indexPath.row == 3) {
            cell.dataLab.textColor =[UIColor getColor:@"B9C4D6"];
            cell.dataLab.text = @"暂无数据，请测量";
              cell.dataLab.font =[UIFont systemFontOfSize:14.f];
             cell.timeLab.text = @"";
            for ( PhysicalList *model in self.PhysicalList) {
                
                if ([model.PhysicalItemIdentifier isEqualToString:@"TC"]){
                    Dateformat *dateFor = [[Dateformat alloc] init];
                    
                  cell.timeLab.text =   [NSString stringWithFormat:@"%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy/MM/dd HH:mm"]];
                    cell.dataLab.font =model.TypeParameter?[UIFont fontWithName:@"Impact" size:30]:[UIFont systemFontOfSize:14.f];
                       cell.dataLab.textColor = model.TypeParameter?[UIColor getColor:@"4DC1F6"]:[UIColor getColor:@"B9C4D6"];
                    cell.dataLab.text = model.TypeParameter?(model.TypeParameter):@"暂无数据，请测量";
                    }
                
                
            }
         
//            if (self.infoModel.WorkRestLastTime>0) {
//
//                NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",self.infoModel.WorkRestLastTime] doubleValue] / 1000.0;
//                NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
//
//                cell.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
//                //                cell.timeLab.text = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",self.infoModel.WorkRestLastTime]] withFormat:@"YYYY-MM-dd"];
//            }else
//                cell.timeLab.text = @"";
            [cell.sportBtn setTitle:@"去测量" forState:UIControlStateNormal];
             return cell;
        }
        if (indexPath.row == 4) {
            cell.dataLab.textColor =[UIColor getColor:@"B9C4D6"];
            cell.dataLab.text = @"暂无数据，请测量";
            cell.dataLab.font =[UIFont systemFontOfSize:14.f];
            cell.timeLab.text = @"";
            for ( PhysicalList *model in self.PhysicalList) {
                
                if ([model.PhysicalItemIdentifier isEqualToString:@"WG"]){
                    Dateformat *dateFor = [[Dateformat alloc] init];
                    
                    cell.timeLab.text = [NSString stringWithFormat:@"%@",[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.TestTime]] withFormat:@"yyyy/MM/dd HH:mm"]];
                        cell.dataLab.font =model.TypeParameter?[UIFont fontWithName:@"Impact" size:30]:[UIFont systemFontOfSize:14.f];
                    cell.dataLab.textColor = model.TypeParameter?[UIColor getColor:@"4DC1F6"]:[UIColor getColor:@"B9C4D6"];
                    cell.dataLab.text = model.TypeParameter?(model.TypeParameter):@"暂无数据，请测量";
                }
                
                
            }
          
//            if (self.infoModel.WorkRestLastTime>0) {
//
//                NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",self.infoModel.WorkRestLastTime] doubleValue] / 1000.0;
//                NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
//
//                cell.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
//                //                cell.timeLab.text = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",self.infoModel.WorkRestLastTime]] withFormat:@"YYYY-MM-dd"];
//            }else
//                cell.timeLab.text = @"";
            [cell.sportBtn setTitle:@"去测量" forState:UIControlStateNormal];
        }
        return cell;
    }else
    {
        NSString *cellid = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//         return 0.01;
//    }else  if (section <=5) {
//        return 45+5;
//    }
//    else
//    {
    
        return 0.01;
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
         return 117+5;
    }
    else
        return 0.01;
  
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//     XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
//    if (section == 1){
//        EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
//        headV.titleLab.text=@"血压(mmHg)";
//        headV.delegate = self;
//        for (XKHouseHoldModel *hmode in  self.homeArr) {
//            if ([headV.titleLab.text containsString:hmode.Name]) {
//                mode = hmode;
//                break;
//            }
//        }
//        headV.moreLab.text = (mode.IsBind==1?@"已绑定":@"未绑定");
//        return headV;
//    }
////    else if (section == 2){
////        EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
////        headV.titleLab.text=@"体温(℃)";
////        headV.delegate = self;
////        headV.arrowImg.hidden = NO;
////        for (XKHouseHoldModel *hmode in  self.homeArr) {
////            if ([headV.titleLab.text containsString:hmode.Name]) {
////                mode = hmode;
////                break;
////            }
////        }
////        headV.moreLab.text = (mode.IsBind==1?@"已绑定":@"未绑定");
////        return headV;
////    }
////    else if (section == 3){
////        EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
////        headV.titleLab.text=@"体重(kg)";
////        headV.delegate = self;
////        for (XKHouseHoldModel *hmode in  self.homeArr) {
////            if ([headV.titleLab.text containsString:hmode.Name]) {
////                mode = hmode;
////                break;
////            }
////        }
////        headV.moreLab.text = (mode.IsBind==1?@"已绑定":@"未绑定");
////        return headV;
////    }
//    else if (section == 2){
//        EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
//        headV.titleLab.text=@"血糖(mmol/L)";
//        headV.delegate = self;
//        for (XKHouseHoldModel *hmode in  self.homeArr) {
//            if ([headV.titleLab.text containsString:hmode.Name]) {
//                mode = hmode;
//                break;
//            }
//        }
//        headV.moreLab.text = (mode.IsBind==1?@"已绑定":@"未绑定");
//        return headV;
//    }
//    else if (section == 3) {
//        EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
//        headV.titleLab.text=@"血脂(mmol/L)";
//        for (XKHouseHoldModel *hmode in  self.homeArr) {
//            if ([headV.titleLab.text containsString:hmode.Name]) {
//                mode = hmode;
//                break;
//            }
//        }
//        headV.moreLab.text = (mode.IsBind==1?@"已绑定":@"未绑定");
//        headV.delegate = self;
//        return headV;
//    }
//    else {
//        UIView *headV=[[UIView alloc]init];
//        return headV;
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
        return 0.01;//UITableViewAutomaticDimension;
    }
    else if (section == 1)
    {
        
        return 282;
    }
    else if (section == 2)
    {
        
        return 289;
    }
    else if (section == 3)
    {
        for ( PhysicalList *model in self.PhysicalList) {
            if (([model.PhysicalItemIdentifier containsString:@"BF_"]||[model.PhysicalItemIdentifier isEqualToString:@"CHOL"]))
            {
                return 462+10;
            }
        }
        return 282;
    }
//    else if (section == 2)
//    {
//        return 299;
//
//    }
    else
    {
        return 282;
        
    }
}//  
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1){
//        EPluseSugarView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseSugarView" owner:self options:nil]  firstObject];
//        footerV.isSugar = NO;
//        footerV.PhysicalMod = self.PhysicalList;
        for ( PhysicalList *model in self.PhysicalList) {
            if (([model.PhysicalItemIdentifier containsString:@"BP_"]||[model.PhysicalItemIdentifier isEqualToString:@"ECG"]||[model.PhysicalItemIdentifier isEqualToString:@"RHR"]))
            {
                EPluseWeightView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseWeightView" owner:self options:nil]  firstObject];
                footerV.PhysicalMod = self.PhysicalList;
                footerV.delegate = self;
                return footerV;
                
            }
        }
        EPluseNoneDataView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseNoneDataView" owner:self options:nil]  firstObject];
        [footerV.titleBtn setTitle:@"血压" forState:UIControlStateNormal];
        [footerV.titleBtn setImage:[UIImage imageNamed:@"icon_xueya"] forState:UIControlStateNormal];
        footerV.backImageView.image = [UIImage imageNamed:@"iv_xueya_empty"];
        footerV.delegate = self;
        return footerV;
     
    }
//    else if (section == 3){
//        EPluseWeightView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseWeightView" owner:self options:nil]  firstObject];
//         footerV.PhysicalMod = self.PhysicalList;
//        return footerV;
//    }
//    else if (section == 2){
//        EPluseTemperView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseTemperView" owner:self options:nil]  firstObject];
//         footerV.PhysicalMod = self.PhysicalList;
//        return footerV;
//    }
    else if (section == 2){
        for ( PhysicalList *model in self.PhysicalList) {
            if ([model.PhysicalItemIdentifier containsString:@"BG_"])
            {
                EPluseSugarDetailView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseSugarDetailView" owner:self options:nil]  firstObject];
                footerV.PhysicalMod = self.PhysicalList;
                footerV.delegate = self;
                return footerV;
            }
        }
            EPluseNoneDataView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseNoneDataView" owner:self options:nil]  firstObject];
            [footerV.titleBtn setTitle:@"血糖" forState:UIControlStateNormal];
            [footerV.titleBtn setImage:[UIImage imageNamed:@"icon_xuetang"] forState:UIControlStateNormal];
            footerV.backImageView.image = [UIImage imageNamed:@"iv_xuetang_empty"];
            footerV.delegate = self;
            return footerV;
    }
     else if (section == 3){
         for ( PhysicalList *model in self.PhysicalList) {
             if (([model.PhysicalItemIdentifier containsString:@"BF_"]||[model.PhysicalItemIdentifier isEqualToString:@"CHOL"]))
             {
                EPluseHyperlipidemiaView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHyperlipidemiaView" owner:self options:nil]  firstObject];
                footerV.PhysicalMod = self.PhysicalList;
                footerV.delegate = self;
                return footerV;
             }
         }
             EPluseNoneDataView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseNoneDataView" owner:self options:nil]  firstObject];
             [footerV.titleBtn setTitle:@"血脂" forState:UIControlStateNormal];
             [footerV.titleBtn setImage:[UIImage imageNamed:@"icon_xuezhi"] forState:UIControlStateNormal];
             footerV.backImageView.image = [UIImage imageNamed:@"iv_xuezhi_empty"];
             footerV.delegate = self;
             return footerV;
    }
    else {
        UIView *headV=[[UIView alloc]init];
        return headV;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//          
//        }else if (indexPath.row == 1){
//            
//            
//        }else
//        {
//            
//            
//        }
//    }else
//    {
//        
//    }
//    
    
}
- (void)buttonClickEPluseHeaderViewAtIndex:(NSString *)url title:(NSString *)title index:(NSInteger)tag;
{
//设备分类（1.PC300血压、2.PC300血糖、3.PC300体温、4.PC300血氧、5.PC300脉率、6血压、7体重、8血糖、9血脂、10血红蛋白、11血氧、12体温）
//    HouseholdCheckHomeController *house=[[HouseholdCheckHomeController alloc]init];
//    house.tagLeft = 200;
//    house.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:house animated:YES];
    XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
    for (XKHouseHoldModel *hmode in  self.homeArr) {
        if ([title containsString:@"血压"]&&[hmode.Name isEqualToString:@"血压"]) {
            mode = hmode;
            mode.DeviceClass = 6;
            break;
        }
        else if ([title containsString:@"体温"]&&[hmode.Name isEqualToString:@"体温"]) {
            mode = hmode;
             mode.DeviceClass = 12;
            break;
        }
       else  if ([title containsString:@"体重"]&&[hmode.Name isEqualToString:@"体重"]) {
            mode = hmode;
            mode.DeviceClass = 7;
           break;
        }
       else if ([title containsString:@"血糖"]&&[hmode.Name isEqualToString:@"血糖"]) {
           mode = hmode;
            mode.DeviceClass = 8;
           break;
       }
       else if ([title containsString:@"血脂"]&&[hmode.Name isEqualToString:@"血脂"]) {
           mode = hmode;
            mode.DeviceClass = 9;
           break;
       }
    }
    XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];
    connection.style = mode.DeviceClass;
    connection.model = mode;
    connection.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:connection animated:YES];
}
#pragma mark   EPluseDelegate
- (void)sportEPluseCellbuttonClick:(NSString *)titleStr headline:(NSString *)headline;
{
    if ([titleStr isEqualToString:@"去运动"]) {
        SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
        sport.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sport animated:YES];
    }
    if ([titleStr isEqualToString:@"去喝水"]) {
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
         web.isNewHeight = YES;
        web.urlString = kHealthDrinkUrl;
        web.myTitle = titleStr;
        web.hidesBottomBarWhenPushed = YES;
       
            //展示当天任务是否完成喝水
//            XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
//            [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(14)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(14)}];
       
        [self.navigationController pushViewController:web animated:YES];
    }
    if ([titleStr isEqualToString:@"去工作"]) {
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
         web.isNewHeight = YES;
        web.urlString = kHealthSitDownUrl;
        web.myTitle = titleStr;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
    if ([titleStr isEqualToString:@"去测量"]) {
        XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
        for (XKHouseHoldModel *hmode in  self.homeArr) {
            if ([headline containsString:@"体温"]&&[hmode.Name isEqualToString:@"体温"]) {
                mode = hmode;
                mode.DeviceClass = 12;
                break;
            }
            else  if ([headline containsString:@"体重"]&&[hmode.Name isEqualToString:@"体重"]) {
                mode = hmode;
                mode.DeviceClass = 7;
                break;
            }

        }
        XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];
        connection.style = mode.DeviceClass;
        connection.model = mode;
        connection.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:connection animated:YES];
    }
}
#pragma mark  血压代理
- (void)EPluseWeightViewBloodPressurebuttonClick;
{
    XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
    for (XKHouseHoldModel *hmode in  self.homeArr) {
        if ([hmode.Name isEqualToString:@"血压"]) {
            mode = hmode;
            mode.DeviceClass = 6;
            break;
        }
       
    }
    XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];
    connection.style = mode.DeviceClass;
    connection.model = mode;
    connection.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:connection animated:YES];
    
}
#pragma mark 血糖数据代理
- (void)EPluseSugarDetailViewbuttonClick:(NSInteger)sugarCondition;
{
    
    XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
    for (XKHouseHoldModel *hmode in  self.homeArr) {
        
        if ([hmode.Name isEqualToString:@"血糖"]) {
            mode = hmode;
            mode.DeviceClass = 8;
            break;
        }
    }
    XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];
    connection.style = mode.DeviceClass;
    connection.model = mode;
    connection.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:connection animated:YES];
    
}
- (void)EPluseHyperlipidemiaViewGotestbuttonClick;
{
    XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
    for (XKHouseHoldModel *hmode in  self.homeArr) {

      if ([hmode.Name isEqualToString:@"血脂"]) {
            mode = hmode;
            mode.DeviceClass = 9;
            break;
        }
    }
    XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];
    connection.style = mode.DeviceClass;
    connection.model = mode;
    connection.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:connection animated:YES];
    
}
#pragma mark  无数据显示页面代理
- (void)EPluseNoneDataViewButtonClick:(NSString *)nameStr;
{
    if ([nameStr isEqualToString:@"血压"]) {
        [self EPluseWeightViewBloodPressurebuttonClick];
    }else if ([nameStr isEqualToString:@"血脂"])
    {
        [self EPluseHyperlipidemiaViewGotestbuttonClick];

    }else if([nameStr isEqualToString:@"血糖"])
    {
        [self EPluseSugarDetailViewbuttonClick:1];
        
    }
    
}
#pragma mark NetWorking
-(void)loadHealthData{
    
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [MusicTrainViewModel getEPluseListWithParams:dic FinishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            NSLog(@"327%@",response.Result);
             self.PhysicalList = (NSMutableArray *)[PhysicalList mj_objectArrayWithKeyValuesArray:response.Result[@"PhysicalList"]];
             self.infoModel = [BasicInfo mj_objectWithKeyValues:response.Result[@"BasicInfo"]];
            
            self.homeArr =  [XKHouseHoldModel mj_objectArrayWithKeyValuesArray:response.Result[@"HomeInspectionList"]];
            
            [self.tableView reloadData];
            
        }else{
            
            ShowErrorStatus(response.msg);
        }
    }];
}
//今日记步信息
-(void)sendStepMesage:(int )step;{
   
    EPluseCell *cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.dataLab.text = [NSString stringWithFormat:@"%i",step];
    
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
