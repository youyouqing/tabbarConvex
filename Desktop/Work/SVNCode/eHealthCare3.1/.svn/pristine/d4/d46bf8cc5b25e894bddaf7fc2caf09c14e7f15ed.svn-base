//
//  ArchivesEditView.h
//  eHealthCare
//
//  Created by xiekang on 16/9/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryMsg.h"

@class ArchivesEditView;

@protocol ArchivesEditViewDelegate <NSObject>
-(void)changeDataPicker:(DictionaryMsg *)msg andRow:(NSInteger)row withSelef:(ArchivesEditView *)view;
@end

@interface ArchivesEditView : UIView
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,assign)id <ArchivesEditViewDelegate> delegate;
@end
