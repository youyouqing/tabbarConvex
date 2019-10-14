//
//  XKAddMedicalRecordController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKAddMedicalRecordController.h"
#import "XKRecordBasisCell.h"
#import "XKRecordTypeCell.h"
#import "XKRecordHospitalMessageCell.h"
#import "XKRecordSeeDoctorCell.h"
#import "XKRecordPhotoCell.h"
#import "XKPatientDetailModel.h"
#import "XKMedicalLookBigPhotoController.h"

@interface XKAddMedicalRecordController ()<XKRecordPhotoCellDelegate,XKRecordSeeDoctorCellDelegate,XKRecordHospitalMessageCellDelegate,XKRecordTypeCellDelegate,XKRecordBasisCellDelegate>

@property (nonatomic,assign) NSInteger recordType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong) XKPatientDetailModel *detailModel;

@property (nonatomic,assign) BOOL isEnableEdit;

/**
 控制图片高度
 */
@property (nonatomic,assign) CGFloat photoHeightControl;

@end

@implementation XKAddMedicalRecordController

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordBasisCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordTypeCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
//
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordHospitalMessageCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
//
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordSeeDoctorCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
//
//    [self.tableView registerNib:[UINib nibWithNibName:@"XKRecordPhotoCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
//
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.textColor = kMainTitleColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = kbackGroundGrayColor;
    self.tableView.backgroundColor = kbackGroundGrayColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalArchiveCell" bundle:nil] forCellReuseIdentifier:@"PersonalArchiveCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0+(PublicY));
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
    
    self.detailModel = [[XKPatientDetailModel alloc] init];
    self.detailModel.PicList = [NSMutableArray arrayWithCapacity:0];
    self.isEnableEdit = YES;
     self.myTitle = @"添加电子病历";
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_medicalcase_done"] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];

}

-(void)clickEdit{
    
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
    if (self.detailModel.MemberName.length == 0) {
        ShowErrorStatus(@"请输入就诊人" );
        return;
    }
    if (self.detailModel.AttendanceTime == 0) {
        ShowErrorStatus(@"请选择就诊时间" );
        return;
    }
    if (self.detailModel.AttendanceType == 0) {
        ShowErrorStatus(@"请选择就诊类型" );
        return;
    }
    
    if (self.detailModel.AttendanceType != 4) {
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
        if (self.detailModel.AttendanceType == 0) {
            ShowErrorStatus(@"请选择病历类型" );
            return;
        }
    }

   else if(self.detailModel.AttendanceType == 4){
        //非空判断
        if (self.detailModel.MemberName.length == 0) {
            ShowErrorStatus(@"请输入就诊人" );
            return;
        }
        if (self.detailModel.AttendanceTime == 0) {
            ShowErrorStatus(@"请选择就诊时间" );
            return;
        }
        
        //特殊字符判断
        if ([NSString JudgeTheillegalCharacter:self.detailModel.MemberName]) {
            ShowErrorStatus(@"就诊人不能含有特殊字符" );
            return;
        }
        
    }else{
      
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
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"929" parameters:dict success:^(id json) {
        
        NSLog(@"%@",json);
        
        [[XKLoadingView shareLoadingView]hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            NSLog(@"上传成功");
            
            self.detailModel.PatientID = [json[@"Result"][@"PatientID"] integerValue];
            [[XKLoadingView shareLoadingView] showLoadingText:@"上传成功"];
            //循环上传病历图片
            for (int i=0; i<self.detailModel.PicList.count; i++) {
                if ([self.detailModel.PicList[i] isKindOfClass:[UIImage class]]) {
                    
                    UIImage *imageNew = self.detailModel.PicList[i];
//                    UIImage *img = [imageNew imageByScalingAndCroppingForSize:CGSizeMake(200, 200)];
                    NSData *data= UIImageJPEGRepresentation(imageNew, 1);//UIImagePNGRepresentation(img);
                    NSString *str=[data base64EncodedStringWithOptions:0];
                    NSMutableString *mstr=[[NSMutableString alloc]initWithString:str];
                    NSString *ss=[mstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
                    [[XKLoadingView shareLoadingView]showLoadingText:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [ProtosomaticHttpTool protosomaticPostWithURLString:@"931" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"PatientID":@(self.detailModel.PatientID),@"HeadBinary":ss} success:^(id json) {
                            NSLog(@"%@",json);
                            
                            [[XKLoadingView shareLoadingView]hideLoding];
                            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                                self.isEnableEdit = NO;
                                NSLog(@"上传图片成功");
                                
                            }else{
                                //                            [[XKLoadingView shareLoadingView]errorloadingText:@"上传图片失败"];
                            }
                            
                        } failure:^(id error) {
                            
                            //                        NSLog(@"%@",error);
                            //                        [[XKLoadingView shareLoadingView]errorloadingText:@"上传图片失败"];
                            
                        }];
                    });

                }
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //确保修改成功之后可以返回回去
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:@"添加失败"];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:@"添加失败"];
        
    }];

    
}

/**
 图片改变的时候修改原来的数据源
 */
-(void)photoFixDataSource:(XKPatientDetailModel *)data{
    self.detailModel = data;
    NSLog(@"图片改变的时候修改原来的数据源----%@",self.detailModel.PicList);
}

/**
 就诊原因接诊结果改变的时候修改原来的数据源
 */
-(void)seeDoctorFixDataSource:(XKPatientDetailModel *)model{
    self.detailModel = model;
}
//滑动时到最底部让键盘下落  不会再停留在拍照页面
-(void)takePhotoWithKeyboardDone
{
    
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    if (indexPath&&self.detailModel.AttendanceType != 4&&self.detailModel.AttendanceType != 0&&self.detailModel.AttendanceType>0) {
       
            XKRecordSeeDoctorCell *cell =  [self.tableView cellForRowAtIndexPath:indexPath];//bug。 4.1.5版本 6月10号修改
//        [self.tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            if ([cell isKindOfClass:[XKRecordSeeDoctorCell class]]) {
                [cell.resonTxt resignFirstResponder];
                [cell.resultTxt resignFirstResponder];
            }
        
      
      
    }
}
//电子病历查看大图
-(void)jumpTopBigPhoto:(NSArray *) photoArray withPage:(NSInteger) page{
    
    XKMedicalLookBigPhotoController *bigPhoto = [[XKMedicalLookBigPhotoController alloc] initWithType:pageTypeNoNavigation];
    bigPhoto.photoArray = photoArray;
    bigPhoto.currentPage = page;
    [self.navigationController pushViewController:bigPhoto animated:YES];
    
}

/**
 医院信息改变的时候修改原来的数据源
 */
-(void)hospitalMessageFix:(XKPatientDetailModel *)data{
    self.detailModel = data;
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
        if (self.detailModel.AttendanceType == 0) {
           return 2;
        }else if (self.detailModel.AttendanceType == 4) {
            return 3;
        }else{
            return 5;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.detailModel.AttendanceType == 0) {
        
        if (indexPath.row == 0) {
            
            XKRecordBasisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.delegate = self;
            cell.isEnableEdit = self.isEnableEdit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            
            XKRecordTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.typeArray = self.typeArray;
            cell.isEnableEdit = self.isEnableEdit;
            cell.delegate = self;
            cell.model = self.detailModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
    }else if(self.detailModel.AttendanceType == 4) {
        
        if (indexPath.row == 0) {
            
            XKRecordBasisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.isEnableEdit = self.isEnableEdit;
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            
            XKRecordTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.delegate = self;
            cell.isEnableEdit = self.isEnableEdit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        if (indexPath.row == 2) {
            
            XKRecordPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            cell.isEnableEdit = self.isEnableEdit;
            cell.delegate = self;
             cell.previewMothed = 1;//设置图片预览方式
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.detailModel;
            return cell;
            
        }
        
    }else{
        if (indexPath.row == 0) {
            
            XKRecordBasisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.delegate = self;
            cell.isEnableEdit = self.isEnableEdit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            
            XKRecordTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.typeArray = self.typeArray;
            cell.isEnableEdit = self.isEnableEdit;
            cell.delegate = self;
            cell.model = self.detailModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        if (indexPath.row == 2) {
            
            XKRecordHospitalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.delegate = self;
            cell.isEnableEdit = self.isEnableEdit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
        if (indexPath.row == 3) {
            
            XKRecordSeeDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.model = self.detailModel;
            cell.delegate = self;
            cell.isEnableEdit = self.isEnableEdit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
        if (indexPath.row == 4) {
            
            XKRecordPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            cell.delegate = self;
            cell.previewMothed = 2;//设置图片预览方式
            cell.model = self.detailModel;
            cell.isEnableEdit = self.isEnableEdit;
            cell.heightCons.constant = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.detailModel.AttendanceType == 0) {
        if (indexPath.row == 0) {
            return 100.5;
        }
        
        if (indexPath.row == 1) {
            return 50;
        }

    }
    else if (self.detailModel.AttendanceType == 4) {
        if (indexPath.row == 0) {
            return 100.5;
        }
        
        if (indexPath.row == 1) {
            return 50;
        }
        
        if (indexPath.row == 2) {
            if (self.photoHeightControl) {
                return self.photoHeightControl;
            }else{
                return 200;
            }
        }
    }else{
        if (indexPath.row == 0) {
            return 100.5;
        }
        
        if (indexPath.row == 1) {
            return 50;
        }
        
        if (indexPath.row == 2) {
            return 154.5;
        }
        
        if (indexPath.row == 3) {
            
            return 292;
            
        }
        
        if (indexPath.row == 4) {
            
            if (self.photoHeightControl) {
                return self.photoHeightControl;
            }else{
                return 200;
            }
            
        }
    }
    return 0;
    
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
@end