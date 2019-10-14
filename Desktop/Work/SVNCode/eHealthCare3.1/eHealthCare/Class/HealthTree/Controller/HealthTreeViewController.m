//
//  HealthTreeViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthTreeViewController.h"
#import "XKMyPlanLookCell.h"
#import "XKNewHomeInSectionHeadView.h"
#import "XKHotTopicChildCell.h"
#import "RemindCell.h"
#import "HealthTestTableViewCell.h"
#import "MoodTableViewCell.h"
#import "StepTableViewCell.h"
#import "HealthTreeHeaderView.h"
#import "SportViewController.h"
#import "HomeViewModel.h"
#import "PublicViewController.h"
#import "BreathTrainViewController.h"
#import "XKTopicHomeController.h"
#import "XKTopicHotDetialController.h"
#import "QuietController.h"
#import "XKHomePlanModel.h"
#import "HealthData.h"
#import "XKTopicModel.h"
#import "StepModel.h"
#import "StepTool.h"
#import "HealthPlanTableViewCell.h"
#import "HealthPlanTopCell.h"
//#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>
#import "XKNewHomeHealthPlanCell.h"
#import "XKTopicHotBigView.h"
#import "XKVideoBigView.h"
#import "CheckListModel.h"
@interface HealthTreeViewController ()<MoodTableViewCellCellDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic) HealthTreeHeaderView *headView;
@property (strong, nonatomic)XKTopicHotBigView *bigPhoto;

@property (strong, nonatomic)XKVideoBigView *videoBigView;
@property (nonatomic, strong) NSMutableArray *dataArray;

///页码数
@property (nonatomic,assign)NSInteger pageIndex;
/**
 健康自测的数据
 */
@property (strong, nonatomic) NSMutableArray *headViewDataArray;

@property (nonatomic, strong) HealthData *HealthData;
@property (nonatomic, strong) NSMutableArray *HealthPlanList;
@property (nonatomic, strong) NSMutableArray *HotTopicList;
@property (nonatomic, strong) NSMutableArray *SelfSetListArr;
/**记录公告属性和消息条数属性*/
@property (nonatomic,assign) NSInteger pMessageCount;
@property (nonatomic,assign) NSInteger memNoReadCount;


/**保存首页记步信息*/
@property (nonatomic,strong) StepModel *step;
@property (nonatomic,strong)StepTool *tool;
/**定义计时器上传每日步数**/
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, strong) CMPedometer *pedometer;//记步器
@end

@implementation HealthTreeViewController
{
    NSTimer *_timer;
}
-(XKTopicHotBigView *)bigPhoto
{
    if (!_bigPhoto) {
        _bigPhoto = [[[NSBundle mainBundle] loadNibNamed:@"XKTopicHotBigView" owner:self options:nil] lastObject];
        _bigPhoto.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        
    }
    return _bigPhoto;
}
-(XKVideoBigView *)videoBigView
{
    if (!_videoBigView) {
        _videoBigView = [[[NSBundle mainBundle] loadNibNamed:@"XKVideoBigView" owner:self options:nil] lastObject];
        _videoBigView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        
    }
    return _videoBigView;
}
- (HealthTreeHeaderView *)headView
{
    if (!_headView) {
        
        _headView=[[[NSBundle mainBundle]loadNibNamed:@"HealthTreeHeaderView" owner:self options:nil]firstObject];
        _headView.left=0;
        _headView.top=PublicY;
        _headView.width=KScreenWidth;
        _headView.height=KScreenWidth*759/750.0+(KScreenWidth-36)*37/340.0+10;
        _headView.delegate = self;
    }
    return _headView;
}
///**重写消息条数*/
//-(void)setMessageAcount:(NSInteger)messageAcount{
//    _messageAcount = messageAcount;
//
//    //赋值给消息条数
//    self.pMessageCount = messageAcount;
//
//    if ((self.pMessageCount+self.memNoReadCount) == 0) {
//        self.headView.messageCountBadgeLab.text = @"";
//    }else{
//        self.headView.messageCountBadgeLab.text = [NSString stringWithFormat:@"%li",self.pMessageCount+self.memNoReadCount];
//    }
//
//}

/**视图将要出现的方法*/
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //加载健康消息或公告数量
    [self loadPuliceCount];
    [self getHealthTreeData];
    [self updateDayAcount];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(change) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_timer invalidate];
//    _timer = nil;
}

-(void)change
{
    [self currentLocaleDidChange];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    //拉去数据
    self.pageIndex = 1;
    [self getHealthTestData];
    [self loadStep];// 步数上传
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(significantTimeChange)
                                                 name:UIApplicationSignificantTimeChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(currentLocaleDidChange)
                                                 name:NSCurrentLocaleDidChangeNotification
                                               object:nil];//不知道是不是这个导致返回的会卡住。很慢
    [self significantTimeChange];
}
- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)significantTimeChange
{
//    4-9 早上   10-11 早上  12-13 中午  14-17 傍晚   18-22 夜晚
    // todo: Refresh the interface.
    Dateformat *dateF =   [[Dateformat alloc]init];
    if ( [dateF isBetweenFromHour:4 toHour:9]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_morning"];
        self.headView.dayLab.text = @"上午好";
    }else  if ( [dateF isBetweenFromHour:9 toHour:12]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_morning"];
        self.headView.dayLab.text = @"上午好";
    }else  if ( [dateF isBetweenFromHour:12 toHour:13]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_earlymorning"];
        self.headView.dayLab.text = @"下午好";
    }
    else  if ( [dateF isBetweenFromHour:13 toHour:17]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_earlymorning"];
        self.headView.dayLab.text = @"下午好";
    }
    else  if ( [dateF isBetweenFromHour:17 toHour:19]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_afternoon"];
        self.headView.dayLab.text = @"傍晚好";
    }
    else  if ( [dateF isBetweenFromHour:19 toHour:24]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_evening"];
        self.headView.dayLab.text = @"晚上好";
    }
    else  if ( [dateF isBetweenFromHour:0 toHour:4]) {
        self.headView.bgTreeImg.image = [UIImage imageNamed:@"img_tree_evening"];
        self.headView.dayLab.text = @"晚上好";
    }
    NSLog(@"significantTimeChange:%@",self.headView.dayLab.text);
}

- (void)currentLocaleDidChange
{
    // todo: Refresh the interface.
    [self significantTimeChange];
    NSLog(@"currentLocaleDidChange:%@",self.headView.dayLab.text);
}


NSString *distanceStr;
NSString *distanc;
float dis;
int steps;
/**
 步数上传
 */
-(void)loadStep{
    
    NSNotificationCenter *notiCenter=[NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(sendStepToWealk:) name:@"sendStepToWealk" object:nil];
    //3小时上传去检测一次
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2*60*60  target:self selector:@selector(updateDayAcount) userInfo:nil repeats:YES];
    
    //上传历史六天的步数
    self.tool=[[StepTool alloc]init];
    
    [self.tool updateBeforeDataToService];//倒着上传最近七日步数
    
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"todayRecordUpdate1"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    if (![currentDateStr isEqualToString:[NSString stringWithFormat:@"%@",[defaults objectForKey:@"yesterdayDate1"]]]) {//保存上一个日期
        [defaults removeObjectForKey:@"todayRecordUpdate1"];
        [defaults setObject:currentDateStr forKey:@"yesterdayDate1"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[XKLoadingView shareLoadingView] hideLoding];
        // 1.判断计步器是否可用
        if (![CMPedometer isStepCountingAvailable]) {
            
            return;
        }
        
        //统计某天的
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *todayDateStr = [dateFormatter stringFromDate:[NSDate date]];
        
        NSString *beginDateStr = [todayDateStr stringByAppendingString:@"-00-00-00"];
        //字符转日期
        NSDateFormatter *beginDateFormatter = [[NSDateFormatter alloc] init];
        [beginDateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        NSDate *beginDate = [beginDateFormatter dateFromString:beginDateStr];
        //  [NSDate dateWithTimeInterval:-24*60*画60 sinceDate:[NSDate date]];当你的步数有更新的时候，会触发这个方法，这个方法不会和时时返回结果，每次刷新数据大概在一分钟左右
        [self.pedometer startPedometerUpdatesFromDate:beginDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
            
            if (error) {
                
                NSLog(@"查询有误");
                //                [self loadHealthData:NO];
                return;
            }
            
            //距离字符串
            distanceStr = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
            distanc=[NSString stringWithFormat:@"%@",pedometerData.distance];
            dis=[distanc floatValue];
            
            steps = [distanceStr intValue];
            //讲步数保存到单例里头
            [SingleTon shareInstance].stepCount = steps;
             [SingleTon shareInstance].disT = dis;
            if (!self.step) {
                self.step = [[StepModel alloc]init];
            }
            self.step.StepCount = steps;
            self.step.KilometerCount = [[NSString stringWithFormat:@"%.1lf",dis/1000] floatValue];
            self.step.KilocalorieCount = [[NSString stringWithFormat:@"%.1lf",dis/1000*65] floatValue];
            NSIndexPath *rpath = [NSIndexPath indexPathForRow:0 inSection:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [self.tableView reloadRowsAtIndexPaths:@[rpath] withRowAnimation:UITableViewRowAnimationNone];//重新刷新数据
                if (![defaults objectForKey:@"todayRecordUpdate1"]) {
                    [self updateDayAcount];
                    [defaults setObject:@(1) forKey:@"todayRecordUpdate1"];
                }
                
            });
            
        }];
        
    });
}
-(void)updateDayAcount{
    
    if (! [UserInfoTool getLoginInfo].Token) {
        return;
    }
  
    NSDictionary *dic = @{@"Token": [UserInfoTool getLoginInfo].Token,
                          @"MemberID":@( [UserInfoTool getLoginInfo].MemberID),
                          @"StepCount":[NSString stringWithFormat:@"%li",(long)(steps>0?steps:[SingleTon shareInstance].stepCount)],
                          @"KilometerCount":[NSString stringWithFormat:@"%.2lf",(dis/1000)>0?(dis/1000):([SingleTon shareInstance].disT)/1000],
                          @"KilocalorieCount":[NSString stringWithFormat:@"%.2lf",(dis/1000*65)>0?(dis/1000*65):([SingleTon shareInstance].disT)/1000*65]};
    
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"331" parameters:dic success:^(id json) {
        
        NSLog(@"%@-331--%@",json,@{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"StepCount":[NSString stringWithFormat:@"%i",steps],@"KilometerCount":[NSString stringWithFormat:@"%.1lf",dis/1000],@"KilocailorieCount":[NSString stringWithFormat:@"%.1lf",dis/1000*65]});
        
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            NSLog(@"xxxx上传步数成功");
            [self.tableView reloadData];
            
        }else{
            NSLog(@"xxxx上传步数失败");
        }
        
    } failure:^(id error) {
         [[XKLoadingView shareLoadingView]errorloadingText:@"网络不给力"];
    }];
}
-(void)sendStepCellMesage:(int )step;
{
    
    StepTableViewCell *cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.steps = step;
    
}
-(void)sendStepToWealk:(NSNotification *)noti{
    
    NSLog(@"recodSteprecodSteprecodStep---%@",noti.object);
    
}

-(void)loadPuliceCount
{
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"123" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberId":@([UserInfoTool getLoginInfo].MemberID)} success:^(id json) {
        
        NSLog(@"获取公告条数123（修改 健康加首页右上角未读消息，新增返回话题、添加家人消息）--:%@",json);
        if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            
            self.memNoReadCount = [json[@"Result"][@"MemNoReadCount"] integerValue];
            
            if ((self.pMessageCount+self.memNoReadCount) == 0) {
                self.headView.messageCountBadgeLab.text = @"";
                self.headView.messageCountBadgeLab.hidden = YES;
            }else{
                self.headView.messageCountBadgeLab.text = [NSString stringWithFormat:@"%li",self.pMessageCount+self.memNoReadCount];
                self.headView.messageCountBadgeLab.hidden = NO;
            }
            
        }else{
            
        }
    } failure:^(id error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark UI
- (void)createUI
{
    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-(kTabbarHeight)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kbackGroundGrayColor;//kbackGroundGrayColor;
    self.tableView.tableHeaderView= self.headView;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"RemindCell" bundle:nil] forCellReuseIdentifier:@"RemindCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HealthTestTableViewCell" bundle:nil] forCellReuseIdentifier:@"HealthTestTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoodTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StepTableViewCell" bundle:nil] forCellReuseIdentifier:@"StepTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HealthPlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"HealthPlanTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XKMyPlanLookCell" bundle:nil] forCellReuseIdentifier:@"XKMyPlanLookCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HealthPlanTopCell" bundle:nil] forCellReuseIdentifier:@"HealthPlanTopCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XKHotTopicChildCell" bundle:nil] forCellReuseIdentifier:@"XKHotTopicChildCell"];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKNewHomeHealthPlanCell" bundle:nil] forCellReuseIdentifier:@"HomeHealthPlan"];
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   if (section==4) {
        return self.HotTopicList.count;
    }
    else if (section==2) {
        return self.HealthPlanList.count>0?(self.HealthPlanList.count):1;
      
    }
    else{
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    if (indexPath.section==0) {
//        NSString *cellid = @"StepTableViewCell";
//        StepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//        if (cell == nil) {
//            cell = [[NSBundle mainBundle]loadNibNamed:@"StepTableViewCell" owner:nil options:nil].firstObject;
//        }
//        cell.delegate = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.data = self.HealthData;
//        return cell;
//
//    }
//    else
        if (indexPath.section==0)
    {
        NSString *cellid = @"RemindCell";
        RemindCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.healthData = self.HealthData;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else  if (indexPath.section==1) {
        NSString *cellid = @"MoodTableViewCell";
        MoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
        
    }
    else  if (indexPath.section==2) {
        
         if (self.HealthPlanList.count > 0) {
        if (indexPath.row == 0&& self.HealthPlanList.count>1) {
            NSString *cellid = @"HealthPlanTopCell";
            HealthPlanTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            cell.planModel = self.HealthPlanList[indexPath.row];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == self.HealthPlanList.count-1&& self.HealthPlanList.count>1)
        {
            NSString *cellid = @"HealthPlanTableViewCell";
            HealthPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            cell.planModel = self.HealthPlanList[indexPath.row];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
            UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth, KHeight(126)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
            maskTwoLayer.frame = corTwoPath.bounds;
            maskTwoLayer.path=corTwoPath.CGPath;
            cell.layer.mask=maskTwoLayer;
            return cell;
            
        }else
        {
            
            NSString *cellid = @"XKMyPlanLookCell";
            XKMyPlanLookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            XKHomePlanModel *mod  = self.HealthPlanList[indexPath.row];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.HealthPlanList.count-1 == indexPath.row&& self.HealthPlanList.count == 1) {
                mod.isMiddle = YES;
                cell.planModel = mod;
                return cell;
            }
            else
                cell.planModel = mod;
            return cell;
            
        }

         }else{
            
            XKNewHomeHealthPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHealthPlan" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.isEmpty = YES;
             cell.delegate = self;
            return cell;
        }
    }
    else  if (indexPath.section==3)
    {
        NSString *cellid = @"HealthTestTableViewCell";
        HealthTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.listModArr =  self.SelfSetListArr;
        return cell;
    }
    else
    {
        XKHotTopicChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKHotTopicChildCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.HotTopicList[indexPath.row];
        if (self.HotTopicList.count-1 == indexPath.row) {
           XKTopicModel *modelTpoic =  self.HotTopicList[indexPath.row];
            CGFloat TopicCornerHeight = KHeight(136);
            if (modelTpoic.PublishFlag == 2) {
                
               TopicCornerHeight = KHeight(136)+179;
                
            }else if (modelTpoic.PublishFlag == 1)
            {
               
               TopicCornerHeight = KHeight(136)+(((KScreenWidth - (2 * 25)-4) / 3)*73.0/109.0)+4+2;
            }else
                TopicCornerHeight =KHeight(136);//有视频和图片数据时添加高度129等,无则
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, TopicCornerHeight) byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = CGRectMake(0, 0, KScreenWidth-12, TopicCornerHeight);
            maskLayer.path = maskPath.CGPath;
            cell.backSingleView.layer.mask = maskLayer;
             return cell;
        }else
        return cell;
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0){
//        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
//        headV.titleLab.attributedText = [NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@(目标3000步)",@"今日步数"] withBigBoldFont:18 withNeedchangeText:@"(目标3000步)" withSmallFont:14 dainmaicColor:[UIColor colorWithHexString:@"2C4667"] excisionColor:[UIColor colorWithHexString:@"7C838C"]];
////        headV.titleLab.text=@"今日步数";
//        headV.delegate = self;
//        headV.moreLab.hidden = YES;
//        headV.arrowImg.hidden = YES;
//        return headV;
//    }else
        if (section == 0){
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康提醒";
        headV.delegate = self;
        
        headV.moreLab.hidden = YES;
        headV.arrowImg.hidden = YES;
        return headV;
    }
    else if (section == 1){
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"心情调节";
        headV.delegate = self;
        headV.moreLab.hidden = YES;
        headV.arrowImg.hidden = YES;
        return headV;
    }
    else if (section == 2){
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康计划";
        headV.delegate = self;
        return headV;
    } else if (section == 3){
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康自测";
        headV.delegate = self;
        return headV;
    }
    else {
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"热门话题";
        headV.delegate = self;
        return headV;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section<=4) {
        return 45+6;
    }
    
    else
    {
        
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 6.f;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 5) {
//        
//    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        XKTopicHotDetialController *topic = [[XKTopicHotDetialController alloc]init];
        XKTopicModel *model = self.HotTopicList[indexPath.row];
        topic.modelID = model.TopicID;
        topic.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topic animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        return 134;
//    }
   
    if (indexPath.section==1) {
        return 130;
    }
    if (indexPath.section==0) {
        return  (KScreenWidth - 30-10)/3.0*346/214.0;//214/346
    }
//    if (indexPath.section==4) {
//        return 533;
//    }
    if (indexPath.section==3) {
        //dzc todo 11.18 (KScreenWidth-5-18*2)/      158/246
        NSInteger count =  (self.SelfSetListArr.count+1)/2;
        if (count>0) {
            return (KScreenWidth-5-18*2)/2*190.0/158.0*count+10+30.f;

        }else
            return 0.01;
    }

    if (indexPath.section==2) {
        
        if (indexPath.row !=0&& self.HealthPlanList.count>1&&indexPath.row !=self.HealthPlanList.count-1){
            
            return KHeight(126)-10;
        }else
        {
            if (self.HealthPlanList.count-1 == indexPath.row&& self.HealthPlanList.count == 1)
                return KHeight(126);
            
        }
        return 218*(KScreenWidth-36)/716+30.0;
    }
    else{//话题
        XKTopicModel *model = self.HotTopicList[indexPath.row];
        if (model.PublishFlag == 2) {
          
             return KHeight(136)+179;
            
        }else if (model.PublishFlag == 1)
        {
             return KHeight(136)+(((KScreenWidth - (2 * 25)-4) / 3)*73.0/109.0)+4+2;
        }else
           return KHeight(136);//有视频和图片数据时添加高度129等,无则
    }
    
}
-(void)jumpTopXKHotTopicChildCellBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
{
    if (publishFlag == 1) {
        self.bigPhoto.photoSizeArray = sizeArr;
        
        self.bigPhoto.photoArray = photoArray;
        self.bigPhoto.currentPage = page;
        [[UIApplication sharedApplication].keyWindow addSubview:self.bigPhoto];
    }else if (publishFlag == 2)
    {
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBigView];
        
    }
    
    
}
- (void)buttonClickMainAtIndex:(NSString *)url title:(NSString *)title index:(NSInteger)tag;
{
    
    
    if (tag == 5) {
        XKTopicHomeController *info = [[XKTopicHomeController alloc]initWithType:pageTypeNormal];
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }else if(tag == 4)
    {
        
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
        web.isNewHeight = YES;
        web.urlString = kHealthPlanUrl;
        web.myTitle = @" ";
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }
    else if(tag == 6)
    {
        
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
        web.isNewHeight = YES;
        web.urlString = url;
        web.myTitle = @" ";
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }
    else
    {
        
        SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
        sport.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sport animated:YES];
        
    }
}
#pragma mark 健康自测
-(void)HealthTestTableViewCellJoinAction:(NSString *)cellIndexStr;
{
    
//    if (self.headViewDataArray.count == 0)
//    {
//        [AlertView showMessage:@"正在拉取数据,请稍后重试" withTitle:@"提示" sureButtonTitle:@"确定"];
//        return;
//    }
//
//    //            for (NSDictionary *dic in self.headViewDataArray)
//    //            {
//    //                if ([dic[@"SetCategoryName"] isEqualToString:@"健商"])
//    //                {
//    //                    test.dataDic = dic;
//    //                }
//    //            }
//      [[XKLoadingView shareLoadingView]showLoadingText:nil];
//    ReadyTestViewController *test = [[ReadyTestViewController alloc]initWithType:pageTypeNormal];
//
//    test.myTitle = @"健康自测";
//
//    for (NSDictionary *dic in self.headViewDataArray)
//    {
//        NSString *cateGoryName = dic[@"SetCategoryName"];
//        if ([cellIndexStr containsString:cateGoryName])
//        {
//            test.dataDic = dic;
//        }
//    }
//    test.hidesBottomBarWhenPushed = YES;
//     [[XKLoadingView shareLoadingView] hideLoding];
//    [self.navigationController pushViewController:test animated:YES];
    
    
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    web.urlString = [NSString stringWithFormat:@"%@&TestSetId=%@",kHealthTestItemUrl,cellIndexStr];;
    web.myTitle = @" ";
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}
-(void)HealthTestdetailChangeDataSoure:(CheckListModel *)cellListMod;
{
    
        for (int i= 0; i< self.SelfSetListArr.count; i++) {
            CheckListModel *topic = self.SelfSetListArr[i];
            if (topic == cellListMod) {
                [self.dataArray replaceObjectAtIndex:i withObject:cellListMod];
                [self.tableView reloadData];
                break;
            }

        }
}
#pragma mark dataSource热门话题代理
-(void)changeDataSource:(XKTopicModel *)model{
    
    //    for (int i= 0; i<self.hotTopicList.count; i++) {
    //        XKTopicModel *topic = self.hotTopicList[i];
    //        if (topic == model) {
    //            [self.hotTopicList replaceObjectAtIndex:i withObject:model];
    //            [self.tableView reloadData];
    //
    //            break;
    //        }
    //
    //    }
    
}
-(void)jumpTopTopicBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
{
    

    
    
//  XKVideoBigView *video = [[[NSBundle mainBundle] loadNibNamed:@"XKVideoBigView" owner:self options:nil] lastObject];
    
    if (publishFlag == 1) {
        self.bigPhoto.photoSizeArray = sizeArr;

        self.bigPhoto.photoArray = photoArray;
        self.bigPhoto.currentPage = page;
        [[UIApplication sharedApplication].keyWindow addSubview:self.bigPhoto];
    }else if (publishFlag == 2)
    {
        
     
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBigView];
        
    }
    
    
}
#pragma mark 提醒代理
- (void)RemindDataClick:(NSInteger)remindType;
{
    
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
    web.isNewHeight = YES;
    web.urlString = remindType==0?kHealthDrinkUrl:(remindType==1)?kHealthSitDownUrl:kHealthMedicnaeUrl;
    web.myTitle = @" ";
    web.hidesBottomBarWhenPushed = YES;
    if (remindType == 0) {
        //展示当天任务是否完成喝水
//        XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
//        [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(14)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(14)}];
    }
    [self.navigationController pushViewController:web animated:YES];
    
}
#pragma mark NetWorking
//拉去数据
- (void)getHealthTestData
{
    ///一页返回的试题数量
    NSInteger pageSize = 8;
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"PageIndex":@(self.pageIndex),
                          @"PageSize":@(pageSize)};
    [HomeViewModel getHealthTestWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            //下拉刷新
            if (self.pageIndex == 1) {
                
                NSArray *listArray = response.Result[@"OtherList"];
                NSArray *headViewArray = response.Result[@"FixedList"];
                
                self.headViewDataArray = [NSMutableArray arrayWithArray:headViewArray];
                self.dataArray = [NSMutableArray arrayWithArray:listArray];
                
                [self.tableView reloadData];
                
            }else{
                
                //上拉加载
                NSArray *listArray = response.Result[@"OtherList"];
                NSArray *headViewArray = response.Result[@"FixedList"];
                
                [self.headViewDataArray addObjectsFromArray:headViewArray];
                [self.dataArray addObjectsFromArray:listArray];
                
                [self.tableView reloadData];
            }
        }
    }];
}
- (void)getHealthTreeData
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          };
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
     NSLog(@"944----%@",dic);
    [HomeViewModel gethometree_getHomeResultUrlWithParams:dic FinishedBlock:^(ResponseObject *response) {
        NSLog(@"944%@",response.Result);
        [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            self.HealthData = [HealthData mj_objectWithKeyValues:response.Result[@"HealthData"]];
            
            self.HealthPlanList = (NSMutableArray *)[XKHomePlanModel mj_objectArrayWithKeyValuesArray:response.Result[@"HealthPlanList"]];
            
            self.HotTopicList = (NSMutableArray *)[XKTopicModel mj_objectArrayWithKeyValuesArray:response.Result[@"HotTopicList"]];
            
             self.SelfSetListArr =     [CheckListModel mj_objectArrayWithKeyValuesArray:response.Result[@"SelfSetList"]];
            self.headView.HealthData = self.HealthData;
            [self.tableView reloadData];
            
        }else
        {
            ShowErrorStatus(response.msg);
            
        }
    }];
}

#pragma mark  HeaderDelegate树的页面跳转
-(void)messageDataSoure;
{
    
    PublicViewController *publicVC = [[PublicViewController alloc]initWithType:pageTypeNormal];
    publicVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:publicVC animated:YES];
    
}
- (void)moodButtonClick:(NSInteger)buttonIndex;
{
    
    if (buttonIndex == 0) {
        BreathTrainViewController *breath = [[BreathTrainViewController alloc]initWithType:pageTypeNoNavigation];
        breath.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:breath animated:YES];
    }
    else
    {
        
        [self getMorningEverningAndMindfulnessListWithNetworking:buttonIndex];
    }
    
}
-(void)goHealthTaskDataSoure;
{
    GoHealthTaskController *go = [[GoHealthTaskController alloc]initWithType:pageTypeNormal];
    go.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:go animated:YES];
    
    
}
-(void)goHealthTreeWebUrl:(NSInteger)treeOrXRun;
{

    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    if (treeOrXRun == 1) {
         web.urlString = kHealthTreeUrl;
    }else  if (treeOrXRun == 2)
    {
         web.urlString = kXRunUrl;
        // 2  XRun   5 我的康币 4 健康学术
    }
    else  if (treeOrXRun == 4)
    {
        web.urlString =kUserBadgeUrl ;
      
    }
    else  if (treeOrXRun == 5)
    {
        web.urlString = kMyKCurrenyUrl;
       
    }
   
   
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}
#pragma mark NetWorking
- (void)getMorningEverningAndMindfulnessListWithNetworking:(NSInteger)trainType;
{
    
    QuietController *train = [[QuietController alloc]initWithType:pageTypeNormal];
    train.isQuietOrMusic = (trainType == 2)?YES:NO;
    train.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:train animated:YES];
    
}
#pragma mark  运动页面跳转
-(void)goSportBtnAction;
{
    SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
    sport.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sport animated:YES];
    
}
- (void)sportbuttonClick;{
    
    SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
    sport.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sport animated:YES];
}
#pragma  amrk   添加计划
-(void)HealthPlanTableViewCellJoinAction:(XKHomePlanModel *)cellModel;
{
    
      [self enterPalnData:cellModel.PlanMainID memPlanID:cellModel.MemPlanID PlanTypeID:cellModel.PlanTypeID];
    
}
-(void)XKMyPlanLookCellJoinAction:(XKHomePlanModel *)cellModel;
{
    
     [self enterPalnData:cellModel.PlanMainID memPlanID:cellModel.MemPlanID PlanTypeID:cellModel.PlanTypeID];
    
}
-(void)HealthPlanTopCellJoinAction:(XKHomePlanModel *)cellModel;{
    
     [self enterPalnData:cellModel.PlanMainID memPlanID:cellModel.MemPlanID PlanTypeID:cellModel.PlanTypeID];
    
}
-(void)enterPalnData:(NSInteger )planMainID memPlanID:(NSInteger )memPlanID PlanTypeID:(NSUInteger)PlanTypeID;{
    NSString *tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanMainIDUrl,(long)planMainID,memPlanID];
    if (PlanTypeID == 1) {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanMainIDUrl,(long)planMainID,memPlanID];
    }else if (PlanTypeID == 2)
    {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanSportIDUrl,(long)planMainID,memPlanID];
    }else
    {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanNurseIDUrl,(long)planMainID,memPlanID];
        
    }
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    web.urlString = tempUrlStr;
    web.myTitle = @"我的计划";
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}
-(void)XKNewHomeHealthPlanCellbuttonClick
{
    
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.urlString = kHealthPlanUrl;
    web.myTitle = @"我的计划";
    web.hidesBottomBarWhenPushed = YES;
    web.isNewHeight = YES;
    [self.navigationController pushViewController:web animated:YES];
}
//1、饮食 2、运动 3、调理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end