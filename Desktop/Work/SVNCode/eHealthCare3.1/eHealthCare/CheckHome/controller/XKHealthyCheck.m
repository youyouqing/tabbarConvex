//
//  XKHealthyCheck.m
//  eHealthCare
//
//  Created by mac on 16/12/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKHealthyCheck.h"
#import "XKHealthyCheckCell.h"
#import "XKHealthyCheckHeadView.h"
#import "XKChildViewHelper.h"
#import "XKSortHelper.h"
#import "XKLocationHelper.h"
#import "XKScreeningHelper.h"
#import "XKMedicalDetail.h"
#import "ShopCarController.h"
#import "XKRecommendSortModel.h"
#import "XKPackage.h"
#import "XKConditions.h"
#import "XKScreenAddrees.h"
#import "XKHealthyCheckModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "XKValidationAndAddScoreTools.h"

@interface XKHealthyCheck ()<XKHealthyCheckHeadViewDelegate,UITableViewDelegate,UITableViewDataSource,XKSortHelperDelegate,XKLocationHelperDelegate,XKChildViewHelperDelegate,XKScreeningHelperDelegate,BMKLocationServiceDelegate>{
    
    BMKLocationService *_locService;
    
    BMKUserLocation *_loaction;
    
}

@property (nonatomic,strong)XKHealthyCheckHeadView *headView;

@property (nonatomic,strong)UIButton *grayView;

@property (nonatomic,strong)XKBtton *selectBtn;

/**位置筛选的视图和实体*/
@property (nonatomic,strong)UIView *locationV;
@property (nonatomic,strong)XKChildViewHelper *locationViewModel;

/*默认排序的视图和实体*/
@property (nonatomic,strong)UIView *sortV;
@property (nonatomic,strong)XKSortHelper *sortViewModel;

/*选择的视图和实体*/
@property (nonatomic,strong)UIView *chooseV;
@property (nonatomic,strong)XKLocationHelper *chooseViewModel;

/*筛选的视图和实体*/
@property (nonatomic,strong)UIView *screenV;
@property (nonatomic,strong)XKScreeningHelper *screenViewModel;

/**
数据源
 */
@property (nonatomic,strong)NSMutableArray *dataArray;

/**
 请求参数提交的字典
 */
@property (nonatomic,strong)NSMutableDictionary *requestDict;

/**
 表示当前页数
 */
@property (nonatomic,assign)NSInteger pageIndex;

@property (nonatomic, strong) UIImageView *nullImgeView;

@property (nonatomic,weak)UILabel *carLab;

@end

@implementation XKHealthyCheck

-(XKHealthyCheckHeadView *)headView{
    
    if (!_headView) {
        
        _headView=[[[NSBundle mainBundle]loadNibNamed:@"XKHealthyCheckHeadView" owner:self options:nil]firstObject];
        _headView.left=0;
        _headView.top=0;
        _headView.width=KScreenWidth;
        _headView.height=99;
        _headView.delegate=self;
        
        self.delegate=(id)_headView;
        
    }
    
    return _headView;
    
}

-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - 30);
        _nullImgeView.image = [UIImage imageNamed:@"none"];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}
-(UITableView *)hCheckTableview{
    
    if (!_hCheckTableview) {
        
        _hCheckTableview=[[UITableView alloc]init];
        
        _hCheckTableview.left=0;
        _hCheckTableview.top=self.headView.height;
        _hCheckTableview.width=KScreenWidth;
        _hCheckTableview.height=KScreenHeight-self.headView.height;
        _hCheckTableview.delegate=self;
        _hCheckTableview.dataSource=self;
        
    }
    
    return _hCheckTableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"健康体检";
    
    self.pageIndex=1;
    self.requestDict=[[NSMutableDictionary alloc]initWithDictionary:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[UserInfoTool getLoginInfo].MemberID,@"PageIndex":@(1),@"PageSize":@(8),@"RecommendSort":@(-1),@"SuitClassID":@(-1),@"CityID":@(-1),@"ApplySex":@(-1),@"ApplyAge":@(-1),@"AgencyLevel":@(-1),@"IsExceptionRecommend":@(1),@"PriceInterval":@(-1),@"DiseaseType":@(-1),@"IsParking":@(-1),@"IsWifi":@(-1),@"IsReport":@(-1),@"Latitude":@(22.23),@"Longitude":@(113.345)}];
    //    if (self.isAccordingPersonalCheck) {//******注 参数配置反了*
    self.requestDict[@"IsExceptionRecommend"]=@(0);
    //    }else{
    //        self.requestDict[@"IsExceptionRecommend"]=@(1);
    //    }
    
    [self.view addSubview:self.headView];
    self.dataArray=[NSMutableArray arrayWithCapacity:0];
//    if (!self.navigationItem.leftBarButtonItem) {
//        self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    [self.view addSubview:self.hCheckTableview];
    
    self.hCheckTableview.showsVerticalScrollIndicator=NO;
    self.hCheckTableview.showsHorizontalScrollIndicator=NO;
    self.hCheckTableview.backgroundColor=[UIColor whiteColor];
    self.hCheckTableview.separatorColor=[UIColor clearColor];
    
    [self.hCheckTableview registerNib:[UINib nibWithNibName:@"XKHealthyCheckCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.grayView=[[UIButton alloc]initWithFrame:self.hCheckTableview.frame];
    [self.grayView addTarget:self action:@selector(clickToBack) forControlEvents:UIControlEventTouchUpInside];
    self.grayView.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.4];
    [self.view addSubview:self.grayView];
    
    [self.view bringSubviewToFront:self.hCheckTableview];
    
    self.headView.isAccordingPersonalCheck=self.isAccordingPersonalCheck;
    
    /*初始化位置筛选*/
    self.locationViewModel=[[XKChildViewHelper alloc]init];
    self.locationViewModel.delegate=self;
    self.locationV=[self.locationViewModel returnViewWithSource:CGRectMake(0, self.headView.height, KScreenWidth, 250)];
    [self.view addSubview:self.locationV];
    [self.view sendSubviewToBack:self.locationV];
    
    NSUserDefaults *uds=[NSUserDefaults standardUserDefaults];
    
    if ([uds objectForKey:@"cchchooseData"]) {
        NSArray *chooseData=[XKScreenAddrees objectArrayWithKeyValuesArray:[uds objectForKey:@"cchchooseData"]];
        
        self.locationViewModel.locationData=chooseData;
    }else{
        [[XKLoadingView shareLoadingView]showLoadingText:nil];
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"204" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token} success:^(id json) {
            
            XKLOG(@"%@",json);
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                
                [[XKLoadingView shareLoadingView] hideLoding];
                
                [uds setObject:[json objectForKey:@"Result"] forKey:@"cchchooseData"];
                
                NSArray *chooseData=[XKScreenAddrees objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
                
                self.locationViewModel.locationData=chooseData;
                
            }else{
                [[XKLoadingView shareLoadingView]errorloadingText:nil];
            }
            
        } failure:^(id error) {
            
            XKLOG(@"%@",error);
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            
        }];

    }
    
    
    /*初始化默认排序筛选*/
    self.sortViewModel=[[XKSortHelper alloc]init];
    self.sortV=[self.sortViewModel returnViewWithSource:CGRectMake(0, self.headView.height, KScreenWidth, 200)];
    self.sortViewModel.isAccordingPersonalCheck=self.isAccordingPersonalCheck;
    XKRecommendSortModel *m1=[[XKRecommendSortModel alloc]init];
    m1.ID=-1;
    m1.Name=@"默认推荐";
    XKRecommendSortModel *m4=[[XKRecommendSortModel alloc]init];
    m4.ID=3;
    m4.Name=@"智能推荐";
    XKRecommendSortModel *m2=[[XKRecommendSortModel alloc]init];
    m2.ID=1;
    m2.Name=@"低价优先";
    XKRecommendSortModel *m3=[[XKRecommendSortModel alloc]init];
    m3.ID=2;
    m3.Name=@"高价优先";
    self.sortViewModel.showArray=@[m1,m4,m2,m3];
    self.sortViewModel.delegate=self;
    [self.view addSubview:self.sortV];
    [self.view sendSubviewToBack:self.sortV];
    
    /*初始化套餐排序筛选*/
    self.chooseViewModel=[[XKLocationHelper alloc]init];
    self.chooseV=[self.chooseViewModel returnViewWithSource:CGRectMake(0, self.headView.height, KScreenWidth, 200)];
    self.chooseViewModel.delegate=self;
    [self.view addSubview:self.chooseV];
    [self.view sendSubviewToBack:self.chooseV];
    
    if ([uds objectForKey:@"ccksort"]) {
        
        NSArray *chooseData=[XKPackage objectArrayWithKeyValuesArray:[uds objectForKey:@"ccksort"]];
        
        self.chooseViewModel.chooseData=chooseData;
        
    }else{
        [[XKLoadingView shareLoadingView]showLoadingText:nil];
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"501" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"SuitClassType":@(2)} success:^(id json) {
            
            XKLOG(@"%@",json);
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                
                [[XKLoadingView shareLoadingView] hideLoding];
                
                [uds setObject:[json objectForKey:@"Result"] forKey:@"ccksort"];
                
                NSArray *chooseData=[XKPackage objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
                
                self.chooseViewModel.chooseData=chooseData;
                
            }else{
                [[XKLoadingView shareLoadingView]errorloadingText:nil];
            }
            
        } failure:^(id error) {
            
            XKLOG(@"%@",error);
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            
        }];
    }
    
    /*初始化筛选排序*/
    self.screenViewModel=[[XKScreeningHelper alloc]init];
    self.screenViewModel.delegate=self;
    self.screenV=[self.screenViewModel returnViewWithSource:CGRectMake(0, self.headView.height, KScreenWidth, 250) withIsPh:NO];
    [self.view addSubview:self.screenV];
    [self.view sendSubviewToBack:self.screenV];
    
    XKConditions *onecO=[[XKConditions alloc]init];
    onecO.ConditionId=1;
    onecO.ConditionName=@"男性";
    XKConditions *onecT=[[XKConditions alloc]init];
    onecT.ConditionId=2;
    onecT.ConditionName=@"女性";
    XKConditions *onecT1=[[XKConditions alloc]init];
    onecT1.ConditionId=3;
    onecT1.ConditionName=@"儿童";
    NSDictionary *dictOne=@{@"mainTitle":@"人群选择",@"data":@[onecO,onecT,onecT1]};
    
    XKConditions *twocO=[[XKConditions alloc]init];
    twocO.ConditionId=1;
    twocO.ConditionName=@"20-30";
    XKConditions *twocT=[[XKConditions alloc]init];
    twocT.ConditionId=2;
    twocT.ConditionName=@"30-40";
    XKConditions *twocT1=[[XKConditions alloc]init];
    twocT1.ConditionId=3;
    twocT1.ConditionName=@"40-50";
    XKConditions *twocF=[[XKConditions alloc]init];
    twocF.ConditionId=4;
    twocF.ConditionName=@"50-60";
    NSDictionary *dictTwo=@{@"mainTitle":@"年龄选择",@"data":@[twocO,twocT,twocT1,twocF]};
    
    XKConditions *fourcO=[[XKConditions alloc]init];
    fourcO.ConditionId=1;
    fourcO.ConditionName=@"三甲医院";
    XKConditions *fourcT=[[XKConditions alloc]init];
    fourcT.ConditionId=2;
    fourcT.ConditionName=@"私立医院";
    XKConditions *fourcT1=[[XKConditions alloc]init];
    fourcT1.ConditionId=3;
    fourcT1.ConditionName=@"公立医院";
    NSDictionary *dictFour=@{@"mainTitle":@"机构选择",@"data":@[fourcO,fourcT,fourcT1]};
    
    XKConditions *fivecO=[[XKConditions alloc]init];
    fivecO.ConditionId=1;
    fivecO.ConditionName=@"0-200";
    XKConditions *fivecT=[[XKConditions alloc]init];
    fivecT.ConditionId=2;
    fivecT.ConditionName=@"200-500";
    XKConditions *fivecT1=[[XKConditions alloc]init];
    fivecT1.ConditionId=3;
    fivecT1.ConditionName=@"500-1000";
    XKConditions *fivecF=[[XKConditions alloc]init];
    fivecF.ConditionId=4;
    fivecF.ConditionName=@"1000以上";
    NSDictionary *dictFive=@{@"mainTitle":@"价格选择",@"data":@[fivecO,fivecT,fivecT1,fivecF]};
    
    XKConditions *sixcO=[[XKConditions alloc]init];
    sixcO.ConditionId=2;
    sixcO.ConditionName=@"高血压";
    XKConditions *sixcT=[[XKConditions alloc]init];
    sixcT.ConditionId=3;
    sixcT.ConditionName=@"糖屎病";
    XKConditions *sixcT1=[[XKConditions alloc]init];
    sixcT1.ConditionId=4;
    sixcT1.ConditionName=@"冠心病";
    XKConditions *sixcF=[[XKConditions alloc]init];
    sixcF.ConditionId=7;
    sixcF.ConditionName=@"脑卒中";
    NSDictionary *dictSix=@{@"mainTitle":@"病症筛选",@"data":@[sixcO,sixcT,sixcT1,sixcF]};
    
    XKConditions *sevencO=[[XKConditions alloc]init];
    sevencO.ConditionId=1;
    sevencO.ConditionName=@"停车场";
    XKConditions *sevencT=[[XKConditions alloc]init];
    sevencT.ConditionId=2;
    sevencT.ConditionName=@"WIFI";
    XKConditions *sevencT1=[[XKConditions alloc]init];
    sevencT1.ConditionId=3;
    sevencT1.ConditionName=@"在线报告";
    NSDictionary *dictSeven=@{@"mainTitle":@"设施筛选",@"data":@[sevencO,sevencT,sevencT1]};
    NSArray *screenData=@[dictOne,dictTwo,dictFour,dictFive,dictSix,dictSeven];
    self.screenViewModel.screenData=screenData;
//    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"ico_shopping"] highImage:[UIImage imageNamed:@"ico_shopping"] target:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    
    self.hCheckTableview.contentInset=UIEdgeInsetsMake(0, 0, 60, 0);
    self.hCheckTableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.hCheckTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    
    if ([CLLocationManager locationServicesEnabled]) {
            
        XKLOG(@"定位可用");
        
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        //启动LocationService
        [_locService startUserLocationService];
            
    }
    else {
        XKLOG(@"定位不可用");
        
        self.requestDict[@"Latitude"]=@(22.23);
        self.requestDict[@"Longitude"]=@(113.345);
        
        self.locationViewModel.addressTitle=@"当前位置 :请手动选择";
        
        [self loadData:1 withisFresh:YES];
        
        UIAlertController *alertCons=[UIAlertController alertControllerWithTitle:nil message:@"请去设置中设置允许访问位置" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertCons addAction:action];
        
        [self presentViewController:alertCons animated:YES completion:nil];
        
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"ico_shopping"] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"ico_shopping"] forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab=[[UILabel alloc]init];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.text=@"0";
    lab.font=[UIFont systemFontOfSize:9];
    lab.backgroundColor=ORANGECOLOR;
    lab.textColor=[UIColor whiteColor];
    lab.top=-5;
    lab.left=btn.right-10;
    lab.width=20;
    lab.height=20;
    lab.layer.cornerRadius=20/2;
    lab.layer.masksToBounds=YES;
    [btn addSubview:lab];
    self.carLab=lab;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
//    //展示当天任务是否完成
//    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
//    [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(2),@"MemberID":[UserInfoTool getLoginInfo].MemberID,@"TypeID":@(4)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(2),@"MemberID":[UserInfoTool getLoginInfo].MemberID,@"TypeID":@(4)}];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadCarNumber];
    
}

-(void)loadCarNumber{
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"605" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[UserInfoTool getLoginInfo].MemberID} success:^(id json) {
        
        XKLOG(@"%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            self.carLab.text=[NSString stringWithFormat:@"%@",json[@"Result"][@"ProductCount"]];
            
            if ([json[@"Result"][@"ProductCount"] integerValue]==0) {
                self.carLab.hidden=YES;
            }else{
                self.carLab.hidden=NO;
            }
            
        }else{

        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        
    }];
    
}

-(void)freshLoad{
    
    [self loadData:1 withisFresh:NO];
    
}

-(void)moreLoad{
    
    [self loadData:2 withisFresh:NO];
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    if (_loaction) {
        
        return;
        
    }
    
    [_locService stopUserLocationService];
    
    [[XKLoadingView shareLoadingView] showLoadingText:@"定位中"];
    
    XKLOG(@"拿到位置 lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //创建地理编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //创建位置
    CLLocation *location=[[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //赋值详细地址
//            NSLog(@"%@",placemark.addressDictionary[@"City"]);
//            NSLog(@"%@",placemark.addressDictionary[@"Country"]);
//            NSLog(@"%@",placemark.addressDictionary[@"FormattedAddressLines"]);
//             NSLog(@"%@",placemark.addressDictionary[@"Name"]);
//            NSLog(@"%@",placemark.addressDictionary[@"State"]);
//            NSLog(@"%@",placemark.addressDictionary[@"Street"]);
//            NSLog(@"%@",placemark.addressDictionary[@"SubLocality"]);
//            NSLog(@"%@",placemark.addressDictionary[@"SubThoroughfare"]);
//             NSLog(@"%@",placemark.addressDictionary[@"Thoroughfare"]);
            
            
            self.locationViewModel.addressTitle=[NSString stringWithFormat:@"当前位置 : %@",placemark.addressDictionary[@"SubLocality"]?placemark.addressDictionary[@"SubLocality"]:placemark.addressDictionary[@"City"]];
            
        }
    }];
    
    
    self.requestDict[@"Latitude"]=@(userLocation.location.coordinate.latitude);
    
    self.requestDict[@"Longitude"]=@(userLocation.location.coordinate.longitude);
    
    [self loadData:1 withisFresh:YES];
    _loaction=userLocation;
    
    [[XKLoadingView shareLoadingView] hideLoding];
    
    [_locService stopUserLocationService];
    
}

-(void)loadData:(NSInteger)mothed withisFresh:(BOOL) isf{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    NSInteger size=8;
    
    if (mothed==1) {//刷新
        
        if (self.dataArray.count==0) {
            
            size=8;
            
        }else{
            
            size=8;
            
        }
        
    }else{//加载更多
        
        size=8;
        
        self.pageIndex++;
        
    }
    self.requestDict[@"PageIndex"]=@(self.pageIndex);
    self.requestDict[@"PageSize"]=@(size);
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"700" parameters:self.requestDict success:^(id json) {
        
        XKLOG(@"%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            if (mothed==2) {
                
                if (self.dataArray.count>=[[json objectForKey:@"Rows"] integerValue]&&self.pageIndex>1) {
                    
                    self.pageIndex--;
                    
                    [self.hCheckTableview.mj_header endRefreshing];
                    // 结束刷新
                    [self.hCheckTableview.mj_footer endRefreshing];
                    
                }else{
                    
                    self.pageIndex=1;
                    
                }
                
            }
            
            NSArray *dArray=[XKHealthyCheckModel objectArrayWithKeyValuesArray:json[@"Result"]];
            if (mothed==1) {
                
                self.dataArray=(NSMutableArray *)dArray;
                
            }else{
                
                [self.dataArray addObjectsFromArray:dArray];
                
            }
            
            [self.hCheckTableview reloadData];
            
            [self.hCheckTableview.mj_header endRefreshing];
            // 结束刷新
            [self.hCheckTableview.mj_footer endRefreshing];
            
            if (self.dataArray.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.hCheckTableview.mj_header endRefreshing];
                // 结束刷新
                [self.hCheckTableview.mj_footer endRefreshing];
                
                self.hCheckTableview.mj_footer=nil;
                
            }else{
                
                self.hCheckTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
                
            }
            
            [self showNonPhotp];
            
            [self.hCheckTableview reloadData];
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        
    }];
    
}

-(void)showNonPhotp{
    [self.view addSubview:self.nullImgeView];
    if (self.dataArray.count==0) {
        self.nullImgeView.alpha = 1;
        
    }else{
        self.nullImgeView.alpha = 0;
        for (UIView *vo in self.view.subviews) {
            if ([vo isKindOfClass:[UIImageView class]]) {
                [vo removeFromSuperview];
            }
        }
    }
}

/*点击了购物车*/
-(void)clickRight{
    XKLOG(@"点击了购物车");
    ShopCarController *vc=[[ShopCarController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*城市选择的协议方法*/
-(void)backCurrentLoaction:(XKChildViewHelper *)loaction{
    XKLOG(@"回到当前位置");
    self.requestDict[@"CityID"]=@(-1);
    self.requestDict[@"Latitude"]=@(_loaction.location.coordinate.latitude);
    self.requestDict[@"Longitude"]=@(_loaction.location.coordinate.longitude);
    [self loadData:1 withisFresh:YES];
    [self clickToBack];
}

-(void)sendMsg:(XKChildViewHelper *)loaction province:(id)province city:(id)city area:(id)area{
    
    XKLOG(@"省市区的选择结束");
    XKScreenAddreesThree *three=area;
    self.requestDict[@"CityID"]=@(three.Code);
    [self loadData:1 withisFresh:YES];
    [self clickToBack];
}


-(void)sendScreeningMsg:(XKScreeningHelper *)screening num1:(NSInteger)IsParking num2:(NSInteger)IsWifi num3:(NSInteger)IsReport num4:(NSInteger)ApplySex num5:(NSInteger)ApplyAge num6:(NSInteger)AgencyLevel num7:(NSInteger)PriceInterval num8:(NSInteger)DiseaseType{
    XKLOG(@"点击了确定");
    
    self.requestDict[@"IsParking"]=@(IsParking);
    self.requestDict[@"IsWifi"]=@(IsWifi);
    self.requestDict[@"IsReport"]=@(IsReport);
    self.requestDict[@"ApplySex"]=@(ApplySex);
    self.requestDict[@"ApplyAge"]=@(ApplyAge);
    self.requestDict[@"AgencyLevel"]=@(AgencyLevel);
    self.requestDict[@"PriceInterval"]=@(PriceInterval);
    self.requestDict[@"DiseaseType"]=@(DiseaseType);
    
    [self loadData:1 withisFresh:YES];
    
    [self clickToBack];
}

/*排序的代理方法*/
-(void)sendSort:(XKSortHelper *)sort sendSortMethod:(id)methor withIndexPath:(NSInteger)row{
    XKLOG(@"默认排序方式");
    XKRecommendSortModel *sortM=methor;
    
    if (sortM.ID!=3) {
        self.requestDict[@"RecommendSort"]=@(sortM.ID);
        self.requestDict[@"IsExceptionRecommend"]=@(0);
    }else{
        self.requestDict[@"IsExceptionRecommend"]=@(1);
    }
    
    [self loadData:1 withisFresh:YES];
    
    [self clickToBack];
}

/*套餐选择的代理方法*/
-(void)sendChoose:(XKLocationHelper *)sort sendSortMethod:(id)methor withIndexPath:(NSInteger)row{
    XKLOG(@"套餐选择");
    XKPackage *package=methor;
    self.requestDict[@"SuitClassID"]=@(package.SuitClassID);
    [self loadData:1 withisFresh:YES];
    [self clickToBack];
}

/*背景的点击方法*/
-(void)clickToBack{
    
    XKLOG(@"点击了背景");
    
    [self.view bringSubviewToFront:self.hCheckTableview];
    
    [self.delegate clickBackGround:self withBotton:self.selectBtn];
}

-(void)clickBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*头部的协议方法*/
-(void)selectStatus:(XKHealthyCheckHeadView *)head change:(BOOL)isChange whoBtn:(XKBtton *)btn{
    
    if (isChange) {
        [self.view bringSubviewToFront:self.hCheckTableview];
           
    }else{
        [self.view bringSubviewToFront:self.grayView];
        
        NSInteger btnTag=btn.tag-100;
        if (btnTag==1) {
            [self.view bringSubviewToFront:self.sortV];
            
            self.sortV.hidden=NO;
            
            self.chooseV.hidden=YES;
            
            self.locationV.hidden=YES;
            
            self.screenV.hidden=YES;
            
            
        }
        if (btnTag==2) {
            [self.view bringSubviewToFront:self.chooseV];
            self.sortV.hidden=YES;
            
            self.chooseV.hidden=NO;
            
            self.locationV.hidden=YES;
            
            self.screenV.hidden=YES;
            
        }
        if (btnTag==3) {
            [self.view bringSubviewToFront:self.locationV];
            self.sortV.hidden=YES;
            
            self.chooseV.hidden=YES;
            
            self.locationV.hidden=NO;
            
            self.screenV.hidden=YES;
            
        }
        if (btnTag==4) {
            [self.view bringSubviewToFront:self.screenV];
            self.sortV.hidden=YES;
            
            self.chooseV.hidden=YES;
            
            self.locationV.hidden=YES;
            
            self.screenV.hidden=NO;
            
        }
    }
    
    self.selectBtn=btn;
    
}

-(void)sendHeadView:(XKHealthyCheckHeadView *)head{
    
    [self.headView removeFromSuperview];
    
    self.headView = head;
    
    [self.view addSubview:self.headView];
    
    self.hCheckTableview.left=0;
    self.hCheckTableview.top=self.headView.height;
    self.hCheckTableview.width=KScreenWidth;
    self.hCheckTableview.height=KScreenHeight-self.headView.height;

    self.grayView.frame=self.hCheckTableview.frame;
    self.delegate=(id)self.headView;
    
    self.locationV.top=self.headView.height;
    self.sortV.top=self.headView.height;
    self.chooseV.top=self.headView.height;
    self.screenV.top=self.headView.height;
    
//    self.requestDict[@"IsExceptionRecommend"]=@(0);
//    
//    [self loadData:1 withisFresh:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKHealthyCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XKHealthyCheckModel *model=self.dataArray[indexPath.row];
    cell.model=model;
    cell.selectionStyle=UITableViewCellAccessoryNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XKMedicalDetail *detail=[[XKMedicalDetail alloc]initWithStyle:UITableViewStylePlain];
    XKHealthyCheckModel *model=self.dataArray[indexPath.row];
    detail.SuitProductID=model.SuitProductID;
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
