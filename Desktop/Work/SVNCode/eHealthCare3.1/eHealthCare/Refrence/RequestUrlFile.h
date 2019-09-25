//
//  RequestUrlFile.h
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#ifndef RequestUrlFile_h
#define RequestUrlFile_h

/******************登录注册模块******************/

/**获取登录验证码*/
static NSString *const getLoginMSMCodeUrl = @"100";

/**登录*/
static NSString *const loginActionUrl = @"101";

/**校验Token是否失效*/
static NSString *const tokenIsFailureUrl = @"102";

/**微信第三方登录*/
static NSString *const wechatLoginUrl = @"932";
/**获取登录前引导页问题*/
static NSString *const GuideLoginUrl = @"146";
/******************个人中心模块******************/
//获取用户健康提醒设置
static NSString *const getUserHealthRemindSetUrl = @"945";

//用户提交健康提醒设置
static NSString *const inputUserHealthRemindSetUrl = @"946";
///意见反馈
static NSString *const sendSuggestionUrl = @"131";

/**获取更换手机号验证码*/
static NSString *const getChangePhoneMSMCodeUrl = @"133";

/**获取更换手机号验证码*/
static NSString *const changePhoneNumUrl = @"134";

///获取个人信息
static NSString *const getPersonalMesaageUrl = @"135";

/**更改个人信息*/
static NSString *const resetPersonalMessageUrl = @"136";

/**更换个人头像*/
static NSString *const changeHeadPhotoUrl = @"137";

/**获取测评报告列表数据*/
static NSString *const getTestReportListUrl = @"138";

/*********************健康+*********************/
/**运动模块*/
static NSString *const updateSportMessageUrl = @"343";

///为自己加油 数据列表
static NSString *const listenMyselfListUrl = @"960";

///健康+用户行为记录
static NSString *const updateHealthPlusUserBehaviorUrl = @"961";

///健康+早晚安与正念列表
static NSString *const getMorningEverningAndMindfulnessListUrl = @"962";

//获取E加首页信息（用户当日健康基本信息以及最近一次体检信息）
static NSString *const getEpluseDataListUrl = @"327";
static NSString *const setUserMoodUrl = @"328";
static NSString *const getUserMoodUrl = @"329";
/******************电商模块******************/
/**订单付款校验*/
static NSString *const checkOrderPayUrl = @"613";

/******************首页模块******************/

///获取首页热门话题以及进行中健康计划
static NSString *const home_getHotTopicHealthPlanAndMoreAboutUrl = @"900";

///获取话题分类或资讯或健康计划分类
static NSString *const home_getTopicCategoryOrinformationCategoryOrHealthPlanCategoryUrl = @"908";

///健康分类获取健康计划分页列表
static NSString *const home_getHealthPlanCategoryListUrl = @"912";

///获取我的健康计划分页列表
static NSString *const home_getMyHealthPlanListUrl = @"913";

///加入健康计划
static NSString *const home_joinHealthPlanUrl = @"914";

///根据健康计划编号获取当日健康计划
static NSString *const home_getTodayHealthPlanUrl = @"917";

///获取详细的当日计划详情列表
static NSString *const home_getTodayPlanDetailUrl = @"918";

///完成当日计划
static NSString *const home_finishTodayHealthPlanUrl = @"919";

///根据用户计划结果编号获取 计划结果数据
static NSString *const home_getPlanResultDataUrl = @"921";

/****健康自测****/
///获取首页自测套题
static NSString *const home_getHealthTestUrl = @"400";

///获取测试试题
static NSString *const home_getTestQuestionUrl = @"401";

///上传测试结果
static NSString *const home_upLoadTestResultUrl = @"402";

///获取体质检测试题
static NSString *const home_getPhysicalTestingUrl = @"403";

///上传体质测试结果
static NSString *const home_upLoadPhysicalTestResultUrl = @"404";

///获取体质检测结果
static NSString *const home_getPhysicalTestResultUrl = @"437";




/******************健康树******************/

//获取健康树首页健康提醒以及进行中计划、话题信息
static NSString *const hometree_getHomeResultUrl = @"944";


/******************居家检测模块******************/
/**解除绑定设备*/
static NSString *const checkHomeUnBindDeviceUrl = @"812";

/**获得用户身高*/
static NSString *const checkHomeGetUserHeightUrl = @"836";

/**根据设备编号获得设备详情*/
static NSString *const checkHomeGetDeviceMoreMessageUrl = @"811";

/**根据居家设备编号获得已绑定列表*/
static NSString *const checkHomeGetDeviceBindListUrl = @"809";

/**Pc300上传数据(汇总)*/
static NSString *const checkHomePC300UpdateDataUrl = @"806";

/**Pc300查看报告*/
static NSString *const checkHomePC300GetReportUrl = @"807";
/**根据用户ID获取最新的居家检测信息*/
static NSString *const checkHomeTestGetReportUrl = @"815";
/**获取个人档案相关字典*/
static NSString *const checkHomeEditPersonalReportUrl = @"309";
static NSString *const checkHomeGetPersonalReportUrl = @"300";
static NSString *const checkHomeGetFamilyPersonalUrl = @"326";
static NSString *const checkHomeRemindFamilyPersonalUrl = @"320";
static NSString *const checkHomeaddFamilyRelationUrl = @"317";
static NSString *const checkHomeaddFamilyInformationUrl = @"318";
static NSString *const getHealthRecordHomeResultUrl= @"319";
static NSString *const getTopRecordDataResult = @"148";
/**获取家人申请消息列表*/
static NSString *const hometree_getFamilyMessageListResultUrl = @"126";
/**获取家人申请消息列表*/
static NSString *const hometree_getFamilyAddMessageResultUrl = @"125";
/**删除用户家人）*/
static NSString *const deleteUserFamilydDataResultUrl = @"335";
/**获取体检项目指标趋势列表（新增）*/
static NSString *const checkHomeGetMedicalReportListUrl = @"314";

/**获取用户历史体检列表*/
static NSString *const checkHomeGetUserMedicalReportHistoryListUrl = @"301";

/**编辑个人档案信息*/
static NSString *const checkHomeEditPersonalFileUrl = @"310";

/**获取血脂四项检测项目列表*/
static NSString *const checkHomeGetBloodLipidFourListUrl = @"838";

/*记步数据赋值*/
static NSString *const home_sportsUrl = @"340";
#endif /* RequestUrlFile_h */
