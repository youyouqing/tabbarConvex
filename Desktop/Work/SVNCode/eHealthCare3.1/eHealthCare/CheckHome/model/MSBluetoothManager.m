//
//  MSBluetoothManager.m
//  ThermometerDemo
//
//  Created by xubin luo on 14-4-30.
//  Copyright (c) 2014年 Coolball. All rights reserved.
//

#import "MSBluetoothManager.h"
//#import "TKAlertCenter.h"
#define SCACN_INTERVALS 1.5


@interface MSBluetoothManager()
@property BOOL cbReady;
@property (nonatomic,strong) CBCentralManager *cbCM;
@property (strong,nonatomic) NSMutableArray *nDevices;
@property (strong,nonatomic) NSMutableArray *nServices;
@property (strong,nonatomic) NSMutableArray *nCharacteristics;

@property (strong,nonatomic) CBPeripheral *cbPeripheral;
@property (strong,nonatomic) CBCharacteristic *cbCharacteric;
@end



@implementation MSBluetoothManager

+(MSBluetoothManager*)shareInstance
{
    static dispatch_once_t pred = 0;
    __strong static MSBluetoothManager *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


#pragma mark -对外接口
/**
 *  开始扫描
 */
-(void)startScan
{
     self.recDataStr=@"";
    if(_bluetoothPowerOn)
    {
        if( !_cbReady   )
        {
            [self updateLog:@"Scan for Peripheral..."];
            [_cbCM scanForPeripheralsWithServices:nil options:nil];
            
            //        [self performSelector:@selector(startScan) withObject:nil afterDelay:SCACN_INTERVALS];
        }
    }
    else
    {
        //弹框提示，请去系统中打开蓝牙
        NSLog(@"未打开蓝牙");
        
    }
    
}

/**
 *  停止扫描
 */
-(void)stopScan
{
    [self updateLog:@"stop scan..."];
    [_cbCM stopScan];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScan) object:nil];
}

/**
 *  连接
 */
-(void)startconnect
{
    if (_cbReady ==false)
    {
        NSLog(@"开始连接");
        [self.cbCM connectPeripheral:_cbPeripheral options:nil];
    }
}

/**
 *  取消连接
 */
-(void)cancelConnect
{
    if(_cbReady)
    {
        NSLog(@"取消连接");
        [_cbCM cancelPeripheralConnection:_cbPeripheral];
    }
    
}


/**
 *  向设备写数据
 */
-(BOOL)writeData:(NSData*)data
{
    BOOL ret = NO;
    if([data length] >0)
    {
        [self writeCharacteristic:_cbPeripheral sUUID:MySUUID cUUID:MyCUUID data:data];
        ret = YES;
    }

    return ret;
}


/**
 *  是否可以准备好写数据
 *
 *  @return 是否可以准备好写数据
 */
-(BOOL)isReady
{
    return _cbReady;
}

/**
 *  发送命令
 *
 *  @param command 命令内容
 *
 *  @return 是否发送成功
 */
-(BOOL)sendCommand:(EN_CommandType)command
{
    NSLog(@"begin send command:%d",command);
    BOOL ret  = NO;
    if([self isReady])
    {
        unsigned char data [6]= {0};
        data[0] = 0xa5;
        *(data+1) = 0x01;
        *(data+2) = 0x01;

        switch (command) {
            case EN_Command_Start:
            {
               
            }
                break;
            case EN_Command_Stop:
            {
                command = 0x00;
            }
                break;
            case EN_Command_Mode1:
                break;
            case EN_Command_Mode2:
                break;
            case EN_Command_Mode3:
                break;
            case EN_Command_Mode4:
            case EN_Command_Mode5:
            case EN_Command_Mode6:
            case EN_Command_Mode7:
            case EN_Command_Mode8:
            case EN_Command_Mode9:
            {
//                datastr = [NSString stringWithFormat:@"%d",command];
            }
                break;
            case EN_Command_Shutdown:
            {
                command = 0x5a;
            }
            default:
                break;
        }
        
        NSLog(@"send command:%d",command);
        
 
        
        *(data+3) = command;
        

        NSData *nsdata = [NSData dataWithBytes:data length: sizeof(char)*6];
        
        NSLog(@"send data: %@",nsdata);
        //真正发送命令
        ret = [self writeData:nsdata];
    }
    return ret;
}



#pragma mark -CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            [self updateLog:@"CoreBluetooth BLE hardware is Powered off"];
            //对外抛出断开连接的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDisconnected object:nil];
            _cbReady = FALSE;
            _bluetoothPowerOn = FALSE;
            break;
        case CBCentralManagerStatePoweredOn:
            [self updateLog:@"蓝牙可用"];
            _bluetoothPowerOn = YES;
            break;
            //cbReady = true;
        case CBCentralManagerStateResetting:
//            _cbReady = FALSE;
            [self updateLog:@"CoreBluetooth BLE hardware is resetting"];
            break;
        case CBCentralManagerStateUnauthorized:
            
            [self updateLog:@"CoreBluetooth BLE state is unauthorized"];
//            _cbReady = FALSE;
            
            break;
        case CBCentralManagerStateUnknown:
            
            [self updateLog:@"蓝牙类型未知"];
            break;
        case CBCentralManagerStateUnsupported:
//            _cbReady = FALSE;
            [self updateLog:@"该设备不支持蓝牙"];
            break;
        default:
            break;
    }
}


//已发现从机设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
   
    [self updateLog:[NSString stringWithFormat:@"发现设备peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.identifier, advertisementData]];

     NSLog(@"adVpersincalName---*********-----%@",self.adVpersincalName);
       
        if ([peripheral.name containsString:self.adVpersincalName]) {
           
            [_nDevices addObject:peripheral];
            [self updateLog:@"查找到我要的设备！\r\n"];
            
            _cbPeripheral = peripheral;
            [self stopScan];//停止扫描
           
        }
        
//    }
    if(_cbPeripheral)
    {
        self.searchtTool = YES;
        //对外抛出连接的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSearch object:@[_cbPeripheral]];
        
        if (self.conntiontTool == YES) {
            //开始连接
            if ([_cbPeripheral.name containsString:self.adVpersincalName]){
              [self startconnect];
            
           }
        }

     
    }
    else
    {
       [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationconnectedFail object:nil];
    }
}


//已链接到从机
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    
    //取消重连
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScan) object:nil];
    
    [self updateLog:[NSString stringWithFormat:@"已经连接Connection successfull to peripheral: %@ with UUID: %@",peripheral,peripheral.identifier]];
    //Do somenthing after successfull connection.
    
    //发现services
    //设置peripheral的delegate未self非常重要，否则，didDiscoverServices无法回调
    peripheral.delegate = self;
    [_cbPeripheral discoverServices:nil];
    _cbReady = true;
    [self updateLog:@"didConnectPeripheral"];
    
    //对外抛出连接的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationConnected object:@[_cbPeripheral]];
    
    //统计
//    [AVAnalytics event:@"ConnectToHardWare"];
   
}


//已断开从机的链接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [self updateLog:[NSString stringWithFormat:@"丢失了连接Disconnected from peripheral: %@ with UUID: %@",peripheral,peripheral.identifier]];
    //Do something when a peripheral is disconnected.
    _cbReady = false;
    
    //对外抛出断开连接的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDisconnected object:nil];
    
    //统计
//    [AVAnalytics event:@"DisconnectToHardWare"];
    
    //尝试重连
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self startScan];
//        });
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    
    NSLog(@"连接失败");
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationconnectedFail object:nil];
}

- (void) centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals {
    
    [self updateLog:[NSString stringWithFormat:@"Currently connected peripherals :"]];
    int i = 0;
    for(CBPeripheral *peripheral in peripherals) {
        [self updateLog:[NSString stringWithFormat:@"[%d] - peripheral : %@ with UUID : %@",i,peripheral,peripheral.identifier]];
        i++;
        //Do something on each connected peripheral.
    }
    
}

- (void) centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals {
    
    [self updateLog:[NSString stringWithFormat:@"Currently known peripherals :"]];
    int i = 0;
    for(CBPeripheral *peripheral in peripherals) {
        
        [self updateLog:[NSString stringWithFormat:@"[%d] - peripheral : %@ with UUID : %@",i,peripheral,peripheral.identifier]];
        i++;
        //Do something on each known peripheral.
    }
}

//delegate of CBPeripheral
//已搜索到services
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    [self updateLog:@"已经搜索到Found Services."];
    
    int i=0;
    for (CBService *s in peripheral.services) {
        
        [self.nServices addObject:s];
        
    }
    
    
    for (CBService *s in peripheral.services) {
        [self updateLog:[NSString stringWithFormat:@"%d :Service UUID: %@(%@)",i,s.UUID.data,s.UUID]];
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
    }
}




#pragma mark -CBPeripheralDelegat

//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    [self updateLog:[NSString stringWithFormat:@"Found Characteristics in Service:%@ (%@)",service.UUID.data ,service.UUID]];
    
    for (CBCharacteristic *c in service.characteristics) {
        [self updateLog:[NSString stringWithFormat:@"Characteristic UUID: %@ (%@)",c.UUID.data,c.UUID]];
        [_nCharacteristics addObject:c];
        NSLog(@"didDiscoverCharacteristicsForService%@",c.value);
        
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:MyCUUID]])
//        {
//            
//            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:MyCUUID]])
//            {
            
                
                [peripheral readValueForCharacteristic:characteristic];
                
                [peripheral discoverDescriptorsForCharacteristic:characteristic];
                
        self.cbCharacteric = characteristic;
        
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        
        
        
        
    }

}

//普通字符串转换为十六进制的。
- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error;
{
    
    NSLog(@"didUpdateNotificationStateForCharacteristic");
    if (characteristic.value == NULL) {
        //自动重连
        [self.cbPeripheral autoContentAccessingProxy];
        return;
    }
//处理蓝牙指令返回的数据
    
    CBCharacteristicProperties properties = characteristic.properties;
    if (properties & CBCharacteristicPropertyRead) {
        //如果具备读特性，即可以读取特性的value
        [peripheral readValueForCharacteristic:characteristic];
    }
}



//已读到char  读取到数据
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        return;
    }
    // 解析数据
    NSData *data = characteristic.value;
    
    // 将NSData转Byte数组
    NSUInteger len = [data length];
    Byte *byteData = (Byte *)malloc(len);
    memcpy(byteData, [data bytes], len);
    NSMutableArray *commandArray = [NSMutableArray arrayWithCapacity:0];
    // Byte数组转字符串
    for (int i = 0; i < len; i++) {
        NSString *str = [NSString stringWithFormat:@"%02x", byteData[i]];
        [commandArray addObject:str];
        NSLog(@"byteData = %@", str);
        

    }
    

//    [self updateLog:[NSString stringWithFormat:@"char update! [%ld:%ld:%ld],char = %d",(long)hour,minute,second,data[0]]];
    
    NSData * updatedValue = data;
    uint8_t* dataPointer = (uint8_t*)[updatedValue bytes];
    
    NSString *a = [NSString stringWithFormat:@"%s",dataPointer];
        
    NSLog(@"蓝牙：%@ %@---%@",_cbPeripheral,[NSString stringWithFormat:@"%s",dataPointer],data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              );
    
    if ([a isEqualToString:@"^000TbLo"]) {
        
    }else if ([a isEqualToString:@"^000TaLo"]){
    
    
    }
    else if ([a containsString:@"^0000"]&&[_cbPeripheral.name isEqualToString:@"HTD02"]  ){
        
        if ([self.delegate respondsToSelector:@selector(temperatureManagerToolSend:)]) {
            [self.delegate temperatureManagerToolSend:[NSString loadCharcterView:a startS:@"^0000" endS:@"C"]];
        }
        
    }
    else if ([a containsString:@"^0010"]&&[_cbPeripheral.name isEqualToString:@"HTD02"] ){
        
        if ([self.delegate respondsToSelector:@selector(temperatureManagerToolSend:)]) {
            [self.delegate temperatureManagerToolSend:[NSString loadCharcterView:a startS:@"^0010" endS:@"C"]];
        }
        
    }
    else if ([a containsString:@"^0000"]&&[_cbPeripheral.name isEqualToString:@"HC-08"]  ){
        
        if ([self.delegate respondsToSelector:@selector(temperatureManagerToolSend:)]) {
            [self.delegate temperatureManagerToolSend:[NSString loadCharcterView:a startS:@"^0000" endS:@"C"]];
        }
        
    }
    else if ([a containsString:@"^0010"]&&[_cbPeripheral.name isEqualToString:@"HC-08"]  ){
        
        if ([self.delegate respondsToSelector:@selector(temperatureManagerToolSend:)]) {
            [self.delegate temperatureManagerToolSend:[NSString loadCharcterView:a startS:@"^0010" endS:@"C"]];
        }
        
    }
    else if ([_cbPeripheral.name isEqualToString:@"CardioChek-333E"]  ){
        //[a containsString:@"mmol/L"]&&
        
        self.recDataStr=[self.recDataStr stringByAppendingFormat:@"%s",dataPointer];
        NSString *empthyEndStr =  [NSString stringWithFormat:@"%s",dataPointer];
        NSLog(@"empthyEndStr:%@",empthyEndStr);//0000 0000  4个回车换行  \r\n\r\n\r\n\r\n
        NSLog(@"data.description:%@",data.description);
        if ([data.description isEqualToString:@"<00000000>"])
       // if ([data isEqualToData:[@"00000000" dataUsingEncoding:NSUTF8StringEncoding]])
        {
            NSLog(@"self.recDataStr:%@",self.recDataStr);
            
          
                
                if ([self.recDataStr containsString:@"CHOL"]) {
                      if ([self.delegate respondsToSelector:@selector(resultManagerToolSend:)]) {
                    NSArray *resultArr =  [self BreakCharacterWithString:self.recDataStr];
                    
                          NSString *CHOL = resultArr[0];
                          NSString *TRIG = resultArr[2];
                          NSString *CALC = resultArr[4];//3
                          NSString *HDL = resultArr[1];//  4
                          //                      resultManagerToolSend:{
                          //                          CALC = "1.70";
                          //                          CHOL = "3.76";
                          //                          HDL = "1.7";
                          //                          TRIG = "2.16";
                          //                      }
                          /*    Chol = "3.47";总胆固醇
                           HDL = "2.59"; 高密度脂蛋白
                           LDL = "1.81";低密度脂蛋白
                           Mobile = 15970682406;
                           Token = e530fa07bf1253022a192477621e6f43;
                           Triglycerides = 0;甘油三脂
                           }*/
                          
                          if (HDL != nil) {

                        [self.delegate resultManagerToolSend:@{@"CHOL":CHOL,@"TRIG":TRIG,@"CALC":CALC,@"HDL":HDL}];
                    }

                }
                
                
            }

        }
        
        
    }
    

}
-(NSArray *)BreakCharacterWithString:(NSString *)string{
    
    
    NSString *hahah = string;// @"VER:2.25\r\nCHOL:3.81mmol/L\r  \nASD:2.96\r\nPH:2.29mmol/L\r\nHLH:2.22mmol/L\r\nHLH:";
    hahah = [hahah stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray * arr11 = [hahah componentsSeparatedByString:@"\r\n"];
    
    
    NSMutableArray *result_arr = [NSMutableArray array];
    BOOL flag = false;
    for(NSString *str11  in  arr11){
         NSLog(@"cardiok3eee----%@",str11);
        if ([str11 containsString:@"CHOL:"]) {
            flag = true;
        }
        if (!flag) {
            continue;
        }
        NSString *res_str = str11;
        if ([str11 containsString:@"mmol/L"]) {
            res_str = [str11 stringByReplacingOccurrencesOfString:@"mmol/L" withString:@""];
        }
        res_str = [[res_str componentsSeparatedByString:@":"]lastObject];
        
        
        if ([res_str containsString:@">"]) {
            res_str = [res_str stringByReplacingOccurrencesOfString:@">" withString:@""];
        }
        if ([res_str containsString:@"<"]) {
            res_str = [res_str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        }
         NSLog(@"res_str%@",res_str);
        [result_arr addObject:res_str];
    }
    NSLog(@"%@",result_arr);
    return result_arr;
    
    
}
/**
 十六进制转换为二进制
 
 @param hex 十六进制数
 @return 二进制数
 */
-(NSString *)getBinaryByHex:(NSString *)hex {
    
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}

/**
 二进制转换为十进制
 
 @param binary 二进制数
 @return 十进制数
 */
- (NSInteger)getDecimalByBinary:(NSString *)binary {
    
    NSInteger decimal = 0;
    for (int i=0; i<binary.length; i++) {
        
        NSString *number = [binary substringWithRange:NSMakeRange(binary.length - i - 1, 1)];
        if ([number isEqualToString:@"1"]) {
            
            decimal += pow(2, i);
        }
    }
    return decimal;
}


+ (NSData *)convertStringToHex:(NSString *)tmpid {
    // 将十进制转化为十六进制
    //http://www.jianshu.com/p/a5e25206df39
    //http://blog.csdn.net/weasleyqi/article/details/8048918
    NSString *nLetterValue;
    NSString *str =@"";
    int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid.intValue % 16;
        tmpid = [NSString stringWithFormat:@"%d", (tmpid.intValue) / 16];
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid.intValue == 0) {
            break;
        }
    }
    // 不够一个字节凑0
    if(str.length == 1){
        str = [NSString stringWithFormat:@"0%@",str];
    }

    
    //[iOS中的WiFi与硬件通信](http://www.jianshu.com/p/bcb104f8b8e9 )
    NSMutableData *data = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    if (str.length%2) {
        // 防止丢失半个byte
        str = [@"0" stringByAppendingString:str];
    }
    int i;
    for (i = 0; i < [str length]/2; i++) {
        byte_chars[0] = [str characterAtIndex:i * 2];
        byte_chars[1] = [str characterAtIndex:i * 2 + 1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    //data
    return data;
}


- (void)sendDataToBluetooth:(NSData *)sendData {
    
    NSLog(@"发送到蓝牙设备的数据:  %@  ", sendData);
    // 发送数据
    [self.cbPeripheral writeValue:sendData forCharacteristic:self.cbCharacteric type:CBCharacteristicWriteWithoutResponse];
    // 订阅通知
    [self.cbPeripheral setNotifyValue:YES forCharacteristic:self.cbCharacteric];
}

#pragma mark -内部函数
-(id)init
{
    if(self = [super init])
    {
        _cbCM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        _cbServices =[CBService new];
        _cbCharacteristcs =[CBCharacteristic new];
        
        //列表初始化
        _nDevices = [[NSMutableArray alloc]init];
        _nServices = [[NSMutableArray alloc]init];
        _nCharacteristics = [[NSMutableArray alloc]init];
        
        _cbReady = FALSE;
        _bluetoothPowerOn = FALSE;
        
    }
    return self;
}



-(void)updateLog:(NSString *)s
{
    //用回NSLog，
    NSLog(@"%@",s );

}




-(void)writeCharacteristic:(CBPeripheral *)peripheral sUUID:(NSString *)sUUID cUUID:(NSString *)cUUID data:(NSData *)data {
    // Sends data to BLE peripheral to process HID and send EHIF command to PC
    for ( CBService *service in peripheral.services ) {
        
        if ([service.UUID isEqual:[CBUUID UUIDWithString:sUUID]]) {
            
            for ( CBCharacteristic *characteristic in service.characteristics ) {
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cUUID]]) {
                    [self updateLog:@"has reached\r\n"];
                    /* EVERYTHING IS FOUND, WRITE characteristic ! */
                    
                    [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
                    
                }
            }
        }
    }
}


-(void)setNotificationForCharacteristic:(CBPeripheral *)peripheral sUUID:(NSString *)sUUID cUUID:(NSString *)cUUID enable:(BOOL)enable {
    for ( CBService *service in peripheral.services ) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:sUUID]]) {
            for (CBCharacteristic *characteristic in service.characteristics ) {
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cUUID]])
                {
                    /* Everything is found, set notification ! */
                    [peripheral setNotifyValue:enable forCharacteristic:characteristic];
                }
                
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error

{
    
    [self updateLog:[NSString stringWithFormat:@"%@",error]];
    
    if (error) {
        
        NSLog(@"%s, line = %d, erro = %@",__FUNCTION__,__LINE__,error.description);
        
    }
    
}


@end
