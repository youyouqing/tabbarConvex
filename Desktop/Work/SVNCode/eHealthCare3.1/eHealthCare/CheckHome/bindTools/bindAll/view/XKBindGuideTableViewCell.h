//
//  XKBindGuideTableViewCell.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKDeviceProductMod.h"
@interface XKBindGuideTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *dotBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)XKDeviceProductMod *deviceDetailMod;
@end
