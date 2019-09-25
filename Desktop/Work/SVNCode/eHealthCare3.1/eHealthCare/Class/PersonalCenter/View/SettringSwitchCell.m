//
//  SettringSwitchCell.m
//  eHealthCare
//
//  Created by jamkin on 16/8/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SettringSwitchCell.h"
#import "JPUSHService.h"
@interface SettringSwitchCell ()

@property (weak, nonatomic) IBOutlet UILabel *msgLab;

@property (weak, nonatomic) IBOutlet UISwitch *msgSwitch;

/**
 开启还是关闭
 */
@property (weak, nonatomic) IBOutlet UILabel *tagLab;

@end

@implementation SettringSwitchCell

-(void)setMsg:(NSString *)msg{
    
    _msg=msg;
    
    self.msgLab.text=_msg;
    
}

-(void)setSwitchStatus:(NSInteger)switchStatus{
    
    _switchStatus = switchStatus;
//    是否开启用药提醒 1、开启 0、未开启
    if (_switchStatus == 1) {//关闭
    
        self.tagLab.text = @"开启";
        [self.msgSwitch setOn:YES];
        
    }else{//打开
        self.tagLab.text = @"关闭";
        [self.msgSwitch setOn:NO];
        
    }
    
}

- (IBAction)clickSwitch:(UISwitch *)sender {

//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    if ([self.msgLab.text isEqualToString:@"健康管理信息提醒"]) {
    
        if (self.switchStatus == 0) {//打开通知
            
            self.tagLab.text = @"关闭";
           
            self.switchStatus = 1;
//            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
//
//
//            [defaults setValue:@(0) forKey:@"sStauts"];
            
        }else{//关闭通知
//            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
//            [defaults setValue:@(1) forKey:@"sStauts"];

            self.tagLab.text = @"开启";
            self.switchStatus = 0;
        }
        
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(openOrCloseButton:cell:)]) {
        [self.delegate openOrCloseButton:self.switchStatus cell:self];
    }

    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lineView.backgroundColor=COLOR(221, 230, 235, 1);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
