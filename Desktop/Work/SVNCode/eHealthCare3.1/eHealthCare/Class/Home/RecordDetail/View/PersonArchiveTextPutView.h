//
//  PersonArchiveTextPutView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonArchiveTextPutViewDelegate <NSObject>

- (void)PersonArchiveTextPutViewCompleteClick:(NSString *)dataStr;

@end
typedef NS_ENUM(NSInteger, PersonArchiveSingleType){
    
    PersonArchiveSingleTypeNormal = 0,//输入关系
    PersonArchiveSingleTypeName = 1,//输入姓名
    
};

@interface PersonArchiveTextPutView : UIView
@property (nonatomic, assign) PersonArchiveSingleType popType;
@property (nonatomic, weak) id <PersonArchiveTextPutViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputDataText;
@end
