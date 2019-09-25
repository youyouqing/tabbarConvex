//
//  HomeAnswerView.h
//  eHealthCare
//
//  Created by John shi on 2018/8/7.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeAnswerViewDelegate <NSObject>


/**
 测试完成

 @param testArray 测试结果数组  选择哪些选项的信息
 */
- (void)testFinish:(NSArray *)testArray;

@end

@interface HomeAnswerView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id <HomeAnswerViewDelegate> delegate;

///是否是体质检测 YES:体质检测 NO:不是体质检测
@property (nonatomic, assign) BOOL isCorporeity;

@end
