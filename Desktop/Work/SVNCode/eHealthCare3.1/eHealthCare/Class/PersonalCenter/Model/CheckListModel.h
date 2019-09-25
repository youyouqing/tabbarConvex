//
//  CheckListModel.h
//  eHealthCare
//
//  Created by jamkin on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListModel : NSObject
//推荐内容 默认为1推荐
@property (nonatomic,assign)NSInteger RecommendType;

@property (nonatomic,copy)NSString *SetImgUrl;

@property (nonatomic,copy)NSString *SetCategoryName;

@property (nonatomic,assign)NSInteger BrowseCount;

@property (nonatomic,assign)NSInteger SetCategoryId;

@property (nonatomic,assign)NSInteger IsCorporeity;

/**套题描述**/
@property (nonatomic,copy)NSString *SetContent;


//已测人数
@property (nonatomic,assign)NSInteger TestCount;

@property (nonatomic,assign)NSInteger CollectCount;
//是否收藏 1、已收藏 0、未收藏
@property (nonatomic,assign)NSInteger IsCollect;
@end
