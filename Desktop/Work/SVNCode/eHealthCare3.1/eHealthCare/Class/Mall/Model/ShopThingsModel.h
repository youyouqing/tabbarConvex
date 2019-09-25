//
//  ShopThingsModel.h
//  eHealthCare
//
//  Created by xiekang on 16/12/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopThingsModel : NSObject
/**购物车编号*/
@property(nonatomic, assign) NSInteger ID;

/**类型(1会所、2体检)*/
@property(nonatomic, assign) NSInteger Type;

/**产品ID*/
@property(nonatomic, strong) NSString *SuitID;

/**产品名称*/
@property(nonatomic, strong) NSString *SuitName;

/**金额*/
@property(nonatomic, assign) CGFloat Price;

/**产品数量*/
@property(nonatomic, assign) NSInteger Count;

/**用户ID*/
@property(nonatomic, assign) NSInteger MemberID;

/**图片*/
@property(nonatomic, strong) NSString *SuitImgUrl;

/**机构ID*/
@property(nonatomic, assign) NSInteger AgencyID;

/**机构名称*/
@property(nonatomic, strong) NSString *AgencyName;

/**预约须知*/
@property(nonatomic, strong) NSString *Reminder;

/**机构图片*/
@property(nonatomic, strong) NSString *AgencyImage;

/**折扣*/
@property(nonatomic, assign) CGFloat Discount;

/**是否选中*/
@property(nonatomic, assign) BOOL isSelect;

/**下标*/
@property(nonatomic, strong) NSIndexPath * indexPath;

@end
