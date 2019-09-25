//
//  XKSearchEquiptView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADisplayLineImageView.h"

@class XKEquiptBindTableViewCell;
typedef enum  {
//    XKLoadNormalStyle  = 10, // 默认绑定中
    XKLoadCalcelStyle,
    XKLoadSuccessStyle,// 　绑定成功
    XKLoadLoadingStyle,//加载中
    XKLoadunLoadingStyle,// 未检测到
    XKLoadSearchingStyle,//搜索中
    XKLoadDetectiStyle//检测 选择设备 绑定绑定设备
} XKLoadViewStyle;
@protocol XKSearchEquiptViewDelegate <NSObject>
-(void)selectIndex:(XKEquiptBindTableViewCell *)cell;


/**
 重新开始检测
 */
-(void)beginAgainToDectTool;
@end
@interface XKSearchEquiptView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
    CADisplayLineImageView *displayImageView;
}
@property (weak, nonatomic) IBOutlet UITableView *equiptTabView;

@property(assign,nonatomic)XKLoadViewStyle style;

@property(strong,nonatomic)NSArray *dataBigArray;


@property (nonatomic,assign)id <XKSearchEquiptViewDelegate> delegate;
@end
