//
//  XKExChinereportModel.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKExChinereportModel.h"

@implementation XKExChinereportModel
-(void)setSuggestList:(NSArray *)SuggestList
{
    
    _SuggestList = SuggestList;
    
    //  [ExchinereportModel objectWithKeyValues:[json objectForKey:@"Result"]];
    
//    _SuggestReportModel = [[SuggestReportModel alloc]init];
    _SuggestList = [SuggestReportModel objectArrayWithKeyValuesArray:_SuggestList];
    
    
    
}
@end
