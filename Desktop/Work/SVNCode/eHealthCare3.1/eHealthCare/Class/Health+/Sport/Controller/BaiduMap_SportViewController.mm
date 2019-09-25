//
//  BaiduMap_SportViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaiduMap_SportViewController.h"

@interface BaiduMap_SportViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate,BTKTrackDelegate,SportMessageDelegate,BTKTrackDelegate,BTKEntityDelegate,BMKLocationServiceDelegate,BaiduMapTrackManagerDelegate>
{
    UIImageView *imageview;
    
}
///地图
@property (nonatomic, strong) BMKMapView *mapView;
///显示运动信息的视图
@property (nonatomic,strong) SportMapHeaderView *sportView;

///轨迹线
@property (nonatomic, strong) BMKPolyline *polyLine;

///起点大头针
@property (nonatomic, strong) BMKPointAnnotation *startPoint;
///终点大头针
@property (nonatomic, strong) BMKPointAnnotation *endPoint;

@property(nonatomic,strong)BMKUserLocation *userLocation;

@end
#define removeObjectsLen 20
@implementation BaiduMap_SportViewController
#pragma mark - RCLocationManagerDelegate
-(void)locationManagerGPSData:(CLLocation *)GPS;
{
    [imageview setImage: [UIImage imageNamed:[self GPSStrengthWithLocation:GPS]]];
    
}
-(void)locationManagerdidUpdateUserHeading:(BMKUserLocation *)managerUseManager ;
{
    
//     [self.mapView updateLocationData:managerUseManager];
}
//位置变化的时候调用
-(void)locationManager:(BaiduMapTrackManager *)manager didUpdatedLocations:(NSArray<CLLocation *> *)locations {
    
    
    BMKUserLocation *userLocation = manager.userLocation;
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
//
    //先清空数组
    //    [self clean:locations];
    if(self.type != MapViewTypeLocation) {
        [self drawWalkPolyline:locations];
    }
    NSLog(@"-drawWalkPolyline------%@",locations);
    
    if (!_startPoint) {
        _startPoint = [[BMKPointAnnotation alloc] init];
        [self.mapView addAnnotation:_startPoint];
    }
    _startPoint.title = @"q";
    _startPoint.coordinate = userLocation.location.coordinate;
//    [self.mapView selectAnnotation:_startPoint animated:YES];
    
      if ([SportCommonMod shareInstance].isMinuteCount == YES) {
          self.sportView.distanceLab.text = [NSString stringWithFormat:@"%.2lf",manager.totalDistance/1000.0];
      }else
      {
          
          float dis =    [SportCommonMod shareInstance].totalDistance-manager.totalDistance/1000.0;
          if (dis<=0) {
              self.sportView.distanceLab.text =   [NSString stringWithFormat:@"%@",@"0"];
          }else
              self.sportView.distanceLab.text =  [NSString stringWithFormat:@"%.2lf",dis];
         
          
      }
    
    [imageview setImage: [UIImage imageNamed:[self GPSStrengthWithLocation:self.userLocation.location]]];
    
}
-(void)locationManager:(BaiduMapTrackManager *)manager didChangeLocationsState:(BOOL)running {
    if(running) {
        NSLog(@"running");
        [self.locationManager startTimer];
        UIApplication *app = [UIApplication sharedApplication];
        //接收当前的UIApplication[单例]发送的通知，然后处理selector
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueTimer) name:UIApplicationWillEnterForegroundNotification object:app];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTime) name:UIApplicationDidEnterBackgroundNotification object:app];
        
    }else {
        
    }
}
-(void)locationManagerTime:(NSInteger)timerNumber;
{
    NSLog(@"-----------%zi",timerNumber);
    
    long seconds =  [SportCommonMod shareInstance].totalTime*60;
    
    seconds = seconds - self.locationManager.timerNumber;
    if (seconds < 0) {
        //alert
        return;
    }
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    NSLog(@"%@",format_time);
      if ([SportCommonMod shareInstance].isMinuteCount == YES) {
    if ([str_hour intValue] >= 1) {
        self.sportView.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",[str_hour integerValue],[str_minute integerValue]];
    }else{
        self.sportView.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",[str_minute integerValue],[str_second integerValue]];
    }
    
      }else
          
          self.sportView.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",self.locationManager.timerNumber/60,self.locationManager.timerNumber%60];

    
    
}
-(void)stopTime {
    //关闭定时器
    [self.locationManager.timer setFireDate:[NSDate distantFuture]];
}
-(void)continueTimer {
    if(self.locationManager.running) {
        [self.locationManager.timer setFireDate:[NSDate distantPast]];
        [self update_time_label];
        NSDate *nowDate = [[NSDate alloc] init];
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.locationManager.startLocationDate];
       
        NSLog(@"两个时间相隔4444444：%f---%f", timeInterval,self.locationManager.secondsLoactionDate);
        self.locationManager.timerNumber = (NSInteger)timeInterval-self.locationManager.secondsLoactionDate;
    }
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    NSRange range = NSMakeRange(0, removeObjectsLen);
//    [self.locationManager.locations removeObjectsInRange:range];
}
-(void)dealloc {
    NSLog(@"map view controller dealloc");
}
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    
    _mapView.delegate = self;
    //开始更新位置信息
    //    if(MapViewTypeQueryDetail != self.type || MapViewTypeDetail != self.type) {
    //从locationManager处获得位置信息更新跑步者在地图中的位置
    BMKUserLocation *userLocation = self.locationManager.userLocation;
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    [self.mapView updateLocationData:userLocation];
    //    if(MapViewTypeLocation != self.type) {
    [self drawWalkPolyline:self.locations];
    
    //    if(self.locationManager.running) {
    [self.locationManager.timer setFireDate:[NSDate distantPast]];
    [self update_time_label];
    
    if ([SportCommonMod shareInstance].isMinuteCount == YES) {
        self.sportView.distanceLab.text = [NSString stringWithFormat:@"%.2lf",self.locationManager.totalDistance/1000.0];
    }else
    {
        
        float dis =    [SportCommonMod shareInstance].totalDistance-self.locationManager.totalDistance/1000.0;
        if (dis<=0) {
            self.sportView.distanceLab.text =   [NSString stringWithFormat:@"%@",@"0"];
        }else
            self.sportView.distanceLab.text =  [NSString stringWithFormat:@"%.2lf",dis];
        
        
    }
        
    
    
    //    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    self.locationManager.delegate = nil;
}

#pragma mark UI
- (void)createUI
{
    [self.view addSubview:self.mapView];
    self.locationManager.delegate = self;
    //开始定位[在RunningDetailViewController中已经开启了，这里不会再开启,因为有逻辑判断]
    SportMapHeaderView *sportView = [[[NSBundle mainBundle] loadNibNamed:@"SportMapHeaderView" owner:self options:nil] firstObject];
    [self.view addSubview:sportView];
    self.sportView = sportView;
    
    [sportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KHeight(123));
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        
    }];
    
    
    [self update_time_label];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToUpView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-KHeight(25));
        make.right.mas_equalTo(-KWidth(25));
        make.size.mas_equalTo(CGSizeMake(KWidth(55), KWidth(55)));
        
    }];
    
    
    if(self.locationManager.running) {
        [self.locationManager.timer setFireDate:[NSDate distantPast]];
    }
}

-(void)update_time_label
{
    long seconds =  [SportCommonMod shareInstance].totalTime*60;
    
    seconds = seconds - self.locationManager.timerNumber;
    if (seconds >= 0) {
        //format of hour
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
        //format of minute
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
        //format of second
        NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
        //format of time
        NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
        int hours = [str_hour integerValue];
         if ([SportCommonMod shareInstance].isMinuteCount == YES) {
        if (hours>=1) {
            self.sportView.timeLab.text = [NSString stringWithFormat:@"%ld:%.2ld",(long)[str_hour integerValue],(long)[str_minute integerValue]];
        }else
        {
            self.sportView.timeLab.text = [NSString stringWithFormat:@"%ld:%.2ld",(long)[str_minute integerValue],(long)[str_second integerValue]];
        }
             
         }
        else
        {
            self.sportView.timeLab.text = [NSString stringWithFormat:@"%.2ld:%.2ld",self.locationManager.timerNumber/60,self.locationManager.timerNumber%60];

            
        }
    }
}

#pragma mark Action
- (void)backToUpView
{
    WEAKSELF
    [self dismissViewControllerAnimated:YES completion:^{
        if ([SportCommonMod shareInstance].isMinuteCount == YES) {
            if (weakSelf.backSportDetailDataBlock) {
                weakSelf.backSportDetailDataBlock(self.sportView.distanceLab.text);
            }
        }else
        {
            
//            float dis =    [SportCommonMod shareInstance].totalDistance-self.locationManager.totalDistance/1000.0;
//            if (dis<=0) {
//                self.sportView.distanceLab.text =   [NSString stringWithFormat:@"%@",@"0"];
//            }else
//                self.sportView.distanceLab.text =  [NSString stringWithFormat:@"%.2lf",dis];
            
            if (weakSelf.backSportDetailDataBlock) {
                weakSelf.backSportDetailDataBlock([NSString stringWithFormat:@"%.2lf",self.locationManager.totalDistance/1000.0]);
            }
        }
       
    }];
}
/**
 *  添加一个大头针
 *
 *  @param location ...
 */
- (BMKPointAnnotation *)creatPointWithLocaiton:(CLLocation *)location title:(NSString *)title;
{
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = title;
    [self.mapView addAnnotation:point];
    
    return point;
}

/**
 *  清空数组以及地图上的轨迹
 */
- (void)clean:(NSMutableArray *)locationArrayM
{
    
    //清空数组
    [locationArrayM removeAllObjects];
    
    //清屏，移除标注点
    if (self.startPoint) {
        [self.mapView removeAnnotation:self.startPoint];
        self.startPoint = nil;
    }
    if (self.endPoint) {
        [self.mapView removeAnnotation:self.endPoint];
        self.endPoint = nil;
    }
    if (self.polyLine) {
        [self.mapView removeOverlay:self.polyLine];
        self.polyLine = nil;
    }
}


#pragma mark - BMKMapViewDelegate

/**
 *  根据overlay生成对应的View
 *  @param mapView 地图View
 *  @param overlay 指定的overlay
 *  @return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor clearColor] colorWithAlphaComponent:0.7];
        polylineView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
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
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    if([[annotation title] isEqualToString:@"起点"]) {
        annotationView.pinColor = BMKPinAnnotationColorGreen;
    }else if ([[annotation title] isEqualToString:@"终点"]) {
        annotationView.pinColor = BMKPinAnnotationColorRed;
    }else {
        annotationView.pinColor = BMKPinAnnotationColorPurple;
    }
    UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth(90.9), KHeight(66.6))];
    UIImageView *viewForimageview=[[UIImageView alloc]initWithFrame:viewForImage.frame];
    [viewForimageview setImage:[UIImage imageNamed:@"icon_GPS"]];
    [viewForImage addSubview:viewForimageview];
    
    imageview=[[UIImageView alloc]initWithFrame:CGRectMake( KWidth(56), KHeight(14), KWidth(21), KWidth(21))];
    [imageview setImage: [UIImage imageNamed:[self GPSStrengthWithLocation:self.userLocation.location]]];
    [viewForImage addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake( KWidth(16), 0, KWidth(41), KHeight(54))];
    label.text=@"GPS";
    label.textColor = kMainTitleColor;
    [label setFont:[UIFont systemFontOfSize:18.0f]];
    [viewForImage addSubview:label];
    annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:viewForImage];
    annotationView.selected = YES;
    annotationView.image = [UIImage imageNamed:@" "];
    return annotationView;
    
}
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    
    [self.mapView selectAnnotation:_startPoint animated:YES];
}

#pragma mark lazy load
- (BMKMapView *)mapView
{
    if (!_mapView) {
        
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, KHeight(123), KScreenWidth, KScreenHeight - KHeight(123))];
        [_mapView setZoomLevel:17];
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.rotateEnabled = YES;
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    }
    return _mapView;
}
#pragma mark - 路径绘制

-(void)drawWalkPolyline:(NSArray *)locations {
    //轨迹点的个数
    NSUInteger count = locations.count;// NSUInteger count = self.locationArrayM.count;
    //动态分配存储空间,BMKMapPoint是个结构体，表示地理坐标点，X表示横坐标，Y表示纵坐标
    //动态new一个tempPoints临时数组
    BMKMapPoint *tempPoints = (BMKMapPoint *)malloc(sizeof(BMKMapPoint)*count);
    
    [locations enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger idx, BOOL * _Nonnull stop) {
        BMKMapPoint locationPoint = BMKMapPointForCoordinate(location.coordinate);
        tempPoints[idx] = locationPoint;
        NSLog(@"idx = %lu,tempPoints X = %f Y = %f",(unsigned long)idx,tempPoints[idx].x,tempPoints[idx].y);
    }];
    if(!_startPoint &&count > 0) {
        _startPoint = [self createPointWithLocation:[self.locations firstObject] title:@"起点"];
    }
    //移除原有的绘图，避免重画
    if(self.polyLine) {
        [self.mapView removeOverlay:self.polyLine];
    }
    //通过BMKMapPoint点绘制折线
    self.polyLine = [BMKPolyline polylineWithPoints:tempPoints count:count];
    //把折线添加到地图上显示
    if(self.polyLine) {
        [self.mapView addOverlay:self.polyLine];
    }
    //清空临时数组
    free(tempPoints);
    
    
    //    // 清空 tempPoints 内存
    //    delete []tempPoints;
    
//    [self mapViewFitPolyLine:self.polyLine];
}

//根据polyLine设置地图范围

- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    
    //一个矩形的四边
    /** ltx: top left x */
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    
    BMKMapRect mapRect;
    mapRect.origin = BMKMapPointMake(ltX, ltY);
    mapRect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [self.mapView setVisibleMapRect:mapRect ];
    
    //self.mapView.zoomLevel = self.mapView.zoomLevel - 0.3;
    
    CGPoint point = [self.mapView convertCoordinate:self.locations.firstObject.coordinate toPointToView:self.mapView];
    if (16777215 == point.x) {
        [self.mapView zoomOut];
    }
    [self.mapView zoomOut];
}

//在地图上添加一个大头针
-(BMKPointAnnotation *)createPointWithLocation:(CLLocation *)location title:(NSString *)title {
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    point.title = title;
    [self.mapView addAnnotation:point];
    return point;
}
/**
 * 道格拉斯算法，处理protoArray序列
 * 先将首末两点加入calcArray序列中，然后在calcArray序列找出距离首末点连线距离的最大距离值dmax并与阈值进行比较，
 * 若大于阈值则将这个点加入calcArray序列，重新遍历calcArray序列。否则将两点间的所有点(protoArray)移除
 * @return 返回经过道格拉斯算法后得到的点的序列
 */
//- (NSArray*)douglasAlgorithm:(NSArray <LatLngEntity *>*)coordinateList threshold:(CGFloat)threshold{
//    // 将首末两点加入到序列中
//    NSMutableArray *points = [NSMutableArray array];
//    NSMutableArray *list = [NSMutableArray arrayWithArray:coordinateList];
//
//    [points addObject:list[0]];
//    [points addObject:coordinateList[coordinateList.count - 1]];
//
//    for (NSInteger i = 0; i<points.count - 1; i++) {
//        NSUInteger start = (NSUInteger)[list indexOfObject:points[i]];
//        NSUInteger end = (NSUInteger)[list indexOfObject:points[i+1]];
//        if ((end - start) == 1) {
//            continue;
//        }
//        NSString *value = [self getMaxDistance:list startIndex:start endIndex:end threshold:threshold];
//        NSString *dist = [value componentsSeparatedByString:@","][0];
//        CGFloat maxDist = [dist floatValue];
//
//        //大于限差 将点加入到points数组
//        if (maxDist >= threshold) {
//            NSInteger position = [[value componentsSeparatedByString:@","][1] integerValue];
//            [points insertObject:list[position] atIndex:i+1];
//            // 将循环变量i初始化,即重新遍历points序列
//            i = -1;
//        }else {
//            /**
//             * 将两点间的点全部删除
//             */
//            NSInteger removePosition = start + 1;
//            for (NSInteger j = 0; j < end - start - 1; j++) {
//                [list removeObjectAtIndex:removePosition];
//            }
//        }
//    }
//
//    return points;
//}
///**
// * 根据给定的始末点，计算出距离始末点直线的最远距离和点在coordinateList列表中的位置
// * @param startIndex 遍历coordinateList起始点
// * @param endIndex 遍历coordinateList终点
// * @return maxDistance + "," + position 返回最大距离+"," + 在coordinateList中位置
// */
//- (NSString *)getMaxDistance:(NSArray <LatLngEntity *>*)coordinateList startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex threshold:(CGFloat)threshold{
//
//    CGFloat maxDistance = -1;
//    NSInteger position = -1;
//    CGFloat distance = [self getDistance:coordinateList[startIndex] lastEntity:coordinateList[endIndex]];
//
//    for(NSInteger i = startIndex; i < endIndex; i++){
//        CGFloat firstSide = [self getDistance:coordinateList[startIndex] lastEntity:coordinateList[i]];
//        if(firstSide < threshold){
//            continue;
//        }
//
//        CGFloat lastSide = [self getDistance:coordinateList[endIndex] lastEntity:coordinateList[i]];
//        if(lastSide < threshold){
//            continue;
//        }
//
//        // 使用海伦公式求距离
//        CGFloat p = (distance + firstSide + lastSide) / 2.0;
//        CGFloat dis = sqrt(p * (p - distance) * (p - firstSide) * (p - lastSide)) / distance * 2;
//
//        if(dis > maxDistance){
//            maxDistance = dis;
//            position = i;
//        }
//    }
//
//    NSString *strMaxDistance = [NSString stringWithFormat:@"%f,%ld", maxDistance,position];
//    return strMaxDistance;
//}
//
//// 两点间距离公式
//- (CGFloat)getDistance:(LatLngEntity*)firstEntity lastEntity:(LatLngEntity*)lastEntity{
//    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:[firstEntity getLatitude] longitude:[firstEntity getLangitude]];
//    CLLocation *lastLocation = [[CLLocation alloc] initWithLatitude:[lastEntity getLatitude] longitude:[lastEntity getLangitude]];
//
//    CGFloat  distance  = [firstLocation distanceFromLocation:lastLocation];
//    return  distance;
//}
#pragma mark - 距离测算
- (double)calculateDistanceWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end {
    
    double meter = 0;
    
    double startLongitude = start.longitude;
    double startLatitude = start.latitude;
    double endLongitude = end.longitude;
    double endLatitude = end.latitude;
    
    double radLatitude1 = startLatitude * M_PI / 180.0;
    double radLatitude2 = endLatitude * M_PI / 180.0;
    double a = fabs(radLatitude1 - radLatitude2);
    double b = fabs(startLongitude * M_PI / 180.0 - endLongitude * M_PI / 180.0);
    
    double s = 2 * asin(sqrt(pow(sin(a/2),2) + cos(radLatitude1) * cos(radLatitude2) * pow(sin(b/2),2)));
    s = s * 6378137;
    
    meter = round(s * 10000) / 10000;
    return meter;
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
