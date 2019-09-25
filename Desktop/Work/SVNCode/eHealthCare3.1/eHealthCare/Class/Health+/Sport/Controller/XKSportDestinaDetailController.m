//
//  XKSportDestinaDetailController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "XKSportDestinaDetailController.h"
#import "SportDestinaTableViewCell.h"
#import "XKSportDestinaRunController.h"
#import "SportDestinaTimeView.h"
#import "SportCenterDestinaView.h"

@interface XKSportDestinaDetailController ()
@property (nonatomic,strong) UITableView *acountTable;
@property (nonatomic,strong) SportDestinaTimeView *timeView;
@property (nonatomic,strong)SportCenterDestinaView *destView;

@end

@implementation XKSportDestinaDetailController
-(UITableView *)acountTable{
    
    if (!_acountTable) {
        _acountTable = [[UITableView alloc] init];
        _acountTable.left = 6;
        _acountTable.top = 6;
        _acountTable.width = KScreenWidth-12;
        _acountTable.height =  KScreenHeight-(PublicY)-KHeight(45);
        _acountTable.showsVerticalScrollIndicator = NO;
        _acountTable.showsHorizontalScrollIndicator = NO;
        _acountTable.scrollEnabled = NO;
        _acountTable.dataSource = self;
        _acountTable.delegate = self;
        _acountTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _acountTable.backgroundColor = kbackGroundGrayColor;
        [_acountTable registerNib:[UINib nibWithNibName:@"SportDestinaTableViewCell" bundle:nil] forCellReuseIdentifier:@"SportDestinaTableViewCell"];
    }
    
    return _acountTable;
}
-(SportCenterDestinaView *)destView{
    
    if (!_destView) {
        _destView = [[[NSBundle mainBundle]loadNibNamed:@"SportCenterDestinaView" owner:self options:nil]firstObject];
        _destView.left = 0;
        _destView.top = 0;
        _destView.width = KScreenWidth;
        _destView.height =  KScreenHeight;
        _destView.delegate = self;
    }
    return _destView;
}
-(SportDestinaTimeView *)timeView{
    
    if (!_timeView) {
        _timeView = [[[NSBundle mainBundle]loadNibNamed:@"SportDestinaTimeView" owner:self options:nil]firstObject];
        _timeView.left = 0;
        _timeView.top = 0;
        _timeView.width = KScreenWidth;
        _timeView.height =  KScreenHeight;
        _timeView.delegate = self;
    }
    return _timeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"目标";
     self.view.backgroundColor = kbackGroundGrayColor;
     [self.view addSubview:self.acountTable];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataDestinaArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellid = @"SportDestinaTableViewCell";
    SportDestinaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == self.dataDestinaArray.count-1 )
    {
        CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, KHeight(50)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        maskTwoLayer.frame = corTwoPath.bounds;
        maskTwoLayer.path=corTwoPath.CGPath;
        cell.layer.mask=maskTwoLayer;
        cell.titleLab.text =  [NSString stringWithFormat:@"%@",self.dataDestinaArray[indexPath.row]];
        return cell;
    }
   
    else  if (self.DType == 1) {
       cell.titleLab.text = [NSString stringWithFormat:@"%@公里",self.dataDestinaArray[indexPath.row]];
       if (indexPath.row == 0)
        {
            CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
            UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, KHeight(50)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
            maskTwoLayer.frame = corTwoPath.bounds;
            maskTwoLayer.path=corTwoPath.CGPath;
            cell.layer.mask=maskTwoLayer;
            return cell;
            
        }
        return cell;
    }
    else if (self.DType == 2){
        cell.titleLab.text =  [NSString stringWithFormat:@"%@分钟",self.dataDestinaArray[indexPath.row]];
        if (indexPath.row == 0)
        {
            CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
            UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, KHeight(50)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
            maskTwoLayer.frame = corTwoPath.bounds;
            maskTwoLayer.path=corTwoPath.CGPath;
            cell.layer.mask=maskTwoLayer;
            return cell;
            
        }
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return KHeight(50);
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
 if(indexPath.row == self.dataDestinaArray.count-1 )
    {
        if (self.DType == 1)
        {
              [[UIApplication sharedApplication].keyWindow addSubview:self.destView];
        }
        else
        {
            
              [[UIApplication sharedApplication].keyWindow addSubview:self.timeView];
        }
        
    }
   else
   {
        XKSportDestinaRunController *run = [[XKSportDestinaRunController alloc]initWithType:pageTypeNormal];
        NSString *temp = self.dataDestinaArray[indexPath.row];
        SportDestinaMod *mod = [[SportDestinaMod alloc]init];
        if (self.DType == 1)
        {
            mod.title = @"公里";
//            [SportCommonMod shareInstance].isMinuteCount = NO;
//             [SportCommonMod shareInstance].totalDistance = [temp floatValue];
        }
        else
        {
            
            mod.title = @"分钟";
//            [SportCommonMod shareInstance].isMinuteCount = YES;
//           [SportCommonMod shareInstance].totalTime = [temp floatValue];
        }
        
        
        mod.destinaDataStr = temp;
        run.destinaMod = mod;
        [self.navigationController pushViewController:run animated:YES];
        
    }
}
- (void)SportDestinaTimeViewCompleteClick:(NSString *)dataStr minute:(NSString *)minute;
{
    
    NSLog(@"---_%@",dataStr);
    XKSportDestinaRunController *run = [[XKSportDestinaRunController alloc]initWithType:pageTypeNormal];
    NSString *temp = [NSString stringWithFormat:@"%zi",([dataStr intValue]*60+[minute intValue])];
    SportDestinaMod *mod = [[SportDestinaMod alloc]init];

    mod.title = @"分钟";
 
    mod.destinaDataStr = temp;
    run.destinaMod = mod;
    [self.navigationController pushViewController:run animated:YES];
}
- (void)SportCenterDestinaViewCompleteClick:(NSString *)dataStr;
{
    
    NSLog(@"---_%@",dataStr);
    XKSportDestinaRunController *run = [[XKSportDestinaRunController alloc]initWithType:pageTypeNormal];
    NSString *temp = dataStr;
    SportDestinaMod *mod = [[SportDestinaMod alloc]init];
    mod.title = @"公里";
  
    mod.destinaDataStr = temp;
    run.destinaMod = mod;
    [self.navigationController pushViewController:run animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
