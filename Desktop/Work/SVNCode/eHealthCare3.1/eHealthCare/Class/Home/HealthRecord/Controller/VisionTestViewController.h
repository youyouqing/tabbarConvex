//
//  VisionTestViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseViewController.h"

@interface VisionTestViewController : BaseViewController

///用于区别左眼测试还是右眼测试
@property (nonatomic, assign) BOOL isRight;

///左眼视力
@property (nonatomic, assign) float leftEyeNum;

@end
