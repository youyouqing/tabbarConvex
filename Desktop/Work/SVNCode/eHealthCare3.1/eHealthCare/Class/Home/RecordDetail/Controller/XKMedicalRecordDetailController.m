//
//  XKMedicalRecordDetailController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMedicalRecordDetailController.h"
#import "XKRecordBasisCell.h"
#import "XKRecordTypeCell.h"
#import "XKRecordHospitalMessageCell.h"
#import "XKRecordSeeDoctorCell.h"
#import "XKRecordPhotoCell.h"
#import "XKPatientDetailModel.h"
#import "XKMedicalLookBigPhotoController.h"
#import "Judge.h"
#import "RecordLookTopTableViewCell.h"
@interface XKMedicalRecordDetailController ()<XKRecordPhotoCellDelegate,XKRecordSeeDoctorCellDelegate,XKRecordHospitalMessageCellDelegate,XKRecordTypeCellDelegate,XKRecordBasisCellDelegate>

@property (nonatomic,strong) XKPatientDetailModel *detailModel;

@property (nonatomic,assign) BOOL isEnableEdit;
@property (nonatomic, strong)UITableView *tableView;

/**
 控制图片高度
 */
@property (nonatomic,assign) CGFloat photoHeightControl;

@end

@implementation XKMedicalRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.textColor = kMainTitleColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
 [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor =kbackGroundGrayColor;
    self.tableView.backgroundColor = kbackGroundGrayColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalArchiveCell" bundle:nil] forCellReuseIdentifier:@"PersonalArchiveCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo((PublicY));
        make.left.mas_equalTo(0 );
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo( CGRectGetWidth(self.view.frame));
    }];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordBasisCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordTypeCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordHospitalMessageCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordSeeDoctorCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordPhotoCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordLookTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecordLookTopTableViewCell"];
    
    self.myTitle = @"查看电子病历";
    [self.rightBtn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    self.isEnableEdit = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_medicalcase_edit"] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self loadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}

/**
 图片改变的时候修改原来的数据源
 */
-(void)photoFixDataSource:(XKPatientDetailModel *)data{
    self.detailModel = data;
}

/**
 就诊原因接诊结果改变的时候修改原来的数据源
 */
-(void)seeDoctorFixDataSource:(XKPatientDetailModel *)model{
    self.detailModel = model;
}
/**
 医院信息改变的时候修改原来的数据源
 */
-(void)hospitalMessageFix:(XKPatientDetailModel *)data{
    self.detailModel = data;
}
/**
 头部所有的修改原来的数据源
 */
-(void)RecordLookTopDataSource:(XKPatientDetailModel *) model;
{
    
     self.detailModel = model;
    
}
/**
 就诊类型改变的时候修改原来的数据源
 */
-(void)typeFixDataSource:(XKPatientDetailModel *)model{
    self.detailModel = model;
    
    [self.tableView reloadData];
}
/**
 就诊基本信息改变的时候修改原来的数据源
 */
-(void)basisFixDataSource:(XKPatientDetailModel *)data{
    self.detailModel = data;
}
/**
 查看大图功能
 */
-(void)jumpTopBigPhoto:(NSArray *) photoArray withPage:(NSInteger) page{
    XKMedicalLookBigPhotoController *bigPhoto = [[XKMedicalLookBigPhotoController alloc] initWithType:pageTypeNoNavigation];
    bigPhoto.photoArray = photoArray;
    bigPhoto.currentPage = page;
    [self.navigationController pushViewController:bigPhoto animated:YES];
}

/**
 重新刷新视图
 */
-(void)reloadPhotoViewHeight:(NSArray *)photoArray{
    
    if (photoArray.count < 3) {
        self.photoHeightControl = (KScreenWidth-80)/3 + 90;
    }
    
    if (photoArray.count == 3) {
        if (self.isEnableEdit) {
            self.photoHeightControl = (KScreenWidth-80)/3*2 + 90 +10;
        }else{
            self.photoHeightControl = (KScreenWidth-80)/3 + 90;
        }
    }
    
    if (photoArray.count >3 && photoArray.count <6) {
        self.photoHeightControl = (KScreenWidth-80)/3*2 + 90 +10;
    }
    
    if (photoArray.count == 6) {
        if (self.isEnableEdit) {
            self.photoHeightControl = (KScreenWidth-80)/3*3 + 90 +20;
        }else{
            self.photoHeightControl = (KScreenWidth-80)/3*2 + 90 +10;
        }
    }
    
    if (photoArray.count > 6) {
        self.photoHeightControl = (KScreenWidth-80)/3*3 + 90 + 20;
    }

    self.detailModel.PicList = nil;
    self.detailModel.PicList = [NSMutableArray arrayWithCapacity:0];
    for (int i= 0; i<photoArray.count; i++) {
        [self.detailModel.PicList addObject:photoArray[i]];
    }
    
    [self.tableView reloadData];
    
}

-(void)loadData{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"930" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"PatietnID":@(self.model.PatientID)} success:^(id json) {
        
        NSLog(@"930--------%@",json);
        [[XKLoadingView shareLoadingView]hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            self.detailModel = [XKPatientDetailModel objectWithKeyValues:json[@"Result"]];
            if (self.detailModel.PicList.count <= 3) {
                self.photoHeightControl = (KScreenWidth-80)/3+90;
            }
            if (self.detailModel.PicList.count >= 3 && self.detailModel.PicList.count <= 6) {
                self.photoHeightControl = (KScreenWidth-80)/3*2+90+10;
            }
            if (self.detailModel.PicList.count >= 6 && self.detailModel.PicList.count <= 9) {
                self.photoHeightControl = (KScreenWidth-80)/3*3+90+20;
            }

            [self.tableView reloadData];
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:@"亲，网速不给力哇~"];
        
    }];

    
}

-(void)clickEdit{
    
    NSLog(@"修改电子病历");
    
    if ([self.rightBtn.titleLabel.text isEqualToString:@"编辑"]) {
         [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.isEnableEdit = YES;
        [self.tableView reloadData];
        
    }else{
        
        [self.tableView reloadData];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        dict[@"Token"] = [UserInfoTool getLoginInfo].Token;
        dict[@"MemberID"] = @(self.MemberID);
        dict[@"MemberName"] = self.detailModel.MemberName;
        dict[@"PatientID"] = @(self.detailModel.PatientID);
        for (XKPatientTypeModel *type in self.typeArray) {
            if (self.detailModel.AttendanceType == type.PatientTypeID) {
                
                dict[@"AttendanceType"] = @(type.PatientTypeID);
                
                break;
                
            }
        }
        dict[@"AttendanceTime"] = @(self.detailModel.AttendanceTime);
        dict[@"AttendanceHospital"] = self.detailModel.AttendanceHospital;
        dict[@"DepartmentsName"] = self.detailModel.DepartmentsName;
        dict[@"DoctorName"] = self.detailModel.DoctorName;
        dict[@"AttendanceReason"] = self.detailModel.AttendanceReason;
        dict[@"AttendanceResult"] = self.detailModel.AttendanceResult;
//        NSMutableArray *PicList = [NSMutableArray arrayWithCapacity:0];
//        for (XKPatientPhotoModel *photo in self.detailModel.PicList) {
//            NSDictionary *pDict = @{@"ID":@(photo.ID),@"PicUrl":photo.PicUrl,@"PicStatus":@(photo.PicStatus)};
//            [PicList addObject:pDict];
//        }
//        dict[@"PicList"] = PicList;
        
        
        if (self.detailModel.AttendanceType == 0) {
            ShowErrorStatus(@"请选择病历类型" );
            return;
        }else if(self.detailModel.AttendanceType == 4){
            //判断非空输入
            if (self.detailModel.MemberName.length == 0) {
                ShowErrorStatus(@"请输入就诊人" );
                return;
            }
           if (self.detailModel.AttendanceTime == 0) {
                ShowErrorStatus(@"请选择就诊时间" );
                return;
            }
                        
            //判断特殊字符输入
            if ([NSString JudgeTheillegalCharacter:self.detailModel.MemberName]) {
                ShowErrorStatus(@"就诊人不能输入特殊字符" );
                return;
            }
            
        }else{
            
            if (self.detailModel.MemberName.length == 0) {
                ShowErrorStatus(@"请输入就诊人" );
                return;
            }
            
            if (self.detailModel.AttendanceTime == 0) {
                ShowErrorStatus(@"请选择就诊时间" );
                return;
            }
            
            if (self.detailModel.AttendanceHospital == 0) {
                ShowErrorStatus(@"请输入就诊医院" );
                return;
            }
            

            
            if (self.detailModel.AttendanceReason == 0) {
                ShowErrorStatus(@"请输入就诊原因" );
                return;
            }
            
            if (self.detailModel.AttendanceResult == 0) {
                ShowErrorStatus(@"请输入就诊结果" );
                return;
            }
            
            if ([NSString JudgeTheillegalCharacter:self.detailModel.MemberName]) {
                ShowErrorStatus(@"就诊人不能含有特殊字符" );
                return;
            }
            
            if ([NSString JudgeTheillegalCharacter:self.detailModel.AttendanceHospital]) {
                ShowErrorStatus(@"就诊医院不能含有特殊字符" );
                return;
            }
            
            if (self.detailModel.DepartmentsName.length>0) {
                
                if ([NSString JudgeTheillegalCharacter:self.detailModel.DepartmentsName]) {
                    ShowErrorStatus(@"就诊科室不能含有特殊字符" );
                    return;
                }
               
            }
            if (self.detailModel.DoctorName.length>0) {
                
                if ([NSString JudgeTheillegalCharacter:self.detailModel.DoctorName]) {
                    ShowErrorStatus(@"就诊医生不能含有特殊字符" );
                    return;
                }
                
            }

        }
        NSLog(@"%@",dict);
        [[XKLoadingView shareLoadingView]showLoadingText:nil];
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"929" parameters:dict success:^(id json) {
            
            NSLog(@"%@",json);
            
            [[XKLoadingView shareLoadingView]hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                self.isEnableEdit = NO;
                [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
                NSLog(@"修改成功");
                [[XKLoadingView shareLoadingView] showLoadingText:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //确保修改成功之后可以返回回去
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                [[XKLoadingView shareLoadingView]errorloadingText:@"修改失败"];
                
            }
            
        } failure:^(id error) {
            
            NSLog(@"%@",error);
            [[XKLoadingView shareLoadingView]errorloadingText:@"修改失败"];
            
        }];
        
        //循环上传病历图片
        for (int i=0; i<self.detailModel.PicList.count; i++) {
            if ([self.detailModel.PicList[i] isKindOfClass:[UIImage class]]) {
                UIImage *imageNew = self.detailModel.PicList[i];
//                UIImage *img = [imageNew imageByScalingAndCroppingForSize:CGSizeMake(200, 200)];
                NSData *data= UIImageJPEGRepresentation(imageNew, 1);//UIImagePNGRepresentation(img);
               
                NSString *str=[data base64EncodedStringWithOptions:0];
                NSMutableString *mstr=[[NSMutableString alloc]initWithString:str];
                NSString *ss=[mstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
                [[XKLoadingView shareLoadingView]showLoadingText:nil];
                [ProtosomaticHttpTool protosomaticPostWithURLString:@"931" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"PatientID":@(self.detailModel.PatientID),@"HeadBinary":ss} success:^(id json) {
                    NSLog(@"%@",json);
                    
                    [[XKLoadingView shareLoadingView]hideLoding];
                    if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                        self.isEnableEdit = NO;
                         [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
                        NSLog(@"上传图片成功");

                    }else{
                        [[XKLoadingView shareLoadingView]errorloadingText:@"上传图片失败"];
                        
                    }
                    
                } failure:^(id error) {
                    
                    NSLog(@"%@",error);
                    [[XKLoadingView shareLoadingView]errorloadingText:@"上传图片失败"];
                    
                }];
            }
        }
        
    }
    
}

#pragma mark - 点击事件
-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.detailModel) {
        return 0;
    }else{
//        if (self.detailModel.AttendanceType == 4) {
            return 3;
//        }else{
//            return 5;
//        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.detailModel.AttendanceType == 4) {
    
        if (indexPath.row == 0) {
            
            RecordLookTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordLookTopTableViewCell" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.typeArray = self.typeArray;
            cell.isEnableEdit = self.isEnableEdit;
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
//        if (indexPath.row == 1) {
//
//            XKRecordTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//            cell.model = self.detailModel;
//            cell.typeArray = self.typeArray;
//            cell.delegate = self;
//            cell.isEnableEdit = self.isEnableEdit;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            return cell;
//        }
//
//        if (indexPath.row == 2) {
//
//            XKRecordPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
//            cell.isEnableEdit = self.isEnableEdit;
//            cell.previewMothed = 2;//设置图片预览方式
//            cell.delegate = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.detailModel;
//            return cell;
//
//        }
//
//    }else{
//        if (indexPath.row == 0) {
//
//            XKRecordBasisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//            cell.model = self.detailModel;
//            cell.delegate = self;
//            cell.isEnableEdit = self.isEnableEdit;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//
//        if (indexPath.row == 1) {
//
//            XKRecordTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//            cell.typeArray = self.typeArray;
//            cell.isEnableEdit = self.isEnableEdit;
//            cell.delegate = self;
//            cell.model = self.detailModel;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            return cell;
//        }
//
//        if (indexPath.row == 2) {
//
//            XKRecordHospitalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//            cell.model = self.detailModel;
//            cell.delegate = self;
//            cell.isEnableEdit = self.isEnableEdit;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            return cell;
//
//        }
//
        if (indexPath.row == 1) {
            
            XKRecordSeeDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.delegate = self;
            cell.isEnableEdit = self.isEnableEdit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
        if (indexPath.row == 2) {
            
            XKRecordPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            cell.delegate = self;
            cell.model = self.detailModel;
            cell.previewMothed = 2;//设置图片预览方式
            cell.isEnableEdit = self.isEnableEdit;
            cell.heightCons.constant = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
//        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.detailModel.AttendanceType == 4) {
        if (indexPath.row == 0) {
            return 180;
        }
//
//        if (indexPath.row == 1) {
//            return 50;
//        }
//
//        if (indexPath.row == 2) {
//
//            if (self.photoHeightControl) {
//                return self.photoHeightControl;
//            }else{
//                return 215;
//            }
//
//        }
//    }else{
//        if (indexPath.row == 0) {
//            return 150.5;
//        }
//
//        if (indexPath.row == 1) {
//            return 50;
//        }
//
//        if (indexPath.row == 2) {
//            return 164.5;
//        }
    
        if (indexPath.row == 1) {
            
            return 292;
            
        }
        
        if (indexPath.row == 2) {
            
            if (self.photoHeightControl) {
                return self.photoHeightControl;
            }else{
                return 200;
            }
            
//        }
    }
    return 0;
    
}

@end