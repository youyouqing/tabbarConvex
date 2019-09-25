//
//  InformationCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiTypeList.h"
#import "HealthPlanView.h"
#import "YUHoriView.h"
@class XKNewModel;
@protocol InformationCellDelegate <NSObject>

- (void)InformationCellClick:(XKNewModel *)model;
- (void)refreshCell:(NSArray *)wikiArr;
@end


@interface InformationCell : UITableViewCell
@property (nonatomic,strong)NSArray *WikiTypeList1;
@property (nonatomic, weak) id <InformationCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet YUHoriView *btnsView;
@property(assign,nonatomic) NSInteger SelectTab;//切换的哪个页面
//@property (nonatomic,assign) void(^blockSelectTab)(NSInteger tag);
@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *WikiList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
-(void)replaceData:(WikiTypeList *)WikiTypeModel;
@end
