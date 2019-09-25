//
//  LocationTool.m
//  eHealthCare
//
//  Created by John shi on 2018/8/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "LocationTool.h"

@interface LocationTool () <CLLocationManagerDelegate>

///定位
@property (nonatomic, strong) CLLocationManager *locationManager;

///当前地理信息
@property (nonatomic, copy) NSString *locationString;

@end

@implementation LocationTool

#pragma mark 定位
- (void)getCurrentLocation
{
    if(![CLLocationManager locationServicesEnabled]){
        
        NSLog(@"获取当前位置失败");
        return;
    }
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    self.locationManager.distanceFilter = 10;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.delegate = self;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0)
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0)
    {
        [self.locationManager allowsBackgroundLocationUpdates];//允许后台定位更新
    }
    
    //开始定位
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    
    self.locationString = nil;
    NSLog(@"==error===>>>%@",error.localizedDescription);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *mark = [placemarks firstObject];
        NSLog(@"======>>%@------%@=====>>>%@",mark.locality,mark.name,mark.addressDictionary);
        
        NSDictionary *locationDic = [[NSDictionary alloc]init];
        if (mark)
        {
            locationDic = @{@"district":[NSString stringWithFormat:@"%@",mark.addressDictionary[@"SubLocality"]],
                                          @"Street":[NSString stringWithFormat:@"%@",mark.addressDictionary[@"Street"]],
                                          @"city":[NSString stringWithFormat:@"%@",mark.addressDictionary[@"City"]],
                                          @"lng":[NSString stringWithFormat:@"%@",longitude],
                                          @"streetNumber":[NSString stringWithFormat:@"%@",mark.addressDictionary[@"Street"]],
                                          @"lat":[NSString stringWithFormat:@"%@",latitude],
                                          @"province":[NSString stringWithFormat:@"%@",mark.addressDictionary[@"State"]]};
            
//            locationDic = @{@"district":mark.addressDictionary[@"SubLocality"],
//                            @"Street":mark.addressDictionary[@"Street"],
//                            @"city":mark.addressDictionary[@"City"],
//                            @"lng":longitude,
//                            @"streetNumber":mark.addressDictionary[@"Street"],
//                            @"lat":latitude,
//                            @"province":mark.addressDictionary[@"State"]};
        }
//        ======>>深圳市------招商街道=====>>>{
//            City = "\U6df1\U5733\U5e02";
//            Country = "\U4e2d\U56fd";
//            CountryCode = CN;
//            FormattedAddressLines =     (
//                                         "\U4e2d\U56fd\U5e7f\U4e1c\U7701\U6df1\U5733\U5e02\U5357\U5c71\U533a"
//                                         );
//            Name = "\U62db\U5546\U8857\U9053";
//            State = "\U5e7f\U4e1c\U7701";
//            SubLocality = "\U5357\U5c71\U533a";
//        }
        self.locationString = [locationDic mj_JSONString];
        
        [self.locationManager stopUpdatingLocation];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(getCurrentLocationSuccess:)]) {
            
            [self.delegate getCurrentLocationSuccess:self.locationString];
        }
    }];
    
}

@end
