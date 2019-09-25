//
//  XKMultiFunctionResuiltsuccessUploadView.m
//  eHealthCare
//
//  Created by xiekang on 2017/11/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMultiFunctionResuiltsuccessUploadView.h"
@interface XKMultiFunctionResuiltsuccessUploadView ()
@property (weak, nonatomic) IBOutlet UIButton *lookReportButton;
@property (weak, nonatomic) IBOutlet UIButton *keepOnBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation XKMultiFunctionResuiltsuccessUploadView
- (IBAction)lookReportBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(successUploadViewPushOtherController)]) {
        [self.delegate successUploadViewPushOtherController];
    }
     [self removeFromSuperview];
    
}
- (IBAction)keepOndect:(id)sender {
    
    [self removeFromSuperview];
    
}

/**
 初始化数据
 */
-(void)awakeFromNib
{

    [super awakeFromNib];
    
    self.backView.clipsToBounds = YES;
    
    self.backView.layer.cornerRadius = 10/2.0;
    
    
    self.lookReportButton.clipsToBounds = YES;
    
    self.lookReportButton.layer.cornerRadius = 40/2.0;
    
    
    self.keepOnBtn.clipsToBounds = YES;
    
    self.keepOnBtn.layer.cornerRadius = 40/2.0;
}
@end
