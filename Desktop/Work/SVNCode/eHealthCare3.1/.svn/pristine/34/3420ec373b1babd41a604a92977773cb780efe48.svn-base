//
//  EPluseCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EPluseCellDelegate <NSObject>

- (void)sportEPluseCellbuttonClick:(NSString *)titleStr headline:(NSString *)headline;


/**发送今日记步信息*/
-(void)sendStepMesage:(int )step;
@end


@interface EPluseCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *DataDic;
@property (nonatomic, weak) id <EPluseCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *sportBtn;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UIView *lienView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *icomImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageTwo;
@property (weak, nonatomic) IBOutlet UILabel *titleLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

@end
