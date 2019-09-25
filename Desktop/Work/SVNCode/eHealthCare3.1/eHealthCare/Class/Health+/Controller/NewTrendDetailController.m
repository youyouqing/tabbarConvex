//
//  NewTrendDetailController.m
//  eHealthCare
//
//  Created by xiekang on 16/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "NewTrendDetailController.h"
#import "NewTrendDataModel.h"
#import "TrendSuggestModel.h"
#import "TrendDetailDataCell.h"
#import "ArcDetailReportCell.h"
#import "TrendSuggestCell.h"
#import "DetailArcFootCell.h"
#import "TrendSuggestFootView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "XKTrendDetailShardController.h"
#import "XKNewTrendDataSugarModel.h"
#import "XKTrendSuggestSurgarModel.h"
#import "XKBloodFatChooseView.h"
#import "DrinkHeaderView.h"
#import "HealthPlanView.h"

#import "ShowPlaceHolderView.h"
@interface NewTrendDetailController ()<UITableViewDelegate,UITableViewDataSource,DrinkHeaderViewDelegate,XKBloodFatChooseViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *oneDataArr;
    NSMutableArray *twoDataArr;
    NSMutableArray *timeArr;
    NSMutableArray *yearDataArr;//存储年份
    
    NSMutableArray *afeterTimeArr;
    
    TrendSuggestModel *suggestModel;

    NewTrendDataModel *titleModel;
    
     XKNewTrendDataSugarModel *sugartitleModel;
    NSMutableArray *suggestArr;
    
    NSDictionary *maxNumDic;
    
}
@property (nonatomic,strong) UITableView *mytable;
@property (nonatomic,strong) DrinkHeaderView *DeaderView;
@property (nonatomic,strong) NSMutableArray *allViewDataArray;//头部的数组
@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图
//@property (nonatomic, strong) UIImageView *nullImgeView;
@property (nonatomic, strong) ShowPlaceHolderView *nullView;
@end
@implementation NewTrendDetailController
/**实现协议方法   修改刷新每项的点击事件*/
-(void)clickBtnToIndex:(NSString *)btnTagModel;{
    if ([@"空腹血糖" isEqualToString:btnTagModel]) {
       //检测项目编号 32、空腹血糖,33、餐后血糖,163、随机血糖,9、体温,1、BMI,189、体重,14、脂肪率,51、静息心率,10、血红蛋白,34、总胆固醇,36、高密度胆固醇,37、低密度胆固醇,35、甘油三脂,18、收缩压,19、舒张压,181、血氧,
        self.PhysicalItemID = 32;
    }
    if ([@"餐后2小时" isEqualToString:btnTagModel]) {
      
        self.PhysicalItemID = 33;
    }
    if ([@"随机血糖" isEqualToString:btnTagModel]) {
       
        self.PhysicalItemID = 163;
    }
    if ([@"总胆固醇" isEqualToString:btnTagModel]) {
      
        self.PhysicalItemID = 34;
    }
    if ([@"高密度胆固醇" isEqualToString:btnTagModel]) {
   
        self.PhysicalItemID = 36;
    }
    if ([@"低密度胆固醇" isEqualToString:btnTagModel]) {
   
        self.PhysicalItemID = 37;
    }
    if ([@"甘油三脂" isEqualToString:btnTagModel]) {
        self.PhysicalItemID = 35;
    }
    if ([@"收缩压" isEqualToString:btnTagModel]) {
        self.PhysicalItemID = 18;
    }
    if ([@"舒张压" isEqualToString:btnTagModel]) {
        self.PhysicalItemID = 19;
    }
    if ([@"体重" isEqualToString:btnTagModel]) {
        self.PhysicalItemID = 189;
    }
    if ([@"BMI" isEqualToString:btnTagModel]) {
        self.PhysicalItemID = 1;
    }
    //折线图最大值范围
    maxNumDic = @{@"11":@12,@"32":@12,@"33":@12,@"163":@12,@"9":@50,@"1":@200,@"14":@50,@"51":@100,@"10":@200,@"34":@15,@"36":@10,@"37":@10,@"35":@5,@"12":@260,@"189":@200,@"18":@150,@"19":@100,@"181":@100};
    _DeaderView.maxScore = [[NSString stringWithFormat:@"%@",[maxNumDic objectForKey:[NSString stringWithFormat:@"%li",self.PhysicalItemID]]] integerValue];
    [self loadData];
}
#pragma mark  - 懒加载
-(DrinkHeaderView *)DeaderView{
    
    if (!_DeaderView) {
        
        _DeaderView=[[[NSBundle mainBundle]loadNibNamed:@"DrinkHeaderView" owner:self options:nil]firstObject];
        
        _DeaderView.x=0;
        
        _DeaderView.y=0;
        
        _DeaderView.width=KScreenWidth;
        
        _DeaderView.height=DrinkHeight+45+31;//4.0版本新增的31像素
        
        _DeaderView.delegate=self;
        
        _DeaderView.descriptionStr=NO;
        
        _DeaderView.isShowAir=NO;
        
        _DeaderView.isMulitueDataOrSingle = YES;
        _DeaderView.lineStyle=YES;
        
    }
    
    return _DeaderView;
    
}
/**
 懒加载空数据展示图片
 */
//-(UIImageView *)nullImgeView
//{
//    if (!_nullImgeView) {
//
//        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)];
//        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
//        _nullImgeView.image = [UIImage imageNamed:@"iv_tree_UFO"];//
//        _nullImgeView.backgroundColor = [UIColor whiteColor];
//
//
//    }
//    return _nullImgeView;
//}

-(ShowPlaceHolderView *)nullView{
    
    if (!_nullView) {
        _nullView = [[[NSBundle mainBundle]loadNibNamed:@"ShowPlaceHolderView" owner:self options:nil]firstObject];
        _nullView.left = 0;
        _nullView.top = PublicY;//+(6+45)
        _nullView.width = KScreenWidth;
        _nullView.height = KScreenHeight-(PublicY);////-(6+45)
       
        _nullView.delegate = self;
    }
    return _nullView;
}

-(UITableView *)mytable
{
    if (!_mytable) {
        _mytable = [[UITableView alloc]initWithFrame:CGRectMake(6, PublicY, KScreenWidth-12, KScreenHeight-(PublicY)) style:UITableViewStyleGrouped];
        _mytable.delegate = self;
        _mytable.dataSource = self;
        _mytable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _mytable.backgroundColor = [UIColor whiteColor];
        //预设cell高度
        _mytable.estimatedRowHeight = 44.0;
        //打开自动计算行高
        _mytable.rowHeight = UITableViewAutomaticDimension;
    }
    return _mytable;
}
#pragma mark   暂无数据的代理
- (void)placeHodlerImageButtonClick;
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myTitle = @"趋势图";
   self.headerView.backgroundColor =  [UIColor whiteColor];
    self.view.backgroundColor = self.mytable.backgroundColor = kbackGroundGrayColor;
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.titleLab.textColor = kMainTitleColor;
    titleModel = [[NewTrendDataModel alloc]init];
    dataArr = [[NSMutableArray alloc] init];
    timeArr = [[NSMutableArray alloc] init];
    yearDataArr = [[NSMutableArray alloc]init
                   ];
    sugartitleModel = [[XKNewTrendDataSugarModel alloc]init];
    afeterTimeArr = [[NSMutableArray alloc]init];
    oneDataArr = [[NSMutableArray alloc] init];
    twoDataArr = [[NSMutableArray alloc] init];
    suggestModel = [[TrendSuggestModel alloc] init];
    
    suggestArr = [[NSMutableArray alloc] init];
    [self.view addSubview:self.mytable];
    
    self.mytable.tableHeaderView=self.DeaderView;
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mytable registerNib:[UINib nibWithNibName:@"TrendDetailDataCell" bundle:nil] forCellReuseIdentifier:@"TrendDetailDataCell"];
    [self.mytable registerNib:[UINib nibWithNibName:@"TrendSuggestCell" bundle:nil] forCellReuseIdentifier:@"TrendSuggestCell"];
    [self.mytable registerNib:[UINib nibWithNibName:@"DetailArcFootCell" bundle:nil] forCellReuseIdentifier:@"DetailArcFootCell"];
    
    //折线图最大值范围
    maxNumDic = @{@"11":@12,@"32":@12,@"33":@12,@"163":@12,@"9":@50,@"1":@200,@"14":@50,@"51":@100,@"10":@200,@"34":@15,@"36":@10,@"37":@10,@"35":@5,@"12":@260,@"189":@200,@"18":@150,@"19":@100,@"181":@100};
    
    _DeaderView.maxScore = [[NSString stringWithFormat:@"%@",[maxNumDic objectForKey:[NSString stringWithFormat:@"%li",self.PhysicalItemID]]] integerValue];

    
    if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163||self.PhysicalItemID == 34||self.PhysicalItemID == 36||self.PhysicalItemID == 37||self.PhysicalItemID == 35||self.PhysicalItemID == 18||self.PhysicalItemID == 19||self.PhysicalItemID == 1||self.PhysicalItemID == 189) {
        if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163) {
            //检测项目编号 32、空腹血糖,33、餐后血糖,163、随机血糖,9、体温,1、BMI,189、体重,14、脂肪率,51、静息心率,10、血红蛋白,34、总胆固醇,36、高密度胆固醇,37、低密度胆固醇,35、甘油三脂,18、收缩压,19、舒张压,181、血氧,
            
            self.DeaderView.titleReloaddataArray = @[@"空腹血糖",@"餐后2小时",@"随机血糖"];
        }
        else if(self.PhysicalItemID == 34||self.PhysicalItemID == 36||self.PhysicalItemID == 37||self.PhysicalItemID == 35)
        {
            self.DeaderView.titleReloaddataArray = @[@"总胆固醇",@"高密度胆固醇",@"低密度胆固醇",@"甘油三脂"];
            
        }else if(self.PhysicalItemID == 18||self.PhysicalItemID == 19)
        {
            self.DeaderView.titleReloaddataArray = @[@"收缩压",@"舒张压"];
            
        }
        else if(self.PhysicalItemID == 1||self.PhysicalItemID == 189)
        {
            self.DeaderView.titleReloaddataArray = @[@"体重",@"BMI"];
            
        }
        self.DeaderView.isMulitueDataOrSingle = YES;
    }
    else
    {
        
         self.DeaderView.isMulitueDataOrSingle = NO;
    }
    [self loadData];
    
  
    
   
    [self.mytable addSubview:self.nullView];
    if ( self.DeaderView.isMulitueDataOrSingle == YES) {
        self.nullView.top = (6+45);//
        self.nullView.height = KScreenHeight-(PublicY)-(6+45);////
    }else
    {
        self.nullView.top = 0;//+(6+45)
        self.nullView.height = KScreenHeight-(PublicY);////-(6+45)
        
    }
    self.nullView.alpha = 0;
    
}
-(UIImage *)screenShotView:(UIView *)view{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}

-(void)clickShard{
    

     UIImage *shotImage =   [self screenShotView:self.DeaderView];
    
    
    XKTrendDetailShardController *detailShard=[[XKTrendDetailShardController alloc]initWithType:pageTypeNormal];
    
    detailShard.PhysicalItemID=self.PhysicalItemID;

    detailShard.dataArr=dataArr;
    
    detailShard.suggestModel=suggestModel;
    detailShard.myTitle = self.myTitle;
    detailShard.shareType = self.shareType;
    detailShard.shotImage = shotImage;
    [self.navigationController pushViewController:detailShard animated:YES];
    
    
}

#pragma mark - 获取数据
-(void)loadData
{
    
     self.nullView.alpha = 0;
    
    NSString *typeString = @"315";//体检项目编号(空腹：32、餐后：33、随机：163)
    NSDictionary *dict=@{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberID":[NSNumber numberWithInteger: [UserInfoTool getLoginInfo].MemberID],@"PhysicalItemID":[NSNumber numberWithInteger:self.PhysicalItemID]};
    
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:typeString parameters:dict success:^(id json) {
        NSLog(@"趋势图315：%@",json);
        [dataArr removeAllObjects];
        
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            [[XKLoadingView shareLoadingView]  hideLoding];
            NSArray *dataArray = [NewTrendDataModel objectArrayWithKeyValuesArray:dic[@"Result"][@"PhysicalTendencyList"]];
            dataArr=(NSMutableArray *)dataArray;
            suggestModel = [TrendSuggestModel objectWithKeyValues:dic[@"Result"][@"PhysicalSuggestEntity"]];
            self.myTitle = suggestModel.PhysicalItemNameOne;
            //将数组倒序之后在赋值
//            NSArray* reversedArray = [[dataArray reverseObjectEnumerator] allObjects];
            /**判断是否是血脂四项内容 否则默认选中第一项*/
            [self dealWithData];
            if (dataArr.count == 0) {
                self.nullView.alpha = 1;
                self.rightBtn.hidden = YES;
            }else{
                self.nullView.alpha = 0;
                [self.rightBtn addTarget:self action:@selector(clickShard) forControlEvents:UIControlEventTouchUpInside];
                 self.rightBtn.hidden = NO;
                [self.rightBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
            }
            
            [self.mytable reloadData];
            
        }else{
            [[XKLoadingView shareLoadingView]  errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]  errorloadingText:nil];

    }];
}
//处理数据数组
-(void)dealWithData
{
   
    [oneDataArr removeAllObjects];
    [timeArr removeAllObjects];
    [yearDataArr removeAllObjects];
    [twoDataArr removeAllObjects];
    [afeterTimeArr removeAllObjects];
    [suggestArr removeAllObjects];
    for (id cV in self.DeaderView.chartView.subviews) {
        if ([cV isKindOfClass:[UIButton class]])
        {
            UIButton *cView = (UIButton *)cV;
            if (cView.frame.size.width == 10) {
                [cView removeFromSuperview];
            }
            
        }
    }
    for (UILabel *lab in self.DeaderView.greenLabArray) {
        lab.hidden = YES;
    }
    for (UILabel *lab in self.DeaderView.yellowLabArray) {
        lab.text = @"";
        lab.hidden = NO;
    }
    [self.DeaderView.lineLayer removeFromSuperlayer];
    self.shareType = 2000;
        for (NewTrendDataModel *model in dataArr) {

            [oneDataArr addObject:[NSNumber numberWithFloat:model.ValueOne]];
//            if (model.hasTwoLine) {
//                [twoDataArr addObject:[NSNumber numberWithFloat:model.ValueTwo]];
//            }
            [timeArr addObject:[self loadTimeStr:model.TestTime]];
            [yearDataArr addObject:model.TestTime];
            
        }
        //第一条折线图数据
        self.DeaderView.dataArray = oneDataArr;
        if (self.PhysicalItemID == 189||self.PhysicalItemID == 1) {
             [self.DeaderView.acountOneBtn setTitle:[NSString stringWithFormat:@"单位:%@",suggestModel.PhysicalItemUnitOne] forState:UIControlStateNormal];
        }else
            [self.DeaderView.acountOneBtn setTitle:[NSString stringWithFormat:@"正常范围:%@",suggestModel.ReferenceValue ] forState:UIControlStateNormal];
        if (twoDataArr.count> 0 ) {
            if (self.PhysicalItemID != 11) {
                self.DeaderView.otherDataArray = twoDataArr;//第二条折线图数据
            }
            
            self.DeaderView.acountTwoBtn.hidden = NO;
            [self.DeaderView.acountTwoBtn setTitle:[NSString stringWithFormat:@"%@(%@)",suggestModel.PhysicalItemNameTwo,suggestModel.PhysicalItemUnitTwo] forState:UIControlStateNormal];
        }else{
            self.DeaderView.acountTwoBtn.hidden = YES;
        }
        
        self.DeaderView.labArray = timeArr;
        self.DeaderView.yearDataArr = yearDataArr;
        
        
        titleModel.titleName1 = suggestModel.PhysicalItemNameOne;
//        if (suggestModel.PhysicalItemNameTwo.length > 0) {
//            titleModel.titleName2 = suggestModel.PhysicalItemNameTwo;
//        }
        [dataArr insertObject:titleModel atIndex:0];
        
        if (suggestModel.Status == 0) {
            //最新一次数据为异常时
            if (suggestModel.KnowledgeSuggest.length > 0) {
                [suggestArr addObject:@{@"0":@{@"title":@"健康常识",@"suggest":suggestModel.KnowledgeSuggest}}];
            }
            if (suggestModel.SportSuggest.length > 0) {
                [suggestArr addObject:@{@"1":@{@"title":@"运动建议",@"suggest":suggestModel.SportSuggest}}];
            }
            if (suggestModel.SportSuggest.length > 0) {
                [suggestArr addObject:@{@"2":@{@"title":@"饮食建议",@"suggest":suggestModel.DrinkSuggest}}];
            }
            if (suggestModel.SportSuggest.length > 0) {
                [suggestArr addObject:@{@"3":@{@"title":@"养生建议",@"suggest":suggestModel.HealthSuggest}}];
            }
        }
    
}
#pragma mark   clickDateToTakeData （特别愚蠢的办法   最好不要这样写）  没用到
//-(void)clickDateToTakeData:(NSInteger)type;
//{
//    if (self.PhysicalItemID == 11) {
//        /*第一个按钮和第二个，第一个现实刷新数据*/
//        if (type == 2000) {
//            [self.DeaderView.acountOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//            [self.DeaderView.acountTwoBtn setTitleColor:kColorWithHexString(@"237e89") forState:UIControlStateNormal];
//
//            for (id cV in self.DeaderView.chartView.subviews) {
//                    if ([cV isKindOfClass:[UIButton class]])
//                    {
//                        UIButton *cView = (UIButton *)cV;
//                        if (cView.frame.size.width == 10) {
//                            [cView removeFromSuperview];
//                        }
//
//                    }
//            }
//            for (UILabel *lab in self.DeaderView.greenLabArray) {
//                lab.hidden = YES;
//            }
//            for (UILabel *lab in self.DeaderView.yellowLabArray) {
//                lab.hidden = NO;
//            }
//                [self.DeaderView.lineLayer removeFromSuperlayer];
//
//
//            self.DeaderView.dataArray = oneDataArr;
//
//            self.DeaderView.labArray = timeArr;
//            self.DeaderView.yearDataArr = yearDataArr;
//
//
//
//
//
//        }
//        else
//        {
//            [self.DeaderView.acountOneBtn setTitleColor:kColorWithHexString(@"237e89") forState:UIControlStateNormal];
//
//            [self.DeaderView.acountTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//            for (id cV in self.DeaderView.chartView.subviews) {
//
//                if ([cV isKindOfClass:[UIButton class]])
//                {
//                    UIButton *cView = (UIButton *)cV;
//                    if (cView.frame.size.width == 10) {
//                        [cView removeFromSuperview];
//                    }
//
//                }
//            }
//            for (UILabel *lab in self.DeaderView.yellowLabArray) {
//                lab.hidden = YES;
//            }
//            for (UILabel *lab in self.DeaderView.greenLabArray) {
//                lab.hidden = NO;
//            }
//
//
////            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.DeaderView.lineLayer removeFromSuperlayer];
////            });
//
//
//
//                  self.DeaderView.otherDataArray = twoDataArr;
//                     NSLog(@"twoDataArr---%@",twoDataArr);
//                    self.DeaderView.labArray = afeterTimeArr;
//            self.DeaderView.yearDataArr = yearDataArr;
//
//        }
//        self.shareType = type;
//
//        }
//
//}
/**通过时间戳返回时间**/
-(NSString *)loadTimeStr:(NSString *)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    NSString *timeNumsp =[dateFor timeSpWithDate:time withFormat:@"YYYY-MM-dd"];
    NSString *timeStr=[dateFor DateFormatWithDate:timeNumsp withFormat:@"MM/dd"];
    return timeStr;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return dataArr.count;
    }else{
        return suggestArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //数据概况
        NewTrendDataModel *model;
        XKNewTrendDataSugarModel *mod ;
        if (indexPath.row==0) {

                  model= (NewTrendDataModel *)dataArr[ indexPath.row];
        }else{

                 model= (NewTrendDataModel *)dataArr[dataArr.count-indexPath.row];
        }
        
        TrendDetailDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendDetailDataCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.suggestModel=suggestModel;
        model.PhysicalItemID = self.PhysicalItemID;
        cell.model = model;

        return cell;
    }else{
//        if (indexPath.row == 4) {
//            DetailArcFootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailArcFootCell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//
        TrendSuggestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendSuggestCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *key = [NSString stringWithFormat:@"%li",indexPath.row];
        NSDictionary *d = [suggestArr[indexPath.row] objectForKey:key];
        cell.titleLal.text = d[@"title"];
        cell.textLal.text = d[@"suggest"];
        return cell;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return [[UIView alloc]init];
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0&&dataArr.count>0) {
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0,KScreenWidth-30, 45)];
        label.text = @"数据概况";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kMainTitleColor;
        label.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:label];
        UIImageView *iv_back = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-KWidth(343))/2.0, (45-KHeight(2))/2.0,KWidth(343), KHeight(2))];
        iv_back.image = [UIImage imageNamed:@"iv_shujugailan"];
        [view addSubview:iv_back];
        return view;
    }
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0&&dataArr.count>0) {
        return 45;
    }
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 6.0;
    }
    if (suggestArr.count > 0) {
         return 0.01;
    }else{
        return 0.01;
    }
}
@end
