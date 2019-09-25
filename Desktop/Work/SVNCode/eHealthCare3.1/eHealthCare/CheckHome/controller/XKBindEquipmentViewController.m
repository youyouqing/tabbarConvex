//
//  XKBindEquipmentViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBindEquipmentViewController.h"
#import "XKShopUrlViewController.h"
@class XKEquiptBindTableViewCell;
@interface XKBindEquipmentViewController ()<UITableViewDelegate,UITableViewDataSource,XKSearchEquiptViewDelegate>
{

    NSInteger qinNiuTag;//标记青牛体脂秤链接状态
    
    LanYaSDK *maibobo;//脉搏波
    
    CBPeripheral* cb123;//爱奥乐
    BLEManager* _bleManager;
}
/**
 跳转一次
 */
@property (nonatomic,assign)NSInteger jumpCountIndex;


@property (weak, nonatomic) IBOutlet UITableView *tablView;


@property(strong,nonatomic)XKBindTopTitleView *topView;


@property (weak, nonatomic) IBOutlet UIWebView *webView;


@property (weak, nonatomic) IBOutlet UILabel *nameLab;

/**
 蓝牙连接状态
 */
@property (nonatomic,assign)NSInteger connectionStatus;
/**
 蓝牙工具 PC300 POD
 */
@property (nonatomic,strong)BluetoothConnectionTool *bc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@property (weak, nonatomic) IBOutlet UIImageView *equiptImage;
/**
 数据模型
 */
@property(strong,nonatomic)XKDeviceProductMod *productMod;
/**
 收缩图
 */
@property(strong,nonatomic)XKSearchEquiptView *searchEquipView;

@property (nonatomic,strong)NSArray *dataBigArray;



@property (nonatomic,strong) MSBluetoothManager *toothM;


/** 中心管理者 */
@property (nonatomic, strong) CBCentralManager *cMgr;
/** 连接到的外设 */
@property (nonatomic, strong) CBPeripheral *peripheral;
@end

@implementation XKBindEquipmentViewController
@synthesize state=_state;
@synthesize sendDataStr;
@synthesize recDataStr;
-(XKSearchEquiptView *)searchEquipView
{
    if (!_searchEquipView) {
        _searchEquipView = [[NSBundle mainBundle]loadNibNamed:@"XKSearchEquiptView" owner:self options:nil].firstObject;
        _searchEquipView.x = 0;
        _searchEquipView.y = 0;
        _searchEquipView.width = KScreenWidth;
        _searchEquipView.height = KScreenHeight;
        _searchEquipView.delegate = self;
    }
    return _searchEquipView;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.jumpCountIndex = 1;
   if ([self.model.BluetoothName isEqualToString:@"HTD02"]||[self.model.BluetoothName isEqualToString:@"HC-08"]||[self.model.BluetoothName containsString:@"CardioChek"])
    {
        
        [self.toothM stopScan];
        [self.toothM cancelConnect];
        
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _bleManager.delegate = self;
    
    _bleManager.isEncryption = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.jumpCountIndex = 1;
    self.topCons.constant = (PublicY);
    self.tablView.dataSource = self;
    
    self.tablView.estimatedSectionHeaderHeight = 151;
    
    self.tablView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tablView.delegate = self;

    self.tablView.estimatedRowHeight = KScreenHeight;
    
    self.tablView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tablView registerNib:[UINib nibWithNibName:@"XKBindGuideTableViewCell" bundle:nil] forCellReuseIdentifier:@"XKBindGuideTableViewCell"];
    
    
    
    //  去除滚动条webView
    self.webView.backgroundColor=[UIColor clearColor];
    for (UIView *_aView in [self.webView subviews])
    {
        if ([_aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                }
            }
        }
    }
    
    
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%li%i%@",@"XKDeviceProductMod",[UserInfoTool getLoginInfo].MemberID,self.style,self.model.ProductName]]) {
        NSDictionary *dic1 = (NSDictionary *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%li%i%@",@"XKDeviceProductMod",[UserInfoTool getLoginInfo].MemberID,self.style,self.model.ProductName]];
        
        [self loadDataWithDBOrRequest:dic1];
        
    }//网络环境差的情况下就本地数据
    [self loadData];

    self.searchEquipView.alpha = 0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.searchEquipView];
    

}
#pragma mark   脉搏波设备脉搏波血压
#pragma mark 搜索蓝牙设备 显示蓝牙名称
- (void)handleBluetoothDidRefreshDevicesList:(NSNotification *)notification
{
   NSArray *tempArr = (NSArray *)notification.object;
    NSLog(@"-handleBluetoothDidRefreshDevicesList---%@",tempArr);
    if (tempArr.count == 0) {
//        self.searchEquipView.style = XKLoadunLoadingStyle;
    }
    else
    {
        self.searchEquipView.dataBigArray = tempArr;
        self.searchEquipView.style = XKLoadDetectiStyle;
        [self.searchEquipView.equiptTabView reloadData];
    
    }
}

#pragma mark    普通蓝牙扫描上成功
- (void)notiConnected:(NSNotification *)notification{

    
    self.searchEquipView.dataBigArray = (NSArray *)notification.object;
    self.searchEquipView.style = XKLoadDetectiStyle;
    
     [self.searchEquipView.equiptTabView reloadData];

}


#pragma mark  BLE 体脂秤扫描绑定
- (void)scanDevice:(QingNiuDevice *)qingNiuDevice{
    if (qingNiuDevice.deviceState == QingNiuDeviceStatePoweredOff) {
        NSLog(@"关机");
    }else {
        NSLog(@"开机");
    }
    NSLog(@"%@",qingNiuDevice);
    if (_allScanDevice.count == 0) {
        [_allScanDevice addObject:qingNiuDevice];
        
        
       
        
    }else {
        for (int i = 0; i<_allScanDevice.count; i++) {
            QingNiuDevice *savedDevice = _allScanDevice[i];
            if ([savedDevice.macAddress isEqualToString:qingNiuDevice.macAddress]) {
                
                
                
                break;
            }else if (i == _allScanDevice.count - 1){
                [_allScanDevice addObject:qingNiuDevice];
                
                
              
                break;
            }
        }
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<_allScanDevice.count; i++) {
        QingNiuDevice *savedDevice = _allScanDevice[i];
       
        [tempArr addObject:savedDevice.peripheral];
        
            
            

    }
    if (tempArr.count>0) {
        self.searchEquipView.dataBigArray = (NSArray *)tempArr;
        self.searchEquipView.style = XKLoadDetectiStyle;
        [self.searchEquipView.equiptTabView reloadData];
    }else if (tempArr.count == 0)
    {
       
            self.searchEquipView.style = XKLoadunLoadingStyle;
       
    
    }
    _scanFlag = YES;
}

#pragma mark 再次扫描秤
- (void)scanBleAgain
{
    [self scanBle:qinNiuTag];
}
#pragma mark 扫描
- (void)scanBle:(NSInteger )tag
{
    if (tag == 1) {
   
    qinNiuTag = 2;
    [_allScanDevice removeAllObjects];
    
    __weak XKBindEquipmentViewController *weekSelf = self;
    [QingNiuSDK startBleScan:nil scanSuccessBlock:^(QingNiuDevice *qingNiuDevice) {
        [weekSelf scanDevice:qingNiuDevice];
    } scanFailBlock:^(QingNiuScanDeviceFail qingNiuScanDeviceFail) {
        NSLog(@"121212%ld",(long)qingNiuScanDeviceFail);
        if (qingNiuScanDeviceFail == QingNiuScanDeviceFailValidationFailure) {

            
            [QingNiuSDK registerApp:@"szxkwlkjyxgs2017061521" registerAppBlock:^(QingNiuRegisterAppState qingNiuRegisterAppState) {
                NSLog(@"andReleaseModeFlag%ld",(long)qingNiuRegisterAppState);
            }];
           
            [self searchFailQingNiuDevice];
                
        }
    }];
        }else {//申明：在实际开发过程当中，如果扫描到设备就连接的话，停止扫描方法可不调用，因为连接方法会停止扫描
          
            qinNiuTag = 1;
            [QingNiuSDK stopBleScan];
            [_allScanDevice removeAllObjects];
    
    
        }
}

/**爱奥乐停止搜索*/
- (void)stopScan {
    [_bleManager manualStopScanDevice];
    
    
}

/**爱奥乐搜索设备*/
- (void)scan {
     [_bleManager scanDeviceTime:60];
    
}
/**爱奥乐初始化*/
- (void)createData {
    _bleManager = [BLEManager defaultManager];
    _bleManager.delegate = self;
//        _deviceInfoManager = [NSArray array];
    _deviceArray = [[NSMutableArray alloc] init];
    [self performSelector:@selector(scan) withObject:nil afterDelay:4.0f];

     self.searchTool = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if (self.searchTool == NO) {
            
           [self searchFailAiAoLeDevice];
            
        }
        
        
    });
    
}

- (void)connect {
    if ( a >= _deviceArray.count) {
        a = 0;
    }
    _bleManager.isEncryption = NO;
    if (_deviceArray.count > 0) {
        
         self.searchTool = YES;
        TTCDeviceInfo* info = _deviceArray[a];
        CBPeripheral* cb = [_bleManager getDeviceByUUID:info.UUIDString];
        if (![_bleManager readDeviceIsConnect:cb]) {
            
            
             cb123 = cb;//不链接
            
        }
    }
}

#pragma mark - BLeManager Delegate爱奥乐设备
- (void)scanDeviceRefrash:(NSMutableArray *)array {
    [_deviceArray removeAllObjects];
    
     NSMutableArray *perialArr = [NSMutableArray array];
    for (TTCDeviceInfo* info in array) {

        //得到想要连接的设备
        if ([info.localName containsString:self.model.BluetoothName]) {//BLE#0x44A6E5077A74
//            //停止扫描
            [_bleManager manualStopScanDevice];
//            //开始连接
//            [_bleManager startAutoConnect:@[info.cb]];
             self.searchTool = YES;
            self.searchEquipView.dataBigArray = @[info.cb];
            self.searchEquipView.style = XKLoadDetectiStyle;
            
        }

    }
    if (array.count == 0) {
         self.searchEquipView.style = XKLoadunLoadingStyle;
    }
    

}
#pragma mark - CiGateDelegate methods
- (void)iGateDidUpdateState:(CiGateState)iGateState
{
    [self setState:iGateState];
    switch(iGateState)
    {
        case CiGateStateInit:
            break;
        case CiGateStateIdle:
            break;
        case CiGateStatePoweredOff:
            break;
        case CiGateStateUnknown:
            break;
        case CiGateStateUnsupported:
            break;
        case CiGateStateSearching:
           

            break;
        case CiGateStateConnecting:

            self.searchEquipView.dataBigArray = @[@"iGate"];
            self.searchEquipView.style = XKLoadDetectiStyle;
            [self.searchEquipView.equiptTabView reloadData];
            break;
        case CiGateStateConnected:
            self.searchTool = YES;
            break;
        case CiGateStateBonded:
           
            
            if([iGate getConnectDevName])
            break;
    }
    NSLog(@"iGate %@, State %d",iGate,iGateState);
}
- (void)iGateDidFoundDevice:(CFUUIDRef)devUUID name:(NSString *)devName RSSI:(NSNumber *)RSSI
{
   
//    self.searchEquipView.dataBigArray = @[@"iGate"];
//    self.searchEquipView.style = XKLoadDetectiStyle;
//    [self.searchEquipView.equiptTabView reloadData];
    
}

- (void)iGateDidRetrieveBatteryLevel:(UInt8)levelInPercentage
{
    NSLog(@"iGateDidRetrieveBatteryLevel %d",levelInPercentage);
    self.recDataStr=[self.recDataStr stringByAppendingFormat:@"\nBattery level is %d",levelInPercentage];
}
#pragma mark  绑定设备
- (IBAction)bindToolAction:(id)sender {
    [self bindChooseDectTool];
    
}
-(void)bindChooseDectTool
{

    if ([self.model.BluetoothName isEqualToString:@"HTD02"]||[self.model.BluetoothName isEqualToString:@"HC-08"]||[self.model.BluetoothName containsString:@"CardioChek"]) {
        
        //体温
        self.toothM = [MSBluetoothManager shareInstance];
         self.toothM.adVpersincalName = self.model.BluetoothName;
        self.toothM.conntiontTool = NO;
        self.toothM.searchtTool = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.toothM startScan];
            
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiConnected:) name:kNotificationSearch object:nil];
            
            
            
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if (self.toothM.searchtTool == NO) {
                
                [self searchFailmsToothDevice];
                
            }
            
            
        });
        
        
        
    }
    else if ([self.model.BluetoothName hasPrefix:@"RBP"]||[self.model.BluetoothName hasPrefix:@"BP"])
//        if ([self.model.BluetoothName isEqualToString:@"RBP1708040566"])
    {
        
        maibobo = [LanYaSDK shareInstance];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [maibobo startScan];
        });
        //蓝牙设备列表刷新
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleBluetoothDidRefreshDevicesList:)
                                                     name:BluetoothDidRefreshDevicesList
                                                   object:nil];
        
        
        self.searchTool = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if (self.searchTool == NO) {
                
                [self searchFailmaiboboDevice];
                
            }
            
            
        });
        
        
        
    }
    else if ([self.model.BluetoothName isEqualToString:@"iGate"])
    {
        
        //iGate
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        Boolean useCustomerUUID128 = [defaults boolForKey:@"switchUseUUID128"];
        NSString *serviceUUIDStr=@"1812";
        serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
        if(useCustomerUUID128)
        {
            serviceUUIDStr=[defaults stringForKey:@"customerUuid128"];
            if(serviceUUIDStr==nil)
                serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
            else
            {
                CFUUIDRef tmpUUID0=CFUUIDCreateFromString(kCFAllocatorDefault, (__bridge CFStringRef)serviceUUIDStr);
                CFStringRef aCFString=CFUUIDCreateString(kCFAllocatorDefault,tmpUUID0);
                if(kCFCompareEqualTo!=CFStringCompare(aCFString,(__bridge CFStringRef)serviceUUIDStr,0))
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:serviceUUIDStr message:@"The UUID128 in settings is not correct, default C14D2C0A-401F-B7A9-841F-E2E93B80F631 is used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];
                    serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
                }
                CFRelease(tmpUUID0);
                CFRelease(aCFString);
            }
        }
        
        iGate = [[CiGate alloc] initWithDelegate:self autoConnectFlag:TRUE serviceUuidStr:serviceUUIDStr];
        self.recDataStr=@"";
        _rxFormat=0;
        
        self.searchTool = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if (self.searchTool == NO) {
                
                [self searchFailAiAoLeDevice];
                
            }
            
            
        });
        
        
    }
    else if (self.style == XKDetectWeightStyle) {
        //体脂秤
        _allScanDevice = [NSMutableArray array];
        _deviceData = [NSMutableArray array];
        qinNiuTag = 1;
        [self scanBle:qinNiuTag];
        
        _qingNiuWeightUnit = QingNiuRegisterWeightUnitKg;
        //设置测量单位
        [QingNiuSDK setWeightUnit:_qingNiuWeightUnit];
        
        [QingNiuSDK getCurrentWeightUnit:^(QingNiuWeightUnit qingNiuWeightUnit) {
            _qingNiuWeightUnit = qingNiuWeightUnit;
            
        }];
    } //
    
    else if ([self.model.BluetoothName isEqualToString:@"Bioland-BGM"]) {
        [self createData];//爱奥乐血糖
        
    } // [self createData];//爱奥乐
    else if ([self.model.BluetoothName isEqualToString:@"Bioland-BPM"]) {
        [self createData];//爱奥乐
        
    }
    else if ([self.model.BluetoothName isEqualToString:@"POD"]) {
        
        
        self.bc=[BluetoothConnectionTool sharedInstanceTool];
        
        self.bc.delegate = self;
        
        self.connectionStatus = 1;
        
        self.bc.conntiontTool = 1;//1未来连接   2  连接  3 
        //             self.bc.searchTool = NO;
        [self.bc scanDevice];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(PODSearch:)
                                                     name:@"PODSearch"
                                                   object:nil];
        
        
        

    }
    
    
    self.searchEquipView.style = XKLoadSearchingStyle;
    
    
    self.searchEquipView.alpha = 1;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.searchEquipView];

}
#pragma mark  POD   科瑞康
-(void)TheConnectionPodStatus:(NSInteger)connectionStatus;
{

   if (connectionStatus == 2)
   {
       NSMutableArray *portsArr = [NSMutableArray array];
       for ( CreativePeripheral *p in self.bc.foundPorts) {
           [portsArr addObject:p.peripheral];
       }
      
       self.searchEquipView.dataBigArray = portsArr;
       self.searchEquipView.style = XKLoadDetectiStyle;
       [self.searchEquipView.equiptTabView reloadData];
   
   }
    if (connectionStatus == 3)
    {
        
        
         self.searchEquipView.style = XKLoadunLoadingStyle;
        
    }


}
-(void)PODSearch:(NSNotification *)noti{
    
    self.searchEquipView.dataBigArray = (NSArray *)noti.object;
    self.searchEquipView.style = XKLoadDetectiStyle;
    [self.searchEquipView.equiptTabView reloadData];
    
}

#pragma mark XKBindTopTitleViewDelegate
-(void)bindTopTitleBuyTools;
{



}
#pragma mark  加载数据
-(void)loadData{
        
        [[XKLoadingView shareLoadingView]showLoadingText:nil];//,@"Mobile":[UserInfoTool getLoginInfo].Mobile
    
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"810" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"ProductID":@(self.model.ProductID)}  success:^(id json) {
    
            NSLog(@"810%@",json);
    
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
    
                [[XKLoadingView shareLoadingView] hideLoding];
                
                
                 [[EGOCache globalCache] setObject:[json objectForKey:@"Result"] forKey:[NSString stringWithFormat:@"%@%li%i%@",@"XKDeviceProductMod",[UserInfoTool getLoginInfo].MemberID,self.style,self.model.ProductName]];
                
                
                  [self loadDataWithDBOrRequest:[json objectForKey:@"Result"]];
               
    
            }else{
    
                NSLog(@"操作失败");
                [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
    
    
            }
    
        } failure:^(id error) {
    
            NSLog(@"%@",error);
    
            [[XKLoadingView shareLoadingView] errorloadingText:error];
            
        }];
    
}
-(void)loadDataWithDBOrRequest:(NSDictionary *)dic1{
    

    self.productMod = [XKDeviceProductMod objectWithKeyValues:dic1];
    self.nameLab.text = self.productMod.ProductName;
    
    
    [self.equiptImage sd_setImageWithURL:[NSURL URLWithString:self.productMod.ImgUrl] placeholderImage:[UIImage imageNamed:@"moren"]];
    
    
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.productMod.GuidelinesContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    [self.webView loadHTMLString:attrStr.string baseURL:nil];

    
}


#pragma mark  重新开时搜索设备
-(void)beginAgainToDectTool;
{


 [self bindChooseDectTool];

}
#pragma mark   绑定设备
-(void)selectIndex:(XKEquiptBindTableViewCell *)cell;
{
    NSLog(@"equiptNameLab%@",cell);
    self.searchEquipView.style = XKLoadLoadingStyle;

    [QingNiuSDK stopBleScan];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"813" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"ProductID":@(self.model.ProductID),@"DeviceID":@(self.model.DeviceID),@"BluetoothName":self.model.BluetoothName/*cell.equiptNameLab.text*/}  success:^(id json) {
            
            NSLog(@"813%@",json);
            
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                
             

                self.searchEquipView.style = XKLoadSuccessStyle;
                    
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.searchEquipView removeFromSuperview];
                    
                    if ( self.jumpCountIndex == 1) {
                        CheckResultViewController *check = [[CheckResultViewController alloc]initWithType:pageTypeNormal];
//     4.0注释是因为和检测的设备的重叠了                check.myTitle = self.myTitle?[self.myTitle stringByReplacingOccurrencesOfString:@"检测" withString:@"绑定"]:@"";
                        check.DectStyle = self.style;// XKDetectWeightStyle;//
                        check.BluetoothName = self.model.BluetoothName;
                        //                    check.deviceMod = deviceDetailMod;//名字
                        [self.navigationController pushViewController:check animated:YES];
                        _jumpCountIndex++;
                    }
                });
            }else{
                
                NSLog(@"操作失败");
                [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
                
                
            }
            
        } failure:^(id error) {
            
            NSLog(@"%@",error);
            self.searchEquipView.style = XKLoadCalcelStyle;
            [[XKLoadingView shareLoadingView] errorloadingText:error];
            
        }];

    });
    
    
}

#pragma mark   扫描失败  POD 扫描失败
#pragma mark  BluetoothConnectionToolDelegate
-(void)searchFailDevice;
{

  self.searchEquipView.style = XKLoadunLoadingStyle;
}
#pragma mark   其他设备连接超时扫描失败
-(void)searchFailAiAoLeDevice;
{
    
    self.searchEquipView.style = XKLoadunLoadingStyle;
    
     [self stopScan];
    
}
-(void)searchFailQingNiuDevice;
{
    
    self.searchEquipView.style = XKLoadunLoadingStyle;
    [QingNiuSDK stopBleScan];


}
-(void)searchFailmaiboboDevice;
{
    
    self.searchEquipView.style = XKLoadunLoadingStyle;
    NSLog(@"-------searchFailmaiboboDevice");
  //  [maibobo stopScan];加上这句会导致第一次绑定设备之后，开始测量接收到数据过程中数据断开连接
}
-(void)searchFailiGateDevice;
{
    
    self.searchEquipView.style = XKLoadunLoadingStyle;
     [iGate stopSearch];
}
-(void)searchFailmsToothDevice;
{
    
    self.searchEquipView.style = XKLoadunLoadingStyle;
     [self.toothM stopScan];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 跳转到商场页去购买设备
 
 @param sender <#sender description#>
 */

- (IBAction)buyTools:(id)sender {
    XKShopUrlViewController *shop = [[XKShopUrlViewController alloc]initWithType:pageTypeNormal];
    shop.ShopUrl = self.productMod.HpptUrl;
    [self.navigationController pushViewController:shop animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
