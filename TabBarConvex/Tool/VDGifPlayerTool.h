//
//  VDGifPlayerTool.h
//  eHealthCare
//
//  Created by zhangmin on 2018/10/31.
//  Copyright © 2018年 XXXXX. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface VDGifPlayerTool : NSObject
- (void)addGifWithName:(NSString *)gifName toView:(UIView *)view;
typedef void(^gifDealloc)(BOOL dealloc);
@property (nonatomic, strong) gifDealloc call_back;
//-(void)stopLoading;
-(void)remove;

-(void)startAnimateGifMethod:(NSString *)name toView:(UIImageView *)imgView;
@end
