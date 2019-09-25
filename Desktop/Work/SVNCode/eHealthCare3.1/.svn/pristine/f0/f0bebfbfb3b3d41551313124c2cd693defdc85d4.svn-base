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
@interface NewTrendDetailController ()<UITableViewDelegate,UITableViewDataSource,DrinkHeaderViewDelegate,XKBloodFatChooseViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *sugardataArr;
    NSMutableArray *oneDataArr;
    NSMutableArray *twoDataArr;
    NSMutableArray *timeArr;
    
    
    NSMutableArray *afeterTimeArr;
    
    TrendSuggestModel *suggestModel;
    XKTrendSuggestSurgarModel *sugarsuggestModel;
    NewTrendDataModel *titleModel;
    
     XKNewTrendDataSugarModel *sugartitleModel;
    NSMutableArray *suggestArr;
    
    NSDictionary *maxNumDic;
    
    UIButton *centerBtn;//表格按钮
    BOOL isOpenSelectView;//是否展开标识
}
@property (nonatomic,strong) UITableView *mytable;
@property (nonatomic,strong) DrinkHeaderView *headerView;

@property (nonatomic, strong) XKBloodFatChooseView *allView;//标题视图点击之后是否要显示的视图
@end

@implementation NewTrendDetailController

/**实现协议方法*/
-(void)didSelectOnce:(XKPhySicalItemModel *)model{

    for (XKPhySicalItemModel *b in self.PhysicalItemArr) {
        if (b == model) {
            b.IsSelect = YES;
            self.PhysicalItemID = b.PhysicalItemID;
             [centerBtn setTitle:b.PhysicalItemName forState:UIControlStateNormal];
        }else{
            b.IsSelect = NO;
        }
        XKLOG(@"---IsSelect--%@",b.PhysicalItemName);
    }
    self.allView.dataArray = self.PhysicalItemArr;
    //折线图最大值范围
    maxNumDic = @{@"11":@12,@"32":@12,@"33":@12,@"163":@12,@"9":@50,@"1":@200,@"14":@50,@"51":@100,@"10":@200,@"34":@15,@"36":@10,@"37":@10,@"35":@5,@"12":@260};
    
    _headerView.maxScore = [[NSString stringWithFormat:@"%@",[maxNumDic objectForKey:[NSString stringWithFormat:@"%li",self.PhysicalItemID]]] integerValue];
    [self loadData];
    
    [self changeBloodFat];
    
}

//影长视图的点击方法
-(XKBloodFatChooseView *)allView
{
    if (!_allView) {
        _allView = [[[NSBundle mainBundle] loadNibNamed:@"XKBloodFatChooseView" owner:self options:nil] lastObject];
        _allView.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64);
        _allView.clipsToBounds = YES;
        _allView.alpha = 0;
        _allView.delegate = self;
    }
    return _allView;
}

#pragma mark  - 懒加载
-(DrinkHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView=[[[NSBundle mainBundle]loadNibNamed:@"DrinkHeaderView" owner:self options:nil]firstObject];
        
        _headerView.x=0;
        
        _headerView.y=0;
        
        _headerView.width=KScreenWidth;
        
        _headerView.height=DrinkHeight;
        
        _headerView.delegate=self;
        
        _headerView.descriptionStr=NO;
        
        _headerView.isShowAir=NO;
        
        
//        _headerView.markStr=@"杯";
        
        _headerView.lineStyle=YES;
        
//        _headerView.maxScore = [[NSString stringWithFormat:@"%@",[maxNumDic objectForKey:[NSString stringWithFormat:@"%li",self.PhysicalItemID]]] integerValue];
        //    self.headerView.maxScore = 100;
    }
    
    return _headerView;
    
}

-(UITableView *)mytable
{
    if (!_mytable) {
        _mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStyleGrouped];
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
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
     [self.allView closeAllView];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"趋势图";
   
    titleModel = [[NewTrendDataModel alloc]init];
    dataArr = [[NSMutableArray alloc] init];
     sugardataArr = [[NSMutableArray alloc] init];
    timeArr = [[NSMutableArray alloc] init];
    sugartitleModel = [[XKNewTrendDataSugarModel alloc]init];
    afeterTimeArr = [[NSMutableArray alloc]init];
    oneDataArr = [[NSMutableArray alloc] init];
    twoDataArr = [[NSMutableArray alloc] init];
    suggestModel = [[TrendSuggestModel alloc] init];
     sugarsuggestModel = [[XKTrendSuggestSurgarModel alloc] init];
    suggestArr = [[NSMutableArray alloc] init];
    [self.view addSubview:self.mytable];
    
    self.mytable.tableHeaderView=self.headerView;
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mytable registerNib:[UINib nibWithNibName:@"TrendDetailDataCell" bundle:nil] forCellReuseIdentifier:@"TrendDetailDataCell"];
    [self.mytable registerNib:[UINib nibWithNibName:@"TrendSuggestCell" bundle:nil] forCellReuseIdentifier:@"TrendSuggestCell"];
    [self.mytable registerNib:[UINib nibWithNibName:@"DetailArcFootCell" bundle:nil] forCellReuseIdentifier:@"DetailArcFootCell"];


    
    //折线图最大值范围
    maxNumDic = @{@"11":@12,@"32":@12,@"33":@12,@"163":@12,@"9":@50,@"1":@200,@"14":@50,@"51":@100,@"10":@200,@"34":@15,@"36":@10,@"37":@10,@"35":@5,@"12":@260};
    
    _headerView.maxScore = [[NSString stringWithFormat:@"%@",[maxNumDic objectForKey:[NSString stringWithFormat:@"%li",self.PhysicalItemID]]] integerValue];
    
    if (self.PhysicalItemArr) {
        //处理标题view视图
        XKPhySicalItemModel *mod = self.PhysicalItemArr[0];
        self.PhysicalItemID = mod.PhysicalItemID;
        centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        centerBtn.frame = CGRectMake(0, 0, 130, 40);
        [centerBtn setTitle:mod.PhysicalItemName forState:UIControlStateNormal];
        [centerBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
        centerBtn.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
        [centerBtn addTarget:self action:@selector(changeBloodFat) forControlEvents:UIControlEventTouchUpInside];
        centerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);
        centerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        self.navigationItem.titleView = centerBtn;
        XKPhySicalItemModel *model = self.PhysicalItemArr[0];
        model.IsSelect = YES;
        self.allView.dataArray = self.PhysicalItemArr;
    }else  if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163)
    {
        //处理标题view视图
        centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        centerBtn.frame = CGRectMake(0, 0, 170, 40);
        [centerBtn setTitle:@"空腹血糖" forState:UIControlStateNormal];
        [centerBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
        centerBtn.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
        [centerBtn addTarget:self action:@selector(changeBloodFat) forControlEvents:UIControlEventTouchUpInside];
        centerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        centerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        self.navigationItem.titleView = centerBtn;
        
    }
    
    [self loadData];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"去分享" style:UIBarButtonItemStylePlain target:self action:@selector(clickShard)];

    
    
}

/**血脂四项点击方法*/
-(void)changeBloodFat{
    isOpenSelectView = !isOpenSelectView;
    if (isOpenSelectView) {
        [centerBtn setImage:[UIImage imageNamed:@"pullup"] forState:UIControlStateNormal];
        [self.allView openAllView];
    }else{
        [centerBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
        [self.allView closeAllView];
        
    }
}
-(void)PhysicalItemArrSugarOrDil:(NSArray *)PhysicalItemArr{
//    XKPhySicalItemModel *mod = PhysicalItemArr[0];
//    self.PhysicalItemID = mod.PhysicalItemID;
//
//
//    centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    centerBtn.frame = CGRectMake(0, 0, 130, 40);
//    [centerBtn setTitle:mod.PhysicalItemName forState:UIControlStateNormal];
//    [centerBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
//    centerBtn.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
//    [centerBtn addTarget:self action:@selector(changeBloodFat) forControlEvents:UIControlEventTouchUpInside];
//    centerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);
//    centerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    self.navigationItem.titleView = centerBtn;
//    XKPhySicalItemModel *model = self.PhysicalItemArr[0];
//    model.IsSelect = YES;
    for (XKPhySicalItemModel *b in self.PhysicalItemArr) {
        if (b.PhysicalItemID == self.PhysicalItemID) {
            b.IsSelect = YES;
          
        }else{
            b.IsSelect = NO;
        }
//        XKLOG(@"---IsSelect--%d",b.IsSelect);
    }
    self.allView.dataArray = self.PhysicalItemArr;
    
}
-(void)clickShard{
    
    XKTrendDetailShardController *detailShard=[[XKTrendDetailShardController alloc]init];
    
    detailShard.PhysicalItemID=self.PhysicalItemID;
    if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163)
    {
        detailShard.dataArr=  sugardataArr;
        
        detailShard.sugarsuggestModel= sugarsuggestModel;
        
    }
    else
    {
        
        detailShard.dataArr=dataArr;
        
        detailShard.suggestModel=suggestModel;
    }
   
    
    detailShard.shareType = self.shareType;
    
    [self.navigationController pushViewController:detailShard animated:YES];
    
    
}

#pragma mark - 获取数据
-(void)loadData
{
    NSString *typeString = @"315";//体检项目编号(空腹：32、餐后：33、随机：163)
    if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163) {
      
        
         typeString = @"316";
    }else
    {
        
         typeString = @"315";
        
    }
    
    NSString *memberID = [UserInfoTool getLoginInfo].MemberID];
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,
                         @"MemberID":[NSNumber numberWithInteger:[memberID integerValue]],
                         @"PhysicalItemID":[NSNumber numberWithInteger:self.PhysicalItemID]};
    
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:typeString parameters:dict success:^(id json) {
        XKLOG(@"趋势图315：%@",json);
        
        
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            [[XKLoadingView shareLoadingView]  hideLoding];
          
        if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163) {
            
            
            NSArray *dataArray = [XKNewTrendDataSugarModel objectArrayWithKeyValuesArray:dic[@"Result"][@"PhysicalTendencyList"]];
            sugardataArr=(NSMutableArray *)dataArray;
            sugarsuggestModel = [XKTrendSuggestSurgarModel objectWithKeyValues:dic[@"Result"][@"PhysicalSuggestEntity"]];
            }
            else
            {
                NSArray *dataArray = [NewTrendDataModel objectArrayWithKeyValuesArray:dic[@"Result"][@"PhysicalTendencyList"]];
                dataArr=(NSMutableArray *)dataArray;
                suggestModel = [TrendSuggestModel objectWithKeyValues:dic[@"Result"][@"PhysicalSuggestEntity"]];
            }
          
            //将数组倒序之后在赋值
//            NSArray* reversedArray = [[dataArray reverseObjectEnumerator] allObjects];

            /**判断是否是血脂四项内容 否则默认选中第一项*/
             if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163)
            {
                self.PhysicalItemArr =  [XKPhySicalItemModel objectArrayWithKeyValuesArray:dic[@"Result"][@"Physical_ItemList"]];
               
                [self PhysicalItemArrSugarOrDil:self.PhysicalItemArr];
                
            }
            [self dealWithData];
            [self.mytable reloadData];
            
        }else{
            [[XKLoadingView shareLoadingView]  errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [[XKLoadingView shareLoadingView]  errorloadingText:nil];

    }];
}
//处理数据数组
-(void)dealWithData
{
    /**清除数据*/
    [oneDataArr removeAllObjects];
    [timeArr removeAllObjects];
    [twoDataArr removeAllObjects];
    [afeterTimeArr removeAllObjects];
    [suggestArr removeAllObjects];
    for (id cV in self.headerView.chartView.subviews) {
        if ([cV isKindOfClass:[UIButton class]])
        {
            UIButton *cView = (UIButton *)cV;
            if (cView.frame.size.width == 10) {
                [cView removeFromSuperview];
            }
            
        }
    }
    
    for (UILabel *lab in self.headerView.greenLabArray) {
        lab.hidden = YES;
    }
    for (UILabel *lab in self.headerView.yellowLabArray) {
        lab.text = @"";
        lab.hidden = NO;
    }
    [self.headerView.lineLayer removeFromSuperlayer];
    self.shareType = 2000;
    if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163) {

        
        
        for (XKNewTrendDataSugarModel *model in sugardataArr) {
            
//            if (model.BloodType == 1) {
            
                [oneDataArr addObject:[NSNumber numberWithFloat:model.BloodSugar]];
                Dateformat *format = [[Dateformat alloc]init];
           
                [timeArr addObject:[DateformatTool ymdStringFromString:[DateformatTool dateFromString:[NSString stringWithFormat:@"%@"model.TestTime]]]];
//            }
            
            
            
            
            //        }
            
            
        }
        //第一条折线图数据
        self.headerView.dataArray = oneDataArr;
        if (self.PhysicalItemID == 32) {
             [self.headerView.acountOneBtn setTitle:[NSString stringWithFormat:@"%@(%@)",sugarsuggestModel.PhysicalItemNameOne,sugarsuggestModel.PhysicalItemUnitOne] forState:UIControlStateNormal];
            XKLOG(@"sugarsuggestModel.PhysicalItemNameOne,sugarsuggestModel.PhysicalItemUnitOne%@ %@",sugarsuggestModel.PhysicalItemNameOne,sugarsuggestModel.PhysicalItemUnitOne);
             sugartitleModel.titleName1 = sugarsuggestModel.PhysicalItemNameOne;
        }
        if (self.PhysicalItemID == 33) {
            [self.headerView.acountOneBtn setTitle:[NSString stringWithFormat:@"%@(%@)",sugarsuggestModel.PhysicalItemNameTwo,sugarsuggestModel.PhysicalItemUnitTwo] forState:UIControlStateNormal];
            
             sugartitleModel.titleName1 = sugarsuggestModel.PhysicalItemNameTwo;
        }
        if (self.PhysicalItemID == 163) {
            [self.headerView.acountOneBtn setTitle:[NSString stringWithFormat:@"%@(%@)",sugarsuggestModel.PhysicalItemNameThree,sugarsuggestModel.PhysicalItemUnitThree] forState:UIControlStateNormal];
            
             sugartitleModel.titleName1 = sugarsuggestModel.PhysicalItemNameThree;
        }
       
        if (twoDataArr.count> 0 ) {
            if (self.PhysicalItemID != 11) {
                self.headerView.otherDataArray = twoDataArr;//第二条折线图数据
            }


            self.headerView.acountTwoBtn.hidden = NO;
            [self.headerView.acountTwoBtn setTitle:[NSString stringWithFormat:@"%@(%@)",suggestModel.PhysicalItemNameTwo,suggestModel.PhysicalItemUnitTwo] forState:UIControlStateNormal];
        }else{
            self.headerView.acountTwoBtn.hidden = YES;
        }
        
//        XKLOG(@"%@",timeArr);
        
        

        self.headerView.labArray = timeArr;
        
       
        if (sugarsuggestModel.PhysicalItemNameTwo.length > 0) {
            sugartitleModel.titleName2 = sugarsuggestModel.PhysicalItemNameTwo;
        }
        [sugardataArr insertObject:sugartitleModel atIndex:0];
        
        if (sugarsuggestModel.Status == 0) {
            //最新一次数据为异常时
            if (sugarsuggestModel.KnowledgeSuggest.length > 0) {
                [suggestArr addObject:@{@"0":@{@"title":@"健康常识",@"suggest":sugarsuggestModel.KnowledgeSuggest}}];
            }
            if (sugarsuggestModel.SportSuggest.length > 0) {
                [suggestArr addObject:@{@"1":@{@"title":@"运动建议",@"suggest":sugarsuggestModel.SportSuggest}}];
            }
            if (sugarsuggestModel.SportSuggest.length > 0) {
                [suggestArr addObject:@{@"2":@{@"title":@"饮食建议",@"suggest":sugarsuggestModel.DrinkSuggest}}];
            }
            if (sugarsuggestModel.SportSuggest.length > 0) {
                [suggestArr addObject:@{@"3":@{@"title":@"饮食建议",@"suggest":sugarsuggestModel.HealthSuggest}}];
            }
        }
        
    }else
    {

        
        for (NewTrendDataModel *model in dataArr) {
            if (self.PhysicalItemID == 1  ||self.PhysicalItemID == 12|| self.PhysicalItemID == 11) {//
                //BMI 、血糖、血压
                model.hasTwoLine = YES;
            }
           
            [oneDataArr addObject:[NSNumber numberWithFloat:model.ValueOne]];
            if (model.hasTwoLine) {
                [twoDataArr addObject:[NSNumber numberWithFloat:model.ValueTwo]];
            }
            [timeArr addObject:[self loadTimeStr:model.TestTime]];
            
            //        }
            
            
        }
        //第一条折线图数据
        self.headerView.dataArray = oneDataArr;
        
        [self.headerView.acountOneBtn setTitle:[NSString stringWithFormat:@"%@(%@)",suggestModel.PhysicalItemNameOne,suggestModel.PhysicalItemUnitOne] forState:UIControlStateNormal];
        if (twoDataArr.count> 0 ) {
            if (self.PhysicalItemID != 11) {
                self.headerView.otherDataArray = twoDataArr;//第二条折线图数据
            }
            
            
            self.headerView.acountTwoBtn.hidden = NO;
            [self.headerView.acountTwoBtn setTitle:[NSString stringWithFormat:@"%@(%@)",suggestModel.PhysicalItemNameTwo,suggestModel.PhysicalItemUnitTwo] forState:UIControlStateNormal];
        }else{
            self.headerView.acountTwoBtn.hidden = YES;
        }
        
        XKLOG(@"%@",timeArr);
        

        self.headerView.labArray = timeArr;
        
        titleModel.titleName1 = suggestModel.PhysicalItemNameOne;
        if (suggestModel.PhysicalItemNameTwo.length > 0) {
            titleModel.titleName2 = suggestModel.PhysicalItemNameTwo;
        }
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
                [suggestArr addObject:@{@"3":@{@"title":@"饮食建议",@"suggest":suggestModel.HealthSuggest}}];
            }
        }
        
        
        //    if (oneDataArr.count>0) {
        //        self.headerView.acountOneBtn.enabled = YES;
        //
        //        [self.headerView.acountOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //
        //
        //    }
        //    else
        //    {
        //        self.headerView.acountOneBtn.enabled = NO;
        //        [self.headerView.acountOneBtn setTitleColor:kColorWithHexString(@"237e89") forState:UIControlStateNormal];
        //        self.headerView.otherDataArray = twoDataArr;
        //
        //        self.headerView.labArray = afeterTimeArr;
        //    }
        //
        //    if (twoDataArr.count>0) {
        //
        //        self.headerView.acountTwoBtn.enabled = YES;
        //         [self.headerView.acountTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //    }
        //    else
        //    {
        //        [self.headerView.acountTwoBtn setTitleColor:kColorWithHexString(@"237e89") forState:UIControlStateNormal];
        //         self.headerView.acountTwoBtn.enabled = NO;
        //
        //
        //    }
        
        
    }
  
    
}
#pragma mark   clickDateToTakeData （特别愚蠢的办法   最好不要这样写）
-(void)clickDateToTakeData:(NSInteger)type;
{
    if (self.PhysicalItemID == 11) {
        /*第一个按钮和第二个，第一个现实刷新数据*/
        if (type == 2000) {
            [self.headerView.acountOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.headerView.acountTwoBtn setTitleColor:[UIColor colorWithHexString:@"237e89"] forState:UIControlStateNormal];
            
            for (id cV in self.headerView.chartView.subviews) {
                    if ([cV isKindOfClass:[UIButton class]])
                    {
                        UIButton *cView = (UIButton *)cV;
                        if (cView.frame.size.width == 10) {
                            [cView removeFromSuperview];
                        }
                        
                    }
            }
            for (UILabel *lab in self.headerView.greenLabArray) {
                lab.hidden = YES;
            }
            for (UILabel *lab in self.headerView.yellowLabArray) {
                lab.hidden = NO;
            }
                [self.headerView.lineLayer removeFromSuperlayer];
          
          
            self.headerView.dataArray = oneDataArr;
            
            self.headerView.labArray = timeArr;
           
            
           
            
           
 
        }
        else
        {
            [self.headerView.acountOneBtn setTitleColor:[UIColor colorWithHexString:@"237e89"] forState:UIControlStateNormal];
            
            [self.headerView.acountTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            for (id cV in self.headerView.chartView.subviews) {

                if ([cV isKindOfClass:[UIButton class]])
                {
                    UIButton *cView = (UIButton *)cV;
                    if (cView.frame.size.width == 10) {
                        [cView removeFromSuperview];
                    }
                    
                }
            }
            for (UILabel *lab in self.headerView.yellowLabArray) {
                lab.hidden = YES;
            }
            for (UILabel *lab in self.headerView.greenLabArray) {
                lab.hidden = NO;
            }

            
//            dispatch_async(dispatch_get_main_queue(), ^{
                [self.headerView.lineLayer removeFromSuperlayer];
//            });

            
            
                  self.headerView.otherDataArray = twoDataArr;
                     NSLog(@"twoDataArr---%@",twoDataArr);
                    self.headerView.labArray = afeterTimeArr;
            
            
        }
        self.shareType = type;
        
        }
    
}
/**通过时间戳返回时间**/
-(NSString *)loadTimeStr:(NSString *)time{
    
//    Dateformat *dateFor = [[Dateformat alloc] init];
    NSString *timeNumsp = [DateformatTool timeSpWithDate:time withFormat:@"YYYY-MM-dd"];
    NSString *timeStr = [DateformatTool ymdStringFromString:[DateformatTool dateFromString:[NSString stringWithFormat:@"%@"timeNumsp]]];
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
         if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163) {
            return sugardataArr.count;
        }
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
           
             if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163) {
               
                 mod= (XKNewTrendDataSugarModel *)sugardataArr[ indexPath.row];
            }
            else
                  model= (NewTrendDataModel *)dataArr[ indexPath.row];
        }else{
           
            
             if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163)  {
                mod= (XKNewTrendDataSugarModel *)sugardataArr[sugardataArr.count-indexPath.row];;
            }else
                 model= (NewTrendDataModel *)dataArr[dataArr.count-indexPath.row];
        }
        
        TrendDetailDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendDetailDataCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.suggestModel=suggestModel;
        model.PhysicalItemID = self.PhysicalItemID;
        cell.model = model;
        
        
       
        
        if (self.PhysicalItemID == 32||self.PhysicalItemID == 33||self.PhysicalItemID == 163)  {
           cell.sugarsuggestModel = sugarsuggestModel;
           cell.sugarmodel = mod;
          
        }
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
//    TrendSuggestFootView *footView = [[[NSBundle mainBundle] loadNibNamed:@"TrendSuggestFootView" owner:self options:nil] lastObject];
//    footView.frame = CGRectMake(0, 0, KScreenWidth, 70);
//    footView.clipsToBounds = YES;
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 150, view.height - 15)];
        label.text = @"数据概况";
        label.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:label];
        return view;
    }
    
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 45;
    }
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    if (suggestArr.count > 0) {
         return 0.01;
    }else{
        return 0.01;
    }
}
@end
