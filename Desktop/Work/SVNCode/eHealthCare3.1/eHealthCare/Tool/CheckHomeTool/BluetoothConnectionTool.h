//
//  BluetoothConnectionTool.h
//  PC300
//
//  Created by jamkin on 2017/4/19.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BluetoothConnectionToolDelegate <NSObject>
/**
 韦连接上设备的状态
 */
-(void)TheUnConnectionStatus;
/**
 POD 状态的图
 */
-(void)TheConnectionPodStatus:(NSInteger)connectionStatus;
/**
 更新链接状态
 */
@optional
-(void)updateTheConnectionStatus:(NSInteger) connectionStatus;
/**
 检测结果传输
 @param dict jison数据 多个值
 */
@optional
-(void)resultSend:(NSDictionary *)dict;
/**
 血压检测数据传输
 @param dict jison数据 一个值
 */
-(void)pressureSend:(NSDictionary *)dict;
/**
 血氧检测数据传输
 @param dict jison数据 多个值
 */
@optional
-(void)oxygenSend:(NSDictionary *)dict;
/**
 扫描失败
 */
-(void)searchFailDevice;

/**
 pod

 @param dict <#dict description#>
 */
-(void)oxygenPodSend:(NSDictionary *)dict;
/**
 心率检测数据传输
 @param dict jison数据 多个值
 */
@optional
-(void)heartSend:(NSDictionary *)dict;
/**
 体温检测数据传输
 @param dict jison数据 一个值
 */
@optional
-(void)temperatureSend:(NSDictionary *)dict;
/**
 心电检测数据传输
 @param ecgStr 字符串
 */
@optional
-(void)ecgSend:(NSString *)ecgStr  nHR:(NSInteger)nHR lead:(BOOL)bLeadOff;



-(void)ecgSendnHR:(NSInteger)nHR;



-(void)nGuiSendnGu:(NSInteger)nGu;
@end

@interface BluetoothConnectionTool : NSObject

/**
实例化单列对象
 */
+ (instancetype)sharedInstanceTool;

/**
 断开链接
 */
-(void)disconnectDevice;

/**
 开启自动测量数据
 */
-(void)beginAutoTest;

/**
 断开连接
 */
-(void)PoddisconnectDevice;
/**
 停止扫描  会再次搜索设备
 */
- (void) stopScan;
/**
 开始扫描设备
 */
-(void)scanDevice;



/**
 代理对象
 */
@property (nonatomic,weak) id<BluetoothConnectionToolDelegate> delegate;

@property (nonatomic,assign) NSInteger conntiontStatus;
@property (nonatomic,assign)NSMutableArray *foundPorts;
@property (nonatomic,copy) NSString *adVpersincalName;
@property (nonatomic,assign) NSInteger conntiontTool;//连接设备1  隐藏  2  PC300出现  3Pod jiazai
@property (nonatomic,assign) BOOL searchTool;//是否扫描到设备
@end
