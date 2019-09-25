//
//  EditArchiveController.m
//  eHealthCare
//
//  Created by jamkin on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "EditArchiveController.h"
#import "EidtArchvieHeaderView.h"
#import "PersonalDictionaryMsg.h"

@interface EditArchiveController ()<EidtArchvieHeaderViewDelegate>

@property (nonatomic,strong)EidtArchvieHeaderView *headerView;

@property (nonatomic,assign)CGFloat contentHeight;

@end

@implementation EditArchiveController

-(EidtArchvieHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView=[[[NSBundle mainBundle]loadNibNamed:@"EidtArchvieHeaderView" owner:self options:nil]firstObject];
        
        _headerView.frame=CGRectMake(0, 0, KScreenWidth, 1940);
        
        _headerView.delegate=self;
        
    }
    
    return _headerView;
    
}

-(void)justSelfHeight:(CGFloat)height withMothed:(BOOL)isMoreReduce withWay:(NSInteger)way{
    
    CGFloat lastheight=self.headerView.height;
    
    if (way==1) {//加上高度
        
        if (isMoreReduce) {
            
            lastheight+=height;
            
        }else{
            
            return;
            
        }
        
    }else{//减去高度
        
        if (isMoreReduce) {
            
            lastheight-=height;
            
        }else{
            
            return;
            
        }
        
    }
    
    [self.tableView setContentSize:CGSizeMake(0, lastheight)];
    
    XKLOG(@"调整高度");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"居民健康档案";
    
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    self.tableView.showsVerticalScrollIndicator=NO;
    
    self.tableView.showsHorizontalScrollIndicator=NO;
    
    self.tableView.separatorColor=[UIColor whiteColor];
    
    self.tableView.tableHeaderView=self.headerView;
    
    /**调用方法获取之前的 设置的档案信息**/
    [self loadDataShow];
    
    self.contentHeight=self.headerView.height;
    
    if (!self.navigationItem.leftBarButtonItem) {
        
        self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)clickBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**实现当文本失去焦点时重新给表格的头试图赋值的协议方法**/
-(void)changeSelf:(EidtArchvieHeaderView *)head withHeight:(CGFloat)Height{
    
    [self.tableView setContentSize:CGSizeMake(0, Height)];
    
    head.delegate=self;
    
    self.tableView.tableHeaderView=head;
    
}

/**获取相关的档案编辑信息回滚显示**/
-(void)loadDataShow{
    
//    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token};
    
    [NetWorkTool postAction:checkHomeGetPersonalReport params:dic finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            self.headerView.personalDictionaryMsg=[PersonalDictionaryMsg mj_objectWithKeyValues:response.Result];
            
            self.headerView.personArc=self.personArc;
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
//    [ProtosomaticHttpTool protosomaticPostWithURLString:@"309" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token} success:^(id json) {
//
//        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
//
//            XKLOG(@"309:%@",json);
//
//            [[XKLoadingView shareLoadingView] hideLoding];
//
//            self.headerView.personalDictionaryMsg=[PersonalDictionaryMsg objectWithKeyValues:json[@"Result"]];
//
//            self.headerView.personArc=self.personArc;
//
//        }else{
//
//            XKLOG(@"操作失败");
//
//            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
//
//        }
//
//    } failure:^(id error) {
//
//        XKLOG(@"%@",error);
//
//        [[XKLoadingView shareLoadingView] errorloadingText:error];
//
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
