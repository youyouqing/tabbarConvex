//
//  RecordDetalInfoViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "RecordDetalInfoViewController.h"
#import "PersonalCellHeadView.h"
#import "PersonalArchiveCell.h"
#import "PersonArchiveSinglePopView.h"
#import "HealthRecordViewModel.h"
#import "PersonalDictionaryMsg.h"
#import "PersonArchiveTextPutView.h"
@interface RecordDetalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) PersonArchiveSinglePopView *popBottomView;
@property (nonatomic,strong)PersonalDictionaryMsg *personalDictionaryMsg;
@property(strong,nonatomic) PersonArchiveTextPutView *popInputTextView;
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation RecordDetalInfoViewController
-(PersonArchiveTextPutView*)popInputTextView
{
    if (!_popInputTextView) {
        _popInputTextView = [[[NSBundle mainBundle]loadNibNamed:@"PersonArchiveTextPutView" owner:self options:nil]  firstObject];
        _popInputTextView.left = 0;
        _popInputTextView.top=0;
        _popInputTextView.width=KScreenWidth;
        _popInputTextView.height=KScreenHeight;
        _popInputTextView.delegate = self;
    }
    return _popInputTextView    ;
}
-(PersonArchiveSinglePopView *)popBottomView
{
    if (!_popBottomView) {
        _popBottomView = [[[NSBundle mainBundle]loadNibNamed:@"PersonArchiveSinglePopView" owner:self options:nil]  firstObject];
        _popBottomView.left = 0;
        _popBottomView.top=0;
        _popBottomView.width=KScreenWidth;
        _popBottomView.height=KScreenHeight;
        _popBottomView.delegate = self;
    }
    return _popBottomView    ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view.backgroundColor = kbackGroundGrayColor;
    tableView.backgroundColor = kbackGroundGrayColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"PersonalArchiveCell" bundle:nil] forCellReuseIdentifier:@"PersonalArchiveCell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(6 );
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo( CGRectGetWidth(self.view.frame)-12);
    }];
    self.tableView = tableView;
    [self addFamilyResultWithNetWorking];
    [self getPersonDataWithNewWorking];
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
    return [self.bigArr[self.typeTag] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"PersonalArchiveCell";
    PersonalArchiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *tempArray =  self.bigArr[self.typeTag];
    NSDictionary *dic = tempArray[indexPath.row];
    cell.nameLal.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    cell.textLal.text = [NSString stringWithFormat:@"%@",dic[@"text"]];
    cell.selectStarLab.hidden = [dic[@"hiden"] boolValue];
    if (indexPath.row == [self.bigArr[self.typeTag] count]-1) {
        CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 50) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
        maskTwoLayer.frame = corTwoPath.bounds;
        maskTwoLayer.path=corTwoPath.CGPath;
        cell.layer.mask=maskTwoLayer;
        return cell;
    }else if (indexPath.row == 0)
    {
        CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 50) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
        maskTwoLayer.frame = corTwoPath.bounds;
        maskTwoLayer.path=corTwoPath.CGPath;
        cell.layer.mask=maskTwoLayer;
        return cell;
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSArray *tempArray =  self.bigArr[self.typeTag];
    NSDictionary *dic = tempArray[indexPath.row];
    if ([dic[@"tag"] integerValue]== 1) {
       if(indexPath.row == 0 ){
           
           self.popInputTextView.inputDataText.text = [NSString stringWithFormat:@"%@",self.personalMsg.FullName];// dic[@"text"] 默认显示未填写
           [UIView animateWithDuration:.2 animations:^{
               self.popInputTextView.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                                         CGAffineTransformMakeScale(1.0f, 1.0f));
           }];
           [[UIApplication sharedApplication].keyWindow addSubview:self.popInputTextView];
        
       
        }else
       {
           
           self.popBottomView.defaultselectedStr = [NSString stringWithFormat:@"%@",dic[@"text"]];
           NSLog(@"---defaultselectedStr--%@",self.popBottomView.defaultselectedStr);
            self.popBottomView.tempSmokeOrDrinkArr = self.personalDictionaryMsg.BloodType;
           if (indexPath.row == 5) {
               self.popBottomView.popBottomType = 7;
           }else
            self.popBottomView.popBottomType = indexPath.row;
           
           //5s:300 6:330
//           [UIView animateWithDuration:.2 animations:^{
//               self.popBottomView.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
//                                                                      CGAffineTransformMakeScale(1.0f, 1.0f));
//           }];
           [[UIApplication sharedApplication].keyWindow addSubview:self.popBottomView];
    }
  }else   if ([dic[@"tag"] integerValue]== 2)
  {
       [self addFamilyResultWithNetWorking];
      NSMutableArray *tempArr = [NSMutableArray array];
      NSString *tempStr = @"";
      if (indexPath.row == 1) {
          for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
              [tempArr addObject:model];
          }
         tempStr = @"请您确定具体疾病或异常的名称";//A
          
      }
      else if (indexPath.row == 0)
      {
          for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
              [tempArr addObject:model];
          }
           tempStr = @"您的父母或兄弟姐妹是否有确诊以下疾病";
      }else if (indexPath.row == 2)
      {
//           tempArr = self.personalDictionaryMsg.OperationTrauma;
          for (DictionaryMsg *model in self.personalDictionaryMsg.OperationTrauma) {
              [tempArr addObject:model];
          }
           tempStr = @"请您选择手术部位";
      }
      else if (indexPath.row == 3)
      {
          for (DictionaryMsg *model in self.personalDictionaryMsg.AllergyDrug) {
              [tempArr addObject:model];
          }
           tempStr = @"请您选择过敏药物";
//           tempArr = self.personalDictionaryMsg.AllergyDrug;
      }
      else if (indexPath.row == 4)
      {
          for (DictionaryMsg *model in self.personalDictionaryMsg.FoodAllergy) {
              [tempArr addObject:model];
          }
           tempStr = @"请您选择过敏食物和接触物";
//           tempArr = self.personalDictionaryMsg.FoodAllergy;
      }
      else if (indexPath.row == 5)
      {
          for (DictionaryMsg *model in self.personalDictionaryMsg.LongTermMedicine) {
              [tempArr addObject:model];
          }
           tempStr = @"请您选择长期服用的药物";
//          tempArr = self.personalDictionaryMsg.LongTermMedicine;
      }
      
    
      NSArray *tempArray =  self.bigArr[self.typeTag];
      NSDictionary *dic = tempArray[indexPath.row];
      NSArray *defaultSelectedillness=[dic[@"text"] componentsSeparatedByString:@","];
      NSMutableArray *defaultSelectedConditions = [[NSMutableArray alloc]init];
      NSLog(@"defaultSelectedillness:%@",defaultSelectedillness);
   
      [defaultSelectedConditions removeAllObjects];
          if (defaultSelectedillness.count<1) {
              for (int i = 0; i<tempArr.count; i++) {
                  DictionaryMsg *model= tempArr[i];
                  if ([model.DictionaryName isEqualToString:dic[@"text"]]) {
                      [defaultSelectedConditions addObject:model];
                  }
              }
             
          }else
          {
              for (int i=0; i<defaultSelectedillness.count; i++) {
                  
                  NSString *str=defaultSelectedillness[i];
                  for (int i = 0; i<tempArr.count; i++) {
                      DictionaryMsg *model= tempArr[i];
                      if ([model.DictionaryName isEqualToString:str]) {
                          [defaultSelectedConditions addObject:model];
                      }
                  }
              }
              
          }
           NSLog(@"defaultSelectedConditions:%@",defaultSelectedConditions);
       [SureMultipleSelectedWindow showWindowWithTitle:tempStr selectedConditions:tempArr defaultSelectedConditions:defaultSelectedConditions title:tempStr  selectedBlock:^(NSArray *selectedArr) {
                  NSLog(@"---%@",selectedArr);
                  NSMutableString *medStr=[[NSMutableString alloc]initWithCapacity:0];
                  NSMutableString *medNameStr=[[NSMutableString alloc]initWithCapacity:0];
                  for (DictionaryMsg *model in selectedArr) {
                     
                      if (medStr.length==0) {//长期服用药物，多个药物之间逗号分隔，如（1，2，3）
                            [medNameStr appendString:[NSString stringWithFormat:@"%@",model.DictionaryName]];
                          [medStr appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                          
                      }else{
                           [medNameStr appendString:[NSString stringWithFormat:@"%@%@",@",",model.DictionaryName]];
                          [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                          
                      }
                      
                  }
         
         
           [self dataType:indexPath.row completeStr:medNameStr medStr:medStr];//新增或修改健康档案
        }];
      
  }else
  {
      self.popBottomView.defaultselectedStr = [NSString stringWithFormat:@"%@",dic[@"text"]];
      if (indexPath.row == 0) {
           self.popBottomView.tempSmokeOrDrinkArr = self.personalDictionaryMsg.SmokingStatus;
      }else
           self.popBottomView.tempSmokeOrDrinkArr = self.personalDictionaryMsg.DrinkingStatus;
     
      self.popBottomView.popBottomType = 5+indexPath.row;
      //5s:300 6:330
      [UIView animateWithDuration:.2 animations:^{
          self.popBottomView.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                                 CGAffineTransformMakeScale(1.0f, 1.0f));
      }];
      [[UIApplication sharedApplication].keyWindow addSubview:self.popBottomView];
      
  }
      
}
- (void)addFamilyResultWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                      
                          };
    
    [HealthRecordViewModel editRecordResultDataWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            self.personalDictionaryMsg=[PersonalDictionaryMsg mj_objectWithKeyValues:response.Result];
            
            NSLog(@"309获取个人档案相关字典%@",response.Result);
            [self.tableView reloadData];
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}
//新增或修改健康档案
-(void)modifyRecordsWithNetWorking:(NSString *)completeStr dataType:(NSInteger)ArchiveType  FullName:(NSString *)FullName
                                                            Birthday:(NSString *)Birthday
                                                            FamilyHistoryIDList:(NSString *)FamilyHistoryIDList
                                                            ProjectOperationNo:(NSString *)ProjectOperationNo
                                                            PastHistoryIDList:(NSString *)PastHistoryIDList
                                                            SmokingStatusID:(NSString *)SmokingStatusID
                                                             AllergyDrugNo:(NSString *)AllergyDrugNo
                                                             FoodAllergyNo:(NSString *)FoodAllergyNo
                                                             LongTermMedicineNo:(NSString *)LongTermMedicineNo
                                                             DrinkingStatusID:(NSString *)DrinkingStatusID
                                                             BloodType:(NSString *)BloodType
                                                             sexId:(int)sexId
                                                             Height:(int)Height
                                                             Weight:(int)Weight
                                                             medStr:(NSString *)medStr
                                                             BloodTypeID:(NSString *)BloodTypeID;
{// @"Age":@(), @"IdCard":@"", @"HeadImg":@"",   @"AllergyDrug":@"", @"FoodAllergy":@"", @"SmokingStatusName":@"", @"LongMedication":@"", @"FamilyHistoryIDList":@"",@"PastHistoryIDList":@"",   @"ProjectOperation":@"",  @"DrinkingStatusName":@"",
    NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,
                           @"MemberID":@(self.userMemberID),
                           @"FullName":FullName.length>0?FullName:@"",
                           @"SexID":@(sexId),//性别编号 0、男 1、女 -1、未选择
                           @"Birthday":Birthday.length>0?Birthday:@"",
                           @"Height":@(Height),
                           @"Weight":@(Weight),
                           @"FamilyHistoryIDList":FamilyHistoryIDList.length>0?FamilyHistoryIDList:@"",
                           @"PastHistoryIDList":PastHistoryIDList.length>0?PastHistoryIDList:@"",
                           @"ProjectOperationNo":ProjectOperationNo.length>0?ProjectOperationNo:@"",
                           @"SmokingStatusID":SmokingStatusID.length>0?SmokingStatusID:@"",
                           @"AllergyDrugNo":AllergyDrugNo.length>0?AllergyDrugNo:@"",
                           @"FoodAllergyNo":FoodAllergyNo.length>0?FoodAllergyNo:@"",
                           @"LongTermMedicineNo":LongTermMedicineNo.length>0?LongTermMedicineNo:@"",
                           @"DrinkingStatusID":DrinkingStatusID.length>0?DrinkingStatusID:@"",
                            @"BloodType":BloodTypeID.length>0?BloodTypeID:@0
                           };
    NSLog(@"dict%@",dict);
    [[XKLoadingView shareLoadingView]showLoadingText:@""];

    [NetWorkTool postAction:checkHomeEditPersonalFileUrl params:dict finishedBlock:^(ResponseObject *response) {
       [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {

            NSLog(@"310----%@",response.Result);
            
            if (self.typeTag == 0&&ArchiveType == 0) {
                 self.personalMsg.FullName = completeStr;
                NSArray *tempArray =  self.bigArr[self.typeTag];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tempArray];
                NSDictionary *dic = tempArr[0];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
                [mutableItem setObject:completeStr forKey:@"text"];
                //       [self.bigArr[self.typeTag] setObject:mutableItem atIndexedSubscript:0];
                [self.bigArr[self.typeTag] replaceObjectAtIndex:0 withObject:mutableItem];
                
            }else if (self.typeTag == 0&&ArchiveType <7)
            {
                NSArray *tempArray =  self.bigArr[0];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tempArray];
                NSDictionary *dic = tempArr[ArchiveType];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
                if (ArchiveType == 3) {
                    self.personalMsg.Height = Height;// [completeStr intValue];
                }
                if (ArchiveType == 4) {
                    self.personalMsg.Weight = Weight;//[completeStr intValue];
                }
                if (ArchiveType == 1) {
                    self.personalMsg.SexID = sexId;//[completeStr isEqualToString:@"男"]?0:1;
                }
                if (ArchiveType == 2) {
                      self.personalMsg.Birthday = Birthday ;
                }
                [mutableItem setObject:completeStr forKey:@"text"];
                [self.bigArr[0] replaceObjectAtIndex:ArchiveType withObject:mutableItem];
            }
            else if (self.typeTag == 0&&ArchiveType ==7)
            {
                NSArray *tempArray =  self.bigArr[0];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tempArray];
                NSDictionary *dic = tempArr[5];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
                self.personalMsg.BloodTypeName = BloodType ;
                self.personalMsg.BloodTypeID = BloodTypeID;
                [mutableItem setObject:completeStr forKey:@"text"];
                [self.bigArr[0] replaceObjectAtIndex:5 withObject:mutableItem];
            }
            else if (self.typeTag == 2)
            {
                if (ArchiveType == 5) {
                    NSArray *tempArray =  self.bigArr[2];
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tempArray];
                    NSDictionary *dic = tempArr[0];
                    NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
                    [mutableItem setObject:completeStr forKey:@"text"];
                    [self.bigArr[2] replaceObjectAtIndex:0 withObject:mutableItem];
                    
                    self.personalMsg.SmokingStatusID = SmokingStatusID;
                    self.personalMsg.SmokingStatusName = completeStr ;
                }
                if (ArchiveType == 6) {
                    NSArray *tempArray =  self.bigArr[2];
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tempArray];
                    NSDictionary *dic = tempArr[1];
                    NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
                    [mutableItem setObject:completeStr forKey:@"text"];
                    [self.bigArr[2] replaceObjectAtIndex:1 withObject:mutableItem];
                    self.personalMsg.DrinkingStatusID = DrinkingStatusID;
                    self.personalMsg.DrinkingStatusName = completeStr ;
                }
            }
            else if (self.typeTag == 1)
            {
                if (ArchiveType == 1) {
                    self.personalMsg.PastHistory = completeStr;
                    self.personalMsg.PastHistoryIDList = medStr;
                }
                else if (ArchiveType == 0)
                {
                    self.personalMsg.FamilyHistoryIDList= medStr;
                    self.personalMsg.FamilyHistory = completeStr;
                }
                
                else if (ArchiveType == 2)
                {
                    self.personalMsg.ProjectOperationNo = medStr;
                    self.personalMsg.ProjectOperation = completeStr;
                }
                else if (ArchiveType == 3)
                {
                    self.personalMsg.AllergyDrugNo = medStr;
                    self.personalMsg.AllergyDrug = completeStr;
                }
                else if (ArchiveType == 4)
                {
                    self.personalMsg.FoodAllergyNo = medStr;
                    self.personalMsg.FoodAllergy = completeStr;
                }
                else if (ArchiveType == 5)
                {
                    self.personalMsg.LongTermMedicine = completeStr;
                    self.personalMsg.LongTermMedicineNo = medStr;
                }
                
                NSArray *tempArray =  self.bigArr[1];
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:tempArray];
                NSDictionary *dic = tempArr[ArchiveType];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:dic];
                [mutableItem setObject:completeStr.length>0?completeStr:@"未填写" forKey:@"text"];
                [self.bigArr[1] replaceObjectAtIndex:ArchiveType withObject:mutableItem];
            }
            
            [self.tableView reloadData];
        }else{

            ShowErrorStatus(response.msg);
        }

    }];
    
  
}
-(void)getPersonDataWithNewWorking{
    
    Dateformat *dateF =   [[Dateformat alloc]init];
    NSMutableArray *dataOneArr =  [NSMutableArray arrayWithArray:@[@{@"name":@"姓名",@"text":self.personalMsg.FullName.length>0?self.personalMsg.FullName:@"未填写",@"hiden":@NO,@"tag":@1},
  @{@"name":@"性别",@"text":self.personalMsg.Sex.length>0?self.personalMsg.Sex:@"未填写",@"hiden":@NO,@"tag":@1},
                                                                   @{@"name":@"生日",@"text":self.personalMsg.Birthday.length>0?([dateF DateFormatWithDate:self.personalMsg.Birthday withFormat:@"YYYY-MM-dd"]):@"未填写",@"hiden":@NO,@"tag":@1},
                                                                   @{@"name":@"身高",@"text":self.personalMsg.Height>0?(@(self.personalMsg.Height)):@"未填写",@"hiden":@NO,@"tag":@1},
  @{@"name":@"体重",@"text":self.personalMsg.Weight>0?@(self.personalMsg.Weight):@"未填写",@"hiden":@NO,@"tag":@1},
  @{@"name":@"血型",@"text":self.personalMsg.BloodTypeName.length>0?self.personalMsg.BloodTypeName:@"未填写",@"hiden":@NO,@"tag":@1}]];
    NSMutableArray *dataTwoArr = [NSMutableArray arrayWithArray:@[@{@"name":@"家族病史",@"text":self.personalMsg.FamilyHistory.length>0?self.personalMsg.FamilyHistory:@"未填写",@"hiden":@YES,@"tag":@2},
  @{@"name":@"既往病史",@"text":self.personalMsg.PastHistory.length>0?self.personalMsg.PastHistory:@"未填写",@"hiden":@YES,@"tag":@2},
  @{@"name":@"手术和外伤",@"text":self.personalMsg.ProjectOperation.length>0?self.personalMsg.ProjectOperation:@"未填写",@"hiden":@YES,@"tag":@2},
  @{@"name":@"过敏药物",@"text":self.personalMsg.AllergyDrug.length>0?self.personalMsg.AllergyDrug:@"未填写",@"hiden":@YES,@"tag":@2},
  @{@"name":@"食物和接触物过敏",@"text":self.personalMsg.FoodAllergy.length>0?self.personalMsg.FoodAllergy:@"未填写",@"hiden":@YES,@"tag":@2},
  @{@"name":@"长期服用药物",@"text":self.personalMsg.LongTermMedicine.length>0?self.personalMsg.LongTermMedicine:@"未填写",@"hiden":@YES,@"tag":@2}]];
    //    @[@"家族病史",@"既往病史",@"手术和外伤",@"过敏药物",@"食物和接触物过敏",@"长期服用药物"];
    NSMutableArray *dataThreeArr =  [NSMutableArray arrayWithArray:@[@{@"name":@"吸烟",@"text":self.personalMsg.SmokingStatusName.length>0?self.personalMsg.SmokingStatusName:@"未填写",@"hiden":@NO,@"tag":@3},
      @{@"name":@"饮酒",@"text":self.personalMsg.DrinkingStatusName.length>0?self.personalMsg.DrinkingStatusName:@"未填写",@"hiden":@NO,@"tag":@3}]];
    //  @[@"吸烟",@"饮酒"];
    self.bigArr = @[dataOneArr,dataTwoArr,dataThreeArr];
    [self.tableView reloadData];
}
#pragma mark   输入框添加姓名
- (void)PersonArchiveTextPutViewCompleteClick:(NSString *)dataStr;
{
    if (dataStr.length>0) {
       
         [self dataType:0 completeStr:dataStr medStr:@""];
        
    }
}
- (void)PersonArchiveSinglePopViewSelectItemClick:(NSString *)completeStr ArchiveType:(ArchiveSingleType)ArchiveType;
{
    if (completeStr.length>0) {
    [self dataType:ArchiveType completeStr:completeStr medStr:@""];
    }
}
-(void)dataType:(NSInteger)ArchiveType  completeStr:(NSString *)completeStr medStr:(NSString *)medStr{
//    NSString *FullName =   @"";
//    NSInteger sexId =   -1;
//    NSString *Birthday =    @"";
//    NSInteger Height =   0;
//    NSString *FamilyHistoryIDList =    @"";
//    NSInteger Weight =   0;
//    NSString *ProjectOperationNo =   @"";
//
//    NSString *PastHistoryIDList =    @"";
//    NSString *SmokingStatusID =    @"";
//    NSString *AllergyDrugNo =   @"";
//    NSString *FoodAllergyNo =    @"";
//    NSString *LongTermMedicineNo =    @"";
//    NSString *DrinkingStatusID =   @"";
//    NSString *BloodType =    @"";
    NSString *FullName =   self.personalMsg.FullName;
    int sexId =   self.personalMsg.SexID;
    NSString *Birthday =   self.personalMsg.Birthday;
    int Height =   self.personalMsg.Height;
    NSString *FamilyHistoryIDList =   self.personalMsg.FamilyHistoryIDList;
    int Weight =   self.personalMsg.Weight;
    NSString *ProjectOperationNo =   self.personalMsg.ProjectOperationNo;
    
    NSString *PastHistoryIDList =   self.personalMsg.PastHistoryIDList;
    NSString *SmokingStatusID =   self.personalMsg.SmokingStatusID;
    NSString *AllergyDrugNo =   self.personalMsg.AllergyDrugNo;
    NSString *FoodAllergyNo =   self.personalMsg.FoodAllergyNo;
    NSString *LongTermMedicineNo =   self.personalMsg.LongTermMedicineNo;
    NSString *DrinkingStatusID =   self.personalMsg.DrinkingStatusID;
    NSString *BloodType =   self.personalMsg.BloodTypeName;
     NSString *BloodTypeID =   self.personalMsg.BloodTypeID;
    if (self.typeTag == 0&&ArchiveType == 0) {
        FullName = completeStr;

    }
    
   else  if (self.typeTag == 0&&ArchiveType == 1) {
        sexId =   [completeStr isEqualToString:@"男"]?0:1;

        
    }
    else  if (self.typeTag == 0&&ArchiveType == 2) {
        Birthday =   completeStr;
      
            
        Dateformat *dateF =  [[Dateformat alloc]init];
        completeStr =  [dateF DateFormatWithDate:completeStr withFormat:@"YYYY-MM-dd"];
       
        
    }
    else  if (self.typeTag == 0&&ArchiveType == 4) {
        Weight =   [completeStr intValue];
        
    }
   else   if (self.typeTag == 0&&ArchiveType == 3) {
        Height =   [completeStr intValue];

    }
   else  if (self.typeTag == 0&&ArchiveType == 7) {
       BloodType =  completeStr;
       
       for (DictionaryMsg *model in self.personalDictionaryMsg.BloodType) {
           if ([model.DictionaryName isEqualToString:completeStr]) {
               BloodTypeID  = [NSString stringWithFormat:@"%li",model.DictionaryID];
               completeStr = [NSString stringWithFormat:@"%@",model.DictionaryName];
           }
       }
       
   }
    else  if (self.typeTag == 2&&ArchiveType == 5) {
        
        for (DictionaryMsg *model in self.personalDictionaryMsg.SmokingStatus) {
            if ([model.DictionaryName isEqualToString:completeStr]) {
                 SmokingStatusID = [NSString stringWithFormat:@"%li",model.DictionaryID];
                
            }
        }
     
        
    }
    else  if (self.typeTag == 2&&ArchiveType == 6) {
//        DrinkingStatusID =  medStr;
        for (DictionaryMsg *model in self.personalDictionaryMsg.DrinkingStatus) {
            if ([model.DictionaryName isEqualToString:completeStr]) {
                DrinkingStatusID  = [NSString stringWithFormat:@"%li",model.DictionaryID];
                completeStr = [NSString stringWithFormat:@"%@",model.DictionaryName];
            }
        }
    }
    
    
   else   if (self.typeTag == 1&&ArchiveType == 0) {
        FamilyHistoryIDList =   medStr;
        
    }
    else  if (self.typeTag == 1&&ArchiveType == 1) {
         PastHistoryIDList =   medStr;
        
    }
    
    else  if (self.typeTag == 1&&ArchiveType == 2) {
         ProjectOperationNo =  medStr;
        
    }
    
    
    else  if (self.typeTag == 1&&ArchiveType == 3) {
        AllergyDrugNo =  medStr;
        
    }
    else  if (self.typeTag == 1&&ArchiveType == 4) {
        FoodAllergyNo =   medStr;
        
    }
    
    else  if (self.typeTag == 1&&ArchiveType == 5) {
        LongTermMedicineNo =   medStr;
        
    }
    
    [self modifyRecordsWithNetWorking:completeStr dataType:ArchiveType FullName:FullName Birthday:Birthday FamilyHistoryIDList:FamilyHistoryIDList ProjectOperationNo:ProjectOperationNo PastHistoryIDList:PastHistoryIDList SmokingStatusID:SmokingStatusID AllergyDrugNo:AllergyDrugNo FoodAllergyNo:FoodAllergyNo LongTermMedicineNo:LongTermMedicineNo DrinkingStatusID:DrinkingStatusID BloodType:BloodType sexId:sexId Height:Height Weight:Weight medStr:medStr BloodTypeID:BloodTypeID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end