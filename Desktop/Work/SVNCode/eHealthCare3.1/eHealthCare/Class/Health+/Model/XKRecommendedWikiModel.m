//
//  XKRecommendedWikiModel.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKRecommendedWikiModel.h"

@implementation XKRecommendedWikiModel

-(void)setDetailUrl:(NSString *)DetailUrl{
    _DetailUrl = DetailUrl;
    if ([_DetailUrl containsString:@"?"]) {
        
        _DetailUrl=[NSString stringWithFormat:@"%@&AppIdentify=80001&OSType=2&Token=%@",_DetailUrl,[UserInfoTool getLoginInfo].Token];
        
    }else{
        
        _DetailUrl=[NSString stringWithFormat:@"%@?&AppIdentify=80001&OSType=2&Token=%@",_DetailUrl,[UserInfoTool getLoginInfo].Token];
        
    }
}

@end
