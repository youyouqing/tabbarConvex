//
//  ExchinereportModel.m
//  PC300
//
//  Created by xiekang on 17/5/9.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import "ExchinereportModel.h"

@implementation ExchinereportModel
//-(void)setSuggestReportModel:(SuggestReportModel *)SuggestReportModel
//{
//    _SuggestReportModel = SuggestReportModel;
//    
//     
//}

-(void)setSuggestList:(NSArray *)SuggestList
{

    _SuggestList = SuggestList;
    
//  [ExchinereportModel objectWithKeyValues:[json objectForKey:@"Result"]];
        
        
    _SuggestList = [SuggestReportModel objectArrayWithKeyValuesArray:_SuggestList];
    
    

}

@end
