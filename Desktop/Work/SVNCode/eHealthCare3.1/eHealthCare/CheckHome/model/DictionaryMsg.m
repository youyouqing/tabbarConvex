//
//  DictionaryMsg.m
//  eHealthCare
//
//  Created by jamkin on 16/9/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DictionaryMsg.h"

@implementation DictionaryMsg

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%li------>>>%@",self.DictionaryID,self.DictionaryName];
    
}

@end
