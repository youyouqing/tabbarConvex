//
//  XKPatientDetailModel.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKPatientDetailModel.h"

@implementation XKPatientDetailModel

-(void)setPicList:(NSMutableArray *)PicList{
    
    _PicList = PicList;
    
    _PicList = (NSMutableArray *)[XKPatientPhotoModel objectArrayWithKeyValuesArray:_PicList];
    
}

@end
