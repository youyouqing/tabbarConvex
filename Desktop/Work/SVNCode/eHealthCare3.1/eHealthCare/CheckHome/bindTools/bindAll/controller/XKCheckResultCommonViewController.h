//
//  XKCheckResultCommonViewController.h
//  eHealthCare
//
//  Created by xiekang on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckHeaderResultView.h"
#import "XKXKCheckResultWeightTableViewCell.h"
#import "XKCheckResultWeightTwoTableViewCell.h"
#import "XKCheckResultView.h"
#import "XKSingleCheckMultipleCommonResultCell.h"
#import "QingNiuSDK.h"
#import "QingNiuDevice.h"
#import "QingNiuUser.h"
#import "XKBackButton.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "XKSingleCheckMultipleCommonResultHeadView.h"
#import "XKSingleCheckMultipleCommonPresResultHeadView.h"
#import "XKSingleCheckMultipleCommonResultFootView.h"
#import "ExchinereportModel.h"
#import "MSBluetoothManager.h"
#import "BLEManager.h"
#import "TTCDeviceInfo.h"
#import "XKCheckResultSugarTopView.h"
#import "XKCheckHeaderCommonResultView.h"
#import "XKDectingViewController.h"
#import "XKValidationAndAddScoreTools.h"

@interface XKCheckResultCommonViewController : BaseViewController
@property(assign,nonatomic)XKDetectStyle DectStyle;
@property(assign,nonatomic)BOOL isOtherDect; //手动检测还是自动检测
@property(assign,nonatomic)int BloodSugarType;//血糖类型餐前餐后
@property(copy,nonatomic)NSString *manualText;
@property(copy,nonatomic)NSString *manualTwoText;
@property(copy,nonatomic)NSString *manualThreeText;
@property(copy,nonatomic)NSString *manualFourText;


@property(copy,nonatomic)NSDictionary *temporaryDic;
@property(copy,nonatomic)NSString *temportySum;
@property(copy,nonatomic)NSDictionary *diction;//上传体重数据的字典


/**
 体重结果页区头
 */
@property(strong,nonatomic)XKCheckResultView *checkHeader;


/**
 血氧结果页区头
 */
@property(strong,nonatomic)CheckHeaderResultView *checkHeaderResultView;


/**
 结果页区头
 */
@property(strong,nonatomic)XKCheckHeaderCommonResultView *checkHeaderCommonResultView;

@property(strong,nonatomic)XKSingleCheckMultipleCommonResultHeadView *headHyperliView ;

/**
 
 */
@property(strong,nonatomic)XKSingleCheckMultipleCommonPresResultHeadView  *headPresureView;

/**
 区尾
 */
@property(strong,nonatomic)XKSingleCheckMultipleCommonResultFootView *botoomView;
@end

