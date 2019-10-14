//
//  XKMultiFunctionCheckResultHeadView.m
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//携康3.0版本pc300检测报告页面头部

#import "XKMultiFunctionCheckResultHeadView.h"
#import "XKMultiFunctionCheckResultModel.h"
#import "XKEquipButton.h"
@interface XKMultiFunctionCheckResultHeadView ()
{

    NSArray *houseHoldArr;

}
@property (weak, nonatomic) IBOutlet XKEquipButton *presureBtn;

@property (weak, nonatomic) IBOutlet XKEquipButton *sugarBtn;
@property (weak, nonatomic) IBOutlet XKEquipButton *tempBtn;
@property (weak, nonatomic) IBOutlet XKEquipButton *oxygenBtn;
@property (weak, nonatomic) IBOutlet XKEquipButton *rateBtn;


@end
@implementation XKMultiFunctionCheckResultHeadView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    houseHoldArr = @[self.presureBtn,self.sugarBtn,self.tempBtn,self.oxygenBtn,self.rateBtn];

}

/**
 血压

 @param sender <#sender description#>
 */
- (IBAction)pressureAction:(id)sender {
    XKEquipButton *bt = (XKEquipButton *)sender;
    NSLog(@"pressureAction：%@",bt.DeviceName);
    [self enterMain:bt.deviceID  DeviceClasstag:(int)bt.tag Name:bt.DeviceName];
    
}
- (IBAction)rateAction:(id)sender {
    
    
    XKEquipButton *bt = (XKEquipButton *)sender;
      NSLog(@"pressureAction：%@",bt.DeviceName);
    [self enterMain:bt.deviceID  DeviceClasstag:(int)bt.tag Name:bt.DeviceName];
}
- (IBAction)sugarAction:(id)sender {
    
    XKEquipButton *bt = (XKEquipButton *)sender;
      NSLog(@"pressureAction：%@",bt);
   [self enterMain:bt.deviceID  DeviceClasstag:(int)bt.tag Name:bt.DeviceName];
    
}
- (IBAction)oxgenAction:(id)sender {
    
    XKEquipButton *bt = (XKEquipButton *)sender;
     NSLog(@"pressureAction：%@",bt.DeviceName);
     [self enterMain:bt.deviceID  DeviceClasstag:(int)bt.tag Name:bt.DeviceName];
    
}
- (IBAction)tempureAction:(id)sender {
    
    XKEquipButton *bt = (XKEquipButton *)sender;
     NSLog(@"pressureAction：%@",bt.DeviceName);
    [self enterMain:bt.deviceID  DeviceClasstag:(int)bt.tag Name:bt.DeviceName];
    
}
-(void)enterMain:(int)tag  DeviceClasstag:(int)DeviceClasstag Name:(NSString *)Name{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(enterMainView:DeviceClasstag:Name:)]) {
        [self.delegate enterMainView:tag DeviceClasstag:DeviceClasstag  Name:Name];
    }
}
-(void)setDataArr:(NSArray *)dataArr
{

    _dataArr = dataArr;
    
    for (int i = 0; i<dataArr.count; i++) {
        
        XKMultiFunctionCheckResultModel *mod = dataArr[i];
//        for (int j = 0; j<houseHoldArr.count; j++) {
        
            XKEquipButton *btnone = houseHoldArr[i];
        
               if (mod.DeviceClass  == btnone.tag) {
                btnone.deviceID = mod.DeviceID;
                btnone.DeviceName = mod.Name;
                NSLog(@"设备DeviceClass%d---%@---%@",btnone.deviceID,houseHoldArr,btnone.DeviceName);
            }

//        }
        
    }
    
    
}
@end