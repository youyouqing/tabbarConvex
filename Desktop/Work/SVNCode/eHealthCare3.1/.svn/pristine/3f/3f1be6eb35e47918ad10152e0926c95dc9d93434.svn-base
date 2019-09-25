//
//  XKHealthIntegralSignSuccessView.h
//  eHealthCare
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本签到成功视图

#import <UIKit/UIKit.h>
/**协议对象*/
@protocol XKHealthIntegralSignSuccessViewDelegate <NSObject>
/**协议可选方法*/
@optional
/**点击去浏览商城的方法*/
-(void)clickToMall;
@end

@interface XKHealthIntegralSignSuccessView : UIView

/**明日签到可得康币标签*/
@property (weak, nonatomic) IBOutlet UILabel *tomarroyCountLab;
/**本次签到所得k值标签*/
@property (weak, nonatomic) IBOutlet UILabel *kCountLab;
/**本次签到所得康币标签*/
@property (weak, nonatomic) IBOutlet UILabel *kangCountLab;

/**推荐展示设备图片1*/
@property (weak, nonatomic) IBOutlet UIImageView *signEquipmentImgOne;
/**推荐展示设备标签1*/
@property (weak, nonatomic) IBOutlet UILabel *signEquipmentLabOne;

/**推荐展示设备图片2*/
@property (weak, nonatomic) IBOutlet UIImageView *signEquipmentImgTwo;
/**推荐展示设备标签2*/
@property (weak, nonatomic) IBOutlet UILabel *signEquipmentLabTwo;

/**推荐展示设备图片3*/
@property (weak, nonatomic) IBOutlet UIImageView *signEquipmentImgThree;
/**推荐展示设备标签3*/
@property (weak, nonatomic) IBOutlet UILabel *signEquipmentLabThree;

/**代理对象*/
@property (nonatomic,weak) id<XKHealthIntegralSignSuccessViewDelegate> delegate;

@end
