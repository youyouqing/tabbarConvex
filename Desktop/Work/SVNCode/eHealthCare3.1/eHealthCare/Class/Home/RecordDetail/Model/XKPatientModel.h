//
//  XKPatientModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKPatientModel : NSObject

/**PatientID
 Int32
 病历编号*/
@property (nonatomic,assign) NSInteger PatientID;


/**AttendanceTime
 Long
 就诊时间*/
@property (nonatomic,assign) long AttendanceTime;

/**AttendanceHospital
 Int32
 就诊医院*/
@property (nonatomic,copy) NSString *AttendanceHospital;

/**AttendanceTypeName
 Int32
 就诊类型*/
@property (nonatomic,copy) NSString *AttendanceTypeName;

/**
 病历图片
 */
@property (nonatomic,copy) NSString *PatientPicUrl;


@property (nonatomic,copy) NSString *DepartmentsName;
@end