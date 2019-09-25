//
//  VDGifPlayerTool.h
//  eHealthCare
//
//  Created by John shi on 2018/10/31.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface VDGifPlayerTool : NSObject
- (void)addGifWithName:(NSString *)gifName toView:(UIView *)view;
typedef void(^gifDealloc)(BOOL dealloc);
@property (nonatomic, strong) gifDealloc call_back;
//-(void)stopLoading;
-(void)remove;

-(void)startAnimateGifMethod:(NSString *)name toView:(UIImageView *)imgView;
@end
