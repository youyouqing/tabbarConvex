//
//  ExamDetailReportViewController.m
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ExamDetailReportViewController.h"
#import "DetailReportView.h"
#import "DetailReportModel.h"
#import "ArcDetailReportCell.h"
#import "DetailArcFootCell.h"
#import "XKReportOveralMod.h"
#import "XKHistoryTotalHeadView.h"
#import "XKHistoryTotalCell.h"
#import "XKValidationAndAddScoreTools.h"
@interface ExamDetailReportViewController ()<UITableViewDelegate,UITableViewDataSource,DetailReportViewDelegate>
{
    NSMutableArray *openArr;
    NSMutableArray *dataArr;
    //总监的高度
    double viewHeight;
    
}
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property(strong,nonatomic)XKReportOveralMod *reModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (strong, nonatomic) PersonalArcHeadView *headView;

@end

@implementation ExamDetailReportViewController
-(PersonalArcHeadView *)headView{
    if (!_headView) {
        _headView=[[[NSBundle mainBundle]loadNibNamed:@"PersonalArcHeadView" owner:self options:nil]firstObject];
        _headView.x=0;
        _headView.y=0;
        _headView.width=KScreenWidth;
        _headView.height=180;
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    viewHeight = 50;
    self.topCons.constant = PublicY;
    self.view.backgroundColor = [UIColor whiteColor];
    openArr = [[NSMutableArray alloc]init];;
    dataArr = [[NSMutableArray alloc] init];
    self.myTitle = @"健康报告";
    self.mytable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //预设cell高度
    self.mytable.estimatedRowHeight = 44.0;
    //打开自动计算行高
    self.mytable.rowHeight = UITableViewAutomaticDimension;
    [self.mytable registerNib:[UINib nibWithNibName:@"ArcDetailReportCell" bundle:nil] forCellReuseIdentifier:@"ArcDetailReportCell"];
    [self.mytable registerNib:[UINib nibWithNibName:@"DetailArcFootCell" bundle:nil] forCellReuseIdentifier:@"DetailArcFootCell"];
    [self.mytable registerNib:[UINib nibWithNibName:@"XKHistoryTotalCell" bundle:nil] forCellReuseIdentifier:@"XKHistoryTotalCell"];
    _reModel = [[XKReportOveralMod alloc]init];
    
     self.mytable.tableHeaderView = self.headView;
    //展示当天任务是否完成
    [self loadData];
}
#pragma mark - 请求数据
-(void)loadData
{
    if (self.PhysicalExaminationModel.PhysicalExaminationID.length>0) {
        NSDictionary *dict=@{@"Token": [UserInfoTool getLoginInfo].Token,@"PhysicalExaminationID":self.PhysicalExaminationModel.PhysicalExaminationID.length>0?self.PhysicalExaminationModel.PhysicalExaminationID:@" "};
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"339" parameters:dict success:^(id json) {
            NSLog(@"检测详细报告339：%@",json);
            NSDictionary *dic= (NSDictionary *)json;
            
            if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
                
                _reModel = [XKReportOveralMod objectWithKeyValues:dic[@"Result"]];
                self.headView.exanubeReportModel = self.PhysicalExaminationModel;
                self.headView.model = self.personal;
            }
            
            NSDictionary *dict=@{@"Token": [UserInfoTool getLoginInfo].Token,@"PhysicalExaminationID":self.PhysicalExaminationModel.PhysicalExaminationID.length>0?self.PhysicalExaminationModel.PhysicalExaminationID:@" "};
            
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"302" parameters:dict success:^(id json) {
                NSLog(@"检测详细报告302：%@",json);
                NSDictionary *dic= (NSDictionary *)json;
                
                if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
                    [[XKLoadingView shareLoadingView] hideLoding];
                    
                    dataArr = [NSMutableArray arrayWithArray:[DetailReportModel  objectArrayWithKeyValuesArray:dic[@"Result"]]];
                    //
                    //                    _reModel = [XKReportOveralMod objectWithKeyValues:dic[@"Result"][@"ReportOverallMod"]];
                    
                    for (NSInteger i = 0; i < dataArr.count; i++) {
                        DetailReportModel *model = dataArr[i];
                        [openArr addObject:@"0"];
                        
                        NSArray *temparr = @[@{@"title":@"健康常识",@"text":model.KnowledgeSuggest},@{@"title":@"运动建议",@"text" : model.SportSuggest},@{@"title":@"饮食建议",@"text":model.DrinkSuggest},@{@"title":@"养生建议",@"text" :model.HealthSuggest}];//cell的数据
                        
                        NSMutableArray *suggestTempArr = [[NSMutableArray alloc] init];
                        for (NSDictionary *d in temparr) {
                            if ([NSString stringWithFormat:@"%@",d[@"text"]].length != 0) {
                                [suggestTempArr addObject:d];
                            }
                        }
                        model.suggestArr = suggestTempArr;//每一条对应的建议
                    }
                    
                    if (_reModel.AuditStatus == 1) {
                        
                        [openArr addObject:@"1"];
                        
                    }
                    //                      self.headView.model = self.allDataModel;
                    [self.mytable reloadData];
                }else{
                    [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
                }
            } failure:^(id error) {
                
                NSLog(@"%@",error);
                [[XKLoadingView shareLoadingView] errorloadingText:error];
            }];
            
        } failure:^(id error) {
            
        }];
    }
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_reModel.AuditStatus == 1) {
        return dataArr.count+1;
    }
    else
        return dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_reModel.AuditStatus == 1) {
        
        if (section == dataArr.count&&[openArr[section] isEqualToString:@"1"]) {
            return 1;
        }
        
        else{
            return 0;
        }
        
    }else
    {
        
        if ([openArr[section] isEqualToString:@"1"]) {
            DetailReportModel *model = dataArr[section];
            return model.suggestArr.count ;
        }else{
            return 0;
        }
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == dataArr.count && _reModel.AuditStatus == 1) {
        
        XKHistoryTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKHistoryTotalCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model=_reModel;
        
        return cell;
        
    }else{
        
        if (_reModel.AuditStatus == 0) {
            DetailReportModel *model = dataArr[indexPath.section];
            ArcDetailReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArcDetailReportCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
            //    DetailReportModel *model = dataArr[indexPath.section];
            cell.textLal.text = model.suggestArr[indexPath.row][@"text"];
            cell.titleLal.text = model.suggestArr[indexPath.row][@"title"];
            
            return cell;
            
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            
            return cell;
            
        }
        
        
    }
    
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == dataArr.count) {
        XKHistoryTotalHeadView *v = [[[NSBundle mainBundle]loadNibNamed:@"XKHistoryTotalHeadView" owner:self options:nil] firstObject];
        
        [v setTarget:self action:@selector(clickCellHeadXKHistoryTotalHeadView:)];
        
        
        if ([openArr[dataArr.count] isEqualToString:@"1"]) {
            
            v.arrowIndex = 0;
            
        }else{
            
            v.arrowIndex = 1;
            
        }
        
        return v;
    }
    else
    {
        DetailReportView *view = [[[NSBundle mainBundle]loadNibNamed:@"DetailReportView" owner:self options:nil]firstObject];
        view.width = KScreenWidth;
        view.height = 50;
        view.delegate = self;
        DetailReportModel *model = (DetailReportModel *)dataArr[section];
        model.cellindex = section;
        view.dataModel = model;
        view.tag = section + 800;
        [view setTarget:self action:@selector(clickCellHead:)];
        
        if (_reModel.AuditStatus == 1) {
            view.iconBtn.hidden = YES;
        }
        else
        {
            if ([openArr[section] isEqualToString:@"1"]) {
                [view.iconBtn setImage:[UIImage imageNamed:@"zk"] forState:UIControlStateNormal];
            }else{
                [view.iconBtn setImage:[UIImage imageNamed:@"zk2"] forState:UIControlStateNormal];
            }
            
            
        }
        
        return view;
        
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_reModel.AuditStatus == 1) {
        if (section == dataArr.count) {
            return 65;
        }else
            return   50;
    }
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.01;;
}
#pragma mark - 点击事件
-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - DetailReportViewDelegate

-(void)clickOpenBtn:(NSInteger)index
{
    if ([openArr[index] isEqualToString:@"0"]) {
        [openArr replaceObjectAtIndex:index withObject:@"1"];
    }else{
        [openArr replaceObjectAtIndex:index withObject:@"0"];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
    [self.mytable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
    
}
-(void)examineViewChange:(UIImageView *)openorClose HeightChange:(double )height btn:(UIButton *)btn;
{
    btn.selected  = !btn.selected;
    if (btn.selected) {
        viewHeight = 50;
        [openorClose setImage:[UIImage imageNamed:@"openorClose"]];
    }else{
        viewHeight = height;
        [openorClose setImage:[UIImage imageNamed:@"zk2"] ];
    }
    
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:dataArr.count];
    
    [self.mytable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}
-(void)clickCellHead:(DetailReportView *)view
{
    NSInteger index = view.tag - 800;
    DetailReportModel *model = (DetailReportModel *)dataArr[index];
    if (model.suggestArr.count == 0) {
        return;
    }
    if ([openArr[index] isEqualToString:@"0"]) {
        [openArr replaceObjectAtIndex:index withObject:@"1"];
    }else{
        [openArr replaceObjectAtIndex:index withObject:@"0"];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
    [self.mytable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
-(void)clickCellHeadXKHistoryTotalHeadView:(XKHistoryTotalHeadView*)view
{
    if ([openArr[dataArr.count] isEqualToString:@"0"]) {
        [openArr replaceObjectAtIndex:dataArr.count withObject:@"1"];
    }else{
        [openArr replaceObjectAtIndex:dataArr.count withObject:@"0"];
    }
    [self.mytable reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mytable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end