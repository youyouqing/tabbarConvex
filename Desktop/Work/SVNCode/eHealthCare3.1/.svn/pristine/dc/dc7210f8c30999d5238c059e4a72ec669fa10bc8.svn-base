//
//  LanYaSDK.m
//  LanYaSDK
//
//  Created by iKnet on 16/9/26.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "LanYaSDK.h"

@interface LanYaSDK ()
{
    NSMutableData   *joiningData;
    BOOL             sendState;
}
@property (nonatomic,assign)NSInteger jumpCountIndex;
@end

@implementation LanYaSDK


#pragma mark 封装通知传值对象
-(NSDictionary *)createNoticeDic:(ISNoticeType)isNoticeType andValue:(id)value
{
    return @{TYPE:[NSString stringWithFormat:@"%ld",(long)isNoticeType],
             OBJECT:value?value:@""};
}
+(LanYaSDK*)shareInstance
{
    static dispatch_once_t pred = 0;
    __strong static LanYaSDK *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
        
        
    });
    return _sharedObject;
}
-(instancetype)init
{
    self = [super init];
    [self managerInitializeData];
    return self;
}

#pragma mark No.0 初始化管理器数据
-(void)managerInitializeData
{
    self.scanDeviceListArr = [NSMutableArray new];
     self.jumpCountIndex = 1;
    self.isConnectedEquipt = 1;
    self.bluetoothCentralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

#pragma mark - 功能操作
#pragma mark No.1 开始扫描蓝牙设备
-(void)startScan
{
    NSLog(@"============开始扫描==============================\n");
    //扫描外围设备服务
    [self.bluetoothCentralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
    //清空设备数组并将蓝牙状态改为扫描
    [self.scanDeviceListArr removeAllObjects];
    self.bluetoothStatus = BLE_STATUS_SCANNING;
    
    self.searchTool = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if (self.searchTool == NO) {
            

            
            
        }
        
        
    });
}

#pragma mark  查询电量
- (void)getMeasureUsingRGKTMessage
{
    char length = 0x03;
    char flag = 0x04;
    char sFlag = 0x04;
    char dat = 0x00;
    NSLog(@"======================查询电量");
    [self sendCommandToRGKTSphygmomanometerWithDataLength:length
                                                     Flag:flag
                                                    Sflag:sFlag
                                                      Dat:dat];
}

#pragma mark  开始测量
- (void)startMeasureUsingRGKTSphygmomanometer
{
    char length = 0x03;
    char flag = 0x01;
    char sFlag = 0x02;
    char dat = 0x00;
    NSLog(@"======================开始测量");
    [self sendCommandToRGKTSphygmomanometerWithDataLength:length
                                                     Flag:flag
                                                    Sflag:sFlag
                                                      Dat:dat];
}
#pragma mark - 停止测量
- (void)stopMeasureUsingRGKTSphygmomanometer
{
  
    char length = 0x03;
    char flag = 0x01;
    char sFlag = 0x03;
    char dat = 0x00;
    NSLog(@"======================停止测量");
    [self sendCommandToRGKTSphygmomanometerWithDataLength:length
                                                     Flag:flag
                                                    Sflag:sFlag
                                                      Dat:dat];
}

#pragma mark 停止扫描蓝牙设备
-(void)stopScan
{
    NSLog(@"==============扫描停止==============================\n");
    self.isConnectedEquipt = 1;
    if(self.connectedPeripheral)
    {
        //清除外围连接
        [self.bluetoothCentralManager cancelPeripheralConnection:self.connectedPeripheral];
    }
    [self.bluetoothCentralManager stopScan];
}

#pragma mark - No.2 底层蓝牙握手
//- (void)connectDevice:(id)peripheral
//{
//    NSLog(@"==============底层蓝牙尝试握手==============================\n");
//    if (self.connectedPeripheral)
//    {
//        [self.bluetoothCentralManager cancelPeripheralConnection:self.connectedPeripheral];
//    }
//    [self.bluetoothCentralManager connectPeripheral:peripheral options:nil];
//    self.bluetoothStatus = BLE_STATUS_CONNECTING;
//    [self performSelector:@selector(handleConnectPeripheralTimeout:) withObject:peripheral afterDelay:3.0];
//}



#pragma mark 处理外围连接超时
- (void)handleConnectPeripheralTimeout:(CBPeripheral *)peripheral
{
    if (self.bluetoothStatus != BLE_STATUS_CONNECTED)
    {
        [self disconnectDevice:peripheral];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTICEKEYSTRING object:[self createNoticeDic:ISConnectTimeOut andValue:nil]];
    }
}


#pragma mark 底层蓝牙断开
- (void)disconnectDevice:(CBPeripheral *)peripheral
{
    NSLog(@"============底层蓝牙已断开==============================\n");
    [self.bluetoothCentralManager cancelPeripheralConnection:peripheral];
    self.bluetoothStatus = BLE_STATUS_SCANNING;
}

#pragma mark No.3 血压设备握手
-(void)connectToRGKTSphygmomanometer
{
    NSLog(@"==================连接到RGKT血压计\n\n\n");
    char length = 0x03;
    char flag = 0x01;
    char sFlag = 0x01;
    char dat = 0x00;
    NSLog(@"======================血压设备握手");
    [self sendCommandToRGKTSphygmomanometerWithDataLength:length Flag:flag Sflag:sFlag Dat:dat];
}

#pragma mark 发送命令RGKT血压计
- (void)sendCommandToRGKTSphygmomanometerWithDataLength:(char)length Flag:(char)flag Sflag:(char)sflag Dat:(char )dat
{
    int dataLength = 5 + length;
    unsigned char buffer[dataLength];
    unsigned char *pWrite = buffer;
    
    //前导码 2Byte
    memset(pWrite, RGKT_RequestStart, 1);
    //    pWrite += 2;
    pWrite ++;
    
    //
    memset(pWrite, RGKT_RequestSecond, 1);
    pWrite ++;
    
    //蓝牙版本 1Byte
    memset(pWrite, 0x02, 1);
    pWrite++;
    
    //数据长度 1Byte
    memset(pWrite, length, 1);
    pWrite++;
    
    //类型标识 1Byte
    memset(pWrite, flag, 1);
    pWrite++;
    
    //类型子码 1Byte
    memset(pWrite, sflag, 1);
    pWrite++;
    
    //数据/参数 1Byte
    memset(pWrite, dat, 1);
    pWrite++;
    
    //校验码 1Byte
    //    char fcs = buffer[1] ^ buffer[2];
    unsigned char fcs = 0;
    for (int i = 2; i < dataLength - 1; i++)
    {
        fcs = fcs ^ buffer[i];
    }
    memset(pWrite, fcs, 1);
    pWrite++;
    
    NSData *toWriteData = [NSData dataWithBytes:buffer length:sizeof(buffer)];
    NSLog(@"\n\n\n==============================发送命令:\n\n%@\n\n\n",toWriteData);
    //发送给外围设备 （将data写入外围设备）  CBCharacteristicWriteWithoutResponse
    if (self.writeCharateristic&&self.connectedPeripheral) {
            [self.connectedPeripheral writeValue:toWriteData forCharacteristic:self.writeCharateristic type:CBCharacteristicWriteWithResponse];
    }

}


#pragma mark - No.0.2 蓝牙设备检测
- (BOOL)updateBluetoothStatus:(CBCentralManagerState)state
{
    NSString *message;
    switch (state)
    {
        case CBCentralManagerStateUnsupported:
        {
            message = @"平台/硬件不支持蓝牙低能量";
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            message = @"这个应用程序未被授权使用蓝牙低能量";
            break;
        }
        case CBCentralManagerStatePoweredOff:
        {
            message = @"蓝牙未打开";
            self.bluetoothStatus = BLE_STATUS_PowerOff;
            break;
        }
        case CBCentralManagerStatePoweredOn:
        {
            self.bluetoothStatus = BLE_STATUS_PowerOn;
            NSLog(@"蓝牙已打开");
            return YES;
        }
        case CBCentralManagerStateUnknown:
        {
            message = @"中央管理器状态未知";
            break;
        }
        default:
            return NO;
    }
    
    NSLog(@"中央管理器状态: %@", message);
    
    return NO;
}

#pragma mark - 解析器接收的数据 (血压器连接)
- (void)parserReceivedData:(NSData *)data
{
    char *pData = (char *)[data bytes];
    int packageStart = (*pData++ + 256) % 256;
    int responseStart = (*pData++ + 256) % 256;
    if (packageStart == RGKT_ResponseStart && responseStart == RGKT_ResponseSecond)
    {
        //蓝牙版本（直接跳过）
        pData++;
        //数据长度
        int length = *pData++;
        //类型标识
        int commandID = *pData++;
        
        switch (commandID)
        {
            case RGKT_BloodMeasureCommand:
            {
                //血压测量操作
                [self parserBloodMeasureWithData:pData DataLength:length Data:data];
                break;
            }
            case RGKT_BloodMemoryCommand:
            {
                //血压记忆操作
                [self parserBloodMemoryWithData:pData DataLength:length];
                break;
            }
            case RGKT_GetInfo:
            {
                //获取设备信息
                [self getPower:pData DataLength:length];
                break;
            }
        }
    }
}

-(void)checkData:(NSData *)data
{
    sendState = YES;
    NSString *str = [data description];
    if ([str hasPrefix:@"<aa80"])
    {
        //包头
        NSLog(@"收到数据 是包头 上一条数据：%@ 本次数据：%@",joiningData,data);
        sendState = NO;
        [self doPRData];
        sendState = YES;
        if (joiningData)
        {
            //上一条数据有保留  发送上一条数据 保留本次数据
            NSLog(@"1发送数据：%@",joiningData);
            [self parserReceivedData:joiningData];
            joiningData =[NSMutableData dataWithData:data];
        }else
        {
            //上一条数据没有保留 保留本次数据等待下一条数据
            NSLog(@"上一条数据没有保留 保留本次数据等待下一条数据  启动第2个定时器  上一条数据：%@ 本次数据：%@",joiningData,data);
            joiningData = [NSMutableData dataWithData:data];
            sendState = NO;
            [self performSelector:@selector(doPRData) withObject:nil afterDelay:1];
        }
    }else
    {
        //包尾
        NSLog(@"收到数据 是包尾");
        if (joiningData)
        {
            //上一条数据有保留  本次数据拼接上一次数据 等待下一次数据
            NSLog(@"上一条数据有保留  本次数据拼接上一次数据 等待下一次数据 启动第3个定时器  上一条数据：%@ 本次数据：%@",joiningData,data);
            [joiningData appendData:data];
            sendState = NO;
            [self performSelector:@selector(doPRData) withObject:nil afterDelay:1];
        }
    }
}

-(void)doPRData
{
    if (!sendState&&joiningData)
    {
        NSLog(@"定时器发送数据：%@",joiningData);
        [self parserReceivedData:joiningData];
        joiningData = nil;
    }
}


#pragma mark - 血压测量操作
- (void)parserBloodMeasureWithData:(char *)pData DataLength:(int)dataLength Data:(NSData *)data
{
    int subCommandID = *pData++;
    switch (subCommandID)
    {
        case RGKT_ConnectSphygmomanometer:
        {
            //解析连接到血压计数据
            [self parserConnectToRGKTSphygmomanometerWithLength:dataLength Data:pData];
            break;
        }
        case RGKT_StartMeasure:
        {
            //解析判断血压计开始测量状态
            [self parserStartMeasureUsingRGKTSphygmomanometerWithLength:dataLength Data:pData];
            break;
        }
        case RGKT_StopMeasure:
        {
            break;
        }
        case RGKT_PowerOff:
        {
            break;
        }
        case RGKT_SendMeasureData:
        {
            //获取实时测量数据
            [self parserRGKTMeasureReceiveDataWithLength:dataLength Data:pData];
            break;
        }
        case RGKT_SendMeasureResult:
        {
            //获取测量结果数据
            if (data.length!=20)
            {
                //[GeneralManager failureAlert:@"测量结果异常，请重新测量"];
                
                return;
            }
            [self parserRGKTMeasureResultWithLength:dataLength Data:pData];
            break;
        }
        case RGKT_SendWrongMessage:
        {
            //测量途中发生错误
            [self getWrongMessageWithLength:dataLength Data:pData];
            break;
        }
    }
}


#pragma mark  解析连接到血压计数据
- (void)parserConnectToRGKTSphygmomanometerWithLength:(int)length Data:(char *)data
{
    int status = *data++;
    if (status == RGKT_ResponseSucceed)
    {
        NSLog(@"\n\n\n==============================连接到RGKT血压计成功\n\n\n");
        [[NSNotificationCenter defaultCenter] postNotificationName:StartMeasureUsingRGKTSphygmomanometerSucceed
                                                            object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:ConnectToRGKTSphygmomanometerSucceed object:[self createNoticeDic:ISConnectDeviceSuccess andValue:nil]];
    }
    else if (status == RGKT_ResponseFailed)
    {
        NSLog(@"\n\n\n==============================连接到RGKT血压计失败了\n\n\n");
//        [[NSNotificationCenter defaultCenter] postNotificationName:ConnectToRGKTSphygmomanometerFailed object:[self createNoticeDic:ISConnectDeviceError andValue:nil]];
    }
}

#pragma mark  解析判断血压计开始测量状态
- (void)parserStartMeasureUsingRGKTSphygmomanometerWithLength:(int)length Data:(char *)data
{
    int status = *data++;
    if (status == RGKT_ResponseSucceed)
    {
        NSLog(@"\n\n\n==============================开始测试纯真RGKT血压计成功\n\n\n");
//                [[NSNotificationCenter defaultCenter] postNotificationName:StartMeasureUsingRGKTSphygmomanometerSucceed
//                                                                    object:nil];
    }
    else if (status == RGKT_ResponseFailed)
    {
        NSLog(@"\n\n\n==============================开始测量使用RGKT血压计失败了\n\n\n");
                [[NSNotificationCenter defaultCenter] postNotificationName:StartMeasureUsingRGKTSphygmomanometerFailed object:nil];
    }
}

#pragma mark 获取实时测量数据
- (void)parserRGKTMeasureReceiveDataWithLength:(int)length Data:(char *)data
{
    NSMutableString* hexString = [NSMutableString string];
    
    unsigned char *cdata = (unsigned char*)data;
    
    for (int i=0; i < length; i++)
    {
        [hexString appendFormat:@"%02x", *cdata++];
    }
    
    NSString * strA = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString * strB = [hexString substringWithRange:NSMakeRange(8, 2)];
    
    unsigned long valueA = strtoul([strA UTF8String],0,16);
    unsigned long valueB = strtoul([strB UTF8String],0,16);
    
    int a =((int)(valueA&0xff))*256 +((int)(valueB&0xff));
    //  NSLog(@"%d",a);
    NSLog(@"\n\n\n==============================获取测量数据%d\n\n\n",a);
    [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedRGKTSphygmomanometerMeasureData object:[NSString stringWithFormat:@"%d",a]];
}

#pragma mark 获取测量结果数据
- (void)parserRGKTMeasureResultWithLength:(int)length Data:(char *)data
{
    //用户信息
    UInt8 userInfo = *data++;
    UInt8 heartAtriumShake = userInfo & 32;
    UInt8 heartRateIrregular = userInfo & 16;
    //年
    int year = *data++ + 2000;
    //月
    int month = *data++;
    //日
    int day = *data++;
    //时
    int hour = *data++;
    //分
    int minute = *data++;
    //秒
    int second = *data++;
    //收缩压
    UInt8 firstHighPressure = *data++;
    UInt8 secondHighPressure = *data++;
    int highPressure = firstHighPressure * 16 + secondHighPressure;
    //舒张压
    UInt8 firstLowPressure = *data++;
    UInt8 secondLowPressure = *data++;
    int lowPressure = firstLowPressure * 16 + secondLowPressure;
    //脉搏
    UInt8 firstHeartRate = *data++;
    UInt8 secondHeartRate = *data++;
    int heartRate = firstHeartRate * 16 + secondHeartRate;
    
    BOOL has = (heartAtriumShake == 32) ? YES : NO;
    BOOL hri =   (heartRateIrregular == 16) ? YES : NO;
    
    
    self.measuredResults_Dic = @{HeartAtriumShake:[NSString stringWithFormat:@"%d",has],
                                 HeartRateIrregular:[NSString stringWithFormat:@"%d",hri],
                                 IsHealth:[NSString stringWithFormat:@"%d",has&&hri],
                                 HighPressure:[NSString stringWithFormat:@"%d",highPressure],
                                 LowPressure:[NSString stringWithFormat:@"%d",lowPressure],
                                 DifferencePressure:[NSString stringWithFormat:@"%d",highPressure - lowPressure],
                                 HeartRate:[NSString stringWithFormat:@"%d",heartRate]
                                 };
    [self stopMeasureUsingRGKTSphygmomanometer];
    self.jumpCountIndex = 1 ;
    NSLog(@"\n\n\n==============================获取测量结果数据%@\n\n\n",self.measuredResults_Dic);
    [[NSNotificationCenter defaultCenter]postNotificationName:ReceivedRGKTSphygmomanometerMeasureResult object:[self createNoticeDic:ISGetResultsData andValue:self.measuredResults_Dic]];
}

#pragma mark 测量途中发生错误
- (void)getWrongMessageWithLength:(int)length Data:(char *)data
{
    NSLog(@"\n\n\n==============================测量中途发生错误\n\n\n");
    self.jumpCountIndex = 1 ;
    [[NSNotificationCenter defaultCenter] postNotificationName:GetWrongMessage object:[self createNoticeDic:ISMeasurementError andValue:nil]];
}


#pragma mark - 血压记忆操作（并无实际操作）
- (void)parserBloodMemoryWithData:(char *)pData DataLength:(int)dataLength
{
    int subCommandID = *pData++;
    switch (subCommandID)
    {
        case RGKT_StartMemoryQuary:
        {
            break;
        }
        case RGKT_MemoryDelete:
        {
            break;
        }
        case RGKT_SendMemoryData:
        {
            break;
        }
        case RGKT_SendMemoryDataEnd:
        {
            break;
        }
    }
}

#pragma mark - 获取设备信息
- (void)getPower:(char *)pData DataLength:(int)dataLength
{
    int subCommandID = *pData++;
    switch (subCommandID)
    {
        case RGKT_GetPower:
        {
            //获取电量
            [self getPowerWithLength:dataLength Data:pData];
            break;
        }
    }
}

#pragma mark - 获取电量
- (void)getPowerWithLength:(int)length Data:(char *)data
{
    
    UInt8 firstPower = *data++;
    UInt8 secondPower = *data++;
    int power = firstPower * 256 + secondPower;
    
    

    NSString *powerStr = [NSString stringWithFormat:@"%d",power];
    NSLog(@"\n\n\n==============================获取电量\n\n\n");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BluetoothDidPowerLow" object:powerStr];
    
}
/*
 -(UInt16) swap:(UInt16)s {
 UInt16 temp = s << 8;
 temp |= (s >> 8);
 return temp;
 }
 */

#pragma mark - 代理方法
#pragma mark - CBCentralManagerDelegate
#pragma mark No.0.1 中央管理器更新状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [self updateBluetoothStatus:[central state]];
}
#pragma mark No.1.1 搜索外围设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //过滤搜索到的设备
    NSString *temp = peripheral.name;////RBP1708040566maibobo
     NSLog(@"\n\n\n==============================过滤之后搜索到peripheral.name%@\n\n\n",peripheral.name );
    if ([temp hasPrefix:@"RBP"] || [temp hasPrefix:@"BP"])
    {
        if (![self.scanDeviceListArr containsObject:peripheral])
        {
            [self.scanDeviceListArr addObject:peripheral];
        }
         NSLog(@"\n\n\n==============================过滤之后搜索到的设备%@\n\n\n",self.scanDeviceListArr );
        [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothDidRefreshDevicesList object:self.scanDeviceListArr ];
        if (self.isConnectedEquipt!=2) {
               NSLog(@"\n\n\n===========================");
                [self.bluetoothCentralManager stopScan];
        }
//          [self connectDevice:peripheral];
    }
    if (self.isConnectedEquipt == 2) {
        [central connectPeripheral:peripheral options:nil];
    }
    self.searchTool = YES;

}

#pragma mark No.2.2 蓝牙低层握手连接 扫描外设中的服务和特征
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    
   self.isConnectedEquipt = 1;
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
//      [[NSNotificationCenter defaultCenter] postNotificationName:BluetoothDidConnectToDevice object:peripheral.name];
    //停止搜索
    [self.bluetoothCentralManager stopScan];
    //获取外围对象并设备代理方法
    self.connectedPeripheral = peripheral;
    [peripheral setDelegate:self];
    //设置蓝牙管理器状态
    self.bluetoothStatus = BLE_STATUS_CONNECTED;
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [peripheral discoverServices:nil];
    
//     [self connectToRGKTSphygmomanometer];
    
}

#pragma mark - CBPeripheralDelegate
#pragma mark 外围设备得到服务（请求）状态
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (!error)
    {
        for (CBService *service in peripheral.services)
        {
            NSLog(@"=================接收到外围服务的UUID: \n%@\n", service.UUID);
            //外围设备得到具体请求服务
            //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)erro
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
    else
    {
        NSLog(@"===================发生错误:%@\n",error);
    }
}

#pragma mark 获得外围服务写入特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (!error)
    {
//        for (CBCharacteristic *c in service.characteristics) {
//            NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,c.UUID);
//            NSLog(@"characteristic的properties:%zi",c.properties);
//            for (CBCharacteristic *characteristic in service.characteristics)
//            {
//                NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
//                NSLog(@"characteristic的properties:%zi",c.properties);
//            }
//            if (c.properties == 48||c.properties == 16) {   //读,  包含RB开头设备和BP开头蓝牙设备
//                NSLog(@"返回");
//                //订阅特性的值时，在值改变时，我们会从peripheral对象收到通知
//                [peripheral setNotifyValue:YES forCharacteristic:c];
//                
//                NSLog(@"\n\n\n==============================获得外设的写入特征peripheral:%@\n\n\n",peripheral);
//            }else if (c.properties == 12) {    //写
//                // 拿到特征,和外围设备进行交互   保存写的特征
//                NSLog(@"写入");
//                self.writeCharateristic = c;
//                NSLog(@"\n\n\n==============================获得外设的写入特征Charateristic:%@\n\n\n",self.writeCharateristic);
//                
//            }
//        }
                for (CBCharacteristic *c in service.characteristics)
                {
                   // NSLog(@"-----%@ ",c);
                    for (CBCharacteristic *characteristic in service.characteristics)
                    {
//                        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
                    }
        
                    if ([c.UUID isEqual:[CBUUID UUIDWithString:@"1001"]]||[c.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]])
                    {
                        NSLog(@"写入");
                        self.writeCharateristic = c;
//                         NSLog(@"\n\n\n==============================获得外设的写入特征Charateristic:%@\n\n\n",self.writeCharateristic);
                    }else if([c.UUID isEqual:[CBUUID UUIDWithString:@"1002"]]||[c.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]])
                    {
                        NSLog(@"返回");
                        //订阅特性的值时，在值改变时，我们会从peripheral对象收到通知
                        [peripheral setNotifyValue:YES forCharacteristic:c];
                        [self connectToRGKTSphygmomanometer];
//                         NSLog(@"\n\n\n==============================获得外设的写入特征peripheral:%@\n\n\n",peripheral);
                    }
                }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICEKEYSTRING object:[self createNoticeDic:ISBluetoothConnectDone andValue:nil]];
    }else
    {
        //  蓝牙低层握手失败
        NSLog(@"\n\n\n==============================蓝牙低层握手失败\n\n\n");
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICEKEYSTRING object:[self createNoticeDic:ISBluetoothConnectError andValue:nil]];
    }
}
#pragma mark 接收设备（血压计）握手数据（与外设做数据交互（读写））
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error changing notification state: %@", [error localizedDescription]);
    }
    if (self.jumpCountIndex == 1) {
         [self startMeasureUsingRGKTSphygmomanometer];
        self.jumpCountIndex++;
    }
   
    NSLog(@"=================接收设备（血压计）握手数据：%@----------",characteristic.value);
    if(characteristic.value)
    {
        //解析器接收的数据 (血压器连接)
        [self checkData:characteristic.value];
    }
    
}

//并断开外围设备
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    NSLog(@"===============断开外围设备-==========-------");
   // [self startScan];
    self.jumpCountIndex = 1;
    [[NSNotificationCenter defaultCenter]postNotificationName:BluetoothDidDisConnectToDevice object:[self createNoticeDic:ISConnectTimeOut andValue:error]];
}

@end
