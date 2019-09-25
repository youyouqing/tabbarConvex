//
//  XKCheckResultCommonViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//检测结果页面

#import "XKCheckResultCommonViewController.h"
#import "XKSearchToolView.h"
@interface XKCheckResultCommonViewController () <UITableViewDelegate,UITableViewDataSource>
{
    
    UIButton *leftBackBtn;
    UILabel *centerNameLab;//居中显示title
    
}

@property (nonatomic,strong) UIButton *shareBtn;//分享按钮
@property (strong, nonatomic)  UITableView *tab;
@property (nonatomic, strong) ExchinereportModel *exModel;//单项检测页模型数据
@property (nonatomic, strong) NSArray *exDataArr;//多项检测页数据数组

@end

@implementation XKCheckResultCommonViewController

-(XKSingleCheckMultipleCommonPresResultHeadView *)headPresureView
{
    if (!_headPresureView) {
        _headPresureView = [[[NSBundle mainBundle]loadNibNamed:@"XKSingleCheckMultipleCommonPresResultHeadView" owner:self options:nil]firstObject];
        _headPresureView.delegate = self;
    }
    
    return _headPresureView;
}
-(XKSingleCheckMultipleCommonResultHeadView *)headHyperliView
{
    if (!_headHyperliView) {
        _headHyperliView = [[[NSBundle mainBundle]loadNibNamed:@"XKSingleCheckMultipleCommonResultHeadView" owner:self options:nil]firstObject];
        _headHyperliView.delegate = self;
    }
    
    return _headHyperliView;
}
-(CheckHeaderResultView *)checkHeaderResultView
{
    if (!_checkHeaderResultView) {
        _checkHeaderResultView = [[[NSBundle mainBundle]loadNibNamed:@"CheckHeaderResultView" owner:self options:nil]firstObject];
        _checkHeaderResultView.delegate = self;
    }
    return _checkHeaderResultView;
}
-(XKCheckHeaderCommonResultView *)checkHeaderCommonResultView
{
    if (!_checkHeaderCommonResultView) {
        _checkHeaderCommonResultView =  [[[NSBundle mainBundle]loadNibNamed:@"XKCheckHeaderCommonResultView" owner:self options:nil]firstObject];
        _checkHeaderCommonResultView.delegate = self;
    }
    return _checkHeaderCommonResultView;
    
}
-(XKCheckResultView *)checkHeader
{
    if (!_checkHeader) {
        _checkHeader = [[[NSBundle mainBundle]loadNibNamed:@"XKCheckResultView" owner:self options:nil]firstObject];
        _checkHeader.delegate = self;
    }
    
    return _checkHeader;
}
-(XKSingleCheckMultipleCommonResultFootView *)botoomView
{
    if (!_botoomView) {
        _botoomView = [[[NSBundle mainBundle]loadNibNamed:@"XKSingleCheckMultipleCommonResultFootView" owner:self options:nil]firstObject];
        //        _botoomView.delegate = self;
    }
    
    return _botoomView;
}
-(void)backImageAction{
    
    leftBackBtn = [XKBackButton backBtn:@"icon_back_white"];
    
    [self.view addSubview:leftBackBtn];
    
    
    
    [leftBackBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.shareBtn setImage:[UIImage imageNamed:@"dectShare"] forState:UIControlStateNormal];
    
    
    
    [self.shareBtn sizeToFit];
    
    self.shareBtn.frame = CGRectMake(KScreenWidth- 60, 25, 45, 45);
    
    [self.view addSubview:self.shareBtn];
    
    [self.shareBtn addTarget:self action:@selector(clickShard) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    centerNameLab = [[UILabel alloc]init];
    
    
    centerNameLab.frame = CGRectMake((KScreenWidth-100)/2.0, leftBackBtn.y, 100, leftBackBtn.height);
    
    centerNameLab.textColor = [UIColor whiteColor];
    centerNameLab.hidden = NO;
    centerNameLab.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    centerNameLab.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:centerNameLab];
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle ) {
        
        centerNameLab.text = @"血压检测";
        
    }
    if (self.DectStyle == XKMutilPCBloodSugarStyle ||self.DectStyle == XKDetectBloodSugarStyle) {
        
        
        centerNameLab.text = @"血糖检测";
    }
    if (self.DectStyle == XKMutilPCTemperatureStyle ||self.DectStyle ==  XKDetectBloodTemperatureStyle) {
        
        centerNameLab.text = @"体温检测";
    }
    if (self.DectStyle == XKMutilPCBloodOxygenStyle ||self.DectStyle == XKDetectBloodOxygenStyle) {
        
        
        centerNameLab.text = @"血氧检测";
    }
    if (self.DectStyle == XKMutilPCNormalStyle ) {
        
        centerNameLab.text = @"脉率检测";
    }
    if (self.DectStyle == XKDetectHemoglobinStyle ) {
        centerNameLab.text = @"血红蛋白检测";
        
        
    }
    if (self.DectStyle == XKDetectWeightStyle ) {
        
        
        centerNameLab.text = @"";//体重检测
        
        
    }
    if (self.DectStyle == XKDetectDyslipidemiaStyle ) {
        
        centerNameLab.text = @"血脂检测";
        
    }
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tab.dataSource = self;
    self.tab.delegate = self;
    self.tab.estimatedSectionHeaderHeight = 250;
    self.tab.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tab.estimatedRowHeight = 77;
    self.tab.rowHeight = UITableViewAutomaticDimension;
    self.tab.backgroundColor = [UIColor whiteColor];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tab];
    
    [self.tab registerNib:[UINib nibWithNibName:@"XKSingleCheckMultipleCommonResultCell" bundle:nil] forCellReuseIdentifier:@"XKSingleCheckMultipleCommonResultCell"];
    
    
    [self loadData:self.diction];
    
    
    [self backImageAction];
#ifdef __IPHONE_11_0
    if ([self.tab respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
#endif
    

}

-(void)clickBtn:(UIButton *)btn{
    [self popViewController];
    
}



#pragma mark   UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle||self.DectStyle == XKDetectWeightStyle) {
        
        return self.exDataArr.count;
    }
    
    else
    {
        if (self.exModel.ExStatus == 0) {//是否异常(0是1否)
            
            return self.exModel.SuggestList.count;
        }
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellid = @"XKSingleCheckMultipleCommonResultCell";
    XKSingleCheckMultipleCommonResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle||self.DectStyle == XKDetectWeightStyle) {
        ExchinereportModel *mod  = self.exDataArr[indexPath.row];
        //        if (mod.ExStatus == 0) {
        //             //是否异常(0是1否)
        //            cell.model = mod.SuggestList[0];
        cell.statusModel = mod;
        //        }
        //        else
        //            cell.model = nil;
        
    }
    else
    {
        if (self.exModel.ExStatus == 0) {
            cell.statusModel = self.exModel;
            cell.model = self.exModel.SuggestList[0];
        }
        
    }
    [cell layoutIfNeeded];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return UITableViewAutomaticDimension;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (self.DectStyle == XKMutilPCBloodPressurStyle ||self.DectStyle == XKDetectBloodPressureStyle)  {
        
        return 308;
    }
    else if (self.DectStyle == XKDetectWeightStyle)
    {
        
        return 664;//  return 311;
    }
    else if (self.DectStyle == XKDetectDyslipidemiaStyle)
    {
        
        return 345;
    }
    else  if (self.DectStyle == XKMutilPCBloodOxygenStyle ||self.DectStyle == XKDetectBloodOxygenStyle)  {
        
        return 437;
    }
    return 385;
    
}

//表格组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.DectStyle == XKMutilPCBloodPressurStyle ||self.DectStyle == XKDetectBloodPressureStyle) {
        return self.headPresureView;
    }
    else  if (self.DectStyle == XKDetectDyslipidemiaStyle ) {
        return self.headHyperliView;
        
    }
    else if (self.DectStyle == XKDetectWeightStyle)
    {
        
        
        return self.checkHeader;
    }
    else if(self.DectStyle == XKDetectBloodOxygenStyle||self.DectStyle == XKMutilPCBloodOxygenStyle)
    {
        return  self.checkHeaderResultView;
        
    }
    else
        return self.checkHeaderCommonResultView;
    
}

//表格组尾部视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle ||self.DectStyle == XKDetectWeightStyle) {
        for (ExchinereportModel *exModel in self.exDataArr) {
            if (exModel.ExStatus == 0) {////是否异常(0是1否)
                return nil;
            }
        }
        return self.botoomView;
        
    }
    else  if (self.exModel) {////是否异常(0是1否)
        if (self.exModel.ExStatus == 1) {////是否异常(0是1否)
            return self.botoomView;
        }
        else // if (self.exModel.ExStatus == 0) {//self.exModel.SuggestList.count>0
        {  return nil;
        }
        //        return self.botoomView;
    }
    return self.botoomView;
}
//配置组底部视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle||self.DectStyle == XKDetectWeightStyle) {
        
        for (ExchinereportModel *exModel in self.exDataArr) {
            if (exModel.ExStatus == 0) {////是否异常(0是1否)
                return 0;
            }
        }
        return 300;
    }
    else  if (self.exModel) {////是否异常(0是1否)
        if (self.exModel.ExStatus == 1) {////是否异常(0是1否)
            return 300;
        }
        else // if (self.exModel.ExStatus == 0) {//self.exModel.SuggestList.count>0
        {  return 0;
        }
        //        return self.botoomView;
    }
    return 300;
    
    
}
#pragma mark   再测一次代理
-(void)AgainR:(XKSingleCheckMultipleCommonResultHeadView *)view;
{
    
    [self popViewController];
}

-(void)Again:(XKCheckResultView *)view;
{
    [self popViewController];
}
-(void)AgainV:(XKSingleCheckMultipleCommonResultHeadView *)view;
{
    [self popViewController];
    
}
-(void)AgainC:(CheckHeaderResultView *)view;
{
    [self popViewController];
    
}
-(void)AgainCheckResult:(XKCheckHeaderCommonResultView *)view;
{
    
    [self popViewController];
}

-(void)popViewController{
    
    
    XKDectingViewController *chect;
    
    for (UIViewController *control in self.navigationController.viewControllers) {
        
        if ([control isKindOfClass:[XKDectingViewController class]]) {
            
            chect=(XKDectingViewController *)control;
        }
        
    }
    
    if (!chect) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        [self.navigationController popToViewController:chect animated:YES];
    }
    
}
#pragma mark   上传数据接口
-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
-(void)loadData:(NSDictionary *)diction{
    [self.headHyperliView stopAninmayion];
    
    [self.headPresureView stopAninmayion];
    [self.checkHeaderResultView StopCircleAninmationAndHide];
    [self.checkHeaderCommonResultView StopCircleAninmationAndHide];
    [self.checkHeader StopCircleAninmationAndHide];
    
    UserInfoModel *model = [UserInfoTool getLoginInfo];
    NSMutableDictionary *temporaryDic = [NSMutableDictionary dictionaryWithObject:model.Mobile forKey:@"Mobile"];
    [temporaryDic setValue:model.Token forKey:@"Token"];
    NSString *temportySum = [[NSString alloc]init];
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle ) {
        [temporaryDic setValue:@([self.manualText intValue]) forKey:@"SBP"];
        
        [temporaryDic setValue:@([self.manualTwoText intValue]) forKey:@"DBP"];
        
        [temporaryDic setValue:@([self.manualThreeText intValue]) forKey:@"Pulse"];
        centerNameLab.text = @"血压检测";
        if (self.DectStyle == XKMutilPCBloodPressurStyle) {
            temportySum = @"802";
            
        }
        else
            
            temportySum = @"831";
        
        
        [self.headPresureView.dataOneBtn setTitle:self.manualText forState:UIControlStateNormal];
        [self.headPresureView.dataTwoBtn setTitle:self.manualTwoText forState:UIControlStateNormal];
        [self.headPresureView.dataThreeBtn setTitle:self.manualThreeText forState:UIControlStateNormal];
    }
    if (self.DectStyle == XKMutilPCBloodSugarStyle ||self.DectStyle == XKDetectBloodSugarStyle) {
        if (self.DectStyle == XKMutilPCBloodSugarStyle) {
            temportySum = @"803";
        }
        else
            temportySum = @"833";
        [temporaryDic setValue:@(self.BloodSugarType) forKey:@"BloodSugarType"];
        
        [temporaryDic setValue:self.manualText  forKey:@"BloodSugar"];
        
        centerNameLab.text = @"血糖检测";
        self.checkHeaderCommonResultView.dataLab.text = [NSString stringWithFormat:@"%@",self.manualText];
    }
    if (self.DectStyle == XKMutilPCTemperatureStyle ||self.DectStyle ==  XKDetectBloodTemperatureStyle) {
        if (self.DectStyle == XKMutilPCTemperatureStyle) {
            temportySum = @"800";
        }
        else
            temportySum = @"832";
        
        [temporaryDic setValue:self.manualText  forKey:@"BodyTemperature"];
        centerNameLab.text = @"体温检测";
        self.checkHeaderCommonResultView.dataLab.text = [NSString stringWithFormat:@"%@",self.manualText];
    }
    if (self.DectStyle == XKMutilPCBloodOxygenStyle ||self.DectStyle == XKDetectBloodOxygenStyle) {
        if (self.DectStyle == XKMutilPCBloodOxygenStyle) {
            temportySum = @"801";
        }
        else
            temportySum = @"830";
        [temporaryDic setValue:@([self.manualText intValue]) forKey:@"Bo"];
        
        centerNameLab.text = @"血氧检测";
        
        
        self.checkHeaderResultView.dataLab.text = [NSString stringWithFormat:@"%i",[self.manualText intValue]];
    }
    if (self.DectStyle == XKMutilPCNormalStyle ) {
        if (self.DectStyle == XKMutilPCNormalStyle) {
            temportySum = @"804";
        }
        [temporaryDic setValue:@([self.manualText intValue]) forKey:@"Pulse"];
        centerNameLab.text = @"脉率检测";
        self.checkHeaderCommonResultView.dataLab.text = [NSString stringWithFormat:@"%@",self.manualText];
    }
    if (self.DectStyle == XKDetectHemoglobinStyle ) {
        centerNameLab.text = @"血红蛋白检测";
        [temporaryDic setValue:@([self.manualText intValue]) forKey:@"Hemoglobin"];
        
        temportySum = @"834";
        
    }
    if (self.DectStyle == XKDetectWeightStyle ) {
        
        
        NSString *tempString = [self  dictionaryToJson:diction];
        [temporaryDic setValue:tempString forKey:@"StrJson"];
        centerNameLab.text = @"";//体重检测
        temportySum = @"837";
        
        
        NSMutableDictionary *deviceData = (NSMutableDictionary *)diction;
        
        NSString *fat_free_weight = deviceData[@"LeanWeight"];
        
        NSString *score = deviceData[@"Score"];
        //        Dateformat *dat = [[Dateformat alloc]init];
        ;
        self.checkHeader.weightLab.text = [NSString stringWithFormat:@"%@",deviceData[@"Weight"]];
        
        self.checkHeader.weightKgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"Weight"] ];
        self.checkHeader.BMIKgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"BMI"] ];
        self.checkHeader.BMILab.text = [NSString stringWithFormat:@"BMI：%@",deviceData[@"BMI"]];
        self.checkHeader.sLvLab.text = [NSString stringWithFormat:@"脂肪率：%@",deviceData[@"FatRate"] ];
        
        
        self.checkHeader.slvkgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"FatRate"] ];
        
        self.checkHeader.fatLabOne.text= deviceData[@"FatLevel"] == [NSNull null]?@"0":deviceData[@"FatLevel"];
        self.checkHeader.fatLabTwo.text= [deviceData[@"WaterMass"] isEqual:[NSNull null]]?@"0":deviceData[@"WaterMass"];
        self.checkHeader.fatLabThree.text= [deviceData[@"MuscleMass"] isEqual:[NSNull null]]?@"0":deviceData[@"MuscleMass"];
        self.checkHeader.fatLabFour.text= [deviceData[@"SubcutaneousFatRate"] isEqual:[NSNull null]]?@"0":deviceData[@"SubcutaneousFatRate"];
        
        self.checkHeader.fatLabFive.text= [fat_free_weight length]<=0?@"0":deviceData[@"LeanWeight"];
        self.checkHeader.fatLabSix.text= [deviceData[@"SkeletalMuscleRate"] isEqual:[NSNull null]]?@"--":deviceData[@"SkeletalMuscleRate"];
        self.checkHeader.fatLabSeven.text= [deviceData[@"BoneMass"] isEqual:[NSNull null]]?@"--":deviceData[@"BoneMass"];
        self.checkHeader.fatLabEight.text= [deviceData[@"Proteins"] isEqual:[NSNull null]]?@"--":deviceData[@"Proteins"];
        self.checkHeader.fatLabNine.text= [deviceData[@"Metabolism"] isEqual:[NSNull null]]?@"--":deviceData[@"Metabolism"];
        self.checkHeader.fatLabTen.text= [deviceData[@"BodyAge"] isEqual:[NSNull null]]?@"--":deviceData[@"BodyAge"];
        self.checkHeader.fatLabTwel.text= [score length]<=0?@"0":deviceData[@"Score"];
        self.checkHeader.fatLabElev.text= deviceData[@"BodyType"] ==[NSNull null]?@"--":deviceData[@"BodyType"];
        
        self.manualText = self.checkHeader.weightLab.text;
        
        
    }
    if (self.DectStyle == XKDetectDyslipidemiaStyle ) {
        //        [temporaryDic setValue:@([self.manualText floatValue]) forKey:@"Chol"];
        //        [temporaryDic setValue:@([self.manualTwoText floatValue]) forKey:@"HDL"];
        //        [temporaryDic setValue:@([self.manualThreeText floatValue]) forKey:@"LDL"];
        //        [temporaryDic setValue:@([self.manualFourText floatValue]) forKey:@"Triglycerides"];
        [temporaryDic setValue:self.manualText  forKey:@"Chol"];
        [temporaryDic setValue:self.manualThreeText forKey:@"HDL"];
        [temporaryDic setValue:self.manualFourText  forKey:@"LDL"];
        [temporaryDic setValue:self.manualTwoText  forKey:@"Triglycerides"];
        centerNameLab.text = @"血脂检测";
        temportySum = @"835";
        /*    Chol = "3.47";总胆固醇
         HDL = "2.59"; 高密度脂蛋白
         LDL = "1.81";低密度脂蛋白
         Mobile = 15970682406;
         Token = e530fa07bf1253022a192477621e6f43;
         Triglycerides = 0;甘油三脂
         }*/
        
        [self.headHyperliView.dataOneBtn setTitle:self.manualText forState:UIControlStateNormal];
        [self.headHyperliView.dataTwoBtn setTitle:self.manualTwoText forState:UIControlStateNormal];
        [self.headHyperliView.dataThreeBtn setTitle:self.manualThreeText forState:UIControlStateNormal];
        [self.headHyperliView.dataFourBtn setTitle:self.manualFourText forState:UIControlStateNormal];
    }
    
    //    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    NSLog(@"*******temporaryDic********%@",temporaryDic);
    
    [NetWorkTool postAction:[NSString stringWithFormat:@"%@",temportySum] params:temporaryDic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed){
            
            if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle) {
                self.exDataArr = [ExchinereportModel mj_objectArrayWithKeyValuesArray:response.Result];
                
                
                
                
                self.headPresureView.modeArr = self.exDataArr;
                
                
            }
            else if (self.DectStyle == XKDetectDyslipidemiaStyle)
            {
                self.exDataArr = [ExchinereportModel mj_objectArrayWithKeyValuesArray:response.Result];
                //               (BF_004：总胆固醇、BF_002：高密度脂蛋白、BF_001：低密度纸蛋白、BF_003：甘油三酯)
                
                
                self.headHyperliView.exAmineArray = self.exDataArr;
                
                //                for (int i = 0; i<self.exDataArr.count; i++) {
                //
                //                    ExchinereportModel *mod =   self.exDataArr[i];
                //                    if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_004"]&&i == 0) {
                //                         [self.headHyperliView.dataOneBtn setTitle:self.manualText forState:UIControlStateNormal];
                //                    }
                //                    if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_002"]&&i == 0) {
                //                        [self.headHyperliView.dataOneBtn setTitle:self.manualText forState:UIControlStateNormal];
                //                    }
                //                    if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_001"]&&i == 0) {
                //                        [self.headHyperliView.dataOneBtn setTitle:self.manualText forState:UIControlStateNormal];
                //                    }
                //                    if ([mod.PhysicalItemIdentifier isEqualToString:@"BF_003"]&&i == 0) {
                //                        [self.headHyperliView.dataOneBtn setTitle:self.manualText forState:UIControlStateNormal];
                //                    }
                //
                //                }
                
                if ([self.headHyperliView.nameOneLab.text isEqualToString:@""]) {
                    
                    [self.headHyperliView.dataTwoBtn setTitle:self.manualTwoText forState:UIControlStateNormal];
                    [self.headHyperliView.dataThreeBtn setTitle:self.manualThreeText forState:UIControlStateNormal];
                    [self.headHyperliView.dataFourBtn setTitle:self.manualFourText forState:UIControlStateNormal];
                }
                
            }
            else if (self.DectStyle == XKDetectWeightStyle)
            {
                self.exDataArr = [ExchinereportModel mj_objectArrayWithKeyValuesArray:response.Result];
                //                self.exModel = [ExchinereportModel objectWithKeyValues:[json objectForKey:@"Result"]];
                //                self.checkHeader.mode = self.exModel;
                self.checkHeader.modeArr = self.exDataArr;
                self.checkHeader.sLvLab.hidden = NO;
                self.checkHeader.scoreLab.hidden = NO;
                self.checkHeader.BMILab.hidden = NO;
                
                if (self.isOtherDect == YES) {
                    self.checkHeader.weightLab.text  = [NSString stringWithFormat:@"体重:%@",self.manualText] ;
                    ;
                    self.checkHeader.weightKgLab.text = self.manualText;
                    self.checkHeader.BMILab.text = [NSString stringWithFormat:@"BMI:%@",diction[@"BMI"]] ;
                    self.checkHeader.BMIKgLab.text = [NSString stringWithFormat:@"%@",diction[@"BMI"]] ;
                    
                    //self.checkHeader.scoreLab.text = @"";
                    
                }
                
            }
            else if (self.DectStyle == XKMutilPCBloodOxygenStyle||self.DectStyle == XKDetectBloodOxygenStyle)
            {
                
                self.exModel = [ExchinereportModel mj_objectWithKeyValues:response.Result];
                self.checkHeaderResultView.mode = self.exModel;
                
                
                
                
            }
            else
            {
                self.exModel = [ExchinereportModel mj_objectWithKeyValues:response.Result];
                self.checkHeaderCommonResultView.mode = self.exModel;
                
                self.checkHeaderCommonResultView.dataLab.text = [NSString stringWithFormat:@"%@",self.manualText];
                
                
            }
            
            self.headHyperliView.OnceAgainBtn.hidden = NO;
            
            
            
            self.headPresureView.againBtn.hidden = NO;
            
            
            self.checkHeader.againBtn.hidden = NO;
            
            
            self.checkHeaderResultView.againBtn.hidden = NO;
            
            self.botoomView.bottomDectImage.image = [UIImage imageNamed:@"result_resultImage"];
            [self.tab reloadData];
            
            NSString *freshHealthDataU = [[NSUserDefaults standardUserDefaults]objectForKey:@"freshHealthDataU"];
            if (freshHealthDataU.length>0) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"freshHealthDataU" object:nil];
                [[NSUserDefaults standardUserDefaults]setObject:@"freshHealthDataU" forKey:@"freshHealthDataU"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
            [self taskJump];//健康📖
        }else {
            
            ShowErrorStatus(response.msg);
        }
    }];
    
    
}
-(void)taskJump{
    
    //展示当天任务是否完成  这个放在设备检测哪里  手动输入和设备检测都要放
    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
    
    UserInfoModel *model = [UserInfoTool getLoginInfo];
    [tools validationAndAddScore:@{@"Token":model.Token,
                                   @"TaskType":@(1),
                                   @"MemberID":@(model.MemberID),
                                   @"TypeID":@(2)}
                         withAdd:@{@"Token":model.Token,
                                   @"TaskType":@(1),
                                   @"MemberID":@(model.MemberID),
                                   @"TypeID":@(2)} isPopView:YES];
}
#pragma 分享
-(void)clickShard{
    
    NSArray *imageArray = @[[self getImage]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"" images:imageArray url:nil title:@"携康e加" type:SSDKContentTypeImage];
        
        [ShareSDK showShareActionSheet:nil customItems:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)] shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            switch (state) {
                    
                case SSDKResponseStateBegin:
                {
                    //                               [IanAlert showLoading:@"分享中..." allowUserInteraction:NO];
                    break;
                }
                case SSDKResponseStateSuccess:
                {
                    //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                    if (platformType == SSDKPlatformTypeFacebookMessenger)
                    {
                        break;
                    }
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                        message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil, nil];
                        [alert show];
                        break;
                    }
                    else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                        message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil, nil];
                        [alert show];
                        break;
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                        message:[NSString stringWithFormat:@"%@",error]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil, nil];
                        [alert show];
                        break;
                    }
                    break;
                }
                case SSDKResponseStateCancel:
                {
                    //                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                    //                                                                                   message:nil
                    //                                                                                  delegate:nil
                    //                                                                         cancelButtonTitle:@"确定"
                    //                                                                         otherButtonTitles:nil];
                    //                               [alertView show];
                    
                    break;
                }
                default:
                    break;
            }
            
            if (state != SSDKResponseStateBegin)
            {
                //                [IanAlert hideLoading];
            }
            
        }];
        
    }
    
}
- (UIImage *)getImage {
    self.shareBtn.hidden = YES;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenWidth, [UIApplication sharedApplication].keyWindow.height), NO, 0);  //NO，YES 控制是否透明
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    self.shareBtn.hidden = NO;
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
