//
//  FriendTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamilyMemberObject.h"
@protocol FriendTableViewCellDelegate <NSObject>

- (void)agreeAddFamilybuttonClick:(FamilyMemberObject *)Fobject pass:(NSInteger)pass;

@end



@interface FriendTableViewCell : UITableViewCell
@property (nonatomic,strong)FamilyMemberObject *Fobject;
@property (nonatomic, weak) id <FriendTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;

@end
