//
//  HematocrystallinView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HematocrystallinViewDelegate <NSObject>
-(void)selectSexIndex:(NSString *)title birthdayText:(NSString *)birthday heightText:(NSString *)height;



@end
@interface HematocrystallinView : UIView
@property(weak,nonatomic)id<HematocrystallinViewDelegate>delegate;
@end
