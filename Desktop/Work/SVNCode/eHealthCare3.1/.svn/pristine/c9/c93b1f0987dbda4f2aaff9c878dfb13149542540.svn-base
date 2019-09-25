//
//  PersonalArchiveViewController.m
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonalArchiveViewController.h"
#import "PersonalArcHeadView.h"
#import "PersonalCellHeadView.h"
#import "FamilyMemberViewController.h"
#import "PersonBackdropCell.h"
#import "PersonBackdropModel.h"
#import "PersonBackdropFrame.h"
#import "PersonexamCell.h"
#import "PersonLifeModel.h"
#import "PersonalArcModel.h"
#import "DetailReportModel.h"
#import "NewTrendHomeController.h"
#import "ReportNewModel.h"
#import "ExamNextController.h"
#import "XKMedicalRecords.h"
#import "XKMedicalRecordDetailController.h"
#import "XKAddMedicalRecordController.h"
#import "XKPatientModel.h"
//#import "LQPhotoPickerViewController.h"
#import "XKPatientTypeModel.h"

@interface PersonalArchiveViewController ()<UITableViewDelegate,UITableViewDataSource,PersonalArcHeadViewDelegate,UIAlertViewDelegate,XKMedicalRecordsDelegate>
{
    NSMutableArray *backOpenArr;
    NSMutableArray *backDataArr;
    NSMutableArray *backBigArr;
    NSMutableArray *backCellDataArr;
    
    NSMutableArray *habitOpenArr;
    NSMutableArray *habitDataArr;
    NSMutableArray *habitTextArr;
    NSMutableArray *habitBigArr;
    BOOL habitRet;//控制cell展开的button图片
    
    NSMutableArray *lifeDataArr;
    
    NSMutableArray *targetDataArr;//检测指标
    NSMutableArray *scoreTypeListArr;
    
    NSString *_nowBtn;
}
@property (nonatomic,strong)UITableView *mytable;
@property (nonatomic,strong)PersonalArcHeadView *headView;
@property (nonatomic,strong)XKArchiveTransetionDelegateModel *archiveCoverDelegate;
@property (nonatomic,strong)PersonalArcModel *allDataModel;
@property (nonatomic, strong) UIImageView *nullImgeView;

/**
 电子病历视图
 */
@property (nonatomic,strong)XKMedicalRecords *medicalRecords;

/**
 电子病历类型
 */
@property (nonatomic,strong) NSArray *typeArray;

@end

@implementation PersonalArchiveViewController

#pragma mark - 懒加载电子病历视图
-(XKMedicalRecords *)medicalRecords{
    
    if (!_medicalRecords) {
        
        _medicalRecords = [[[NSBundle mainBundle] loadNibNamed:@"XKMedicalRecords" owner:self options:nil] firstObject];
        
        _medicalRecords.delegate = self;
        
    }
    
    return _medicalRecords;
    
}

#pragma mark - 懒加载
-(XKArchiveTransetionDelegateModel *)archiveCoverDelegate{
    if (!_archiveCoverDelegate) {
        _archiveCoverDelegate=[[XKArchiveTransetionDelegateModel alloc]init];
    }
    return _archiveCoverDelegate;
}

-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2);
        _nullImgeView.image = [UIImage imageNamed:@"none"];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}
-(PersonalArcHeadView *)headView{
    if (!_headView) {
        _headView=[[[NSBundle mainBundle]loadNibNamed:@"PersonalArcHeadView" owner:self options:nil]firstObject];
        _headView.x=0;
        _headView.y=0;
        _headView.delegate = self;
        [_headView.familBtn addTarget:self action:@selector(clickFamily) forControlEvents:UIControlEventTouchUpInside];
        [_headView.trendBtn addTarget:self action:@selector(clickTrend) forControlEvents:UIControlEventTouchUpInside];
        _headView.width=KScreenWidth;
        _headView.backgroundColor = NAVICOLOR;
        _headView.height=140;
    }
    return _headView;
}

/**查看电子病历*/
-(void)selectdetial:(NSIndexPath *)index dataModel:(XKPatientModel *)model{
    
    XKMedicalRecordDetailController *detail = [[XKMedicalRecordDetailController alloc] initWithStyle:UITableViewStylePlain];
    
    detail.MemberID = self.MemberID;
    
    detail.typeArray = self.typeArray;
    
    detail.model = model;
    
    detail.title = @"查看病历";
    
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:detail];
    
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [self  presentViewController:nav animated:YES completion:nil];
    
}

/**添加电子病历*/
-(void)addMedicalRecord{
    
    XKAddMedicalRecordController *addRecord = [[XKAddMedicalRecordController alloc] initWithStyle:UITableViewStylePlain];
    addRecord.MemberID = self.MemberID;
    
    addRecord.title = @"添加病历";
    addRecord.typeArray = self.typeArray;
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:addRecord];
    
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [self  presentViewController:nav animated:YES completion:nil];
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.isfriend) {
        self.headView.familBtn.hidden = YES;
        self.headView.trendBtn.hidden = YES;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(clickDelect)];
    }
    self.allDataModel = [[PersonalArcModel alloc]init];//初始化model
    if (!self.isfriend) {
        self.MemberID = [UserInfoTool getLoginInfo].MemberID;
    }
    
    _nowBtn = @"背景";//默认是第一个背景cell
    self.view.backgroundColor = NAVICOLOR;
    self.mytable.backgroundColor = NAVICOLOR;
    [self.view addSubview:self.headView];
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), KScreenWidth, KScreenHeight - 64 - self.headView.frame.size.height) style:UITableViewStylePlain];
    
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    self.mytable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.mytable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //复用注册
    [self.mytable registerNib:[UINib nibWithNibName:@"PersonexamCell" bundle:nil] forCellReuseIdentifier:@"PersonexamCell"];
    
    //增加下拉刷新
    self.mytable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHeadData)];
    
    [self.view addSubview:self.mytable];
    
    //请求缓存数据
    if (!self.isfriend) {
        [self loadDataFromBase];
    }
    
    //    [self loadTargetData];
    
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(editDone) name:@"endEditArchive" object:nil];
    
    //调整电子病历视图的位置
    self.medicalRecords.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), KScreenWidth, KScreenHeight - 64 - self.headView.frame.size.height);
    //添加电子病历视图
    [self.view addSubview:self.medicalRecords];
    self.medicalRecords.hidden = YES;
    //网络请求数据
    //    if (self.isFirstLoadData == 1) {
    //            [self loadData];
    //            [self loadType];//加载电子病历类型
    //    }
    
    
    if (self.RecordID != 0) {//电子病历编号赋值
        self.medicalRecords.RecordID = self.RecordID;
    }
    
//    if (![_nowBtn isEqualToString:@"检测指标"]) {
        [self loadType];
//    }
    
}
/**
 加载电子病历类型方法
 */
-(void)loadType{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"927" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token} success:^(id json) {
        
        XKLOG(@"%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            self.typeArray = [XKPatientTypeModel objectArrayWithKeyValuesArray:json[@"Result"]];
            [[EGOCache globalCache] setObject:json[@"Result"] forKey:[NSString stringWithFormat:@"%@%li",@"XKPatientTypeModel",[UserInfoTool getLoginInfo].MemberID]];
            [[XKLoadingView shareLoadingView] hideLoding];
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:@"加载失败"];
        
    }];
    
}

-(void)getHeadData
{
    if ([_nowBtn isEqualToString:@"检测指标"]) {
        [self loadTargetData];
    }else{
        [self loadData];
        [self loadType];
    }
}

#pragma mark - 通知响应事件
-(void)editDone
{
    XKLOG(@"编辑数据保存成功，刷新个人档案数据");
    [self loadData];
    
}

#pragma mark - 获取数据
//数据库
-(void)loadDataFromBase
{
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%li",@"arcInfo",[UserInfoTool getLoginInfo].MemberID]]) {
        NSDictionary *dic1 = (NSDictionary *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%li",@"arcInfo",[UserInfoTool getLoginInfo].MemberID]];
        self.allDataModel = [PersonalArcModel objectWithKeyValues:dic1[@"Result"]];
        self.headView.model = self.allDataModel;
        //拿到数据之后分别赋值
        [self addBackData];
        [self addHabitData];
        [self addLifeData];
    }
    
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%li",@"arcExamInfo",[UserInfoTool getLoginInfo].MemberID]]){
        NSDictionary *dic2 = (NSDictionary *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%li",@"arcExamInfo",[UserInfoTool getLoginInfo].MemberID]];
        targetDataArr = (NSMutableArray *)[ReportNewModel objectArrayWithKeyValuesArray:dic2[@"Result"]];
        
        [self.mytable reloadData];
    }
    
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%li",@"XKPatientTypeModel",[UserInfoTool getLoginInfo].MemberID]]){
        
        
        NSDictionary *dic2 =(NSDictionary *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%li",@"XKPatientTypeModel",[UserInfoTool getLoginInfo].MemberID]];
        self.typeArray = [XKPatientTypeModel objectArrayWithKeyValuesArray:dic2];
    }
}

-(void)loadData
{
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[NSNumber numberWithInteger:self.MemberID]};
    
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"300" parameters:dict success:^(id json) {
        XKLOG(@"个人档案300：%@",json);
        NSDictionary *dic=[json objectForKey:@"Basis"];
        
        if ([[NSString stringWithFormat:@"%@",dic[@"Status"]] isEqualToString:@"200"]) {
            [[XKLoadingView shareLoadingView] hideLoding];
            
            self.allDataModel = [PersonalArcModel objectWithKeyValues:[json objectForKey:@"Result"]];
            self.medicalRecords.MemberID = self.MemberID;//给电子病历赋值当前的会员id
            self.medicalRecords.RecordID = [self.allDataModel.RecordID integerValue];//给电子病历赋值当前的会员id
            [[NSNotificationCenter defaultCenter]postNotificationName:@"sendData" object:self.allDataModel userInfo:nil];
            
            self.headView.model = self.allDataModel;
            
            //拿到数据之后分别赋值
            [self addBackData];
            [self addHabitData];
            [self addLifeData];
            
            [self.mytable.mj_header endRefreshing];
            [self.mytable reloadData];
            
            if (!self.isfriend) {
                [[EGOCache globalCache] setObject:(NSDictionary *)json forKey:[NSString stringWithFormat:@"%@%li",@"arcInfo",[UserInfoTool getLoginInfo].MemberID]];
            }
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            [self.mytable.mj_header endRefreshing];
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:error];
        [self.mytable.mj_header endRefreshing];
    }];
}

-(void)loadTargetData
{
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[NSNumber numberWithInteger:self.MemberID ]};
    
    //    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"303" parameters:dict success:^(id json) {
        
        XKLOG(@"检测指标303：%@",json);
        NSDictionary *dic= (NSDictionary *)json;
        
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            
            targetDataArr = [[NSMutableArray alloc]init];
            //            scoreTypeListArr = [[NSMutableArray alloc] init];
            
            targetDataArr = (NSMutableArray *)[ReportNewModel objectArrayWithKeyValuesArray:dic[@"Result"]];
            
            [self.view addSubview:self.nullImgeView];
            [self.mytable reloadData];
            [self.mytable.mj_header endRefreshing];
            
            if (!self.isfriend) {
                [[EGOCache globalCache] setObject:(NSDictionary *)json forKey:[NSString stringWithFormat:@"%@%li",@"arcExamInfo",[UserInfoTool getLoginInfo].MemberID]];
            }
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"加载失败"];
            [self.mytable.mj_header endRefreshing];
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [self.mytable.mj_header endRefreshing];
        [[XKLoadingView shareLoadingView] errorloadingText:error];
    }];
}


#pragma mark - 四个模块的数据
-(void)addBackData
{
    backCellDataArr = [[NSMutableArray alloc] init];//存放个人病史 和 家庭病史的数组
    NSArray *personArr = [self dealPersonStringWith:self.allDataModel.PastHistory];
    NSArray *familyArr = [self dealFamilyStringWith:self.allDataModel.FamilyHistory];
    NSArray *medicalNameArr = [self dealPersonStringWith:self.allDataModel.MedicalPaymentNameList];
    
    
    //**控制背景分组数
    backOpenArr = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    NSString *str=self.allDataModel.PermanentAddress.length==0?@"":self.allDataModel.PermanentAddress;
    //**haeadView 组试图的数据数组
    backBigArr = [NSMutableArray arrayWithArray:@[@{@"name":@"籍贯",@"text":str},@{@"name":@"户口类型",@"text":self.allDataModel.ResidenceType},@{@"name":@"婚况",@"text":self.allDataModel.MaritalStatus},@{@"name":@"血型",@"text":self.allDataModel.BloodType},@{@"name":@"文化程度",@"text":self.allDataModel.EducationLevel}]];
    
    if (medicalNameArr.count == 0) {
        [backBigArr addObject:@{@"name":@"医保类型",@"text":@"未添加"}];
    }else{
        [backBigArr addObject:@{@"name":@"医保类型",@"text":@"有"}];
    }
    
    if (personArr.count == 0) {
        if ([self.allDataModel.PastHistory isEqualToString:@"无疾病"]) {
            [backBigArr addObject:@{@"name":@"个人病史",@"text":self.allDataModel.PastHistory}];
        }else{
            [backBigArr addObject:@{@"name":@"个人病史",@"text":@"未填写"}];
        }
    }else{
        [backBigArr addObject:@{@"name":@"个人病史",@"text":@"有"}];
    }
    
    if (familyArr.count == 0) {
        [backBigArr addObject:@{@"name":@"家庭病史",@"text":@"未填写"}];
    }else{
        [backBigArr addObject:@{@"name":@"家庭病史",@"text":@"有"}];
    }
    
    //**添加背景前五组组的cell数
    backDataArr = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0,@0]];
    [backDataArr addObject:[NSNumber numberWithInteger:medicalNameArr.count]];//添加个人病史展开的cell数量
    [backDataArr addObject:[NSNumber numberWithInteger:personArr.count]];//添加个人病史展开的cell数量
    [backDataArr addObject:[NSNumber numberWithInteger:familyArr.count]];//添加家庭病史展开的cell数量
    
    [backCellDataArr addObject:medicalNameArr];//存入个人病史的数据
    [backCellDataArr addObject:personArr];//存入个人病史的数据
    [backCellDataArr addObject:familyArr];//存入家庭病史的数据
    
}

-(void)addHabitData
{
    habitOpenArr = [[NSMutableArray alloc]init];
    habitDataArr = [[NSMutableArray alloc] init];
    if ([self.allDataModel.SmokingStatusID isEqualToString:@"1"]) {
        [habitDataArr addObject:@2];//根据SmokingStatusID，控制cell的数量
    }else{
        [habitDataArr addObject:@0];
    }
    [habitOpenArr addObjectsFromArray:@[@"0",@"0",@"0",@"0"]];//控制背景分组数
    [habitDataArr addObjectsFromArray:@[@0,@0,@0]];//控制背景每组的cell数
    habitTextArr = [[NSMutableArray alloc]init];//背景cell中的内容
    
    //haeadView 组试图的数据数组
    habitBigArr = [NSMutableArray array];
    
    //判断抽烟--喝酒--睡眠规律--长期服药的情况处理
    if ([[NSString stringWithFormat:@"%@",self.allDataModel.SmokingStatusID] isEqualToString:@"1"]) {
        [habitBigArr addObject:@{@"name":@"抽烟",@"text":self.allDataModel.SmokingStatusName}];
    }else if ([[NSString stringWithFormat:@"%@",self.allDataModel.SmokingStatusID] isEqualToString:@"0"]){
        [habitBigArr addObject:@{@"name":@"抽烟",@"text":@"不吸烟"}];
    }else{
        [habitBigArr addObject:@{@"name":@"抽烟",@"text":@"未选择"}];
    }
    
    //    if ([[NSString stringWithFormat:@"%@",self.allDataModel.DrinkingStatusID] isEqualToString:@"1"]){
    //        [habitBigArr addObject:@{@"name":@"喝酒",@"text":@"不饮"}];
    //    }else if ([[NSString stringWithFormat:@"%@",self.allDataModel.DrinkingStatusID] isEqualToString:@"2"]){
    //        [habitBigArr addObject:@{@"name":@"喝酒",@"text":@"少于每月1次"}];
    //    }else if ([[NSString stringWithFormat:@"%@",self.allDataModel.DrinkingStatusID] isEqualToString:@"3"]){
    //        [habitBigArr addObject:@{@"name":@"喝酒",@"text":@"至少每月饮酒一次"}];
    //    }else {
    //        [habitBigArr addObject:@{@"name":@"喝酒",@"text":@"未选择"}];
    //    }
    
    if (self.allDataModel.DrinkingStatusName.length>0) {
        [habitBigArr addObject:@{@"name":@"喝酒",@"text":self.allDataModel.DrinkingStatusName}];
    }else{
        [habitBigArr addObject:@{@"name":@"喝酒",@"text":@"未选择"}];
    }
    
    if ([[NSString stringWithFormat:@"%@",self.allDataModel.SleepRule] isEqualToString:@"1"]) {
        [habitBigArr addObject:@{@"name":@"睡眠规律",@"text":@"是"}];
    }else if ([[NSString stringWithFormat:@"%@",self.allDataModel.SleepRule] isEqualToString:@"0"]){
        [habitBigArr addObject:@{@"name":@"睡眠规律",@"text":@"否"}];
    }else{
        [habitBigArr addObject:@{@"name":@"睡眠规律",@"text":@"未选择"}];
    }
    
    if ([[NSString stringWithFormat:@"%@",self.allDataModel.LongMedication] isEqualToString:@"1"]) {
        [habitBigArr addObject:@{@"name":@"长期服药",@"text":@"是"}];
    }else if([[NSString stringWithFormat:@"%@",self.allDataModel.LongMedication] isEqualToString:@"0"]) {
        [habitBigArr addObject:@{@"name":@"长期服药",@"text":@"否"}];
    }else{
        [habitBigArr addObject:@{@"name":@"长期服药",@"text":@"未选择"}];
    }
    
    //抽烟的展开cell数据
    for (int i = 0; i < 2; i++) {
        PersonBackdropModel *model = [[PersonBackdropModel alloc]init];
        PersonBackdropFrame *frame = [[PersonBackdropFrame alloc] init];
        if (i == 0) {
            model.numArr =  @[self.allDataModel.SmokingAge];
            model.name = @"烟龄";
        }else if(i == 1){
            model.numArr =  @[self.allDataModel.SmokingAmountDay];
            model.name = @"每天数量";
        }
        frame.personModel = model;
        [habitTextArr addObject:frame];//cell的数据数组
    }
}
-(void)addLifeData
{
    lifeDataArr = [[NSMutableArray alloc]init];
    NSArray *contextArr;
    if (self.allDataModel.LifeEnvironmentName.length == 0) {
        contextArr = @[@"",@"",@"",@""];
    }else{
        contextArr = [self.allDataModel.LifeEnvironmentName  componentsSeparatedByString:@","];
    }
    NSArray *arr = @[@{@"name":@"厨房排风",@"text":contextArr[3]},@{@"name":@"燃料类型",@"text":contextArr[0]},@{@"name":@"饮水",@"text":contextArr[1]},@{@"name":@"厕所",@"text":contextArr[2]}];
    for (int i = 0; i < arr.count; i++) {
        PersonLifeModel *model = [[PersonLifeModel alloc]init];
        model.title = arr[i][@"name"];
        model.text = arr[i][@"text"];
        model.resultStr = @"";
        [lifeDataArr addObject:model];
    }
}

#pragma mark - 字符串处理方法
-(NSArray *)dealPersonStringWith:(NSString *)str
{
    if (str.length == 0 || [str isEqualToString:@"无疾病"]) {
        return @[];
    }
    NSArray *arr = [str componentsSeparatedByString:@","];
    
    PersonBackdropModel *model = [[PersonBackdropModel alloc]init];
    PersonBackdropFrame *frame = [[PersonBackdropFrame alloc] init];
    model.name = @"";//个人病史没有名字
    model.numArr = arr;
    frame.personModel = model;
    
    NSArray *dataArr = @[frame];
    return dataArr;
}
-(NSArray *)dealFamilyStringWith:(NSString *)str
{
    if (str.length == 0) {
        return @[];
    }
    NSMutableArray *arr;
    arr = [[NSMutableArray alloc]init];
    NSArray *typeArr = [str componentsSeparatedByString:@"|"];
    for (NSString *s  in typeArr) {
        PersonBackdropModel *model = [[PersonBackdropModel alloc]init];
        PersonBackdropFrame *frame = [[PersonBackdropFrame alloc] init];
        NSArray *getNameArr = [s componentsSeparatedByString:@","];
        model.name = getNameArr[0];//父亲、母亲放进model中
        model.numArr = [getNameArr[1] componentsSeparatedByString:@"-"];
        frame.personModel = model;
        [arr addObject:frame];
    }
    
    return arr;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.nullImgeView.alpha = 0;
    if ([_nowBtn isEqualToString:@"背景"]) {
        
        return backOpenArr.count;//分组数
    }else if ([_nowBtn isEqualToString:@"检测指标"]) {
        if (targetDataArr.count == 0) {
            self.nullImgeView.alpha = 1;
        }else{
            self.nullImgeView.alpha = 0;
        }
        return 1;
    }else if ([_nowBtn isEqualToString:@"生活习惯"]){
        return habitOpenArr.count;//分组数
    }else{
        //居住环境
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_nowBtn isEqualToString:@"背景"]) {
        if ([backOpenArr[section] isEqualToString:@"1"]) {
            return [backCellDataArr[section - 5] count];
        }else{
            return 0;
        }
        
    }else if ([_nowBtn isEqualToString:@"检测指标"]) {
        return targetDataArr.count;
        
    }else if ([_nowBtn isEqualToString:@"生活习惯"]){
        if ([habitOpenArr[section] isEqualToString:@"1"]) {
            return [habitDataArr[section] integerValue];
        }else{
            return 0;
        }
        
    }else{
        //居住环境
        return lifeDataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_nowBtn isEqualToString:@"背景"]) {
        NSString *cellid = @"cellid";
        PersonBackdropCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonBackdropCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        PersonBackdropFrame *frame = backCellDataArr[indexPath.section - 5][indexPath.row];
        cell.backdropFrame= frame;
        return cell;
        
    }else if ([_nowBtn isEqualToString:@"检测指标"]) {
        ReportNewModel  *model = targetDataArr[indexPath.row];
        //检测指标
        PersonexamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonexamCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.targetModel = model;
        return cell;
        
    }else if ([_nowBtn isEqualToString:@"生活习惯"]) {
        NSString *cellid = @"cellid";
        PersonBackdropCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[PersonBackdropCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        PersonBackdropFrame *frame = habitTextArr[indexPath.row];
        cell.backdropFrame= frame;
        return cell;
        
    }else{
        PersonLifeModel *model = lifeDataArr[indexPath.row];
        //居住环境
        PersonexamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonexamCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lifeModel = model;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_nowBtn isEqualToString:@"背景"]) {
        if (section == 0) {
            return 52 + 15;//首行空位
        }else{
            return 52;
        }
        
    }else if ([_nowBtn isEqualToString:@"检测指标"]) {
        
        return  15;//首行空位
    }else if ([_nowBtn isEqualToString:@"生活习惯"]) {
        if (section == 0) {
            return 52 + 15;//首行空位
        }else{
            return 52;
        }
        
    }else{
        //居住环境
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_nowBtn isEqualToString:@"背景"]) {
        PersonBackdropFrame *frame = backCellDataArr[indexPath.section - 5][indexPath.row];
        return frame.cellHeight;
    }else if ([_nowBtn isEqualToString:@"检测指标"]) {
        return 50;
    }else if ([_nowBtn isEqualToString:@"生活习惯"]){
        PersonBackdropFrame *frame = habitTextArr[indexPath.row];
        return frame.cellHeight;
    }else{
        //居住环境
        return 50;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_nowBtn isEqualToString:@"背景"]) {
        PersonalCellHeadView *cellHeadView = [[PersonalCellHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
        if (![backDataArr[section] isEqualToNumber:@0]) {
            cellHeadView.isextend = YES;
            cellHeadView.textLal.textColor = BLACKCOLOR;
        }else{
            cellHeadView.isextend = NO;
            cellHeadView.textLal.textColor = GRAYCOLOR;
        }
        cellHeadView.nameLal.text = backBigArr[section][@"name"];
        
        if (((NSString *)backBigArr[section][@"text"]).length == 0) {
            cellHeadView.textLal.text = @"未添加";
        }else{
            cellHeadView.textLal.text = backBigArr[section][@"text"];
        }
        
        if ([backOpenArr[section] isEqualToString:@"1"]) {
            [cellHeadView.extendBtn setImage:[UIImage imageNamed:@"zk"] forState:UIControlStateNormal];
        }else{
            [cellHeadView.extendBtn setImage:[UIImage imageNamed:@"zk2"] forState:UIControlStateNormal];
        }
        cellHeadView.indexs = section;
        //        [cellHeadView setTarget:self action:@selector(clickBackCellHeadView:)];//整行都可以点击
        [cellHeadView.extendBtn addTarget:self action:@selector(clickBackCellHeadView:) forControlEvents:UIControlEventTouchUpInside];
        cellHeadView.extendBtn.tag = 100 + section;
        return cellHeadView;
        
    }else if ([_nowBtn isEqualToString:@"检测指标"]){
        CGFloat addY = 15;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, addY)];
        view.backgroundColor = [UIColor whiteColor];
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, addY, 150, addY)];
        //        label.font = [UIFont systemFontOfSize:20];
        //        label.textColor = COLOR(152, 225, 83, 1.0);
        //        label.text = targetDataArr[section][@"dataTitle"];
        //        [view addSubview:label];
        
        //        UILabel *lineLal = [[UILabel alloc]initWithFrame:CGRectMake(8, view.frame.size.height - 1, view.frame.size.width - 16, 1)];
        //        lineLal.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
        //        [view addSubview:lineLal];
        return view;
        
    }else if ([_nowBtn isEqualToString:@"生活习惯"]){
        
        PersonalCellHeadView *cellHeadView = [[PersonalCellHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
        if (![habitDataArr[section] isEqualToNumber:@0]) {
            cellHeadView.isextend = YES;
            cellHeadView.textLal.textColor = BLACKCOLOR;
        }else{
            cellHeadView.isextend = NO;
            cellHeadView.textLal.textColor = GRAYCOLOR;
        }
        if (((NSString *)habitBigArr[section][@"text"]).length == 0) {
            cellHeadView.textLal.text = @"未选择";
        }else{
            cellHeadView.textLal.text = habitBigArr[section][@"text"];
        }
        cellHeadView.nameLal.text = habitBigArr[section][@"name"];
        
        if (habitRet) {
            [cellHeadView.extendBtn setImage:[UIImage imageNamed:@"zk"] forState:UIControlStateNormal];
        }else{
            [cellHeadView.extendBtn setImage:[UIImage imageNamed:@"zk2"] forState:UIControlStateNormal];
        }
        cellHeadView.indexs = section;
        [cellHeadView.extendBtn addTarget:self action:@selector(clickHabitCellHeadView:) forControlEvents:UIControlEventTouchUpInside];
        cellHeadView.extendBtn.tag = 200 + section;
        return cellHeadView;
        
    }else{
        //居住环境
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 15)];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_nowBtn isEqualToString:@"检测指标"]){
        ReportNewModel *model = (ReportNewModel *)targetDataArr[indexPath.row];
        if (model.DetailFlag == 1) {
            //跳转到子项的查看页面
            ExamNextController *nextVC = [[ExamNextController alloc]init];
            nextVC.title = model.PhysicalItemName;
            nextVC.allDataArr = model.ChildList;
            XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:nextVC];
            
            nav.transitioningDelegate=(id)self.archiveCoverDelegate;
            nav.modalPresentationStyle=UIModalPresentationCustom;
            [self  presentViewController:nav animated:YES completion:nil];
        }
        
    }
    
}

#pragma mark - 点击事件
-(void)clickBackCellHeadView:(UIButton *)button
{
    XKLOG(@"%li", button.tag);
    if ([backDataArr[button.tag - 100] integerValue] != 0) {
        if ([backOpenArr[button.tag - 100] isEqualToString:@"0"]) {
            [backOpenArr replaceObjectAtIndex:button.tag-100 withObject:@"1"];
        }else{
            [backOpenArr replaceObjectAtIndex:button.tag-100 withObject:@"0"];
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:button.tag - 100];
        [self.mytable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)clickHabitCellHeadView:(UIButton *)button
{
    habitRet = !habitRet;
    XKLOG(@"%li", button.tag);
    if ([habitDataArr[button.tag - 200] integerValue] != 0) {
        if ([habitOpenArr[button.tag - 200] isEqualToString:@"0"]) {
            [habitOpenArr replaceObjectAtIndex:button.tag-200 withObject:@"1"];
        }else{
            [habitOpenArr replaceObjectAtIndex:button.tag-200 withObject:@"0"];
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:button.tag - 200];
        [self.mytable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }
}
//点击家庭成员
-(void)clickFamily
{
    FamilyMemberViewController *vc = [[FamilyMemberViewController alloc]init];
    vc.RecordNo = self.allDataModel.RecordNo;
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:vc];
    
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [self  presentViewController:nav animated:YES completion:nil];
}

//点击指标趋势
-(void)clickTrend
{
    NewTrendHomeController *trendVC=[[NewTrendHomeController alloc]init];
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:trendVC];
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    nav.modalPresentationStyle=UIModalPresentationCustom;
    [self  presentViewController:nav animated:YES completion:nil];
}

-(void)clickHeadBtn:(NSString *)btnName
{
    
    if ([btnName isEqualToString:@"电子病历"]) {
        
        self.medicalRecords.hidden = NO;
        
    }else{
        
        _nowBtn = btnName;
        [self.mytable reloadData];
        
        self.medicalRecords.hidden = YES;
        
    }
    
}


#pragma mark - 删除家庭成员档案
-(void)clickDelect
{
    if([[NSString stringWithFormat:@"%li",self.RecordID] isEqualToString:[NSString stringWithFormat:@"%@",[UserInfoTool getLoginInfo].RecordID]]){
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"不能删除自己的档案" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        XKLOG(@"确定");
        
        NSString *memberID = UserInfoTool getLoginInfo].MemberID;
        NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,
                             @"MemberID":[NSNumber numberWithInteger:[memberID integerValue]],
                             @"RecordID":[NSNumber numberWithInteger:self.RecordID]};
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"313" parameters:dict success:^(id json) {
            XKLOG(@"删除家庭成员313：%@",json);
            NSDictionary *dic=(NSDictionary *)json;
            if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
                [[XKLoadingView shareLoadingView] hideLoding];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [[XKLoadingView shareLoadingView] errorloadingText:@"删除失败"];
            }
            
        } failure:^(id error) {
            
            XKLOG(@"%@",error);
            [[XKLoadingView shareLoadingView] errorloadingText:error];
        }];
        
    }else{
        XKLOG(@"取消");
    }
}


//注销通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

