//
//  CheckHomeHeadFile.h
//  eHealthCare
//
//  Created by John shi on 2018/7/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#ifndef CheckHomeHeadFile_h
#define CheckHomeHeadFile_h

typedef NS_ENUM(NSInteger, XKDetectStyle){
    
    XKMutilPCBloodPressurStyle =1,
    
    XKMutilPCBloodSugarStyle  =2,
    
    XKMutilPCTemperatureStyle  =3,//211
    XKMutilPCBloodOxygenStyle  ,
    XKMutilPCNormalStyle  = 5, //多功能检测仪脉率
    
    XKDetectBloodPressureStyle =6,
    XKDetectWeightStyle = 7,//
    XKDetectBloodSugarStyle,//
    XKDetectDyslipidemiaStyle,//血脂
    XKDetectHemoglobinStyle =10 ,//
    XKDetectBloodOxygenStyle,//
    XKDetectBloodTemperatureStyle = 12,//体温
    
};

#import "BluetoothConnectionTool.h"
#import "UIView+Frame.h"

#import "ProtosomaticHttpTool.h"

#import "Dateformat.h"

/**自定义控件*/
#import "XKInputField.h"
#import "XKCircalButton.h"
#import "XKLineViewOne.h"
#import "XKlabel.h"


/**复用比较频繁的*/
#import "XKLoadingView.h"

#import "SXWaveView.h"


#pragma mark - 设备相关（硬件或者软件）
#define IS_IPHONE4S ([UIScreen mainScreen].bounds.size.height == 480)
#define IS_IPHONE5 ([UIScreen mainScreen].bounds.size.height == 568)
#define IS_IPHONE6 ([UIScreen mainScreen].bounds.size.height == 667)
#define IS_IPHONE6_PLUS ([UIScreen mainScreen].bounds.size.height ==736)
#define IS_IPHONEX ([UIScreen mainScreen].bounds.size.height ==812)

#define kColorWithHexString(s)   [UIColor getColor:s]

/**居家检测模块用到的颜色值*/
#define kThemeColor  kColorWithHexString(@"333333")
#define kGrayColor  kColorWithHexString(@"959595")
#define kLineColor  kColorWithHexString(@"d8d8d8")

#define kCommonBgColor  kColorWithHexString(@"efeff0")
#define kCommonNavTitleColor kColor(whiteColor)
#define kCommonNavLeftTitleColor  kColorWithHexString(@"efeff0")
#define kCommonNavRightTitleColor  kColorWithHexString(@"efeff0")
#define StyleColor [UIColor colorWithRed:63/255.0 green:188/255.0 blue:127/255.0 alpha:1.0]


#define MainCOLOR [UIColor getColor:@"03C7FF"]
#define BLACKCOLOR [UIColor getColor:@"B3BBC4"]
#define GRAYCOLOR [UIColor getColor:@"B3BCC3"]
#define ORANGECOLOR COLOR(255, 69, 100, 1)
#define GREENCOLOR COLOR(145, 222, 57, 1)
#define LINEGRAYCOLOR [UIColor colorWithWhite:0.92 alpha:1.0]
#define DrinkHeight 278


#pragma mark 网络请求宏
#define XKMedicalURL [NSURL URLWithString:[NSString stringWithFormat:@"%@/Mall/PhysicalProductPackageList?Token=%@&OSType=2&Version=%@",XKWebURL,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]]


#endif /* CheckHomeHeadFile_h */
