//
//  XKPatientDetailModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKPatientPhotoModel.h"

@interface XKPatientDetailModel : NSObject

/**MemberID
 Int32
 用户编号
 必填*/
@property (nonatomic,assign) NSInteger MemberID;

/**MemberName
 String
 用户姓名
 必填*/
@property (nonatomic,copy) NSString *MemberName;

/**PatientID
 Int32
 病历编号
 必填*/
@property (nonatomic,assign) NSInteger PatientID;

/**AttendanceType
 Int32
 就诊类型*/
@property (nonatomic,assign) NSInteger AttendanceType;

/**AttendanceTime
 Long
 就诊时间*/
@property (nonatomic,assign) long AttendanceTime;

/**AttendanceHospital
 String
 就诊医院*/
@property (nonatomic,copy) NSString *AttendanceHospital;

/**DepartmentsName
 String
 就诊科室*/
@property (nonatomic,copy) NSString *DepartmentsName;

/**DoctorName
 String
 医生姓名*/
@property (nonatomic,copy) NSString *DoctorName;

/**AttendanceReason
 String
 就诊原因*/
@property (nonatomic,copy) NSString *AttendanceReason;

/**AttendanceResult
 String
 就诊结果*/
@property (nonatomic,copy) NSString *AttendanceResult;

/**PicList
*/
@property (nonatomic,strong) NSMutableArray *PicList;

@end
