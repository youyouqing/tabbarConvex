//
//  SportMapViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportMapViewController.h"
#import "XKSportDestinationController.h"
#import "BaiduMap_SportViewController.h"
#import <CoreLocation/CoreLocation.h>
//定位头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>//只引入所需的单个头文件,用于计算
#import "CountDownViewController.h"
@interface SportMapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
{
    UIImageView *imageview;
    
}
@property (strong, nonatomic) BMKMapView *mapView;
@property(nonatomic,strong) BMKPointAnnotation *startAnnotation;
@property(nonatomic,strong) BMKPolyline *polyLine;
@property(nonatomic,strong) BMKLocationService *locationService;
@property(nonatomic,strong)BMKUserLocation *userLocation;
@property (nonatomic,retain) BMKGeoCodeSearch *geoSearch;
@end
@implementation SportMapViewController
- (BMKMapView *)mapView
{
    if (!_mapView) {
        
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight )];
        [_mapView setZoomLevel:17];
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.rotateEnabled = YES;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.delegate = self;
    
    }
    return _mapView;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
     _locationService.delegate = self;
     _geoSearch.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
     _mapView.delegate = nil;
     _locationService.delegate = nil;
     _geoSearch.delegate = nil;
}
- (void)initBaiduMap
{
    _locationService = [[BMKLocationService alloc]init];
    _locationService.distanceFilter = 15;
    _locationService.desiredAccuracy = kCLLocationAccuracyBest;
//    if (SystemVersion  >=9 ) {
        _locationService.allowsBackgroundLocationUpdates = YES;
//    }
     _locationService.delegate = self;
    //设置是否允许系统自动暂停定位，这里要设置为NO，如果没有设置默认为YES，后台定位持续20分钟左右就停止了！
    _locationService.pausesLocationUpdatesAutomatically = NO;
    [self.locationService startUserLocationService];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.backgroundColor= [UIColor whiteColor];
    if ([SportCommonMod shareInstance].Type ==2) {
         self.myTitle = @"跑步";
    }
    else if ([SportCommonMod shareInstance].Type ==3) {
        
        self.myTitle = @"登山";
    }
    else if ([SportCommonMod shareInstance].Type ==4) {
        
        self.myTitle = @"骑行";
    }
   
    self.titleLab.textColor = kMainTitleColor;
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    [self.rightBtn setImage:[UIImage imageNamed:@"icon_target"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickDestination) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:[UIColor getColor:@"03C7FF"] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"目标" forState:UIControlStateNormal];
    [self.view addSubview:self.mapView];
 
    [self initBaiduMap];
    
    //开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateNormal];
     [startButton setImage:[UIImage imageNamed:@"btn_start"] forState:UIControlStateSelected];
    [startButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo( - KHeight(43));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(120), KWidth(120)));
    }];
     self.geoSearch = [[BMKGeoCodeSearch alloc] init];
}
-(void)startAction
{
    
    [SportCommonMod shareInstance].isMinuteCount = NO;
    CountDownViewController *viewController = [[CountDownViewController alloc] initWithType:pageTypeNoNavigation];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)clickDestination
{
    
    XKSportDestinationController *sport = [[XKSportDestinationController alloc]initWithType:pageTypeNormal];
    
    [self.navigationController pushViewController:sport animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    NSLog(@"地图加载完毕");
}
//地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"拖拽结束");

    //将View坐标转换成地图经纬度坐标
    CLLocationCoordinate2D pt = [_mapView convertPoint:self.mapView.center toCoordinateFromView:self.mapView];

    //发起反向地理编码检索
//    BMKReverseGeoCodeOption *searchOption = [[BMKReverseGeoCodeOption alloc] init];
//    searchOption.reverseGeoPoint = pt;
//    [_geoSearch reverseGeoCode:searchOption];
    //添加标注

//    _startAnnotation.title = @"GPS";
    _startAnnotation.coordinate = self.userLocation.location.coordinate;
    [self.mapView addAnnotation:_startAnnotation]; //弹出气泡
}

//原作者说添加大头针的时候调用,viewDidLoad中不会调用
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
   
    BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
    UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth(90.9), KHeight(66.6))];
    UIImageView *viewForimageview=[[UIImageView alloc]initWithFrame:viewForImage.frame];
    [viewForimageview setImage:[UIImage imageNamed:@"icon_GPS"]];
    [viewForImage addSubview:viewForimageview];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake( KWidth(56), KHeight(14), KWidth(21), KWidth(21))];
    [imageview setImage: [UIImage imageNamed:[self GPSStrengthWithLocation:self.userLocation.location]]];
    [viewForImage addSubview:imageview];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake( KWidth(16), 0, KWidth(41), KHeight(54))];
    label.text=@"GPS";
    label.textColor = kMainTitleColor;
     [label setFont:[UIFont systemFontOfSize:18.0f]];
    [viewForImage addSubview:label];
     newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:viewForImage];
    newAnnotationView.selected = YES;
    newAnnotationView.image = [UIImage imageNamed:@" "];
    return newAnnotationView;
}
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    
    [self.mapView selectAnnotation:_startAnnotation animated:YES];
}
#pragma mark - GPS图片信号强度判断
- (NSString *)GPSStrengthWithLocation:(CLLocation *)location{
    //默认图片 搜索中
    CLLocationAccuracy horizontalAccuracy = location.horizontalAccuracy;
    
    if(horizontalAccuracy<0){
        //无信号
        return @"icon_gps_0";
    }else if(horizontalAccuracy>=200){
        //信号微弱（一格）
        return @"icon_gps_1";
    }else if(horizontalAccuracy>=50&&horizontalAccuracy<200){
        //信号弱（两格）
        return @"icon_gps_2";
    }else if(horizontalAccuracy>=10&&horizontalAccuracy<50){
        //信号中（三格）
        return @"icon_gps_3";
    }else if(horizontalAccuracy>=0&&horizontalAccuracy<10){
        //信号强（四格）
        return @"gps-zhong";
    }else{
        return @"gps-zhong";
    }
}
#pragma mark - BMKLocationServiceDelegate
//是否正确定位
-(void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"定位失败 error : %@",error);
}
/**
 *  用户位置更新后，会调用此函数
 *  @param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
    NSLog(@"La:%f, Lo:%f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    _mapView.centerCoordinate = userLocation.location.coordinate;
    CLLocationCoordinate2D loc = [userLocation.location coordinate];
    
    //放大地图到自身的经纬度位置。
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(loc, BMKCoordinateSpanMake(0.02f,0.02f));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    self.userLocation = userLocation;
    
    // 3. 如果精准度不在100米范围内
    if (userLocation.location.horizontalAccuracy > kCLLocationAccuracyNearestTenMeters) {
        NSLog(@"userLocation.location.horizontalAccuracy is %f",userLocation.location.horizontalAccuracy);
    }else
    {
      
    }
    if (!_startAnnotation) {
        _startAnnotation = [[BMKPointAnnotation alloc] init];
        [self.mapView addAnnotation:_startAnnotation];
    }
    _startAnnotation.title = @"q";
    _startAnnotation.coordinate = userLocation.location.coordinate;
    [self.mapView selectAnnotation:_startAnnotation animated:YES];
    [imageview setImage: [UIImage imageNamed:[self GPSStrengthWithLocation:self.userLocation.location]]];

}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    // 动态更新我的位置数据
    [self.mapView updateLocationData:userLocation];
}
@end

