//
//  ArchiveViewController.m
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArchiveViewController.h"
#import "PersonalArchiveViewController.h"
#import "ExamineReportViewController.h"
#import "EditArchiveController.h"
#import "PersonalArcModel.h"

#import "NewTrendHomeController.h"

@interface ArchiveViewController ()
{
    UIButton *rightBtn;
    BOOL isDoneReport;
    BOOL isPersonArchive;//
}
//@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (nonatomic, strong)UISegmentedControl *mySegment;
@property (nonatomic, strong)PersonalArchiveViewController *personalVC;
@property (nonatomic, strong)ExamineReportViewController *examVC;

@property (nonatomic,strong)PersonalArcModel *personalArcModel;

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = NAVICOLOR;
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.mySegment = [[UISegmentedControl alloc]initWithItems:@[@"检测报告",@"个人档案"]];
    self.mySegment.frame =CGRectMake(0, 0, 176, 29);
    CALayer *viewLayer = self.mySegment.layer;
    [viewLayer setFrame:CGRectMake(0, 0, 176, 34)];
    [self.mySegment setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.mySegment setTitleTextAttributes:@{NSForegroundColorAttributeName :NAVICOLOR} forState:UIControlStateSelected];
    [self.mySegment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    self.mySegment.tintColor = [UIColor whiteColor];
    [self.mySegment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.mySegment;
    
    self.examVC = [[ExamineReportViewController alloc]init];
    self.examVC.view.frame = self.view.frame;
    self.personalVC = [[PersonalArchiveViewController alloc]init];
    self.personalVC.view.frame = self.view.frame;
    //    self.isHistoryReport = YES;
    if (self.isHistoryReport) {
        self.mySegment.selectedSegmentIndex = 0;
        
        [self.view addSubview:self.personalVC.view];
        [self.view addSubview:self.examVC.view];
        
        
      
   
        
    }else{
        self.mySegment.selectedSegmentIndex = 1;
        
        [self.view addSubview:self.examVC.view];
        [self.view addSubview:self.personalVC.view];
        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(takeData:) name:@"sendData" object:nil];
    
    rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [rightBtn setTitle:@"编辑" forState:UIControlStateHighlighted];
    
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    
    [rightBtn setTintColor:[UIColor whiteColor]];
    
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    
    [rightBtn addTarget:self action:@selector(toEdit) forControlEvents:UIControlEventTouchUpInside];
    
    //隐藏编辑按钮，和查看报告请求数据的判断处理
    if (self.isHistoryReport) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"xk_archirvetendency"] highImage:[UIImage imageNamed:@"xk_archirvetendency"] target:self action:@selector(actionTrend) forControlEvents:UIControlEventTouchUpInside];
        
        if (!isDoneReport) {
            [self.examVC loadData];
            isDoneReport = YES;
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xk_archivetendency"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(trendIndex)];
        
    }else{
        
        if (!isPersonArchive) {
            [self.personalVC loadData];
            isPersonArchive = YES;
        }
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    }
    
}

/**趋势指标的跳转*/
-(void)actionTrend{
    XKLOG(@"趋势指标");
    NewTrendHomeController *trendVC=[[NewTrendHomeController alloc]init];
    [self.navigationController pushViewController:trendVC animated:YES];
}

-(void)takeData:(NSNotification *)noti{
    
    self.personalArcModel=noti.object;
    
}

/**
 趋势指标
 */
-(void)trendIndex
{
    NewTrendHomeController *trend = [[NewTrendHomeController alloc]init];
    
    [self.navigationController pushViewController:trend animated:YES];
}

-(void)toEdit{
    
    XKLOG(@"编辑个人档案");
    
    if (!self.personalArcModel) {
        
        ShowMessage(@"请稍等...");
//        [[XKLoadingView shareLoadingView]errorloadingText:@"请稍等..."];
        
        return;
        
    }else{
        
        if (!self.personalArcModel.RecordID||self.personalArcModel.RecordID.length==0||[self.personalArcModel.RecordID isEqualToString:@" "]||[self.personalArcModel.RecordID integerValue]==0) {
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先去线下体检" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                return ;
                
            }];
            
            UIAlertAction *action2=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                return ;
                
            }];
            
            [alert addAction:action1];
            
            [alert addAction:action2];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
            
        }else{
            
            EditArchiveController *eidt=[[EditArchiveController alloc]init];
            
            eidt.personArc=self.personalArcModel;
            
            [self.navigationController pushViewController:eidt animated:YES];
            
        }
        
    }
    
}

-(void)clickSegment:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 1) {
        [self.view addSubview:self.personalVC.view];
        [self.view bringSubviewToFront:self.personalVC.view];
        [self.examVC.view removeFromSuperview];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

        if (!isPersonArchive) {
            [self.personalVC loadData];
            isPersonArchive = YES;
        }
    }else{
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"xk_archirvetendency"] highImage:[UIImage imageNamed:@"xk_archirvetendency"] target:self action:@selector(actionTrend) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.examVC.view];
        [self.view bringSubviewToFront:self.examVC.view];
        [self.personalVC.view removeFromSuperview];
//        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"xk_archivetendency"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(trendIndex)];
        //当点击检测报告按钮时，请求检测报告页面的数据
        if (!isDoneReport) {
            [self.examVC loadData];
            isDoneReport = YES;
        }
    }
}

-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(void)judge
//{
//    if (self.mySegment.selectedSegmentIndex == 1) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"homeFresh1" object:nil];
//    }
//}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
