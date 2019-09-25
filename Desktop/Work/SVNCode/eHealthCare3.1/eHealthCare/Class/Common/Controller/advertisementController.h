//
//  advertisementController.h
//  eHealthCare
//
//  Created by jamkin on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiseModel.h"

#import "AdvertiseModel.h"

@interface AdvertisementController : BaseViewController

@property (nonatomic,copy)NSString *webUrlStr;

/**分享的属性*/
@property (nonatomic,strong) AdvertiseModel *model;

@end

