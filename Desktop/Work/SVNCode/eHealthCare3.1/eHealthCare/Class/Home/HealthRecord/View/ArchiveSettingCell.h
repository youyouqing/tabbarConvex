//
//  ArchiveSettingCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamilyObject.h"

@protocol ArchiveSettingCelllDelegate <NSObject>

- (void)deleteFamilybuttonClick:(FamilyObject *)famMod;

@end


@interface ArchiveSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic, strong)FamilyObject *famMod;
@property (nonatomic, weak) id <ArchiveSettingCelllDelegate> delegate;

@end
