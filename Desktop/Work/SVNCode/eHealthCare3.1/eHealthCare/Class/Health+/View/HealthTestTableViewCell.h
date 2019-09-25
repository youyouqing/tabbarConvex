//
//  HealthTestTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HealthTestTableViewCellDelegate <NSObject>

-(void)HealthTestTableViewCellJoinAction:(NSString *)cellIndexStr;

@end
@interface HealthTestTableViewCell : UITableViewCell
@property (weak, nonatomic)id <HealthTestTableViewCellDelegate>delegate;

@property(strong,nonatomic)NSArray *listModArr;
@end
