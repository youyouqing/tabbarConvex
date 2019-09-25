//
//  HealthRecordController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordController.h"
#import "HealthRecordCell.h"
#import "HealthRecordHeaderView.h"
#import "HealthRecordMedical TableViewCell.h"
#import "HealthInformationCell.h"
#import "HealthRecordFooterView.h"
#import "RecordDetailController.h"
#import "MineElectronMedicController.h"
#import "ArchiveSettingViewController.h"
#import "HealthRecordNoDataFooterView.h"
#import "HealthTopScrollHeaderView.h"
#import "AddFamilyViewController.h"
#import "PersonArchiveBottomView.h"
#import "FamilyRelationController.h"
#import "PersonalDictionaryMsg.h"
#import "PersonalArcModel.h"
#import "FamilyObject.h"
#import "PhysicalInfo.h"
#import "PatientInfo.h"
#import "TopRecordModel.h"
#import "SportViewController.h"
#import "HealthPlanRecordFooterView.h"
#import "HealthRecordNoneDataCell.h"
static NSString *testReportListCell = @"HealthRecordCell";

@interface HealthRecordController ()
 @property(assign,nonatomic) NSInteger  userMemberID;
@property (nonatomic, strong)PatientInfo *modle;
@property (nonatomic, strong)PhysicalInfo * modl;
@property (nonatomic, strong)PersonalArcModel *personalMsg;
@property (nonatomic, strong)HealthRecordHeaderView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)HealthRecordNoDataFooterView *rowFooterView;
@property (nonatomic, strong)HealthTopScrollHeaderView *HeaderTopScrollView;
/**
 心情编号 1、酷 2、良好 3、没特别 4、差劲 5、糟透
 */
@property(nonatomic, assign)int MoodID;
//@property (nonatomic, strong)UserMoodModel *userMood;
@property (nonatomic, strong)NSMutableArray  *aewArchiveArray;
//@property (nonatomic, strong) NSMutableArray *basicArr;
@property (nonatomic, strong)NSMutableArray *basicInforamtionArr;
/**
 健康史
 */
@property (nonatomic, strong)NSMutableArray *healthbasicArr;
/**
 运动基本情况
 */
@property (nonatomic, strong)NSMutableArray *sportBasicArr;
/**
 健康计划数组
 */
@property (nonatomic, strong)NSMutableArray *PlanBasicArr;
@end
@implementation HealthRecordController
-(HealthTopScrollHeaderView *)HeaderTopScrollView
{
    if (!_HeaderTopScrollView) {
        _HeaderTopScrollView = [[[NSBundle mainBundle] loadNibNamed:@"HealthTopScrollHeaderView" owner:self options:nil] firstObject];
        _HeaderTopScrollView.delegate = self;
        _HeaderTopScrollView.left=0;
        _HeaderTopScrollView.top=PublicY;
        _HeaderTopScrollView.width=KScreenWidth;
        _HeaderTopScrollView.height= KHeight(180)-(PublicY);
    }
    return _HeaderTopScrollView;
}

-(HealthRecordNoDataFooterView *)rowFooterView
{
    
    if (!_rowFooterView) {
        _rowFooterView = [[[NSBundle mainBundle] loadNibNamed:@"HealthRecordNoDataFooterView" owner:self options:nil] firstObject];
        //        _rowFooterView.delegate = self;
        _rowFooterView.left=0;
        _rowFooterView.top=PublicY;
        _rowFooterView.width=KScreenWidth;
        _rowFooterView.height=KHeight(180)-(PublicY);
    }
    return _rowFooterView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getRecordFamilyPersonWithNetWorking];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.myTitle = @"健康档案";
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_my_setting"] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(enterArchive) forControlEvents:UIControlEventTouchUpInside];
    self.userMemberID = [UserInfoTool getLoginInfo].MemberID;
    [self getHealthRecordHomeResultWithNetWorking:self.userMemberID];
   
}

#pragma mark UI
- (void)createUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator=NO;
    tableView.showsHorizontalScrollIndicator=NO;
    tableView.delegate = self;
    tableView.dataSource = self;
     tableView.backgroundColor = kbackGroundGrayColor;
     self.view.backgroundColor = kbackGroundGrayColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"HealthRecordCell" bundle:nil] forCellReuseIdentifier:@"HealthRecordCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HealthRecordMedical TableViewCell" bundle:nil] forCellReuseIdentifier:@"HealthRecordMedical TableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HealthInformationCell" bundle:nil] forCellReuseIdentifier:@"HealthInformationCell"];
    [self.view addSubview:tableView];
     self.tableView = tableView;
//    self.sportBasicArr = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"运动步数%ld",self.modle.AttendanceTime],[NSString stringWithFormat:@"饮水量%@",self.modle.AttendanceType],[NSString stringWithFormat:@"工作时间%@",self.modle.DepartmentsName],[NSString stringWithFormat:@"休息时间%@",self.modle.DepartmentsName],[NSString stringWithFormat:@"今日服药%@",self.modle.DepartmentsName],[NSString stringWithFormat:@"健康计划%@",self.modle.DepartmentsName]]];
     self.tableView.tableHeaderView= self.HeaderTopScrollView;
    [self.tableView setSeparatorColor:[UIColor clearColor]];
}

#pragma mark  HealthTopScrollHeaderView代理
-(void)addFamilyTools;
{
  
    [self openPersonArchiveUI];
}
-(void)replaceRelationData:(NSInteger )dataInt;//切换数据
{
    self.userMemberID = dataInt;
    
    [self getHealthRecordHomeResultWithNetWorking:dataInt];
}

- (void)getRecordFamilyPersonWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
//      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HealthRecordViewModel getRecordFamilyPersonWithParmas:dic FinishedBlock:^(ResponseObject *response) {
//          [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
           NSArray *fameliyDataArr =    [FamilyObject mj_objectArrayWithKeyValuesArray:response.Result];

            NSInteger userID = [UserInfoTool getLoginInfo].MemberID;
            for (FamilyObject *objec in fameliyDataArr) {
                if (objec.FamilyMemberID == self.userMemberID) {
                    userID = self.userMemberID;
                    break;
                }
            }
                
            self.HeaderTopScrollView.userMemberID = userID;
            self.userMemberID = userID;
            self.HeaderTopScrollView.familyArr = [FamilyObject mj_objectArrayWithKeyValuesArray:response.Result];
              NSLog(@"获取健康档案家人及本身信息列表326%@",self.HeaderTopScrollView.familyArr);
            [self getHealthRecordHomeResultWithNetWorking:self.userMemberID];

            [self.tableView reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}
-(void)goRemindFamilyWithNet:(NSInteger)RemindType MemberID:(NSInteger)MemberID{
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"RemindType":@(RemindType),
                           @"MemberID":@(MemberID)
                          };
     [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HealthRecordViewModel getRecordRemindFamilyPersonWithParmas:dic FinishedBlock:^(ResponseObject *response) {
        NSLog(@"320健康记录提醒家人%@",response.Result);
        [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            NSLog(@"200 成功");
            ShowSuccessStatus(@"提醒成功");
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
    
}
- (void)getHealthRecordHomeResultWithNetWorking:(NSInteger)MemberID//PersonalArchiveViewController
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@(MemberID)};
     [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HealthRecordViewModel getHealthRecordHomeResultWithParams:dic FinishedBlock:^(ResponseObject *response) {
          [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.personalMsg = [PersonalArcModel mj_objectWithKeyValues:response.Result[@"PersonalInfo"]];
            UserInfoModel *userModel = [UserInfoTool getLoginInfo];
            userModel.FullName = self.personalMsg.FullName;
            [UserInfoTool saveLoginInfo:userModel];
            self.modl = [PhysicalInfo mj_objectWithKeyValues:response.Result[@"PhysicalInfo"]];//为空 时表示没有健康体检记录
            self.modle = [PatientInfo mj_objectWithKeyValues:response.Result[@"PatientInfo"]];//为空 时表示没有电子病历记录
            [self.basicInforamtionArr removeAllObjects];
            [self.aewArchiveArray removeAllObjects];
            [self.healthbasicArr removeAllObjects];
            if (self.personalMsg&&self.personalMsg.RecordID!=0) {//为空 或者RecordID为0时表示没有健康档案
                  if (self.personalMsg.Birthday.length>0||self.personalMsg.Height>0||self.personalMsg.Weight>0||self.personalMsg.BloodType.length>0||self.personalMsg.AllergyDrug.length>0) {
                       Dateformat *dateF =  [[Dateformat alloc]init];
                    
                      self.basicInforamtionArr = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"生日：%@",[dateF DateFormatWithDate:self.personalMsg.Birthday withFormat:@"YYYY-MM-dd"]],[NSString stringWithFormat:@"身高：%icm",self.personalMsg.Height],[NSString stringWithFormat:@"体重：%ikg",self.personalMsg.Weight],[NSString stringWithFormat:@"血型：%@",self.personalMsg.BloodTypeName.length>0?self.personalMsg.BloodTypeName:@"无"],[NSString stringWithFormat:@"过敏药物：%@",self.personalMsg.AllergyDrug]]];
                  }else
                  {
                     
                      self.basicInforamtionArr = [NSMutableArray arrayWithCapacity:0];
                      
                  }
            
                if (self.personalMsg.FamilyHistory.length>0||self.personalMsg.ProjectOperation.length>0||self.personalMsg.PastHistory.length>0||self.personalMsg.SmokingStatusName.length>0||self.personalMsg.LongTermMedicine.length>0||self.personalMsg.DrinkingStatusName.length>0) {
                     self.healthbasicArr = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"家族病史：%@",self.personalMsg.FamilyHistory],[NSString stringWithFormat:@"手术史：%@",self.personalMsg.ProjectOperation],[NSString stringWithFormat:@"疾病史：%@",self.personalMsg.PastHistory],[NSString stringWithFormat:@"吸烟史：%@",self.personalMsg.SmokingStatusName],[NSString stringWithFormat:@"用药史：%@",self.personalMsg.LongTermMedicine],[NSString stringWithFormat:@"饮酒史：%@",self.personalMsg.DrinkingStatusName]]];
                }else
                {
                      self.healthbasicArr = [NSMutableArray arrayWithCapacity:0];
                }
            }
            if (self.modl) {
                if (self.modl.CheckCount>0||self.modl.NormalCount>0||self.modl.ExceptionCount>0) {
                    self.aewArchiveArray = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"检查项目：%i项",self.modl.CheckCount],[NSString stringWithFormat:@"正常项目：%i项",self.modl.NormalCount],[NSString stringWithFormat:@"异常项目：%i项",self.modl.ExceptionCount]]];
                }else
                    self.aewArchiveArray = [NSMutableArray arrayWithCapacity:0];
               
            }
             self.MoodID = [response.Result[@"MoodID"] intValue];
             NSArray *sportArr = [TopRecordModel mj_objectArrayWithKeyValuesArray:response.Result[@"HealthRecord"]];
            NSMutableArray *planModArray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *sportModArray = [NSMutableArray arrayWithCapacity:0];
            BOOL isContainPlan = NO;
            for (TopRecordModel *planMod in sportArr) {
                if (planMod.RemindType == 3) {
                    [planModArray addObject:planMod];
                    isContainPlan = YES;
                }else
                     [sportModArray addObject:planMod];
            }
            self.sportBasicArr = [NSMutableArray arrayWithArray:sportModArray];
//            if (isContainPlan == YES) {
                TopRecordModel *mod = [[TopRecordModel alloc]init];
                mod.Title = @"健康计划";
                mod.RemindType = 3;
                [self.sportBasicArr addObject:mod];
//            }
            self.PlanBasicArr = [NSMutableArray arrayWithArray:planModArray];
            NSLog(@"获取健康档案首页（下半部分）319%@",response.Result);
            [self.tableView reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.sportBasicArr.count;
    }
    else  if (section==4)
    {
        if (self.modle.PatientID!=0) {
            return 1;
        }else
            return 0;
    }
    else  if (section==1)
    {
        if (self.basicInforamtionArr) {
            return self.basicInforamtionArr.count;
        }else
            return 0;
    }
    else  if (section==2)
    {
        if (self.healthbasicArr) {
            return self.healthbasicArr.count;
        }else
            return 0;
    }
    else  if (section==3)
    {
        if (self.aewArchiveArray) {
            return self.aewArchiveArray.count;
        }else
            return 0;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;//self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HealthRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:testReportListCell];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userMemberID = self.userMemberID;
        cell.recprdMod = self.sportBasicArr[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    
    else  if (indexPath.section==4)
    {
        NSString *cellid = @"HealthRecordMedical TableViewCell";
        HealthRecordMedical_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        //cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modle = self.modle;
        return cell;
    }else  if (indexPath.section==1)
    {
        
        NSString *cellid = @"HealthInformationCell";
        HealthInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
           cell.dataStr = self.basicInforamtionArr[indexPath.row];
        //        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else  if (indexPath.section==2)
    {
        
        NSString *cellid = @"HealthInformationCell";
        HealthInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.dataStr = self.healthbasicArr[indexPath.row];
        //        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else
    {
        
        NSString *cellid = @"HealthInformationCell";
        HealthInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (self.modl.IsOverall==2&&(indexPath.row == self.aewArchiveArray.count-1)) {//self.modl.ExceptionCount>0
            [cell.goBtn setTitle:@"解读" forState:UIControlStateNormal];
            cell.goBtn.layer.borderColor = [UIColor getColor:@"F67475"].CGColor;
            [cell.goBtn setTitleColor:[UIColor getColor:@"F67475"] forState:UIControlStateNormal];
            cell.goBtn.hidden = NO;
        }else
            cell.goBtn.hidden = YES;
         cell.dataStr = self.aewArchiveArray[indexPath.row];
      
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        return KHeight(113)+6;
    }else
    return KHeight(40);//KHeight(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 4) {
     
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        HealthRecordHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordHeaderView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"今日健康记录";
        headV.MoodID = self.MoodID;
        headV.editBtn.layer.borderWidth = 0;
        headV.delegate = self;
        return headV;
    }else if (section == 1){
        HealthRecordHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordHeaderView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"基本健康信息";
          [headV.editBtn setTitle:@"编辑" forState: UIControlStateNormal];
//        if (self.basicInforamtionArr.count>0) {
        if (self.userMemberID == [UserInfoTool getLoginInfo].MemberID) {
         
            headV.editBtn.hidden = NO;
        }else
        {

              headV.editBtn.hidden = YES;
        }
        
        headV.delegate = self;
        //        headV.arrowImg.hidden = NO;
        return headV;
    }
    else if (section == 2){
        HealthRecordHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordHeaderView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康史信息";
          [headV.editBtn setTitle:@"编辑" forState: UIControlStateNormal];
//        if (self.healthbasicArr.count>0) {
        if (self.userMemberID == [UserInfoTool getLoginInfo].MemberID) {
            headV.editBtn.hidden = NO;
        }else
        {

            headV.editBtn.hidden = YES;
        }
        headV.delegate = self;
        return headV;
    }
    else if (section == 3){
        HealthRecordHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordHeaderView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"最新检测报告";
        [headV.editBtn setTitle:@"查看详情" forState: UIControlStateNormal];
        if (self.userMemberID == [UserInfoTool getLoginInfo].MemberID) {
            headV.editBtn.hidden = NO;
        }else
        {
            
            headV.editBtn.hidden = YES;
        }
        headV.delegate = self;
        return headV;
    }
    else{
        HealthRecordHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordHeaderView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"最新电子病历";
        [headV.editBtn setTitle:@"查看更多" forState: UIControlStateNormal];
        if (self.userMemberID == [UserInfoTool getLoginInfo].MemberID) {
            headV.editBtn.hidden = NO;
        }else
        {
            
            headV.editBtn.hidden = YES;
        }
         headV.delegate = self;
        return headV;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45+6;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
//        for (TopRecordModel *mod in self.sportBasicArr) {
//            if ([mod.Title isEqualToString:@"健康计划"]) {
//                return 213;
//            }
//        }
        if (self.PlanBasicArr.count>0) {
            return (self.PlanBasicArr.count*45)+6;
           
        }else
            return 90+20;
        return 90+20;//UITableViewAutomaticDimension;
    }
    else if (section == 1)
    {
        if (self.basicInforamtionArr.count>0) {
            return 0.01;
        }else
            return 199;
    }
    else  if (section==4)
    {
        if (self.modle.PatientID!=0) {
            return 0.01;
        }else
            return 228;
    }
    else  if (section==2)
    {
        if (self.healthbasicArr.count>0) {
            return 0.01;
        }else
            return 228;
    }
    else  if (section==3)
    {
        if (self.aewArchiveArray.count>0) {
            if (self.modl.ExceptionCount >0) {
                return (self.modl.ExceptionCount*45)+6;
//                self.tableView.estimatedRowHeight = 50.0f;
//                self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
//                return UITableViewAutomaticDimension;
            }else{
            return 0.01;
            }
        }else
            return 228;
    }
   else
        return 228;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0){
        if (self.PlanBasicArr.count>0) {
            HealthRecordFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordFooterView" owner:self options:nil]  firstObject];
            footerV.planOrArchive = YES;
            footerV.userMemberID = self.userMemberID;
            footerV.basicArr = self.PlanBasicArr;
            footerV.delegate = self;
            return footerV;
        }else
        {
            
            
            HealthPlanRecordFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthPlanRecordFooterView" owner:self options:nil]  firstObject];
            footerV.delegate = self;
            if (self.userMemberID != [UserInfoTool getLoginInfo].MemberID) {
                footerV.addBtn.hidden = YES;
                
            }else
                footerV.addBtn.hidden = NO;
             return footerV;
        }
       
    }
   else if (section == 1){
       if (self.basicInforamtionArr.count>0) {
           UIView *view = [[UIView alloc]init];
           return view;
       }else
       {
        HealthRecordNoneDataCell *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordNoneDataCell" owner:self options:nil]  firstObject];
        footerV.titleLab.text=@"加入健康队伍";
        [footerV.goBtn setTitle:@"我来了" forState:UIControlStateNormal];
        footerV.delegate = self;
        return footerV;
       }
    }
    else if (section == 2){
        if (self.healthbasicArr.count>0) {
            UIView *view = [[UIView alloc]init];
            return view;
        }else
        {
        HealthRecordNoDataFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordNoDataFooterView" owner:self options:nil]  firstObject];
        footerV.titleLab.text=@"加入健康队伍就差这一步了";
        [footerV.goBtn setTitle:@"这就来" forState:UIControlStateNormal];
        footerV.delegate = self;
        return footerV;
        }
    }
    else if (section == 3){
        if (self.aewArchiveArray.count>0) {
           
          
            if (self.modl.ExceptionCount >0) {
                HealthRecordFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordFooterView" owner:self options:nil]  firstObject];
                 footerV.planOrArchive = NO;
                footerV.basicArr = self.modl.ItemList;
//                footerV.delegate = self;
                return footerV;
            }else{
                
                 UIView *view = [[UIView alloc]init];
                return view;
            }
                
            
            
        }else
        {
        HealthRecordNoDataFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordNoDataFooterView" owner:self options:nil]  firstObject];
        footerV.titleLab.text=@"您半年没跟“体检”约会了";
         [footerV.goBtn setTitle:@"约个时间" forState:UIControlStateNormal];
        footerV.delegate = self;
        return footerV;
        }
    }
    else{

        if (self.modle.PatientID!=0) {
            UIView *view = [[UIView alloc]init];
            return view;
        }else
        {
      
        HealthRecordNoDataFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"HealthRecordNoDataFooterView" owner:self options:nil]  firstObject];
        footerV.titleLab.text=@"之前的病历还在吗";
        
        [footerV.goBtn setTitle:@"找到TA上传" forState:UIControlStateNormal];
//        footerV.editBtn.layer.borderWidth = 0;
        footerV.delegate = self;
        return footerV;
    }
    }

}
-(void)enterArchive{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (FamilyObject *object in self.HeaderTopScrollView.familyArr) {
        if (object.FamilyMemberID != [UserInfoTool getLoginInfo].MemberID) {
             [tempArr addObject:object];
        }
           
    }
    ArchiveSettingViewController *detail = [[ArchiveSettingViewController alloc]initWithType:pageTypeNormal];
    detail.familyArr = tempArr;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark HealthRecordNoDataFooterViewDelegate
- (void)ComebuttonClick:(NSString *)title;
{
    if (self.userMemberID != [UserInfoTool getLoginInfo].MemberID) {
        return;
        
    }
    if ([title isEqualToString:@"约个时间"]) {
       
//        ExamDetailReportViewController *Examine = [[ExamDetailReportViewController alloc]initWithType:pageTypeNormal];
//        ExanubeReportModel *model =  [[ExanubeReportModel alloc]init];
//        model.PhysicalExaminationID = [NSString stringWithFormat:@"%i",self.modl.PhysicalExaminationID];
//        model.ExceptionCount = [NSString stringWithFormat:@"%i",self.modl.ExceptionCount] ;
//        model.CheckCount =  [NSString stringWithFormat:@"%i",self.modl.CheckCount];
//        model.TestTime = [NSString stringWithFormat:@"%li",self.modl.TestTime];
//        Examine.PhysicalExaminationModel = model;
//        FamilyObject *objFamily = [[FamilyObject alloc]init];
//        for (FamilyObject *objF in  self.HeaderTopScrollView.familyArr) {
//            if ( objF.FamilyMemberID == self.userMemberID) {
//                objFamily = objF;
//
//                break;
//            }
//        }
//        Examine.personal = objFamily;
//        [self.navigationController pushViewController:Examine animated:YES];
        
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
        web.urlString = [NSString stringWithFormat:@"%@/ReportOverall/AppointmentPhysicalActive?Token=%@&OSType=2&Version=%@",MallUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        web.myTitle = @"我的预约";
        [self.navigationController pushViewController:web animated:YES];
        
        
        
    }
    if ([title isEqualToString:@"这就来"]||[title isEqualToString:@"我来了"]) {
        
        RecordDetailController *detail = [[RecordDetailController alloc]initWithType:pageTypeNormal];
        detail.userMemberID = self.userMemberID;
        WEAKSELF
        detail.UserMemberId = ^(NSInteger memberId) {
            weakSelf.userMemberID  = memberId;
            
        };
        [self.navigationController pushViewController:detail animated:YES];
     
    }
    if ([title isEqualToString:@"找到TA上传"]) {
        MineElectronMedicController *detail = [[MineElectronMedicController alloc]initWithType:pageTypeNormal];
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (void)addComebuttonClick:(NSString *)title;
{
    if (self.userMemberID != [UserInfoTool getLoginInfo].MemberID) {
        return;
        
    }
  
    if ([title isEqualToString:@"这就来"]||[title isEqualToString:@"我来了"]) {
        
        RecordDetailController *detail = [[RecordDetailController alloc]initWithType:pageTypeNormal];
        detail.userMemberID = self.userMemberID;
        WEAKSELF
        detail.UserMemberId = ^(NSInteger memberId) {
            weakSelf.userMemberID  = memberId;
            
        };
        [self.navigationController pushViewController:detail animated:YES];
        
    }
 
}
#pragma mark HealthRecordHeaderViewDelegate
- (void)HealthRecordHeaderViewButtonClick:(NSString *)nameStr;
{
    if (self.userMemberID != [UserInfoTool getLoginInfo].MemberID) {
        return;
        
    }
    if ([nameStr isEqualToString:@"最新电子病历"]) {
        MineElectronMedicController *detail = [[MineElectronMedicController alloc]initWithType:pageTypeNormal];
        [self.navigationController pushViewController:detail animated:YES];
    }else if([nameStr isEqualToString:@"基本健康信息"]||[nameStr isEqualToString:@"健康史信息"])
    {
        
        RecordDetailController *detail = [[RecordDetailController alloc]initWithType:pageTypeNormal];
        detail.userMemberID = self.userMemberID;
        detail.SelectTab = [nameStr isEqualToString:@"基本健康信息"]?0:1;
        WEAKSELF
        detail.UserMemberId = ^(NSInteger memberId) {
            weakSelf.userMemberID  = memberId;
            
        };
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if ([nameStr isEqualToString:@"最新检测报告"]){
        
//        ExamDetailReportViewController *Examine = [[ExamDetailReportViewController alloc]initWithType:pageTypeNormal];
//        if (self.modl.PhysicalExaminationID!=0) {//体检编号为0就当没有这个数据
//            ExanubeReportModel *model =  [[ExanubeReportModel alloc]init];
//            model.PhysicalExaminationID = [NSString stringWithFormat:@"%i",self.modl.PhysicalExaminationID];
//            model.ExceptionCount = [NSString stringWithFormat:@"%i",self.modl.ExceptionCount] ;
//            model.CheckCount =  [NSString stringWithFormat:@"%i",self.modl.CheckCount];
//            model.TestTime = [NSString stringWithFormat:@"%li",self.modl.TestTime];
//           
//            Examine.PhysicalExaminationModel = model;
//        }
//       
//        FamilyObject *objFamily = [[FamilyObject alloc]init];
//        for (FamilyObject *objF in  self.HeaderTopScrollView.familyArr) {
//            if ( objF.FamilyMemberID == self.userMemberID) {
//                objFamily = objF;
//                
//                break;
//            }
//        }
//        Examine.personal = objFamily;
//      
//        [self.navigationController pushViewController:Examine animated:YES];
         [self goOverAll];
    }
    
   
}
#pragma mark   创建家人档案的底部选择已有家人
-(void)openPersonArchiveUI
{
    //5s:300 6:330
//    PersonArchiveBottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"PersonArchiveBottomView" owner:self options:nil]  firstObject];
//    bottomView.left = 0;
//    bottomView.top=0;
//    bottomView.width=KScreenWidth;
//    bottomView.height=KScreenHeight;
//    bottomView.delegate = self;
//    [[UIApplication sharedApplication].keyWindow addSubview:bottomView];
//    
    AddFamilyViewController *detail = [[AddFamilyViewController alloc]initWithType:pageTypeNormal];
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)ArchiveBottomViewSelectClick:(NSInteger)selectedIndex;
{
    
    NSLog(@"--------_%li",selectedIndex);
    if (selectedIndex == 1) {
        AddFamilyViewController *detail = [[AddFamilyViewController alloc]initWithType:pageTypeNormal];
        
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    if (selectedIndex == 0) {
        FamilyRelationController *detail = [[FamilyRelationController alloc]initWithType:pageTypeNormal];
        [self.navigationController pushViewController:detail animated:YES];
        
    }
}
#pragma mark HealthRecordCell 点击去运动。去饮水.休息
- (void)HealthRecordCellbuttonClick:(int)recprdModRemindType remind:(BOOL)remind  ;
{
    if (remind) {// 类型1、运动 2、饮水 3、健康计划  4、服药 5、休息(休息没有达不达标这一说,故把self.proessLab.text设为空)
           [self goRemindFamilyWithNet:recprdModRemindType MemberID:self.userMemberID];
    }else
    {
        
        if (recprdModRemindType == 1) {
            
            SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
            [self.navigationController pushViewController:sport animated:YES];
            
        }else if (recprdModRemindType == 2||recprdModRemindType == 4)
        {
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
            web.isNewHeight = YES;
            web.urlString = recprdModRemindType==2?kHealthDrinkUrl:kHealthMedicnaeUrl;
            web.myTitle = @" ";
//            web.hidesBottomBarWhenPushed = YES;
            if (recprdModRemindType == 2) {
                //展示当天任务是否完成  喝水
//                XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
//                [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(14)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(14)}];
            }
            [self.navigationController pushViewController:web animated:YES];
        }
        else if (recprdModRemindType == 5)
        {
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
            web.isNewHeight = YES;
            web.urlString = kHealthSitDownUrl;
            web.myTitle = @" ";
            [self.navigationController pushViewController:web animated:YES];
        }
    }

}
#pragma mark   解读
- (void)HealthInformationCellDelegatebuttonClick;
{
    
    [self goOverAll];
}
#pragma mark  去添加计划

- (void)HealthPlanRecordFooterViewbuttonClick;
{
    
    if (self.userMemberID != [UserInfoTool getLoginInfo].MemberID) {//自己的才可以点击去完成......
        return;
        
    }
    [self addPaln];
    
    
}
-(void)addPaln{
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.urlString = kHealthPlanUrl;
    web.myTitle = @"我的计划";
    web.isNewHeight = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}
-(void)enterPalnData:(NSInteger )planMainID memPlanID:(NSInteger )memPlanID PlanTypeID:(NSUInteger)PlanTypeID;{
    NSString *tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanMainIDUrl,(long)planMainID,memPlanID];
    if (PlanTypeID == 1) {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanMainIDUrl,(long)planMainID,memPlanID];
    }else if (PlanTypeID == 2)
    {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanSportIDUrl,(long)planMainID,memPlanID];
    }else
    {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanNurseIDUrl,(long)planMainID,memPlanID];
        
    }
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    web.urlString = tempUrlStr;
    web.myTitle = @"我的计划";
    [self.navigationController pushViewController:web animated:YES];
}
#pragma  mark   今日健康记录的尾部试图
- (void)HealthRecordFooterViewButtonClick:(TopRecordModel *)tModel remind:(BOOL)remind;
{
    
    if (remind) {//类型1、运动 2、饮水 3、健康计划  4、服药
        [self goRemindFamilyWithNet:tModel.RemindType MemberID:self.userMemberID];
    }else
    {
//    [self addPaln];
      [self enterPalnData:tModel.PlanMainID memPlanID:tModel.MemPlanID PlanTypeID:tModel.PlanTypeID];
    }
}
-(void)goOverAll{
    
    ExamDetailReportViewController *Examine = [[ExamDetailReportViewController alloc]initWithType:pageTypeNormal];
    if (self.modl.PhysicalExaminationID!=0) {//体检编号为0就当没有这个数据
        ExanubeReportModel *model =  [[ExanubeReportModel alloc]init];
        model.PhysicalExaminationID = [NSString stringWithFormat:@"%i",self.modl.PhysicalExaminationID];
        model.ExceptionCount = [NSString stringWithFormat:@"%i",self.modl.ExceptionCount] ;
        model.CheckCount =  [NSString stringWithFormat:@"%i",self.modl.CheckCount];
        model.TestTime = [NSString stringWithFormat:@"%li",self.modl.TestTime];
        
        Examine.PhysicalExaminationModel = model;
    }
    
    FamilyObject *objFamily = [[FamilyObject alloc]init];
    for (FamilyObject *objF in  self.HeaderTopScrollView.familyArr) {
        if ( objF.FamilyMemberID == self.userMemberID) {
            objFamily = objF;
            
            break;
        }
    }
    Examine.personal = objFamily;
    
    [self.navigationController pushViewController:Examine animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
