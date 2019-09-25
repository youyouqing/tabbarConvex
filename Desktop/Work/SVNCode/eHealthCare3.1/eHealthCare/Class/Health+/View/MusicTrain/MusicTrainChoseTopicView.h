//
//  MusicTrainChoseTopicView.h
//  eHealthCare
//
//  Created by John shi on 2018/7/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicTrainChoseTopicDelegate <NSObject>

- (void)choseTopic:(NSInteger)indexTopic;

@end

@interface MusicTrainChoseTopicView : UIView

@property (nonatomic, weak) id <MusicTrainChoseTopicDelegate> delegate;

///数据源
@property (nonatomic, strong) NSArray *listArray;

@end
