//
//  XKDectingViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/11/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKDectingViewController.h"
#import "XKDetectTableViewCell.h"
#import "XKDetectView.h"
#import "XKManualInputView.h"
#import "CheckResultViewController.h"
#import "XKBindToolsViewController.h"
#import "XKBindEquipmentViewController.h"
#import "HematocrystallinView.h"
#import "NewTrendDetailController.h"
#import "XKDeviceMod.h"
#import "XKDeviceDetailMod.h"
#import "XKValidationAndAddScoreTools.h"
#import "XKShopUrlViewController.h"
#import "XKCheckResultCommonViewController.h"
@interface XKDectingViewController ()<UIWebViewDelegate>
{
    
    XKDeviceDetailMod *deviceDetailMod;
    
}

@property (weak, nonatomic) IBOutlet UIButton *unBindToolBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;


/**
 手动输入
 */
@property(strong,nonatomic)XKManualInputView *manualInputView;

/**
 手动输入
 */
@property(strong,nonatomic)HematocrystallinView *manualHematoryView;


/**
 区头
 */
@property(strong,nonatomic)XKDetectView *dectView;

@property (nonatomic,strong)NSArray *dataBigArray;

@property (weak, nonatomic) IBOutlet UIWebView *weView;

@property (weak, nonatomic) IBOutlet UIView *unBindEquiptToolsView;

@property (weak, nonatomic) IBOutlet UILabel *introduceLab;

/**
 还没有设备？中心X坐标
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *unHaveEquiptCenterX;


/**
 手动输入 中心X坐标
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manaualInputCenterX;

@property (weak, nonatomic) IBOutlet UIButton *unHaveEquiptBtn;

/**
 自动检测
 */
@property (weak, nonatomic) IBOutlet UIButton *detectBtn;

/**
 手动输入
 */
@property (weak, nonatomic) IBOutlet UIButton *manaulBtn;
@end

@implementation XKDectingViewController

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *bodyStyle = @"document.getElementsByTagName('body')[0].style.textAlign = 'center';";
    [webView stringByEvaluatingJavaScriptFromString:bodyStyle];
}

-(HematocrystallinView *)manualHematoryView
{
    
    if (!_manualHematoryView) {
        
        _manualHematoryView = [[NSBundle mainBundle]loadNibNamed:@"HematocrystallinView" owner:self options:nil].firstObject;
        
        _manualHematoryView.x = 0;
        
        _manualHematoryView.y = 0;
        
        _manualHematoryView.width = KScreenWidth;
        
        _manualHematoryView.height = KScreenHeight;
        
        _manualHematoryView.delegate = self;
    }
    return _manualHematoryView;
    
}
-(XKManualInputView *)manualInputView
{
    
    if (!_manualInputView) {
        
        _manualInputView = [[NSBundle mainBundle]loadNibNamed:@"XKManualInputView" owner:self options:nil].firstObject;
        
        _manualInputView.x = 0;
        
        _manualInputView.y = 0;
        
        _manualInputView.width = KScreenWidth;
        
        _manualInputView.height = KScreenHeight;
        
        
        
        _manualInputView.delegate = self;
    }
    return _manualInputView;
    
}
-(XKDetectView *)dectView
{
    
    if (!_dectView) {
        
        _dectView = [[NSBundle mainBundle]loadNibNamed:@"XKDetectView" owner:self options:nil].firstObject;
        
        _dectView.x = 0;
        
        _dectView.y = 0;
        
        _dectView.width = KScreenWidth;
        
        _dectView.height = 45;
    }
    return _dectView;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [[EGOCache globalCache] setObject:response.Result forKey:[NSString stringWithFormat%li"%@%zi%li",@"XKDeviceDetailMod",[UserInfoTool getLoginInfo].(long)MemberID,(long)self.style]];
    
    if ([[EGOCache globalCache]hasCacheForKey:[NSString stringWithFormat:@"%@%zi%li",@"XKDeviceDetailMod",[UserInfoTool getLoginInfo].MemberID,(long)self.style]]) {
        NSDictionary *dic1 = (NSDictionary *)[[EGOCache globalCache] objectForKey:[NSString stringWithFormat:@"%@%zi%li",@"XKDeviceDetailMod",[UserInfoTool getLoginInfo].MemberID,(long)self.style]];
        
        [self loadDataWithDBOrRequest:dic1];
        
    }//网络环境差的情况下就本地数据
     [self loadData];
    
#ifdef __IPHONE_11_0
  
//        self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0);
   
#endif

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.detectBtn.layer.cornerRadius=self.detectBtn.frame.size.height/2.0;
    
     self.topCons.constant = (PublicY);
    self.detectBtn.layer.masksToBounds=YES;
    
    self.manaulBtn.layer.cornerRadius=self.manaulBtn.frame.size.height/2.0;
    
    self.manaulBtn.layer.masksToBounds=YES;
    self.manaulBtn.layer.borderWidth = 0.5;
    self.manaulBtn.layer.borderColor = kMainColor.CGColor;
    self.unHaveEquiptBtn.layer.cornerRadius=self.manaulBtn.frame.size.height/2.0;
    self.unHaveEquiptBtn.layer.masksToBounds=YES;
    self.unHaveEquiptBtn.layer.borderWidth = 0.5;
    self.unHaveEquiptBtn.layer.borderColor = kMainColor.CGColor;
  
    [self.rightBtn setImage:[UIImage imageNamed:@"check_trend"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(pressPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.detectBtn setTitle:@"去绑定" forState:UIControlStateNormal];
    if (self.style <=5) {
        self.unBindToolBtn.hidden = YES;
    }
   
    
    if (self.style == XKDetectWeightStyle) {
        
        if ([UserInfoTool getLoginInfo].Height<=5.0) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:self.manualHematoryView];
        }
        
    }
    //  去除滚动条webView
    self.weView.backgroundColor=[UIColor clearColor];
    for (UIView *_aView in [self.weView subviews])
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
    
}



-(void)pressPicture{
    
//    if (self.style == XKDetectDyslipidemiaStyle) {//血脂四项请求基本数据
//
//        [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
//
//        [NetWorkTool postAction:checkHomeGetBloodLipidFourListUrl params:@{@"Token":[UserInfoTool getLoginInfo].Token} finishedBlock:^(ResponseObject *response) {
//             [[XKLoadingView shareLoadingView] hideLoding];
//            NSLog(@"获取血脂四项id838--:%@",response.Result);
//            if (response.code == CodeTypeSucceed) {
//
//                NSArray *arr =  [XKPhySicalItemModel mj_objectArrayWithKeyValuesArray:response.Result];
//                NewTrendDetailController *vc = [[NewTrendDetailController alloc] initWithType:pageTypeNormal];
//                vc.PhysicalItemArr = arr;
//                [self.navigationController  pushViewController:vc animated:YES];
//            }else{
//                ShowErrorStatus(response.msg);
//            }
//
//        }];
//
//    }else{
                NewTrendDetailController *vc = [[NewTrendDetailController alloc] initWithType:pageTypeNormal];
                if (deviceDetailMod.PhysicalItemID == 11) {//规则：血糖11  单独给他PhysicalItemID为33的值
                     vc.PhysicalItemID = 32;
                }
                else if (deviceDetailMod.PhysicalItemID == 12) {//规则：血压
                    vc.PhysicalItemID = 18;
                }
                else if (deviceDetailMod.PhysicalItemID == 1) {//规则：体重 BMI
                    vc.PhysicalItemID = 189;//显示体重
                }else
                 vc.PhysicalItemID = deviceDetailMod.PhysicalItemID;
                [self.navigationController  pushViewController:vc animated:YES];
//            }
}

#pragma mark    获取用户身高
-(void)getUserHeight
{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [NetWorkTool postAction:checkHomeGetUserHeightUrl params:@{@"Mobile":[UserInfoTool getLoginInfo].Mobile,@"Token":[UserInfoTool getLoginInfo].Token} finishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
             NSLog(@"获取用户身高成功");
        }else{
             NSLog(@"获取用户身高失败");
        }
    }];
}



-(void)dectUnableBind;
{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];//,@"Mobile":[UserInfoTool getLoginInfo].Mobile
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"BindID":@(deviceDetailMod.BindID)};
    [NetWorkTool postAction:checkHomeUnBindDeviceUrl params:dic finishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            ShowSuccessStatus(@"解绑成功");
            self.model.IsBind = 0;
            self.unBindEquiptToolsView.hidden = NO;
            
            
            self.unHaveEquiptCenterX.constant = -60;
            
            [self.detectBtn setTitle:@"去绑定" forState:UIControlStateNormal];
            
            
            self.manaualInputCenterX.constant = 60;
        }else{
            ShowErrorStatus(response.msg);
        }
    }];
}

-(void)birthDayPickerChange:(NSString *)dateStr andBtnTitle:(NSString *)title
{
    
    if ([title isEqualToString:@"确定"] && dateStr.length > 0) {
        NSLog(@"生日时间 -- %@",dateStr);
        
    }
}

#pragma mark   XKManualInputViewDelegate
-(void)selectIndex:(NSString *)title manualText:(NSString *)manualText manualTwoText:(NSString *)manualTwoText manualThreeText:(NSString *)manualThreeText manualFourText:(NSString *)manualFourText sugarTag:(NSInteger)sugarTag;
{
    
    NSLog(@"manualText:%@",manualText);
    
    XKCheckResultCommonViewController *con =  [[XKCheckResultCommonViewController alloc]initWithType:pageTypeNoNavigation];
    con.DectStyle = self.style;
    con.isOtherDect = YES;
    con.manualText = manualText;
    con.manualTwoText = manualTwoText;
    con.manualThreeText = manualThreeText;
    con.manualFourText = manualFourText;
    con.BloodSugarType = (int)sugarTag;
     con.myTitle = self.myTitle;
    Dateformat *dateFor = [[Dateformat alloc] init];
   
    NSString *timeStr = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",[UserInfoTool getLoginInfo].Birthday]] withFormat:@"YYYY-MM-dd"];
    /* BMI :体重／身高的平方（单位m）*/
    double BMI =  ([manualText doubleValue])/((double)[UserInfoTool getLoginInfo].Height/100.0* (double)[UserInfoTool getLoginInfo].Height/100.0);
    NSString *BMIStr = [NSString stringWithFormat:@"%.2f",BMI];
    NSLog(@"BMI-%@-%d-%lf",manualText,[UserInfoTool getLoginInfo].Height,BMI);
    if (!BMI) {
        BMI = 0;
    }
    NSDictionary *t = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"FatLevel",BMIStr, @"BMI", @"0",@"FatRate",@"0",@"WaterMass",@"0",@"MuscleMass",@([UserInfoTool getLoginInfo].Height),@"Hight", manualText, @"Weight",@"0",@"SubcutaneousFatRate", @"0",@"SkeletalMuscleRate",@"0",@"LeanWeight", @"0", @"Proteins",@"0", @"Metabolism", @"0",@"BoneMass",@([Dateformat getNowTimestamp]*1000), @"TestTime", @"0",@"Score",@"0",@"BodyType",@"0",@"BodyAge",nil];
    NSLog(@"%@",t);
    con.diction = t;
    
    
    if(self.isReload)//刷新新的E家以及健康监测的监测数据
    {
        self.isReload(YES);
    }
    [self.navigationController pushViewController:con animated:YES];
    
}

-(void)selectSexIndex:(NSString *)title birthdayText:(NSString *)birthday heightText:(NSString *)height;
{
    //转成时间戳
    Dateformat *date = [[Dateformat alloc]init];
    NSString *timeSp = [date timeConvertSp:birthday];
    NSLog(@"uuuuu=timeSp--- %@",timeSp);
//    NSDictionary *dict = [[UserInfoTool getLoginInfo] mj_keyValues];
//    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:dict];
//    dic[@"Height"] = @([height integerValue]);
//    dic[@"Birthday"] = timeSp;
    UserInfoModel *model = [UserInfoTool getLoginInfo];
    model.Height = [height integerValue];
    model.Birthday = timeSp;
  
    [UserInfoTool saveLoginInfo:model];
    
    ShowSuccessStatus(@"保存成功");
     NSLog(@"uuuuu= %@",[[UserInfoTool getLoginInfo] mj_keyValues]);
    
}

-(void)loadData{
    
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];//,@"Mobile":[UserInfoTool getLoginInfo].Mobile
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"DeviceID":@(self.model.DeviceID),
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    NSLog(@"--DeviceID----dic------%@",dic);
    [NetWorkTool postAction:checkHomeGetDeviceMoreMessageUrl params:dic finishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed)
        {
            [[EGOCache globalCache] setObject:response.Result forKey:[NSString stringWithFormat:@"%@%zi%li",@"XKDeviceDetailMod",[UserInfoTool getLoginInfo].MemberID,(long)self.style]];
            
            
            
            [self loadDataWithDBOrRequest:response.Result];
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];

}



/**
 手动输入页
 
 @param sender
 */
- (IBAction)manaulAction:(id)sender {
    
    if (self.style) {
        
        
        if (self.style == XKDetectWeightStyle) {
            
            if ([UserInfoTool getLoginInfo].Height>0) {
                
            }else
            {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [window addSubview:self.manualHematoryView];
                return;
            }
            
            
        }
        self.manualInputView.style = self.style;
        
        [self.view.window addSubview:self.manualInputView];
        
        return;
    }
    ShowNormailMessage(@"网络不好，请稍后再试");
    
    
    
}

/**
 跳转到商场页去购买设备
 
 @param sender
 */
- (IBAction)unHaveEquiptAction:(id)sender {
    
    XKShopUrlViewController *shop = [[XKShopUrlViewController alloc]initWithType:pageTypeNormal];
    shop.ShopUrl = deviceDetailMod.ShopUrl;
    [self.navigationController pushViewController:shop animated:YES];
    
}
/**
 已绑定跳转到检测设备页，未绑定跳转到绑定设备页
 
 @param sender <#sender description#>
 */
- (IBAction)detectAction:(id)sender {

    if ([self.detectBtn.titleLabel.text isEqualToString:@"去绑定"]) {//设备绑定页
        XKBindToolsViewController *tool = [[XKBindToolsViewController alloc]initWithType:pageTypeNormal];
        tool.myTitle = self.model.Name;
        tool.style = self.style;
        tool.DeviceID = self.model.DeviceID;
        [self.navigationController pushViewController:tool animated:YES];

    }
    else //检测设备页
    {
    
        if (self.style == XKDetectWeightStyle) {
            
            if ([UserInfoTool getLoginInfo].Height>0) {
                
            }else
            {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [window addSubview:self.manualHematoryView];
                return;
            }
            
            
        }
        if (self.style<=5) {
            self.bc=[BluetoothConnectionTool sharedInstanceTool];
            self.bc.delegate = self;
            self.bc.conntiontTool = 2;
             NSInteger CRCreativeSDK  = [[NSUserDefaults standardUserDefaults] integerForKey:@"CRCreativeSDKF"];
            
            if (CRCreativeSDK == 1) {
                [self.bc scanDevice];
                
            }
           
        }
        if(self.isReload)//刷新新的健康监测的监测数据
        {
            self.isReload(YES);
        }
        
        CheckResultViewController *con =  [[CheckResultViewController alloc]initWithType:pageTypeNormal];
        con.DectStyle = self.style;// XKDetectWeightStyle;//
        con.BluetoothName = deviceDetailMod.BluetoothName;
        [self.navigationController pushViewController:con animated:YES];
        
    }
    
    
    
}
-(void)loadDataWithDBOrRequest:(NSDictionary *)dic1{
    
    deviceDetailMod = [XKDeviceDetailMod mj_objectWithKeyValues:dic1];
    
    
    self.introduceLab.text = deviceDetailMod.Description;
    self.myTitle = [NSString stringWithFormat:@"%@检测",self.model.Name?self.model.Name:@""];
    deviceDetailMod.DeviceImg = [NSString stringWithFormat:@"&lt;style&gt;img{max-width: 100%%;}&lt;/style&gt;%@",deviceDetailMod.DeviceImg];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[deviceDetailMod.DeviceImg dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    //    self.dataLab.attributedText = attrStr;
    
    [self.weView loadHTMLString:attrStr.string baseURL:nil];
    self.weView.delegate = self;
    NSLog(@"-----deviceDetailMod.BindIDdeviceDetailMod.BindID-------%d----%i",deviceDetailMod.BindID,self.model.IsBind);

    if (self.model.IsBind == 1||self.style<=5||deviceDetailMod.BindID>0) {//（0未绑定1已绑定）||deviceDetailMod.BindID>0
        self.unBindEquiptToolsView.hidden = YES;
        
        
        self.unHaveEquiptCenterX.constant = -10000;
        
        [self.detectBtn setTitle:@"开始检测" forState:UIControlStateNormal];
        
        
        self.manaualInputCenterX.constant = 0;
        
        if (self.model.IsBind == 1) {
            self.dectView.unbindBtn.hidden = NO;
        }
        
        
    }
    else
    {
        
        self.unBindEquiptToolsView.hidden = NO;
        
        
        self.unHaveEquiptCenterX.constant = -60;
        
        [self.detectBtn setTitle:@"去绑定" forState:UIControlStateNormal];
        
        
        self.manaualInputCenterX.constant = 60;
        
    }
}
#pragma mark   取消绑定
- (IBAction)dectectBtnAction:(id)sender {
    
    [self dectUnableBind];
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