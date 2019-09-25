//
//  ViewController.m
//  HXJBlueSDK
//
//  Created by solon on 16/10/9.
//  Copyright © 2016年 solon. All rights reserved.
//

#import "ViewController.h"
#import "BLEHelper.h"
#import "SGHttpTool.h"

static NSString *cellId = @"hxjCell";

@interface ViewController ()<BLEHelperDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *PEFLabel;
@property (weak, nonatomic) IBOutlet UILabel *FVCLabel;
@property (weak, nonatomic) IBOutlet UILabel *FEV1Label;



@property (weak, nonatomic) IBOutlet UILabel *status;
@property (nonatomic,strong) BLEHelper *helper;
@property (weak, nonatomic) IBOutlet UITextField *imeiTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSDictionary *matchInfo;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helper = [BLEHelper shareBLEHelper];
    self.helper.delegate = self;
    //按照如下格式传入检测人资料，下面资料是假数据
    NSDictionary *matchInfo = @{
                                @"PEF" : @"601",
                                @"FEV1" : @"4.44",
                                @"FVC" : @"5.22",
                                @"gender" : @"0",
                                @"height" : @"176",
                                @"weight" : @"67",
                                @"detectedNo" : @"6381",
                                @"mobile" : @"13480016536",
                                @"birthdate" : @"1989-07-07",
                                @"saleChannel" : @"0",
                                @"deviceNo" : @"A116080011"
                                };
    
    
    [self.helper requestMatchInfoWithHolderDict:matchInfo];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)BLEHelper:(BLEHelper *)helper detectedResults:(NSArray *)detectedResults currentResult:(SGHolderDetectedResult *)result
{
    self.PEFLabel.text = result.pef;
    self.FVCLabel.text = result.fvc;
    self.FEV1Label.text = result.fev1;
    NSLog(@"results count - %zd \n current result time %@",detectedResults.count,result.saveTime);
}

- (void)BLEHelper:(BLEHelper *)helper ConnectStatusType:(BLEConnectStatusType)type
{
    [self.tableView reloadData];
    
    switch (type) {
        case BLEConnectOnStatus:
            self.status.text = @"连接";
            break;
        case BLEConnectingStatus:
            self.status.text = @"连接中";
            break;
        case BLEConnectOffStatus:
            self.status.text = @"断开";
            break;
        case BLEWillUpdateDeviceStatus:
            self.status.text = @"将要更新";
            break;
        case BLEUpdatingDeviceStatus:
            self.status.text = @"更新中";
            break;
        case BLEDidUpdateDeviceStatus:
            self.status.text = @"更新完成";
            break;
    }
}



- (IBAction)connectBLE:(UIButton *)sender {
    
    if (self.imeiTextField.text.length < 1) {
        return;
    }
    
    NSString *imeiStr = [self.imeiTextField.text uppercaseString];//字母需要转为大写
    
    [self.helper connectedPeripheral:nil imei:imeiStr];
    
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.helper.peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    CBPeripheral *p = self.helper.peripherals[indexPath.row];
    cell.textLabel.text = p.name;
    
    return cell;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
