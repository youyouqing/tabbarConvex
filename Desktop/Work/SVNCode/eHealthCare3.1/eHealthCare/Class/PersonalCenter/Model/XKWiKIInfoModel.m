//
//  XKWiKIInfoModel.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKWiKIInfoModel.h"

@implementation XKWiKIInfoModel

-(void)setLinkUrl:(NSString *)LinkUrl{
    _LinkUrl = LinkUrl;
    if ([_LinkUrl containsString:@"?"]) {
        
        _LinkUrl=[NSString stringWithFormat:@"%@&AppIdentify=80001&OSType=2&Token=%@",_LinkUrl,[UserInfoTool getLoginInfo].Token];
        
    }else{
        
        _LinkUrl=[NSString stringWithFormat:@"%@?&AppIdentify=80001&OSType=2&Token=%@",_LinkUrl,[UserInfoTool getLoginInfo].Token];
        
    }

}

@end
