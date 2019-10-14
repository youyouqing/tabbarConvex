//
//  XKValidationAndAddScoreTools.m
//  eHealthCare
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKValidationAndAddScoreTools.h"
#import "XKHealthIntegralTaskSuccessView.h"
#import "XKCompleteTaskModel.h"

@interface XKValidationAndAddScoreTools()

@property (nonatomic,strong) XKCompleteTaskModel *data;

@end

@implementation XKValidationAndAddScoreTools
//goTask?TaskType=1&TypeID=1（TaskType 1、每日任务  2、福利任务即完善档案，TypeID 任务分类   如 1、签到等）
-(XKCompleteTaskModel *)validationAndAddScore:(NSDictionary *)validationDict withAdd:(NSDictionary *)addScoreDcit isPopView:(BOOL)isPopView{
    self.data = nil;
    NSLog(@"配置的参数%@--%@",validationDict,addScoreDcit);
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"943" parameters:validationDict success:^(id json) {
        NSLog(@"943验证当前任务是否完成--:%@",json);
        if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            
            if ([json[@"Result"][@"Iscomplete"] integerValue] == 0 && [json[@"Result"][@"IsExistsTask"] integerValue] == 1) {//未完成
                [ProtosomaticHttpTool protosomaticPostWithURLString:@"940" parameters:addScoreDcit success:^(id json) {
                    NSLog(@"940完成任务加分--:%@",json);
                    if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
                        [[XKLoadingView shareLoadingView] hideLoding];
                        
                        self.data = [XKCompleteTaskModel objectWithKeyValues:json[@"Result"]];
                        if (isPopView == YES) {
                            XKHealthIntegralTaskSuccessView *taskV = [[[NSBundle mainBundle] loadNibNamed:@"XKHealthIntegralTaskSuccessView" owner:self options:nil] firstObject];
                            if ([validationDict[@"TaskType"] integerValue] == 1) {//每日任务
                                //                            taskV.kangImg.hidden = YES;
                                // taskV.tatolKValueLab.hidden = NO;
                                // taskV.kmarkLab.hidden = NO;
                            }else{//福利任务
                                //                            taskV.kangImg.hidden = NO;
                                //    taskV.tatolKValueLab.hidden = YES;
                                //  taskV.kmarkLab.hidden = YES;
                            }
                            taskV.frame = [UIScreen mainScreen].applicationFrame;
                            [[UIApplication sharedApplication].delegate.window addSubview:taskV];
                            taskV.completeModel = self.data;
                        }else
                        {
                            NSLog(@"完成任务加分成功,只是树不弹窗");
                            
                        }
                     
                        NSLog(@"完成任务加分成功😆😆😆😆😆😆😆😆😆");
                    }else{
                        NSLog(@"任务失败加分失败");
                        ShowErrorStatus(@"加分失败");
                    }
                } failure:^(id error) {
                    NSLog(@"任务失败加分失败");
                    ShowErrorStatus(@"任务失败");
                }];
            }
            NSLog(@"签到成功😆😆😆😆😆😆😆😆😆");
        }else{
            NSLog(@"验证当前任务是否完成失败");
            ShowErrorStatus(@"任务失败");
        }
    } failure:^(id error) {
        NSLog(@"验证当前任务是否完成失败");
         ShowErrorStatus(@"任务失败");
    }];
    
    return self.data;
}

@end