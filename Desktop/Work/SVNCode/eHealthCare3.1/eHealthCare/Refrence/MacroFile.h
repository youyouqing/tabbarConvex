//
//  MacroFile.h
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#ifndef MacroFile_h
#define MacroFile_h

#pragma mark 网络Url
////#if DEBUG
//#define kBaseUrl @"http://192.168.1.133:8007/v15/"
////#else
////#define kBaseUrl @"https://api.xiekang.net/v15/"
////#endif

//#define kWXMTestService

#ifdef  kWXMTestService
//http://api.xiekang.net/
//http://192.168.1.6:8004/  8021
//http://192.168.1.133:8007/
//http://api.xk12580.net/
#define kBaseUrl      [NSString stringWithFormat:@"%@/v16/",MallUrl] //@"http://apinew.xk12580.com/v16/"

#else

#define kBaseUrl       [NSString stringWithFormat:@"%@/v16/",MallUrl] // @"https://api.xiekang.net/v16/"

#endif

///在线问诊
#define XKOnlineConsultantUrl [NSString stringWithFormat:@"%@/AppComm/ChunyuDoctorLogin?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

///mian URL
#define kMainUrl [NSString stringWithFormat:@"%@/",MallUrl]//@"https://api.xiekang.net/"//@"https://api.xiekang.net/"   //http://apinew.xk12580.com/


#define kMainWebUrl @"https://wechat.xiekang.net" //@"https://wechat.xiekang.net"   //http://wechatnew.xk12580.com https://wechat.xiekang.net
//@"http://192.168.1.133:8004"

///微信前缀携康url
#define MallUrl @"https://api.xiekang.net" //@"https://api.xiekang.net" //http://apinew.xk12580.com

//160预约挂号的链接  正式环境  https://wap.91160.com/vue/unit/index.html?cid=100012935&mtToken=
#define kguaHuaUrl @"https://weixintest2.91160.com/vue/doctor/detail.html?unit_id=125&dep_id=138&doc_id=692&type=guahao&cid=100012930&mtToken="

///调理养生
#define kConditioningRegimenUrl [NSString stringWithFormat:@"%@/Mall/ClubProductPackageList?Token=%@&OSType=2&Version=%@",kMainWebUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]

///健康体检
#define kHealthCheckUpUrl [NSString stringWithFormat:@"%@/Mall/PhysicalProductPackageList?Token=%@&OSType=2&Version=%@",kMainWebUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]
//自测首页
#define kHealthTestPageUrl [NSString stringWithFormat:@"%@/AppComm/HealthTestPage?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//套题详情页
#define kHealthTestItemUrl [NSString stringWithFormat:@"%@/AppComm/HealthTestItem?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//九型体质
#define kHealthTestNineTypeResultUrl [NSString stringWithFormat:@"%@/AppComm/NineTypeResult?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//自测
#define kHealthTestResultUrl [NSString stringWithFormat:@"%@/AppComm/TestResult?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//商城页面
#define kMallMiddleUrl [NSString stringWithFormat:@"%@/Mall/Index?Token=%@&OSType=2&Version=%@",kMainWebUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]


//喝水首页
#define kHealthDrinkUrl [NSString stringWithFormat:@"%@/appcomm/MemWater?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//久坐首页
#define kHealthSitDownUrl [NSString stringWithFormat:@"%@/appcomm/MemBreak?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//用药首页
#define kHealthMedicnaeUrl [NSString stringWithFormat:@"%@/appcomm/MemMedicine?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//健康树
#define kHealthTreeUrl [NSString stringWithFormat:@"%@/AppComm/MemHealthTreeTop?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//百科分类 AppComm/WikiList?CategoryID=%i&ClassId=2&ClassName=%@
#define kHealthBaiKeWikiUrl [NSString stringWithFormat:@"%@/AppComm/WikiEncyList?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//健康百科 AppComm/WikiList?CategoryID=%i&ClassId=2&ClassName=%@
#define kHealthBaiKeUrl [NSString stringWithFormat:@"%@/AppComm/BaikeIndex?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//XRUN
#define kXRunUrl [NSString stringWithFormat:@"%@/AppComm/MemXRunRanking?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//我的康币
#define kMyKCurrenyUrl [NSString stringWithFormat:@"%@/AppComm/MemKCurrency?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

//用户徽章
#define kUserBadgeUrl [NSString stringWithFormat:@"%@/AppComm/MemBadgeList?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//康币攻略
#define kKangcoinstrategyUrl [NSString stringWithFormat:@"%@/AppComm/KCurrencyStrategy?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//健康果增重攻略
#define kHealthWeightGainStrategyUrl [NSString stringWithFormat:@"%@/AppComm/HealthFruitStrategy?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//健康计划
#define kHealthPlanUrl [NSString stringWithFormat:@"%@/appcomm/GetAppMemHealthPlanLstToPage?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]
//健康计划进行中页面
#define kHealthPlanMainIDUrl [NSString stringWithFormat:@"%@/AppComm/GetAppHealthPlanDetail?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]


#define kHealthPlanSportIDUrl [NSString stringWithFormat:@"%@/AppComm/GetAppHealthPlanSportDetail?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]


#define kHealthPlanNurseIDUrl [NSString stringWithFormat:@"%@/AppComm/GetAppHealthPlanNurseDetail?Token=%@&OSType=2",MallUrl,[UserInfoTool getLoginInfo].Token]

/**携康我的现金券链接常量
 1.内网测试.6环境地质 http://192.168.1.6:8026/CashCoupon/MyCashCouponList?
 2.外网测试环境地址 http://wechat.xk12580.net/CashCoupon/MyCashCouponList?
 3.正式环境地址 http://wechat.xiekang.net/CashCoupon/MyCashCouponList?
 *///http://192.168.1.133:8004/
#define XKCashCouponURL [NSString stringWithFormat:@"%@/CashCoupon/MyCashCouponList?Token=%@&OSType=2&Version=%@",kMainWebUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]
/**携康我的订单链接常量*/

#define XKMyOderURL [NSString stringWithFormat:@"%@/Order/MyOrder?Token=%@&OSType=2&Version=%@",kMainWebUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]


#pragma mark 高度和宽度
//屏幕宽度
#define KScreenWidth   CGRectGetWidth([UIScreen mainScreen].bounds)
//屏幕高度
#define KScreenHeight  CGRectGetHeight([UIScreen mainScreen].bounds)

/**以iPhone8尺寸为标准尺寸的情况下*/

//判断是否是iPhone X
#define is_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//导航栏的高度
#define PublicY KScreenHeight == 812.0 ? 88.0 : 64

//tabbar高度
#define kTabbarHeight KScreenHeight == 812.0 ? 83.0 : 49

//宽度和高度适配
#define KWidth(f)  KScreenWidth * f / 375

//iPhone X的高度做到和iphone 8一样
#ifndef is_IPhoneX

#define KHeight(f) f

#else

#define KHeight(f) KScreenHeight * f / 667

#endif
//字体适配
#define Kfont(s) [UIFont systemFontOfSize:s * KScreenWidth / 375]

#pragma mark 自定义的宏

/**debug模式下输出日志*/
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__);
#else
#define NSLog(...)
#endif

///GCD获取全局队列
#define GLOBAL_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

///GCD主线程
#define MAIN_QUEUE dispatch_get_main_queue()


#pragma mark 弱引用
#define WEAKSELF typeof(self) __weak weakSelf = self;

#pragma mark 提示语
#define NetDisconnect @"网络不给力，请检查网络设置！"

#define gettingData @"正在获取数据..."
#define submitData @"正在提交数据..."

#define noDataRecording @"暂无数据记录"
#define errorMessageWrong @"信息出错"

#pragma mark NSUserDefaults用到的字段

#define firstLaunch @"firstLaunch" //判断是否是第一次加载

#pragma mark 颜色值
#define COLOR(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

#define kTabbarTextColor [UIColor getColor:@"2C4667"]

#define kTabbarTextSelectColor [UIColor colorWithRed:236/255. green:202/255. blue:66/255. alpha:1]

#define lightBlueColor [UIColor colorWithRed:85/255. green:184/255. blue:249/255. alpha:1]

#define kLightkMainColor COLOR(250, 240, 82, 1)

#define kLightGrayColor COLOR(247, 247, 247, 1)

#define kSeperateLineColor COLOR(218, 218, 218, 1)

#define kMainColor [UIColor getColor:@"03C7FF"]



#define kMainTitleColor [UIColor getColor:@"2C4667"]
#define kbackGroundGrayColor [UIColor getColor:@"F4F4F4"]//15号以后的
#define kbackGroundColor [UIColor getColor:@"EFF8FE"]//15号原来的主要背景颜色
#pragma mark 公共图片

/***无数据的图片***/
///默认无数据图片
#define noDataImage [UIImage imageNamed:@"noDataImage"]

///占位图图片
#define KPlaceHoldImage [UIImage imageNamed:@"placeHoldImage"]

///健康计划默认无数据图片
#define healthPlanNoDataImage [UIImage imageNamed:@"plan_noData"]

#pragma mark 一些第三方的AppId之类

///shareSDK
#define shareSDKAppkey @"177818057da80"

///百度地图
#define baiduMapAppKey @"OemtTWw50CF49UgULZY6NtkGt9VLbild"

///鹰眼轨迹的鹰眼服务ID
static NSUInteger const serviceID = 150130;

///Bundle Identifier
static NSString * const MCODE = @"com.xiekang.cn";


typedef NS_ENUM(NSInteger,sportCommonType){
    sportTypeWalk = 1,
    sportTypeRun = 2,//跑步
    sportTypeClimb = 3,//登山
    sportTypeRide = 4//骑行
    
};

#endif /* MacroFile_h */