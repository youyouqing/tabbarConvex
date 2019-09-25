//
//  BLEManager.h
//  BLEManager
//
//  Created by TTC on 16/1/20.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TTCDeviceInfo.h"
#import <UIKit/UIKit.h>
#import "oad.h"

typedef void (^GetRssiBlock) (NSNumber *RSSI);

typedef void(^Get_Version_Block )(NSString *string);

typedef void(^OAD_PROGRESS_Block)(float progress, NSError *error);

/**
 *  oad 升级的类型
 */
typedef NS_ENUM(NSInteger, Oad_Upgrade_Type) {
    Oad_Upgrade_2541_A_or_B = 0,        //2541 a,b版升级方式
    Oad_Upgrade_2541_Big_Capacity,      //2541大容量升级
    Oad_Upgrade_2640_On_Chip,           //2640片内
    Oad_Upgrade_2640_Off_Chip,          //2640片外
    Oad_Upgrade_2640_R1_R2              //2640 R1/R2 OAD
};

/**
 *  bin 文件存在的位置
 */
typedef NS_ENUM(NSInteger, OAD_Bin_File_Location){
    OAD_Bin_File_ON_Project = 1,        //Bin 文件在工程中
    OAD_Bin_File_Document               //Bin 文件在沙盒目录中
};

/**
 *  1004返回数据的类型
 */
typedef NS_ENUM(NSInteger, ReceiveData_Type_1004) {
    ReceiveData_Type_1004_Version = 0,      //设备的版本
    ReceiveData_Type_1004_Battery,          //电量
    ReceiveData_Type_1004_UTFTime,          //时钟
    ReceiveData_Type_1004_ChannelRates,     //波特率
    ReceiveData_Type_1004_TXPower,          //TX 发射功率
    ReceiveData_Type_1004_SettingName,      //名称
    ReceiveData_Type_1004_SettingPassword,  //配对密码
    ReceiveData_Type_1004_AdvertInterval,   //广播间隔
    ReceiveData_Type_1004_ConnectInterval,  //连接间隔
    ReceiveData_Type_1004_Latency,          //从机延时
    ReceiveData_Type_1004_ConnectTimeOut,   //连接超时间隔
    ReceiveData_Type_1004_AdvertData        //广播数据
};

@protocol BLEManagerDelegate <NSObject>

@optional

/**
 *  控制中心状态回调
 *
 *  @param state 0 = 未知   1 = 重置    2 = 不支持蓝牙4.0    3 = 未被授权   4 = 手机蓝牙关闭   5 = 手机蓝牙打开
 */
- (void)centerManagerStateChange:(CBManagerState)state;

/**
 *  搜索到设备回调方法
 *
 *  @param array 设备数组
 */
- (void)scanDeviceRefrash:(NSMutableArray *)array;

- (void)bleManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

/**
 *  连接设备成功回调方法
 *
 *  @param device 设备对象
 *  @param error  错误信息
 */
- (void)connectDeviceSuccess:(CBPeripheral *)device error:(NSError *)error;

/**
 *  断开设备成功回调
 *
 *  @param device 设备对象
 *  @param error  错误信息
 */
- (void)didDisconnectDevice:(CBPeripheral *)device error:(NSError *)error;

/**
 *  收到数据回调方法(1002)
 *
 *  @param data   数据
 *  @param device 设备对象
 */
- (void)receiveDeviceDataSuccess_1:(NSData *)data device:(CBPeripheral *)device;

/**
 *  收到数据回调方法(1003)
 *
 *  @param data   数据
 *  @param device 设备对象
 */
- (void)receiveDeviceDataSuccess_3:(NSData *)data device:(CBPeripheral *)device;

- (void) Receive_Data_EventfromModel:(NSData *)TXP p:(UInt8)len DEV:(CBPeripheral *)cb AndMarkId:(NSInteger)markId;//读取设备电池电量，此接口为防丢器专用

/**
 *  可以开始选取 OAD 文件进行 OAD 升级的回调
 *  (这个是2541 A,B 版升级时会用到的回调)
 *  @param fileType  OAD升级选取文件的类型 fileType为A选取A版bin文件 fileType为B选取B版bin文件
 */
- (void)didCanSelectOADFileWithFileType:(char)fileType;

/**
 *  oad升级过程中发送文件的进度的回调
 *
 *  @param filePer 发送的文件的进度
 */
- (void)returnSendOADFileProgressWith:(float)filePer;

/**
 *  oad升级成功的回调
 */
- (void)returnSendOADSuccess;

/**
 *  oad 升级失败的回调
 */
- (void)returnSendOADFailure;

/**
 *  停止搜索回调
 */
- (void)stopScanDevice;

/**
 *  获取特征下的描述的值的回调(descriptor.value)
 */
- (void)receiveDeviceDescriptorValue:(NSString *)data withCharacteristic:(CBCharacteristic *)characteristic peripheral:(CBPeripheral *)peripheral;

/**
 *  获取到指定设备的某个服务下的某个特征的值后的回调
 */
- (void)bleManagerPeripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

/**
 *  发送数据成功的回调
 */
- (void)bleManagerPeripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

/**
 *  操作 notify 的回调
 */
- (void)bleManagerPeripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;


#pragma mark - extra(common)
/**
 *  读取设备版本号回调方法
 *
 *  @param version 版本信息
 *  @param device  设备对象
 */
- (void)receiveDeviceVersion:(NSString *)version device:(CBPeripheral *)device;

/**
 *  读取设备电量回调方法
 *
 *  @param battery 电量值
 *  @param device  设备对象
 */
- (void)receiveDeviceBattery:(NSInteger)battery device:(CBPeripheral *)device;

/**
 *  读取设备时钟寄存器回调方法
 *
 *  @param year   年
 *  @param month  月
 *  @param day    日
 *  @param hour   时
 *  @param monute 分
 *  @param second 秒
 *  @param device 设备对象
 */
- (void)receiveDeviceUTFTime:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)monute second:(NSInteger)second device:(CBPeripheral *)device;

/**
 *  读取设备波特率回调方法
 *
 *  @param rate   波特率  9600bps   19200bps   38400bps   57600bps   115200bps
 *  @param device 设备对象
 */
- (void)receiveDeviceChannelRate:(NSString *)rate device:(CBPeripheral *)device;

/**
 *  读取设备TX发射功率回调方法
 *
 *  @param txPower  TX发射功率 -23dbm  -6dbm  0dbm  4dbm
 *  @param device  设备对象
 */
- (void)receiveDeviceTXPower:(NSString *)txPower device:(CBPeripheral *)device;

/**
 *  读取设备名称回调方法
 *
 *  @param name   设置名称
 *  @param device 设备对象
 */
- (void)receiveDeviceSettingName:(NSString *)name device:(CBPeripheral *)device;

/**
 *  读取设备配对密码回调方法
 *
 *  @param password 设置配对密码
 *  @param device   设备对象
 */
- (void)receiveDeviceSettingPassword:(NSString *)password device:(CBPeripheral *)device;

/**
 *  读取设备广播时间间隔回调方法
 *
 *  @param interval 广播时间间隔(单位：ms)
 *  @param device   设备对象
 */
- (void)receiveDeviceAdvertInterval:(NSInteger)interval device:(CBPeripheral *)device;

/**
 *  读取设备的连接时间间隔回调方法
 *
 *  @param interval 连接时间间隔(单位：ms)
 *  @param device   设备对象
 */
- (void)receiveDeviceConnectInterval:(NSInteger)interval device:(CBPeripheral *)device;

/**
 *  读取设备从机延时间隔回调方法
 *
 *  @param interval 延时间隔(单位：ms)
 *  @param device   设备对象
 */
- (void)receiveDeviceLatency:(NSInteger)interval device:(CBPeripheral *)device;

/**
 *  读取设备连接超时时间回调方法
 *
 *  @param interval 连接超时时间(单位：ms)
 *  @param device   设备对象
 */
- (void)receiveDeviceConnectTimeOut:(NSInteger)interval device:(CBPeripheral *)device;

/**
 *  读取设备广播数据回调方法
 *
 *  @param dataStr 设备广播数据
 *  @param device  设备对象
 */
- (void)receiveDeviceAdvertData:(NSString *)dataStr device:(CBPeripheral *)device;

/**
 *  读取连接的设备的信号的回调方法
 */
- (void)readDeviceRSSI:(CBPeripheral *)peripheral RSSI:(NSNumber *)RSSI;


#pragma mark - 180A服务相关的回调
/**
 *  得到设备模组型号信息的回调方法
 */
- (void)receiveDeviceInfoModel:(NSString *)string withDevice:(CBPeripheral *)cb;

/**
 *  180A服务返回数据的回调
 */
- (void)receiveDeviceInfomation:(NSString *)string withPeripheral:(CBPeripheral *)cb;


#pragma mark - 2000服务相关的回调
- (void)receiveData:(NSData *)data with2000ServiceDevice:(CBPeripheral *)cb withCharacteristic:(CBCharacteristic *)characteristic;


@end


@interface BLEManager : NSObject

@property (nonatomic, strong) id <BLEManagerDelegate> delegate;

@property (nonatomic, strong) GetRssiBlock getRssiBlock;

@property (nonatomic, strong) Get_Version_Block getVersionBlock;

@property (nonatomic, strong) CBCentralManager* centralManager;

/**
 *  数据是否需要加密,默认为加密,如果不需要加密,请将 isEncryption 设置为 NO
 */
@property (nonatomic, assign) BOOL isEncryption;

@property (nonatomic, assign) NSInteger getIder;

@property (nonatomic, strong) NSMutableArray * dev_DICARRAY;


/**
 *  实例化蓝牙管理单列对象的方法
 */
+ (BLEManager *)defaultManager;

/**
 *  搜索设备
 *
 *  @param interval 搜索时间间隔
 */
- (void)scanDeviceTime:(NSInteger)interval;

/**
 *  手动停止搜索设备
 */
- (void)manualStopScanDevice;

/**
 *  停止自动连接的方法
 */
- (void)stopAutoConnect;

/**
 *  自动连接的方法
 */
- (void)startAutoConnect:(NSArray *)peripheralArray;

/**
 *  获取设备名称
 *
 *  @param device 设备对象
 *
 *  @return 设备名称
 */
- (NSString *)getDeviceName:(CBPeripheral *)device;

/**
 *  获取设备是否已连接
 *
 *  @param device 设备对象
 *
 *  @return YES 已连接  NO 未连接
 */
- (BOOL)readDeviceIsConnect:(CBPeripheral *)device;

/**
 *  获取设备的UUID
 *
 *  @param device 设备对象
 *
 *  @return 设备UUID
 */
- (NSString *)readDeviceUUID:(CBPeripheral *)device;

/**
 *  连接设备
 *
 *  @param device        设备对象
 */
- (void)connectToDevice:(CBPeripheral *)device;

/**
 *  断开设备
 *
 *  @param device 设备对象
 */
- (void)disconnectDevice:(CBPeripheral *)device;

/**
 *  根据设备UUID获取设备对象
 *
 *  @param uuid 设备UUID
 *
 *  @return 返回设备对象
 */
- (CBPeripheral *)getDeviceByUUID:(NSString *)uuid;

/**
 *  @param peripheral   蓝牙对象
 *  @param serviceUUID  服务 UUID    eg:0x1000;
 *  @param characteruisticUUID   特征 UUID       eg:0x1001;
 *  @param encryption   是否加密;
 @  @param response     写数据的方式      response = YES (CBCharacteristicWriteWithResponse)
                        response = NO (CBCharacteristicWriteWithoutResponse)
 */
- (void)bleManagerPeripheral:(CBPeripheral *)peripheral writeValue:(NSString *)string serviceUUID:(UInt16)serviceUUID characteruisticUUID:(UInt16)characteruisticUUID encryption:(BOOL)encryption response:(BOOL)response;

/**
 *  设置设备notify状态
 *
 *  @param serviceUUID 服务UUID   eg:(0x1000)
 *  @param cUUID       特征UUID   eg:(0x1001)
 *  @param device      设备对象
 *  @param isEnable    YES打开  NO关闭
 */
- (void)notification:(UInt16)serviceUUID characteristicUUID:(UInt16)cUUID peripheral:(CBPeripheral *)device enableState:(BOOL)isEnable;




#pragma mark - 1000
/**
 *  发送数据api(1001)
 *
 *  @param dataStr 16进制字符串
 *  @param device  设备对象
 */
- (void)sendDataToDevice1:(NSString *)dataStr device:(CBPeripheral *)device;

- (void)sendData:(NSString *)dataString peripheral:(CBPeripheral *)peripheral responseState:(BOOL)state;

/**
 *  发送数据api(1003)
 *
 *  @param dataStr 16进制字符串
 *  @param device  设备对象
 */
- (void)sendDataToDevice3:(NSString *)dataStr device:(CBPeripheral *)device;

/**
 *  读取1004通道的数据
 */
- (void)readDataWithDevice4:(CBPeripheral *)device;

/**
 *  发送数据,1005通道
 */
- (void)sendDataToDevice5:(NSString *)dataStr device:(CBPeripheral *)device;

/**
 *  打开设备notify通道
 *
 *  @param device 设备对象
 */
- (void)enableNotify:(CBPeripheral *)device;

/**
 *  关闭设备notify通道
 *
 *  @param device 设备对象
 */
- (void)disableNotify:(CBPeripheral *)device;

/**
 *  清空设备数据
 */
- (void)clearDeviceData;

/**
 *  获取控制中心状态
 *
 *  @return state 0=未知   1=重置    2=不支持蓝牙4.0    3=未被授权   4= 手机蓝牙关闭   5=手机蓝牙打开
 */
- (NSInteger)readCenterManagerState;



#pragma mark - 2000

/**
 *  向2000服务的通道写数据
 *  参数3: 比如向2001通道写数据的话,传的值是 0x2001
 */
- (void)sendData:(NSString *)string to2000ServiceDevice:(CBPeripheral *)peripheral WithCharacteristic:(UInt16)UUID responseState:(BOOL)state;

/**
 *  读2000服务的设备数据
 *  参数2: 比如读2001通道的数据的话,传的值是 0x2001
 */
- (void)readValueWith2000ServiceDevice:(CBPeripheral *)device wihtCharacteristics:(UInt16)uuid;

/**
 *  打开2000服务的设备的 notify 通道
 *  参数2: 比如打开2001通道的notify,传的值是 0x2001
 */
- (void)enableNotify2000ServiceDevice:(CBPeripheral *)device withcharacteristicUUID:(UInt16)uuid;



#pragma mark - extra(common)
/**
 *  读取模组型号的方法
 */
- (void)readDeviceINfoModelNumberWithDevice:(CBPeripheral *)peripheral;

/**
 *  读取模组的软件版本信息
 */
- (void)readDeviceINfoSoftVersionWithDevice:(CBPeripheral *)peripheral getVersioBlcok:(Get_Version_Block)getVersionBlock;

/**
 *  读取设备数据
 *
 *  @param serviceUUID 服务UUID (0x1000)
 *  @param cUUID       特征UUID (0x1001)
 *  @param device      设备对象
 */
- (void)readData:(UInt16)serviceUUID characteristicUUID:(UInt16)cUUID peripheral:(CBPeripheral *)device;

/**
 *  读取指定设备的版本
 *
 *  @param device 设备对象
 */
- (void)readDeviceVersion:(CBPeripheral *)device;

/**
 *  读取指定设备的电量
 *
 *  @param device 设备对象
 */
- (void)readDeviceBattery:(CBPeripheral *)device;

/**
 *  读取指定设备的时钟寄存器
 *
 *  @param device 设备对象
 */
- (void)readDeviceUTFTime:(CBPeripheral *)device;

/**
 *  读取指定设备的波特率
 *
 *  @param device 设备对象
 */
- (void)readDeviceChannelRates:(CBPeripheral *)device;

/**
 *  读取指定设备的TX发射功率
 *
 *  @param device 设备对象
 */
- (void)readDeviceTXPower:(CBPeripheral *)device;

/**
 *  读取指定设备的设置名称
 *
 *  @param device 设备对象
 */
- (void)readDeviceSettingName:(CBPeripheral *)device;

/**
 *  修改指定设备的名称
 *
 *  @param name   设备名称
 *  @param device 设备对象
 */
- (void)setDeviceName:(NSString *)name device:(CBPeripheral *)device;

/**
 *  读取指定设备设置的配对密码
 *
 *  @param device 设备对象
 */
- (void)readDeviceSettingPassword:(CBPeripheral *)device;

/**
 *  修改指定设备的配对密码
 *
 *  @param password 密码范围为（000000－999999）之间的六位数
 *  @param device   设备对象
 */
- (void)setDevicePassword:(NSString *)password device:(CBPeripheral *)device;

/**
 *  读取指定设备的广播间隔 (32-24000单位, 625us)
 *
 *  @param device 设备对象
 */
- (void)readDeviceAdvertInterval:(CBPeripheral *)device;

/**
 *  设定指定设备的广播间隔 (32-24000单位, 625us)
 *
 *  @param device 设备对象
 */
- (void)setDeviceAdvertDistanceData:(NSString *)advert device:(CBPeripheral *)device;

/**
 *  读取指定设备的连接间隔 (16-3200单位, 1.25ms)
 *
 *  @param device 设备对象
 */
- (void)readDeviceConnectInterval:(CBPeripheral *)device;

/**
 *  设定指定设备的连接间隔 (16-3200单位, 1.25ms)
 *
 *  @param device 设备对象
 */
- (void)setDeviceConnectDistanceData:(NSString *)advert device:(CBPeripheral *)device;

/**
 *  读取指定设备从机延时(0-500ms)
 *
 *  @param device 设备对象
 */
- (void)readDeviceLatency:(CBPeripheral *)device;

/**
 *  读取指定设备的连接超时间隔(0-1000ms)
 *
 *  @param device 设备对象
 */
- (void)readDeviceConnectTimeOut:(CBPeripheral *)device;

/**
 *  读取指定设备的广播数据
 *
 *  @param device 设备对象
 */
- (void)readDeviceAdvertData:(CBPeripheral *)device;

/**
 *  设置指定设备的广播数据
 *
 *  @param advert 广播数据
 *  @param device 设备对象
 */
- (void)setDeviceAdvertData:(NSString *)advert device:(CBPeripheral *)device;

/**
 *  获取设备信号的方法
 */
- (void)readDeviceRSSI:(CBPeripheral *)cb getRssiBlock:(GetRssiBlock)getRssiBlock;

- (void)readDeviceRSSI:(CBPeripheral *)cb;



#pragma mark - OAD

@property (nonatomic, assign) Oad_Upgrade_Type oad_type;

/**
 *  oad升级的时候发送数据的间隔
 */
@property (nonatomic, assign) float sendOadDataInteral;

@property (nonatomic, strong) OAD_PROGRESS_Block oadProgressBlock;

/**
 *  是否取消 OAD 升级,如果要将正在进行的 OAD 升级停止,将 canceled 设置为 NO
 */
@property (nonatomic,assign) BOOL canceled;

/**
 *  要进行 oad 升级的设备
 */
@property (nonatomic,strong) CBPeripheral * oadPeripheral;

/**
 *  判断是否允许oad升级
 *
 *  @param dev 要进行 oad 升级的设备
 */
- (BOOL)judgeCanOADWith:(CBPeripheral *)dev;

/**
 *  打开 OAD 升级的通道
 *
 *  @param cb oad 升级的设备 (只要在 judegeCanOADWith: 返回 YES 后才能调用这个方法)
 *  打开 OAD 升级通道成功后,如果是2541 A,B版的升级方式会调用 didCanSelectOADFileWithFileType: 回调方法,该回调方法会传递应该选择的 OAD 升级的文件的类型
 */
- (void)configureProfile:(CBPeripheral *)cb oadType:(Oad_Upgrade_Type)type;



#pragma mark - 2541 A,B版升级
/**
 *  选择 OAD 升级的 bin 文件
 *
 *  @param fileName oad 升级的 bin 文件的文件名字
 *  如果要进行 oad 升级在 didCanSelectOADFileWithFileType: 回调方法里面调用下面的方法
 *  传递参数类型为 string 格式如: B 版（Low）-DXM-LYD-20151215-V1.6.7.bin 或者: A 版（Low）-DXM-LYD-20151215-V1.6.7.bin ,选择 A 还是 B 根据 didCanSelectOADFileWithFileType: 回调回来的文件类型确定
 *
 *  path path = 1 升级文件是放在工程里面 path = 2 升级文件放在沙盒目录的Documents文件夹下面
 */
- (void)startOADFileWithFileName:(NSString *)fileName filePath:(OAD_Bin_File_Location)path;



#pragma mark - 2541 大容量升级 和 2640 片内 OAD 升级
- (void)enter2541BigImageOADState:(CBPeripheral *)peripheal;

/**
 *  通过向指定的通道写入数据,然后进入 oad 模式后,然后,使用方法 startOADFileWithFileName: 开始升级,这两种模式的 oad 升级不需要选择 A 或者 B 版的 bin文件,这种模式的 oad 只有一个 bin 文件
 */
- (void)writeCharacteristic:(CBPeripheral *)peripheral sCBUUID:(CBUUID *)sCBUUID cCBUUID:(CBUUID *)cCBUUID dataString:(NSString *)string;



#pragma mark - 2640 片外 OAD 升级
/**
 *  path path = 1 升级文件是放在工程里面 path = 2 升级文件放在沙盒目录的Documents文件夹下面
 */
- (void)startOADFileWithFileName:(NSString *)fileName peripheral:(CBPeripheral *)cb filePath:(OAD_Bin_File_Location)path progressBlock:(OAD_PROGRESS_Block)block;



#pragma mark - 2640 R2 / R1 OAD 升级
/**
 *  进入 2640 R1/R2 OAD升级模式
 */
- (void)configure2640_R1_or_R2_OADProfile:(CBPeripheral *)cb;

/**
 *  开始2640 R1/R2 OAD 升级工作
 */
- (void)R1_or_R2_2640_OADStartOADWithFileName:(NSString *)fileName peripheral:(CBPeripheral *)peripheral filePath:(OAD_Bin_File_Location)path;


@end
