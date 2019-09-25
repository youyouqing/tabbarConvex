//
//  SportMapViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
@class CLLocation;
@interface SportMapViewController : BaseViewController
@property(nonatomic,strong) NSMutableArray<CLLocation *> *locations;
@end

