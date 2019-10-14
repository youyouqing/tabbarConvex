//
//  PersonArchiveSinglePopView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ArchiveSingleType){
    
    ArchiveSingleTypeNormal = 0,//
    ArchiveSingleTypeSex = 1,//性别
    ArchiveSingleTypeBirthday = 2,
    ArchiveSingleTypeHeight = 3,
    ArchiveSingleTypeSexWeight = 4,
    ArchiveSingleTypeSmoking = 5,
    ArchiveSingleTypeDrinking = 6,
    ArchiveSingleTypeBloodType = 7
};
@protocol PersonArchiveSinglePopViewDelegate <NSObject>

- (void)PersonArchiveSinglePopViewSelectItemClick:(NSString *)completeStr ArchiveType:(ArchiveSingleType)ArchiveType;

@end


@interface PersonArchiveSinglePopView : UIView
@property (nonatomic, strong)NSArray *tempSmokeOrDrinkArr;
@property (nonatomic, weak) id <PersonArchiveSinglePopViewDelegate> delegate;
@property (nonatomic, assign) ArchiveSingleType popBottomType;

 /**
  默认数据
  */
@property (nonatomic, copy)NSString *defaultselectedStr;

@end