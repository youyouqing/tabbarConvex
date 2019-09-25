//
//  LocationTool.h
//  eHealthCare
//
//  Created by John shi on 2018/8/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationToolDelegate <NSObject>


/**
 定位成功

 @param locations 返回当前位置的json字符串  例如：{"district":"南山区","Street":"南海大道","city":"深圳市","lng":"113.921305","streetNumber":"1060号","lat":"22.497196","province":"广东省"}
 */
- (void)getCurrentLocationSuccess:(NSString *)locations;

@end

@interface LocationTool : NSObject

@property (nonatomic, weak) id <LocationToolDelegate> delegate;

/**
 获取当前位置
 */
- (void)getCurrentLocation;

@end
