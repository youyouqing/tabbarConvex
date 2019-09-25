//
//  HealthTopScrollHeaderView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthTopScrollHeaderViewDelegate <NSObject>
-(void)addFamilyTools;


-(void)replaceRelationData:(NSInteger )dataInt;
@end





@interface HealthTopScrollHeaderView : UIView
@property(weak,nonatomic)id<HealthTopScrollHeaderViewDelegate>delegate;
 @property(assign,nonatomic) NSInteger  userMemberID;
@property (nonatomic, strong)NSArray *familyArr;

@end
