//
//  EidtArchvieHeaderView.m
//  eHealthCare
//
//  Created by jamkin on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "EidtArchvieHeaderView.h"
#import "ArchivesEditView.h"
#import "BirthDayPickerView.h"
#import "EqualSpaceFlowLayoutEvolve.h"
#import "XKCollectionViewCell.h"


#import "XKValidationAndAddScoreTools.h"
@interface EidtArchvieHeaderView ()<ArchivesEditViewDelegate,BirthDayPickerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/**个人背景的标签**/
@property (weak, nonatomic) IBOutlet UILabel *personBackLab;

/**籍贯标签**/
@property (weak, nonatomic) IBOutlet XKInputField *addressTxt;

/**户口类型的按钮**/
@property (weak, nonatomic) IBOutlet XKCircalButton *houseTypeOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *houseTypeTwo;

@property (nonatomic,assign)NSInteger count;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doctorLeftCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doctorLeftConsTwo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doctorLeftConsThress;

@property (weak, nonatomic) IBOutlet UILabel *historyLab;

@property (weak, nonatomic) IBOutlet XKCircalButton *diseaseHaveBtn;

@property (weak, nonatomic) IBOutlet XKCircalButton *diseaseNoBtn;

@property (weak, nonatomic) IBOutlet UIView *disaseContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *diseaseContainerViewHeightCons;

@property (weak, nonatomic) IBOutlet UIView *disaseBigContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseBigContainerViewHeightCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *diseaseLeftCons;

@property (weak, nonatomic) IBOutlet XKLineViewOne *disaseLineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseOneHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTwoHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseThreeHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseFourHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseFiveHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseSixHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseSevenHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseSix;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseSeven;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseEight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *diaseEleven;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTwolve;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseThreeteen;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseFourteen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseSixteen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseSeventeen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseFiveteen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseEightteen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseNineteen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Disasetwenty;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseToLeft;

/**疾病一栏文本框约束和线条的约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTxt1Hight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTxt2Hight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseTxt3Hight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseLine3Hight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseLine2Hight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *disaseLine1Hight;

/**手术一栏外边试图的约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationV1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationV2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationV3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationV4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationV5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationV;
/*手术一栏线条的处理和文本框的处理*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationT1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationT2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationT3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *operationT4;
@property (weak, nonatomic) IBOutlet XKInputField *otxt1;
@property (weak, nonatomic) IBOutlet XKInputField *otxt2;
@property (weak, nonatomic) IBOutlet XKInputField *otxt3;
@property (weak, nonatomic) IBOutlet XKInputField *otxt4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ol1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ol2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ol3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ol4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ov1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ov2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ov3;
/*手术一栏有无按钮*/
@property (weak, nonatomic) IBOutlet XKCircalButton *opreationBtnHave;
@property (weak, nonatomic) IBOutlet XKCircalButton *opreationBtnNot;
- (IBAction)clickOpretion:(XKCircalButton *)sender;

/*外伤一栏外边几个视图高度的调整*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cBigHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cFourHeight;
/**外伤一栏里边小视图的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLineOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLineTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cLineOneThreeHeight;

/*输血一栏按钮操作的处理*/
@property (weak, nonatomic) IBOutlet XKCircalButton *tHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *tNotBtn;
- (IBAction)tClickAction:(id)sender;
/*外伤一栏几个大的视图的高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TransBitHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tansTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tansThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transFourHeight;
/**外伤一栏子视图的高度约束*///lab和txt反了
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transTHeightOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transTHeightTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transTHeightThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transTHeightFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transLOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transLThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transLFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transLineHeightOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transLineHeightTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transLineHeightThree;

/*保存按钮的处理*/
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)clickSave:(id)sender;

/**外伤一栏按钮的操作*/
@property (weak, nonatomic) IBOutlet XKCircalButton *cHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *cNotBtn;
- (IBAction)cClickAntion:(id)sender;

/**居住环境左对齐的约束*/
//厨房
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kitchenLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kitchenLeftTwo;
//厕所环境
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toiletLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toiletLeftTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toiletLeftThree;
//饮水类型
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *walterLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *walterLeftTwo;
//家庭燃料
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeLeftTwo;
//居住环境标签
@property (weak, nonatomic) IBOutlet UILabel *environmentLab;
//生活习惯标签
@property (weak, nonatomic) IBOutlet UILabel *hobbylab;
//生活习惯中是否抽烟的处理
//是否抽烟按钮的操作
@property (weak, nonatomic) IBOutlet XKCircalButton *somekingHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *somekingNotBtn;
- (IBAction)clickSomeking:(XKCircalButton *)sender;
//抽烟视图高度的处理
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hobbyBitHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingFiveHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingSixHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingYearHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *somekingCountHeight;

/*家庭病史的处理*/
/**父亲一栏的处理*/
//按钮的处理
@property (weak, nonatomic) IBOutlet XKCircalButton *fatherHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *fatherNotBtn;
- (IBAction)fatherClick:(XKCircalButton *)sender;
//距离左边距离的处理
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherLeftTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherLeftThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherLeftFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherLeftFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherLeftSix;
//外部视图高度的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherBigHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherFiveHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherSixHeight;
//子视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherOneOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherOneTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherOneThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherTwoOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherTwoTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherThreeOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherThreeTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherFourOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherFourTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherFiveOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherSixOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherSixTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fatherSixThreeHeight;

/**母亲一栏的处理*/
//按钮的处理
@property (weak, nonatomic) IBOutlet XKCircalButton *motherHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *motherNotBtn;
- (IBAction)motherClick:(XKCircalButton *)sender;
//距离左边一栏的处理
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherLeftTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherLeftThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherLeftFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherLeftFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherLeftSix;
//外部视图高度的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherBigHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherFiveHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherSixHeight;
//子视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherOneOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherOneTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherOneThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherTwoOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherTwoTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherThreeOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherThreeTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherFourOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherFourTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherFiveOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherSixOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherSixTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherSixThreeHeight;

/**兄弟姐妹一栏的处理*/
//按钮的处理
@property (weak, nonatomic) IBOutlet XKCircalButton *brotherHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *brotherNotBtn;
- (IBAction)brotherClick:(XKCircalButton *)sender;
//距离左边的处理
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherLeftTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherLeftThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherLeftFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherLeftFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherLeftSix;
//外部视图高度的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherBigHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherFiveHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherSixHeight;
//子视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherOneOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherOneTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherOneThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherTwoOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherTwoTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherThreeOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherThreeTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherFourOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherFourTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherFiveOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherSixOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherSixTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *brotherSixThreeHeight;

/*子女一栏的处理*/
//按钮的处理
@property (weak, nonatomic) IBOutlet XKCircalButton *childHaveBtn;
@property (weak, nonatomic) IBOutlet XKCircalButton *childNotBtn;
- (IBAction)childClick:(XKCircalButton *)sender;
//距离左边的处理
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childLeftOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childLeftTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childLeftThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childLeftFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childLeftFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childLeftSix;
//外部视图高度的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childBigHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childFourHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childFiveHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childSixHeight;
//子视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childOneOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childOneTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childOneThreeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childTwoOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childTwoTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childThreeOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childThreeTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childFourOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childFourTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childFiveOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childSixOneHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childSixTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childSixThreeHeight;

/**医药支付类型的总视图和其子视图*/
@property (weak, nonatomic) IBOutlet UIView *payTypeBigView;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnSix;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnSeven;
@property (weak, nonatomic) IBOutlet XKCircalButton *payBtnEight;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *payOtherTxt;
@property (nonatomic,strong)NSArray *payBtnArray;

//厨房排风的按钮视图操作
@property (weak, nonatomic) IBOutlet XKCircalButton *kitchenBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *kitchenBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *kitchenBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *kitchenBtnFour;
@property (nonatomic,strong)NSArray *kitchenBtnArray;

//厕所环境视图中按钮视图操作
@property (weak, nonatomic) IBOutlet XKCircalButton *toiletBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *toiletBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *toiletBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *toiletBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *toiletBtnFive;
@property (nonatomic,strong)NSArray *toiletArray;

/**饮水环境视图中按钮的视图操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *drinkingWaterBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *drinkingWaterBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *drinkingWaterBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *drinkingWaterBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *drinkingWaterBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *drinkingWaterBtnSix;
@property (nonatomic,strong)NSArray *drinkingWaterArray;

/**家庭燃料中视图按钮的视图的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *indoorBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *indoorBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *indoorBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *indoorBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *indoorBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *indoorBtnSix;
@property (nonatomic,strong)NSArray *indoorArray;

/**是否长期服药视图按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *sleepBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *sleepBtnTwo;
@property (nonatomic,strong)NSArray *sleepArray;

/**是否睡眠规律视图按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *medicineBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *medicineBtnTwo;
@property (nonatomic,strong)NSArray *medicineArray;

/**疾病一栏中视图按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnSix;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnSeven;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnEight;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnNine;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnTen;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtnEleven;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBtntwelve;
@property (nonatomic,strong)NSMutableArray *illnessArray;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessProfessionTxt;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessTumourTxt;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessOtherTxt;

/**家庭病史中父亲一栏按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnSix;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnSeven;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnEight;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnNine;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnTen;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessFatherBtnEleven;
@property (nonatomic,strong)NSMutableArray *illnessFatherArray;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessFatherTxt;

/**家庭病史中母亲一栏按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnSix;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnSeven;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnEight;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnNine;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnTen;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessMotherBtnEleven;
@property (nonatomic,strong)NSMutableArray *illnessMotherArray;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessMotherTxt;

/**家庭病史中兄弟姐妹一栏按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnSix;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnSeven;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnEight;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnNine;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnTen;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessBortherBtnEleven;
@property (nonatomic,strong)NSMutableArray *illnessBortherArray;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessBortherOtherTxt;

/**家庭病史中子女一栏按钮的操作**/
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnOne;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnTwo;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnThree;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnFour;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnFive;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnSix;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnSeven;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnEight;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnNine;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnTen;
@property (weak, nonatomic) IBOutlet XKCircalButton *illnessChildBtnEleven;
@property (nonatomic,strong)NSMutableArray *illnessChildArray;
@property (weak, nonatomic) IBOutlet XkInputFieldTwo *illnessChildTxt;

/**抽烟的年龄的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *smokingAgeLab;
/**每天抽烟数量的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *smokingCount;
/**喝酒的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *drinkLab;
/**籍贯的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *addresslab;
/**名族的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *notionLab;
/**婚姻状态的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *marlab;
/**血型的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *bloodlab;

/**外伤的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *traumaText1;
@property (weak, nonatomic) IBOutlet XKInputField *traumaText2;
@property (weak, nonatomic) IBOutlet XKInputField *traumaText3;
@property (weak, nonatomic) IBOutlet XKInputField *traumaText4;

/**输血的文本框**/
@property (weak, nonatomic) IBOutlet XKInputField *transfusionText1;
@property (weak, nonatomic) IBOutlet XKInputField *transfusionText2;
@property (weak, nonatomic) IBOutlet XKInputField *transfusionText3;
@property (weak, nonatomic) IBOutlet XKInputField *transfusionText4;

/**抽烟的年龄和每日抽烟数量标签的属性**/
@property (weak, nonatomic) IBOutlet UILabel *yearLab;
@property (weak, nonatomic) IBOutlet UILabel *amountcount;

/**外伤一栏的标签属性**/
@property (weak, nonatomic) IBOutlet XKlabel *olab1;
@property (weak, nonatomic) IBOutlet XKlabel *olab2;
@property (weak, nonatomic) IBOutlet XKlabel *olab3;
@property (weak, nonatomic) IBOutlet XKlabel *olab4;

/**手术一栏的标签**/
@property (weak, nonatomic) IBOutlet XKlabel *tolab1;
@property (weak, nonatomic) IBOutlet XKlabel *tolab2;
@property (weak, nonatomic) IBOutlet XKlabel *tolab3;
@property (weak, nonatomic) IBOutlet XKlabel *tolab4;

/**输血一栏标签**/
@property (weak, nonatomic) IBOutlet XKlabel *tlab1;
@property (weak, nonatomic) IBOutlet XKlabel *tlab2;
@property (weak, nonatomic) IBOutlet XKlabel *tlab3;
@property (weak, nonatomic) IBOutlet XKlabel *tlab4;

/**定义属性用于文本框的属性传值**/
@property (nonatomic,weak)ArchivesEditView *txtInputView1;

@property (nonatomic,weak)ArchivesEditView *txtInputView2;

@property (nonatomic,weak)ArchivesEditView *txtInputView3;

@property (nonatomic,weak)ArchivesEditView *txtInputView4;

@property (nonatomic,weak)ArchivesEditView *txtInputView5;

@property (nonatomic,assign)CGFloat contentHeight;

/**教育等级的标签**/
@property (weak, nonatomic) IBOutlet XKInputField *educationTxt;

@property (nonatomic,strong)NSTimer *timer;

/**控制是否有填写户口类型的标示**/
@property (nonatomic,assign)BOOL isHousType;

/**控制是否有填写疾病的标示**/
@property (nonatomic,assign)BOOL isIllness;

/**控制是否有填写父亲疾病的标示**/
@property (nonatomic,assign)BOOL isFatherIllness;

/**控制是否有填写母亲疾病的标示**/
@property (nonatomic,assign)BOOL isMotherIllness;

/**控制是否有填写兄弟姐妹疾病的标示**/
@property (nonatomic,assign)BOOL isBrotherIllness;

/**控制是否有填写子女疾病的标示**/
@property (nonatomic,assign)BOOL isChildIllness;

/**厨房排风是否填写的标示**/
@property (nonatomic,assign)BOOL isChentch;

/**控制是否填写厕所环境的标示**/
@property (nonatomic,assign)BOOL isTitol;

/**控制是否填写燃料的标示**/
@property (nonatomic,assign)BOOL isFutal;

/**控制是否填写饮水环境的标示**/
@property (nonatomic,assign)BOOL isWater;

/**控制是否长期服药的标示**/
@property (nonatomic,assign)BOOL isLoog;

/**控制是否睡眠规律的标示**/
@property (nonatomic,assign)BOOL isReguler;


/**
 子女的家庭疾病的数据
 */
@property (weak, nonatomic) IBOutlet UIView *childViewCalButtonView;
/**
 子女的家庭疾病的数据
 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *fatherCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *brotherCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *motherCollectionView;


@property (weak, nonatomic) IBOutlet UICollectionView *illesCollectionView;


@property (weak, nonatomic) IBOutlet UIView *brotherViewCalButtonView;




@end

@implementation EidtArchvieHeaderView
{

      //子女的选中未选中
    NSMutableArray *childSelectedArr;
    
    
    //brother的选中未选中
    NSMutableArray *brotherSelectedArr;
    //father的选中未选中
    NSMutableArray *fatherSelectedArr;
    //mother的选中未选中
    NSMutableArray *motherSelectedArr;

     NSMutableArray *illesSelectedArr;

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField==self.notionLab) {
        
        if (self.notionLab.text.length==0) {
        
            self.notionLab.text=((DictionaryMsg *)self.personalDictionaryMsg.NationList[0]).DictionaryName;
            
        }
        
    }
    
    if (textField==self.educationTxt) {
        
        if (self.educationTxt.text.length==0) {
        
            self.educationTxt.text=((DictionaryMsg *)self.personalDictionaryMsg.EducationLevel[0]).DictionaryName;
            
        }
        
    }
    
    if (textField==self.marlab) {
        
        if (self.marlab.text.length==0) {
            
            self.marlab.text=((DictionaryMsg *)self.personalDictionaryMsg.MaritalStatus[0]).DictionaryName;
            
        }
        
    }
    
    if (textField==self.bloodlab) {
        
        if (self.bloodlab.text.length==0) {
            
            self.bloodlab.text=((DictionaryMsg *)self.personalDictionaryMsg.BloodType[0]).DictionaryName;
            
        }
        
    }
    
    if (textField==self.drinkLab) {
        
        if (self.drinkLab.text.length==0) {
            
            self.drinkLab.text=((DictionaryMsg *)self.personalDictionaryMsg.DrinkingStatus[0]).DictionaryName;
            
        }
        
    }
    
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
    
}

/**添加检测文本框长度的变化**/
-(void)changeLength{
    
    if (self.smokingAgeLab.text.length>3) {
        
        NSRange range=NSMakeRange(self.smokingAgeLab.text.length-3,3);
        
        self.smokingAgeLab.text=[self.smokingAgeLab.text substringWithRange:range];
        
    }
    
    if (self.smokingCount.text.length>3) {
        
        NSRange range=NSMakeRange(self.smokingCount.text.length-3,3);
        
        self.smokingCount.text=[self.smokingCount.text substringWithRange:range];
        
    }
    
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.notionLab.delegate=(id)self;
    
    self.educationTxt.delegate=(id)self;
    
    self.marlab.delegate=(id)self;
    
    self.bloodlab.delegate=(id)self;
    
    self.drinkLab.delegate=(id)self;
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.002 target:self selector:@selector(changeLength) userInfo:nil repeats:YES];
    
    //把医药支付类型的按钮放到数据中
    self.payBtnArray=@[self.payBtnOne,self.payBtnTwo,self.payBtnThree,self.payBtnFour,self.payBtnFive,self.payBtnSix,self.payBtnSeven,self.payBtnEight];
    
    //把厨房排风的按钮放到数组中
    self.kitchenBtnArray=@[self.kitchenBtnOne,self.kitchenBtnTwo,self.kitchenBtnThree,self.kitchenBtnFour];
    
    //把厕所环境的按钮添加到数据中
    self.toiletArray=@[self.toiletBtnOne,self.toiletBtnTwo,self.toiletBtnThree,self.toiletBtnFour,self.toiletBtnFive];
    
    //把饮水类型的按钮加到数组中
    self.drinkingWaterArray=@[self.drinkingWaterBtnOne,self.drinkingWaterBtnTwo,self.drinkingWaterBtnThree,self.drinkingWaterBtnFour,self.drinkingWaterBtnFive,self.drinkingWaterBtnSix];
    
    //把家庭燃料总的按钮加到数组中
    self.indoorArray=@[self.indoorBtnOne,self.indoorBtnTwo,self.indoorBtnThree,self.indoorBtnFour,self.indoorBtnFive,self.indoorBtnSix];
    
    //长期服药 睡眠规律按钮添加到数组中
    self.sleepArray=@[self.sleepBtnOne,self.sleepBtnTwo];
    self.medicineArray=@[self.medicineBtnOne,self.medicineBtnTwo];
    
    //将疾病按钮添加到数组中
//    self.illnessArray=@[self.illnessBtnOne,self.illnessBtnTwo,self.illnessBtnThree,self.illnessBtnFour,self.illnessBtnFive,self.illnessBtnSix,self.illnessBtnSeven,self.illnessBtnEight,self.illnessBtnNine,self.illnessBtnTen,self.illnessBtnEleven,self.illnessBtntwelve];
    
//    //将家庭病史中的按钮添加到数组中
//    self.illnessFatherArray=@[self.illnessFatherBtnOne,self.illnessFatherBtnTwo,self.illnessFatherBtnThree,self.illnessFatherBtnFour,self.illnessFatherBtnFive,self.illnessFatherBtnSix,self.illnessFatherBtnSeven,self.illnessFatherBtnEight,self.illnessFatherBtnNine,self.illnessFatherBtnTen,self.illnessFatherBtnEleven];
//    self.illnessMotherArray=@[self.illnessMotherBtnOne,self.illnessMotherBtnTwo,self.illnessMotherBtnThree,self.illnessMotherBtnFour,self.illnessMotherBtnFive,self.illnessMotherBtnSix,self.illnessMotherBtnSeven,self.illnessMotherBtnEight,self.illnessMotherBtnNine,self.illnessMotherBtnTen,self.illnessMotherBtnEleven];
//    self.illnessBortherArray=@[self.illnessBortherBtnOne,self.illnessBortherBtnTwo,self.illnessBortherBtnThree,self.illnessBortherBtnFour,self.illnessBortherBtnFive,self.illnessBortherBtnSix,self.illnessBortherBtnSeven,self.illnessBortherBtnEight,self.illnessBortherBtnNine,self.illnessBortherBtnTen,self.illnessBortherBtnEleven];
  

    //生活习惯标签
    self.hobbylab.textColor = kMainColor;
    
    //居住环境标签
    self.environmentLab.textColor=kMainColor;
    
    self.backgroundColor=[UIColor clearColor];
    
    self.personBackLab.textColor=COLOR(145, 225, 57, 1);
    
    self.count=1;
    
    if (IS_IPHONE5) {
        
        self.doctorLeftCons.constant=60;
        self.doctorLeftConsTwo.constant=60;
        self.doctorLeftConsThress.constant=60;
        self.disaseOne.constant=60;
        self.disaseFive.constant=60;
        self.disaseEight.constant=60;
        self.disaseTen.constant=60;
        self.diaseEleven.constant=60;
        self.disaseTwolve.constant=60;
        self.disaseThreeteen.constant=60;
        self.disaseToLeft.constant=60;
        
        //厨房设备在5带的情况下
        self.kitchenLeftOne.constant=50;
        self.kitchenLeftTwo.constant=15;
        
        //厕所环境在5带的情况下
        self.toiletLeftOne.constant=101;
        self.toiletLeftTwo.constant=91;
        self.toiletLeftThree.constant=15;
        //饮水环境
        self.walterLeftOne.constant=101;
        self.walterLeftTwo.constant=15;
        
        //家庭燃料
        self.homeLeftOne.constant=101;
        self.homeLeftTwo.constant=15;
        
        //家庭病史中父亲一栏距离左边距离的处理
        self.fatherLeftOne.constant=60;
        self.fatherLeftTwo.constant=60;
        self.fatherLeftThree.constant=60;
        self.fatherLeftFour.constant=60;
        self.fatherLeftFive.constant=60;
        self.fatherLeftSix.constant=60;
        
        //家庭病史中母亲一栏距离左边的处理
        self.motherLeftOne.constant=60;
        self.motherLeftTwo.constant=60;
        self.motherLeftThree.constant=60;
        self.motherLeftFour.constant=60;
        self.motherLeftFive.constant=60;
        self.motherLeftSix.constant=60;
        
        //家庭病史中兄弟姐妹一栏距离左边的处理
        self.brotherLeftOne.constant=60;
        self.brotherLeftTwo.constant=60;
        self.brotherLeftThree.constant=60;
        self.brotherLeftFour.constant=60;
        self.brotherLeftFive.constant=60;
        self.brotherLeftSix.constant=60;
        
        //家庭病史中子女一栏距离左边的处理
        self.childLeftOne.constant=60;
        self.childLeftTwo.constant=60;
        self.childLeftThree.constant=60;
        self.childLeftFour.constant=60;
        self.childLeftFive.constant=60;
        self.childLeftSix.constant=60;
        
    }
    
    self.historyLab.textColor=ORANGECOLOR;
    
    self.diseaseContainerViewHeightCons.constant=1;
    
    self.disaseBigContainerViewHeightCons.constant=101;
    
    self.disaseOneHeightCons.constant=0;
    
    self.disaseTwoHeightCons.constant=0;
    
    self.disaseThreeHeightCons.constant=0;
    
    self.disaseFourHeightCons.constant=0;
    
    self.disaseFiveHeightCons.constant=0;
    
    self.disaseSixHeightCons.constant=0;
    
    self.disaseSevenHeightCons.constant=0;
    
    self.disaseTwo.constant=0;
    self.disaseThree.constant=0;
    self.disaseFour.constant=0;
    
    self.disaseSix.constant=0;
    self.disaseSeven.constant=0;
    
    self.disaseFourteen.constant=0;
    self.disaseFiveteen.constant=0;
    self.disaseSixteen.constant=0;
    self.disaseSeventeen.constant=0;
    self.disaseEightteen.constant=0;
    self.disaseNineteen.constant=0;
    self.Disasetwenty.constant=0;
    
#pragma mark 疾病文本框和线条的初始高度
    self.disaseTxt1Hight.constant=0;
    self.disaseTxt2Hight.constant=0;
    self.disaseTxt3Hight.constant=0;
    self.disaseLine3Hight.constant=0;
    self.disaseLine2Hight.constant=0;
    self.disaseLine1Hight.constant=0;
    
#pragma mark 手术一栏外边视图的初始高度
    self.operationV.constant=51;
    self.operationV1.constant=50;
    self.operationV2.constant=0;
    self.operationV3.constant=0;
    self.operationV4.constant=0;
    self.operationV5.constant=1;
#pragma mark 手术一栏文本框的初始高度
    self.operationT1.constant=0;
    self.operationT2.constant=0;
    self.operationT3.constant=0;
    self.operationT4.constant=0;
    self.ol1.constant=0;
    self.ol2.constant=0;
    self.ol3.constant=0;
    self.ol4.constant=0;
    self.ov1.constant=0;
    self.ov3.constant=0;
    self.ov2.constant=0;
    
#pragma mark 保存按钮的处理
    self.btnSave.layer.cornerRadius=22.5;
    self.btnSave.layer.masksToBounds=YES;
    [self.btnSave setBackgroundColor:GREENCOLOR];
    
#pragma mark 外伤一栏视图的初始高度
    self.cBigHight.constant=51;
    self.cOneHeight.constant=0;
    self.cTwoHeight.constant=0;
    self.cThreeHeight.constant=0;
    self.cFourHeight.constant=1;
    self.cLOneHeight.constant=0;
    self.cLTwoHeight.constant=0;
    self.cLThreeHeight.constant=0;
    self.cLFourHeight.constant=0;
    self.cTOneHeight.constant=0;
    self.cTTwoHeight.constant=0;
    self.cTThreeHeight.constant=0;
    self.cTFourHeight.constant=0;
    self.cLineOneHeight.constant=0;
    self.cLineTwoHeight.constant=0;
    self.cLineOneThreeHeight.constant=0;
    
#pragma mark 外伤一栏视图的初始高度
    self.TransBitHeight.constant=51;
    self.transOneHeight.constant=0;
    self.tansTwoHeight.constant=0;
    self.tansThreeHeight.constant=0;
    self.transFourHeight.constant=1;
    self.transTHeightOne.constant=0;
    self.transTHeightTwo.constant=0;
    self.transTHeightThree.constant=0;
    self.transTHeightFour.constant=0;
    self.transLOneHeight.constant=0;
    self.transTwoHeight.constant=0;
    self.transLThreeHeight.constant=0;
    self.transLFourHeight.constant=0;
    self.transLineHeightOne.constant=0;
    self.transLineHeightTwo.constant=0;
    self.transLineHeightThree.constant=0;

#pragma mark 生活环境抽烟的视图初始处理
    self.hobbyBitHeight.constant=250;
    self.somekingOneHeight.constant=0;
    self.somekingTwoHeight.constant=0;
    self.somekingThreeHeight.constant=0;
    self.somekingFourHeight.constant=0;
    self.somekingFiveHeight.constant=0;
    self.somekingSixHeight.constant=0;
    self.somekingYearHeight.constant=0;
    self.somekingCountHeight.constant=0;

#pragma mark 家庭病史中父亲一栏的视图初始处理
    //外部视图高度的约束
    self.fatherBigHieght.constant=51;
    self.fatherOneHeight.constant=0;
    self.fatherTwoHeight.constant=0;
    self.fatherThreeHeight.constant=0;
    self.fatherFourHeight.constant=0;
    self.fatherFiveHeight.constant=0;
    self.fatherSixHeight.constant=1;
    //子视图的高度
    self.fatherOneOneHeight.constant=0;
    self.fatherOneTwoHeight.constant=0;
    self.fatherOneThreeHeight.constant=0;
    self.fatherTwoOneHeight.constant=0;
    self.fatherTwoTwoHeight.constant=0;
    self.fatherThreeOneHeight.constant=0;
    self.fatherThreeTwoHeight.constant=0;
    self.fatherFourOneHeight.constant=0;
    self.fatherFourTwoHeight.constant=0;
    self.fatherFiveOneHeight.constant=0;
    self.fatherSixOneHeight.constant=0;
    self.fatherSixTwoHeight.constant=0;
    self.fatherSixThreeHeight.constant=0;
    
#pragma mark 家庭母亲中父亲一栏的视图初始处理
    //外部视图高度的约束
    self.motherBigHieght.constant=51;
    self.motherOneHeight.constant=0;
    self.motherTwoHeight.constant=0;
    self.motherThreeHeight.constant=0;
    self.motherFourHeight.constant=0;
    self.motherFiveHeight.constant=0;
    self.motherSixHeight.constant=1;
    //子视图的高度
    self.motherOneOneHeight.constant=0;
    self.motherOneTwoHeight.constant=0;
    self.motherOneThreeHeight.constant=0;
    self.motherTwoOneHeight.constant=0;
    self.motherTwoTwoHeight.constant=0;
    self.motherThreeOneHeight.constant=0;
    self.motherThreeTwoHeight.constant=0;
    self.motherFourOneHeight.constant=0;
    self.motherFourTwoHeight.constant=0;
    self.motherFiveOneHeight.constant=0;
    self.motherSixOneHeight.constant=0;
    self.motherSixTwoHeight.constant=0;
    self.motherSixThreeHeight.constant=0;
    
#pragma mark 家庭病史中兄弟姐妹一栏的视图初始处理
    //外部视图高度的约束
    self.brotherBigHieght.constant=51;
    self.brotherOneHeight.constant=0;
    self.brotherTwoHeight.constant=0;
    self.brotherThreeHeight.constant=0;
    self.brotherFourHeight.constant=0;
    self.brotherFiveHeight.constant=0;
    self.brotherSixHeight.constant=1;
    //子视图的高度
    self.brotherOneOneHeight.constant=0;
    self.brotherOneTwoHeight.constant=0;
    self.brotherOneThreeHeight.constant=0;
    self.brotherTwoOneHeight.constant=0;
    self.brotherTwoTwoHeight.constant=0;
    self.brotherThreeOneHeight.constant=0;
    self.brotherThreeTwoHeight.constant=0;
    self.brotherFourOneHeight.constant=0;
    self.brotherFourTwoHeight.constant=0;
    self.brotherFiveOneHeight.constant=0;
    self.brotherSixOneHeight.constant=0;
    self.brotherSixTwoHeight.constant=0;
    self.brotherSixThreeHeight.constant=0;
    
#pragma mark 家庭病史中子女一栏的视图初始处理
    //外部视图高度的约束
    self.childBigHieght.constant=51;
    self.childOneHeight.constant=0;
    self.childTwoHeight.constant=0;
    self.childThreeHeight.constant=0;
    self.childFourHeight.constant=0;
    self.childFiveHeight.constant=0;
    self.childSixHeight.constant=1;
    //子视图的高度
    self.childOneOneHeight.constant=0;
    self.childOneTwoHeight.constant=0;
    self.childOneThreeHeight.constant=0;
    self.childTwoOneHeight.constant=0;
    self.childTwoTwoHeight.constant=0;
    self.childThreeOneHeight.constant=0;
    self.childThreeTwoHeight.constant=0;
    self.childFourOneHeight.constant=0;
    self.childFourTwoHeight.constant=0;
    self.childFiveOneHeight.constant=0;
    self.childSixOneHeight.constant=0;
    self.childSixTwoHeight.constant=0;
    self.childSixThreeHeight.constant=0;
    
    [self commonSetting];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
   
}


-(void)createUI:(NSMutableArray *)illnessArray  ViewCalButtonView:(UICollectionView *)view  selectedArr:(NSMutableArray *)selectedArr{
    
    
   
//    CGFloat lastWidth = 0;
//    
//    int j = 0;
//    
//    for (int i = 0; i<self.personalDictionaryMsg.PastHistory.count; i++) {
//        
//        ++j;
//        
//        DictionaryMsg *model = self.personalDictionaryMsg.PastHistory[i];
//        
//        if ([model.DictionaryName isEqualToString:@"无疾病"]) {
//            
//           
//            continue;
//        }
//        
//        CGFloat width = [model.DictionaryName boundingRectWithSize:CGSizeMake(KScreenWidth-110-110, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}context:nil].size.width+20;
//        
//        
//        
//        XKCircalButton *btn = [[XKCircalButton alloc]init];
//        
//        [btn setTitle:model.DictionaryName forState:UIControlStateNormal];
//        
//        btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
//       
//      
//        btn.frame = CGRectMake(110+(i%2)*(width+10), (10+30+10)*((i-1)/2)+10, width, 30);
//        
//        btn.backgroundColor=[UIColor whiteColor];
//        
//        btn.layer.borderWidth=1;
//        
//        btn.layer.borderColor=kMainColor.CGColor;
//        
//        btn.layer.borderWidth = 0.5f;
//        
//        btn.layer.cornerRadius = 15.f;
//        
//        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
//        
//        [btn addTarget:self action:@selector(illnessChildBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//
//        
//        [view addSubview:btn];
//        
//        lastWidth = width;
//        
//        [illnessArray addObject:btn];
//    }
    
    EqualSpaceFlowLayoutEvolve * flowLayout = [[EqualSpaceFlowLayoutEvolve alloc]initWthType:AlignWithLeft];
    view.collectionViewLayout = flowLayout;
  
    view.delegate = self;
    view.dataSource = self;
    [view registerNib:[UINib nibWithNibName:@"XKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XKCollectionViewCell"];
     for (int i = 0; i<self.personalDictionaryMsg.PastHistory.count; i++) {
         
         DictionaryMsg *model = self.personalDictionaryMsg.PastHistory[i];
         
         if ([model.DictionaryName isEqualToString:@"无疾病"]) {
             continue;
        }
         [illnessArray addObject:model.DictionaryName];
     }
//     selectedArr = [NSMutableArray array];
     for (NSString *name in illnessArray) {
         
         if ([name isEqualToString:@"无疾病"]) {
             continue;
         }
        [selectedArr addObject:@"0"];
     }
    
      [view reloadData];
    

}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"homeFresh1" object:nil];
    
    [self.timer invalidate];
    
    self.timer=nil;
    
}

/**文本框得到焦点时的通知方法**/
-(void)keyboardWillShow:(NSNotification *)noti{
    
    self.contentHeight=self.height;
    
}

/**文本框失去焦点时的通知方法**/
-(void)keyboardWillHide:(NSNotification *)noti{
    
    [self.delegate changeSelf:self withHeight:self.contentHeight];
    
}
-(void)commonSetting{
    
    for (UIView *v in self.subviews) {
        
        if ([v isKindOfClass:[XKCircalButton class]]) {
            
            XKCircalButton *btn=(XKCircalButton *)v;
            
            btn.responsType=2;
            
        }
        
        if ([v isKindOfClass:[UIView class]]) {
            
            for (UIView *vv in v.subviews) {
                
                if ([vv isKindOfClass:[XKCircalButton class]]) {
                    
                    XKCircalButton *vbtn=(XKCircalButton *)vv;
                    
                    vbtn.responsType=2;
                    
                }
                
                if ([vv isKindOfClass:[UIView class]]) {
                    
                    for (UIView *vvv in vv.subviews) {
                        
                        if ([vvv isKindOfClass:[XKCircalButton class]]) {
                            
                            XKCircalButton *vvbtn=(XKCircalButton *)vvv;
                            
                            vvbtn.responsType=2;
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

#pragma mark 清除所有按钮的选中状态
-(void)clearBtnSelect:(NSMutableArray *)btnArray{
    
//    for (XKCircalButton *btn in btnArray) {
//        NSLog(@"btn:%@---%@",btn.titleLabel.text,btn.backgroundColor);
//        btn.responsType=2;
//
//    }

    for (int i = 0;i< btnArray.count;i++) {//有2种数据情况不一样，钟华镇接到的数据其他是XKCircalButtonif (sender==self.payBtnEight) ，我的账号接到的数据是NSString类型，
        if ([btnArray[i] isKindOfClass:[XKCircalButton class]]) {
            XKCircalButton *btn =  btnArray[i];
            NSLog(@"909009009btn:%@---",btn.titleLabel.text);
             btn.responsType=2;
        }else  if ([btnArray[i] isKindOfClass:[NSString class]])
        {
            
            NSLog(@"900009090btn1:%@----",btnArray);
            [btnArray replaceObjectAtIndex:i withObject:@"0"];
        }


    }
    
    
    
}

/**户口类型的单选**/
- (IBAction)clickHouseType:(XKCircalButton *)sender {
    
    sender.responsType=1;
    
    self.isHousType=YES;
    
    if (sender==self.houseTypeOne) {
        
        self.houseTypeTwo.responsType=2;
        
    }else{
        
        self.houseTypeOne.responsType=2;
        
    }
    
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return self.illnessChildArray.count;
    }
    else  if (collectionView == self.fatherCollectionView) {
        return self.illnessFatherArray.count;
    }
    else  if (collectionView == self.motherCollectionView) {
        return self.illnessMotherArray.count;
    }
    else  if (collectionView == self.illesCollectionView) {
        return self.illnessArray.count;
    }
    else
         return self.illnessBortherArray.count;
    
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *moreCellIdentifier = @"XKCollectionViewCell";
    XKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreCellIdentifier forIndexPath:indexPath];
   
    if (collectionView == self.collectionView) {
        cell.name.text = self.illnessChildArray[indexPath.row];
        cell.backgroundColor = [childSelectedArr[indexPath.row] isEqualToString:@"1"]?kMainColor:[UIColor whiteColor];
        cell.name.textColor = [childSelectedArr[indexPath.row] isEqualToString:@"0"]?kMainColor:[UIColor whiteColor];
    }
    else  if (collectionView == self.fatherCollectionView) {
        cell.name.text = self.illnessFatherArray[indexPath.row];
        cell.backgroundColor = [fatherSelectedArr[indexPath.row] isEqualToString:@"1"]?kMainColor:[UIColor whiteColor];
        cell.name.textColor = [fatherSelectedArr[indexPath.row] isEqualToString:@"0"]?kMainColor:[UIColor whiteColor];
    }
    else  if (collectionView == self.motherCollectionView) {
        cell.name.text = self.illnessMotherArray[indexPath.row];
        cell.backgroundColor = [motherSelectedArr[indexPath.row] isEqualToString:@"1"]?kMainColor:[UIColor whiteColor];
        cell.name.textColor = [motherSelectedArr[indexPath.row] isEqualToString:@"0"]?kMainColor:[UIColor whiteColor];
    }
    else  if (collectionView == self.illesCollectionView) {
      
        cell.name.text = self.illnessArray[indexPath.row];
        cell.backgroundColor = [illesSelectedArr[indexPath.row] isEqualToString:@"1"]?kMainColor:[UIColor whiteColor];
        cell.name.textColor = [illesSelectedArr[indexPath.row] isEqualToString:@"0"]?kMainColor:[UIColor whiteColor];
    }
    else
    {
    
        cell.name.text = self.illnessBortherArray[indexPath.row];
        cell.backgroundColor = [brotherSelectedArr[indexPath.row] isEqualToString:@"1"]?kMainColor:[UIColor whiteColor];
        cell.name.textColor = [brotherSelectedArr[indexPath.row] isEqualToString:@"0"]?kMainColor:[UIColor whiteColor];
    
    }
    
   
     NSLog(@"%@",cell.name.text);
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(10, 30, 10, 10);
}

//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *na = self.illnessChildArray[indexPath.row];
    
    
    CGFloat width = [na boundingRectWithSize:CGSizeMake(KScreenWidth-110-25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}context:nil].size.width+20;
    
    return CGSizeMake(width, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *selectedarr = nil;
    NSMutableArray *darr = nil;
    if (collectionView == self.collectionView) {

        
        
        selectedarr = childSelectedArr;
        darr = self.illnessChildArray;
    }
    else  if (collectionView == self.fatherCollectionView) {
        
         selectedarr = fatherSelectedArr;
        darr = self.illnessFatherArray;
    }
    else  if (collectionView == self.motherCollectionView) {
         selectedarr = motherSelectedArr;
         darr = self.illnessMotherArray;
    }
    else  if (collectionView == self.illesCollectionView) {
        selectedarr = illesSelectedArr;
        darr = self.illnessArray;
       
    }
    else
    {
        
         selectedarr = brotherSelectedArr;
         darr = self.illnessBortherArray;
        
    }
    
    NSString *name = selectedarr[indexPath.row];
    
    NSString *na = darr[indexPath.row];
    
    if ([na isEqualToString:@"其它疾病"]) {
        for (int i=0;i<selectedarr.count;i++) {
            [selectedarr replaceObjectAtIndex:i withObject:@"0"];
        }
        
        
       
    }else
    {
    
        for (int i = 0; i<darr.count; i++) {
            NSString *na = darr[i];
            
            if ([na isEqualToString:@"其它疾病"]) {
                
                [selectedarr replaceObjectAtIndex:i withObject:@"0"];
                
            }
            
        }
    }
    
    [selectedarr replaceObjectAtIndex:indexPath.row withObject:[name isEqualToString:@"0"]?@"1":@"0"];
   
    
    
    [collectionView reloadData];
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

- (IBAction)clikDisaseHave:(XKCircalButton *)sender {
    
    XKCircalButton *btn=(XKCircalButton *)sender;
    
    btn.responsType=1;
    
    self.isIllness=YES;
    
    if (btn==self.diseaseNoBtn) {
        
        NSLog(@"无疾病");
        
        [self clearBtnSelect:illesSelectedArr];
        
        [self.illnessTumourTxt resignFirstResponder];
        
        [self.illnessOtherTxt resignFirstResponder];
        
        [self.illnessProfessionTxt resignFirstResponder];
        
        if (self.disaseBigContainerViewHeightCons.constant==101) {
            
            [self.delegate justSelfHeight:249 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:249 withMothed:YES withWay:2];
            
            self.height-=249;
            
        }
        
        self.diseaseHaveBtn.responsType=2;
        
        self.disaseOneHeightCons.constant=0;
        
        self.disaseTwoHeightCons.constant=0;
        
        self.disaseThreeHeightCons.constant=0;
        
        self.disaseFourHeightCons.constant=0;
        
        self.disaseFiveHeightCons.constant=0;
        
        self.disaseSixHeightCons.constant=0;
        
        self.disaseSevenHeightCons.constant=0;
        
        self.disaseTwo.constant=0;
        self.disaseThree.constant=0;
        self.disaseFour.constant=0;
        
        self.disaseSix.constant=0;
        self.disaseSeven.constant=0;
        
        self.disaseFourteen.constant=0;
        self.disaseFiveteen.constant=0;
        self.disaseSixteen.constant=0;
        self.disaseSeventeen.constant=0;
        self.disaseEightteen.constant=0;
        self.disaseNineteen.constant=0;
        self.Disasetwenty.constant=0;
        
#pragma mark 疾病文本框和线条的初始高度
        self.disaseTxt1Hight.constant=0;
        self.disaseTxt2Hight.constant=0;
        self.disaseTxt3Hight.constant=0;
        self.disaseLine3Hight.constant=0;
        self.disaseLine2Hight.constant=0;
        self.disaseLine1Hight.constant=0;
        
        self.diseaseContainerViewHeightCons.constant=1;
        
        self.disaseBigContainerViewHeightCons.constant=101;
        
    }else{
        
        NSLog(@"有疾病");
        
        if (self.disaseBigContainerViewHeightCons.constant==400) {
            
            [self.delegate justSelfHeight:299 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:299 withMothed:YES withWay:1];
            
            self.height+=299;
            
        }
        
        self.diseaseNoBtn.responsType=2;
        
        self.diseaseContainerViewHeightCons.constant=50;
        
        self.disaseBigContainerViewHeightCons.constant=50;
        
        self.disaseOneHeightCons.constant=50;
        
        self.disaseTwoHeightCons.constant=50;
        
        self.disaseThreeHeightCons.constant=50;
        
        self.disaseFourHeightCons.constant=50;
        
        self.disaseFiveHeightCons.constant=0;
        
        self.disaseSixHeightCons.constant=50;
        
        self.disaseSevenHeightCons.constant=50;
        
        self.disaseTwo.constant=30;
        self.disaseThree.constant=30;
        self.disaseFour.constant=30;
        
        self.disaseSix.constant=30;
        self.disaseSeven.constant=30;
        
        self.disaseFourteen.constant=30;
        self.disaseFiveteen.constant=30;
        self.disaseSixteen.constant=30;
        self.disaseSeventeen.constant=30;
        self.disaseEightteen.constant=0;
        self.disaseNineteen.constant=30;
        self.Disasetwenty.constant=30;
        
#pragma mark 疾病文本框和线条的高度改变
        self.disaseTxt1Hight.constant=0;
        self.disaseTxt2Hight.constant=50;
        self.disaseTxt3Hight.constant=50;
        self.disaseLine3Hight.constant=1;
        self.disaseLine2Hight.constant=1;
        self.disaseLine1Hight.constant=1;
        
         self.diseaseContainerViewHeightCons.constant=300;
        
        self.disaseBigContainerViewHeightCons.constant=400;
        
    }
    
    if (sender==self.illnessBtntwelve) {
        
        if (self.illnessBtntwelve.responsType==1) {
            
            [self clearBtnSelect:illesSelectedArr];
            
            self.illnessBtntwelve.responsType=1;
            
        }
        
    }else{
        
        self.illnessBtntwelve.responsType=2;
        
    }
    
//    if (sender==self.illnessBtnTen) {
//        
//        [self.illnessProfessionTxt becomeFirstResponder];
//        
//        [self.illnessOtherTxt resignFirstResponder];
//        
//        [self.illnessTumourTxt resignFirstResponder];
//        
//    }
//    
//    if (sender==self.illnessBtntwelve) {
//        
//        [self.illnessOtherTxt becomeFirstResponder];
//        
//        [self.illnessTumourTxt resignFirstResponder];
//        
//        [self.illnessProfessionTxt resignFirstResponder];
//        
//    }
//    
//    if (sender==self.illnessBtnEleven) {
//        
//        [self.illnessTumourTxt becomeFirstResponder];
//        
//        [self.illnessProfessionTxt resignFirstResponder];
//        
//        [self.illnessOtherTxt resignFirstResponder];
//        
//    }
    
}

#pragma mark 医药支付类型的按钮的单机效果
- (IBAction)clickPayType:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    if (sender.responsType==1) {
        
        sender.responsType=2;
        
    }else{
        
        sender.responsType=1;
        
    }
    
    if (sender==self.payBtnEight) {
        
        if (self.payBtnEight.responsType==1) {
            
            [self clearBtnSelect:self.payBtnArray];//钟华镇的首次进入按钮为XKCirButton
            
            self.payBtnEight.responsType=1;
            
        }
        
    }else{
        
        self.payBtnEight.responsType=2;
        
    }
    
}

#pragma mark 点击按钮抽取公共的方法
-(void)selectBtn:(XKCircalButton *)selectBtn withInArray:(NSArray *)btnArray{
    
    selectBtn.responsType=1;
    
    for (XKCircalButton *btn in btnArray) {
        
        if (btn!=selectBtn) {
            
            btn.responsType=2;
            
        }
        
    }
    
    
}

- (IBAction)clickOpretion:(XKCircalButton *)sender {
    
    XKCircalButton *btn=(XKCircalButton *)sender;
    btn.responsType=1;
    
    if (btn==self.opreationBtnHave) {
        
        self.tolab1.text=@"手术名称";
        
        self.tolab2.text=@"手术日期";
        
        self.tolab3.text=@"手术名称";
        
        self.tolab4.text=@"手术日期";
        
        NSLog(@"有手术");
        
        if (self.operationV.constant==250) {
            
            [self.delegate justSelfHeight:200 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:200 withMothed:YES withWay:1];
            
            self.height+=200;
            
        }
        
#pragma mark 手术一栏外边视图的初始高度
        self.operationV.constant=250;
        self.operationV1.constant=50;
        self.operationV2.constant=50;
        self.operationV3.constant=50;
        self.operationV4.constant=50;
        self.operationV5.constant=50;
#pragma mark 手术一栏文本框的初始高度
        self.operationT1.constant=50;
        self.operationT2.constant=50;
        self.operationT3.constant=50;
        self.operationT4.constant=50;
        self.ol1.constant=22;
        self.ol2.constant=22;
        self.ol3.constant=22;
        self.ol4.constant=22;
        self.ov1.constant=0.5;
        self.ov3.constant=0.5;
        self.ov2.constant=0.5;
        
        self.opreationBtnNot.responsType=2;
        
    }else{
        
        NSLog(@"无手术");
        
        self.tolab1.text=@"";
        
        self.tolab2.text=@"";
        
        self.tolab3.text=@"";
        
        self.tolab4.text=@"";
        
        self.otxt1.text=@"";
        [self.otxt1 resignFirstResponder];
        self.otxt2.text=@"";
        [self.otxt2 resignFirstResponder];
        self.otxt3.text=@"";
        [self.otxt3 resignFirstResponder];
        self.otxt4.text=@"";
        [self.otxt4 resignFirstResponder];
        
        if (self.operationV.constant==51) {
            
            [self.delegate justSelfHeight:200 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:200 withMothed:YES withWay:2];
            
            self.height-=200;
            
        }
        
#pragma mark 手术一栏外边视图的初始高度
        self.operationV.constant=51;
        self.operationV1.constant=50;
        self.operationV2.constant=0;
        self.operationV3.constant=0;
        self.operationV4.constant=0;
        self.operationV5.constant=1;
#pragma mark 手术一栏文本框的初始高度
        self.operationT1.constant=0;
        self.operationT2.constant=0;
        self.operationT3.constant=0;
        self.operationT4.constant=0;
        self.ol1.constant=0;
        self.ol2.constant=0;
        self.ol3.constant=0;
        self.ol4.constant=0;
        self.ov1.constant=0;
        self.ov3.constant=0;
        self.ov2.constant=0;
        
        self.opreationBtnHave.responsType=2;
        
    }
    
    [self layoutIfNeeded];
    
}

- (IBAction)cClickAntion:(XKCircalButton *)sender {
    
    XKCircalButton *btn=(XKCircalButton *)sender;
    
    btn.responsType=1;
    
    if (btn==self.cHaveBtn) {
        
        NSLog(@"有外伤");
        self.olab1.text=@"外伤名称";
        
        self.olab2.text=@"确诊日期";
        
        self.olab3.text=@"外伤名称";
        
        self.olab4.text=@"确诊日期";
        
        if (self.cBigHight.constant==250) {
            
            [self.delegate justSelfHeight:200 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:200 withMothed:YES withWay:1];
            
            self.height+=200;
            
        }
        
#pragma mark 外伤一栏视图的高度改变
        self.cBigHight.constant=250;
        self.cOneHeight.constant=50;
        self.cTwoHeight.constant=50;
        self.cThreeHeight.constant=50;
        self.cFourHeight.constant=50;
        self.cLOneHeight.constant=21;
        self.cLTwoHeight.constant=21;
        self.cLThreeHeight.constant=21;
        self.cLFourHeight.constant=21;
        self.cTOneHeight.constant=50;
        self.cTTwoHeight.constant=50;
        self.cTThreeHeight.constant=50;
        self.cTFourHeight.constant=50;
        self.cLineOneHeight.constant=1;
        self.cLineTwoHeight.constant=1;
        self.cLineOneThreeHeight.constant=1;
        
        self.cNotBtn.responsType=2;
        
    }else{
        
        NSLog(@"无外伤");
        
        self.olab1.text=@"";
        
        self.olab2.text=@"";
        
        self.olab3.text=@"";
        
        self.olab4.text=@"";
        
        [self.traumaText1 resignFirstResponder];
        
        self.traumaText1.text=@"";
        
        [self.traumaText2 resignFirstResponder];
        
        self.traumaText2.text=@"";
        
        [self.traumaText3 resignFirstResponder];
        
        self.traumaText3.text=@"";
        
        [self.traumaText4 resignFirstResponder];
        
        self.traumaText4.text=@"";
        
        if (self.cBigHight.constant==51) {
            
            [self.delegate justSelfHeight:200 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:200 withMothed:YES withWay:2];
            
            self.height-=200;
            
        }
        
#pragma mark 外伤一栏视图的初始高度
        self.cBigHight.constant=51;
        self.cOneHeight.constant=0;
        self.cTwoHeight.constant=0;
        self.cThreeHeight.constant=0;
        self.cFourHeight.constant=1;
        self.cLOneHeight.constant=0;
        self.cLTwoHeight.constant=0;
        self.cLThreeHeight.constant=0;
        self.cLFourHeight.constant=0;
        self.cTOneHeight.constant=0;
        self.cTTwoHeight.constant=0;
        self.cTThreeHeight.constant=0;
        self.cTFourHeight.constant=0;
        self.cLineOneHeight.constant=0;
        self.cLineTwoHeight.constant=0;
        self.cLineOneThreeHeight.constant=0;
        
        self.cHaveBtn.responsType=2;
        
    }
    
}

- (IBAction)tClickAction:(XKCircalButton *)sender {
    
    XKCircalButton *btn=(XKCircalButton *)sender;
    
    btn.responsType=1;
    
    if (btn==self.tHaveBtn) {
        
        NSLog(@"有输血");
        
        self.tlab1.text=@"输血原因";
        
        self.tlab2.text=@"输血日期";
        
        self.tlab3.text=@"输血原因";
        
        self.tlab4.text=@"输血日期";
        
        if (self.TransBitHeight.constant==250) {
            
            [self.delegate justSelfHeight:200 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:200 withMothed:YES withWay:1];
            
            self.height+=200;
            
        }
        
#pragma mark 外伤一栏视图的初始高度
        self.TransBitHeight.constant=250;
        self.transOneHeight.constant=50;
        self.tansTwoHeight.constant=50;
        self.tansThreeHeight.constant=50;
        self.transFourHeight.constant=50;
        self.transTHeightOne.constant=21;
        self.transTHeightTwo.constant=21;
        self.transTHeightThree.constant=21;
        self.transTHeightFour.constant=21;
        self.transLOneHeight.constant=50;
        self.transTwoHeight.constant=50;
        self.transLThreeHeight.constant=50;
        self.transLFourHeight.constant=50;
        self.transLineHeightOne.constant=1;
        self.transLineHeightTwo.constant=1;
        self.transLineHeightThree.constant=1;
        
        self.tNotBtn.responsType=2;
        
    }else{
        
        NSLog(@"没有输血");
        
        self.tlab1.text=@"";
        
        self.tlab2.text=@"";
        
        self.tlab3.text=@"";
        
        self.tlab4.text=@"";
        
        self.transfusionText1.text=@"";
        
        self.transfusionText2.text=@"";
        
        self.transfusionText3.text=@"";
        
        self.transfusionText4.text=@"";
        
        [self.transfusionText4 resignFirstResponder];
        
        [self.transfusionText3 resignFirstResponder];
        
        [self.transfusionText2 resignFirstResponder];
        
        [self.transfusionText1 resignFirstResponder];
        
        if (self.TransBitHeight.constant==51) {
            
            [self.delegate justSelfHeight:200 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:200 withMothed:YES withWay:2];
            
            self.height-=200;
            
        }
        
#pragma mark 外伤一栏视图的初始高度
        self.TransBitHeight.constant=51;
        self.transOneHeight.constant=0;
        self.tansTwoHeight.constant=0;
        self.tansThreeHeight.constant=0;
        self.transFourHeight.constant=1;
        self.transTHeightOne.constant=0;
        self.transTHeightTwo.constant=0;
        self.transTHeightThree.constant=0;
        self.transTHeightFour.constant=0;
        self.transLOneHeight.constant=0;
        self.transTwoHeight.constant=0;
        self.transLThreeHeight.constant=0;
        self.transLFourHeight.constant=0;
        self.transLineHeightOne.constant=0;
        self.transLineHeightTwo.constant=0;
        self.transLineHeightThree.constant=0;
        
        self.tHaveBtn.responsType=2;
        
    }
    
}

- (IBAction)clickSomeking:(XKCircalButton *)sender {
    
    sender.responsType=1;
    
    if (sender==self.somekingHaveBtn) {
        
        self.yearLab.text=@"烟龄";
        self.amountcount.text=@"每日烟数";
        
        NSLog(@"抽烟");
        
        if (self.hobbyBitHeight.constant==350) {
            
            [self.delegate justSelfHeight:100 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:100 withMothed:YES withWay:1];
            
            self.height+=100;
            
        }
        
        self.hobbyBitHeight.constant=350;
        self.somekingOneHeight.constant=22;
        self.somekingTwoHeight.constant=50;
        self.somekingThreeHeight.constant=22;
        self.somekingFourHeight.constant=50;
        self.somekingFiveHeight.constant=1;
        self.somekingSixHeight.constant=1;
        self.somekingYearHeight.constant=50;
        self.somekingCountHeight.constant=50;
        
        self.somekingNotBtn.responsType=2;
        
        UILabel *lab33=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.smokingAgeLab.frame)-75, 0, 30, 50)];
        
        lab33.text=@"/年";
        
        lab33.textColor = GRAYCOLOR;
       
        if (self.smokingAgeLab.subviews.count==0) {
            
            [self.smokingAgeLab addSubview:lab33];
            
        }
        
        UILabel *lab44=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.smokingAgeLab.frame)-75, 0, 30, 50)];
        
        lab44.text=@"/支";
        
        lab44.textColor=GRAYCOLOR;
        
        if (self.smokingCount.subviews.count==0) {
            
            [self.smokingCount addSubview:lab44];
        }
        
    }else{
        
        self.yearLab.text=@"";
        
        self.amountcount.text=@"";
        
        self.smokingAgeLab.text=@"";
        
        self.smokingCount.text=@"";
        
        if (self.hobbyBitHeight.constant==250) {
            
            [self.delegate justSelfHeight:100 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:100 withMothed:YES withWay:2];
            
            self.height-=100;
            
        }
        
        NSLog(@"不抽烟");
        self.hobbyBitHeight.constant=250;
        self.somekingOneHeight.constant=0;
        self.somekingTwoHeight.constant=0;
        self.somekingThreeHeight.constant=0;
        self.somekingFourHeight.constant=0;
        self.somekingFiveHeight.constant=0;
        self.somekingSixHeight.constant=0;
        self.somekingYearHeight.constant=0;
        self.somekingCountHeight.constant=0;
        
        self.somekingHaveBtn.responsType=2;
        
    }
    
}

- (IBAction)fatherClick:(XKCircalButton *)sender {
    
    sender.responsType=1;
    
    if (sender==self.fatherHaveBtn) {
        
        NSLog(@"家庭病史中父亲有病");
        
        if (self.fatherBigHieght.constant==350) {
            
            [self.delegate justSelfHeight:300 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:300 withMothed:YES withWay:1];
            
            self.height+=300;
            
        }
        
#pragma mark 家庭病史中父亲一栏的视图初始处理
        //外部视图高度的约束
        self.fatherBigHieght.constant=350;
        self.fatherOneHeight.constant=50;
        self.fatherTwoHeight.constant=50;
        self.fatherThreeHeight.constant=50;
        self.fatherFourHeight.constant=50;
        self.fatherFiveHeight.constant=50;
        self.fatherSixHeight.constant=50;
        //子视图的高度
        self.fatherOneOneHeight.constant=30;
        self.fatherOneTwoHeight.constant=30;
        self.fatherOneThreeHeight.constant=30;
        self.fatherTwoOneHeight.constant=30;
        self.fatherTwoTwoHeight.constant=30;
        self.fatherThreeOneHeight.constant=30;
        self.fatherThreeTwoHeight.constant=30;
        self.fatherFourOneHeight.constant=30;
        self.fatherFourTwoHeight.constant=30;
        self.fatherFiveOneHeight.constant=30;
        self.fatherSixOneHeight.constant=30;
        self.fatherSixTwoHeight.constant=50;
        self.fatherSixThreeHeight.constant=1;
        
        self.fatherNotBtn.responsType=2;
        
    }else{
        
        NSLog(@"家庭病史中父亲无病");
        
        [self.illnessFatherTxt resignFirstResponder];
        
         [self clearBtnSelect:fatherSelectedArr];
        
        if (self.fatherBigHieght.constant==51) {
            
            [self.delegate justSelfHeight:299 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:299 withMothed:YES withWay:2];
            
            self.height-=299;
            
        }
        
#pragma mark 家庭病史中父亲一栏的视图初始处理
        //外部视图高度的约束
        self.fatherBigHieght.constant=51;
        self.fatherOneHeight.constant=0;
        self.fatherTwoHeight.constant=0;
        self.fatherThreeHeight.constant=0;
        self.fatherFourHeight.constant=0;
        self.fatherFiveHeight.constant=0;
        self.fatherSixHeight.constant=1;
        //子视图的高度
        self.fatherOneOneHeight.constant=0;
        self.fatherOneTwoHeight.constant=0;
        self.fatherOneThreeHeight.constant=0;
        self.fatherTwoOneHeight.constant=0;
        self.fatherTwoTwoHeight.constant=0;
        self.fatherThreeOneHeight.constant=0;
        self.fatherThreeTwoHeight.constant=0;
        self.fatherFourOneHeight.constant=0;
        self.fatherFourTwoHeight.constant=0;
        self.fatherFiveOneHeight.constant=0;
        self.fatherSixOneHeight.constant=0;
        self.fatherSixTwoHeight.constant=0;
        self.fatherSixThreeHeight.constant=0;
        
        self.fatherHaveBtn.responsType=2;
        
    }
    
}

- (IBAction)motherClick:(XKCircalButton *)sender {
    
    sender.responsType=1;
    
    if (sender==self.motherHaveBtn) {
        
        NSLog(@"家庭病史中母亲有病");
        
        if (self.motherBigHieght.constant==350) {
            
            [self.delegate justSelfHeight:300 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:300 withMothed:YES withWay:1];
            
            self.height+=300;
            
        }
        
        self.motherBigHieght.constant=350;
        self.motherOneHeight.constant=50;
        self.motherTwoHeight.constant=50;
        self.motherThreeHeight.constant=50;
        self.motherFourHeight.constant=50;
        self.motherFiveHeight.constant=50;
        self.motherSixHeight.constant=50;
        //子视图的高度
        self.motherOneOneHeight.constant=30;
        self.motherOneTwoHeight.constant=30;
        self.motherOneThreeHeight.constant=30;
        self.motherTwoOneHeight.constant=30;
        self.motherTwoTwoHeight.constant=30;
        self.motherThreeOneHeight.constant=30;
        self.motherThreeTwoHeight.constant=30;
        self.motherFourOneHeight.constant=30;
        self.motherFourTwoHeight.constant=30;
        self.motherFiveOneHeight.constant=30;
        self.motherSixOneHeight.constant=30;
        self.motherSixTwoHeight.constant=50;
        self.motherSixThreeHeight.constant=1;
        
        self.motherNotBtn.responsType=2;
        
    }else{
        
        NSLog(@"家庭病史中母亲无病");
        
        [self.illnessMotherTxt resignFirstResponder];
        
        [self clearBtnSelect:motherSelectedArr];
        
        if (self.motherBigHieght.constant==51) {
            
            [self.delegate justSelfHeight:299 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:299 withMothed:YES withWay:2];
            
            self.height-=299;
            
        }
        
#pragma mark 家庭病史中父亲一栏的视图初始处理
        //外部视图高度的约束
        self.motherBigHieght.constant=51;
        self.motherOneHeight.constant=0;
        self.motherTwoHeight.constant=0;
        self.motherThreeHeight.constant=0;
        self.motherFourHeight.constant=0;
        self.motherFiveHeight.constant=0;
        self.motherSixHeight.constant=1;
        //子视图的高度
        self.motherOneOneHeight.constant=0;
        self.motherOneTwoHeight.constant=0;
        self.motherOneThreeHeight.constant=0;
        self.motherTwoOneHeight.constant=0;
        self.motherTwoTwoHeight.constant=0;
        self.motherThreeOneHeight.constant=0;
        self.motherThreeTwoHeight.constant=0;
        self.motherFourOneHeight.constant=0;
        self.motherFourTwoHeight.constant=0;
        self.motherFiveOneHeight.constant=0;
        self.motherSixOneHeight.constant=0;
        self.motherSixTwoHeight.constant=0;
        self.motherSixThreeHeight.constant=0;
        
        self.motherHaveBtn.responsType=2;
        
    }
    
}

- (IBAction)brotherClick:(XKCircalButton *)sender {
    
    sender.responsType=1;
    
    if (sender==self.brotherHaveBtn) {

        NSLog(@"家庭病史中兄弟姐妹有病");
        
        if (self.brotherBigHieght.constant==350) {
            
            [self.delegate justSelfHeight:300 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:300 withMothed:YES withWay:1];
            
            self.height+=300;
            
        }
        
        self.brotherBigHieght.constant=350;
        self.brotherOneHeight.constant=50;
        self.brotherTwoHeight.constant=50;
        self.brotherThreeHeight.constant=50;
        self.brotherFourHeight.constant=50;
        self.brotherFiveHeight.constant=50;
        self.brotherSixHeight.constant=50;
        //子视图的高度
        self.brotherOneOneHeight.constant=30;
        self.brotherOneTwoHeight.constant=30;
        self.brotherOneThreeHeight.constant=30;
        self.brotherTwoOneHeight.constant=30;
        self.brotherTwoTwoHeight.constant=30;
        self.brotherThreeOneHeight.constant=30;
        self.brotherThreeTwoHeight.constant=30;
        self.brotherFourOneHeight.constant=30;
        self.brotherFourTwoHeight.constant=30;
        self.brotherFiveOneHeight.constant=30;
        self.brotherSixOneHeight.constant=30;
        self.brotherSixTwoHeight.constant=50;
        self.brotherSixThreeHeight.constant=1;
        
        self.brotherNotBtn.responsType=2;
        
    }else{
        
        NSLog(@"家庭病史中接地姐妹无病");
        
        [self.illnessBortherOtherTxt resignFirstResponder];
        
        [self clearBtnSelect:brotherSelectedArr];
        
        if (self.brotherBigHieght.constant==51) {
            
            [self.delegate justSelfHeight:299 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:299 withMothed:YES withWay:2];
            
            self.height-=299;
            
        }
        
#pragma mark 家庭病史中父亲一栏的视图初始处理
        //外部视图高度的约束
        self.brotherBigHieght.constant=51;
        self.brotherOneHeight.constant=0;
        self.brotherTwoHeight.constant=0;
        self.brotherThreeHeight.constant=0;
        self.brotherFourHeight.constant=0;
        self.brotherFiveHeight.constant=0;
        self.brotherSixHeight.constant=1;
        //子视图的高度
        self.brotherOneOneHeight.constant=0;
        self.brotherOneTwoHeight.constant=0;
        self.brotherOneThreeHeight.constant=0;
        self.brotherTwoOneHeight.constant=0;
        self.brotherTwoTwoHeight.constant=0;
        self.brotherThreeOneHeight.constant=0;
        self.brotherThreeTwoHeight.constant=0;
        self.brotherFourOneHeight.constant=0;
        self.brotherFourTwoHeight.constant=0;
        self.brotherFiveOneHeight.constant=0;
        self.brotherSixOneHeight.constant=0;
        self.brotherSixTwoHeight.constant=0;
        self.brotherSixThreeHeight.constant=0;
        
        self.brotherHaveBtn.responsType=2;
        
    }
    
}

- (IBAction)childClick:(XKCircalButton *)sender {
    
    sender.responsType=1;
    
    if (sender==self.childHaveBtn) {
        
        NSLog(@"家庭病史中子女有病");
        
        if (self.childBigHieght.constant==350) {
            
            [self.delegate justSelfHeight:300 withMothed:NO withWay:1];
            
        }else{
            
            [self.delegate justSelfHeight:300 withMothed:YES withWay:1];
            
            self.height+=300;
            
        }
        
        self.childBigHieght.constant=350;
        self.childOneHeight.constant=50;
        self.childTwoHeight.constant=50;
        self.childThreeHeight.constant=50;
        self.childFourHeight.constant=50;
        self.childFiveHeight.constant=50;
        self.childSixHeight.constant=50;
        //子视图的高度
        self.childOneOneHeight.constant=30;
        self.childOneTwoHeight.constant=30;
        self.childOneThreeHeight.constant=30;
        self.childTwoOneHeight.constant=30;
        self.childTwoTwoHeight.constant=30;
        self.childThreeOneHeight.constant=30;
        self.childThreeTwoHeight.constant=30;
        self.childFourOneHeight.constant=30;
        self.childFourTwoHeight.constant=30;
        self.childFiveOneHeight.constant=30;
        self.childSixOneHeight.constant=30;
        self.childSixTwoHeight.constant=50;
        self.childSixThreeHeight.constant=1;
        
        self.childNotBtn.responsType=2;
        
    }else{
        
        NSLog(@"家庭病史中子女无病");
        
        [self.illnessChildTxt resignFirstResponder];
        
        [self clearBtnSelect:childSelectedArr];
        
        
        
        
        
        
        if (self.childBigHieght.constant==51) {
            
            [self.delegate justSelfHeight:299 withMothed:NO withWay:2];
            
        }else{
            
            [self.delegate justSelfHeight:299 withMothed:YES withWay:2];
            
            self.height-=299;
            
        }
        
#pragma mark 家庭病史中父亲一栏的视图初始处理
        //外部视图高度的约束
        self.childBigHieght.constant=51;
        self.childOneHeight.constant=0;
        self.childTwoHeight.constant=0;
        self.childThreeHeight.constant=0;
        self.childFourHeight.constant=0;
        self.childFiveHeight.constant=0;
        self.childSixHeight.constant=1;
        //子视图的高度
        self.childOneOneHeight.constant=0;
        self.childOneTwoHeight.constant=0;
        self.childOneThreeHeight.constant=0;
        self.childTwoOneHeight.constant=0;
        self.childTwoTwoHeight.constant=0;
        self.childThreeOneHeight.constant=0;
        self.childThreeTwoHeight.constant=0;
        self.childFourOneHeight.constant=0;
        self.childFourTwoHeight.constant=0;
        self.childFiveOneHeight.constant=0;
        self.childSixOneHeight.constant=0;
        self.childSixTwoHeight.constant=0;
        self.childSixThreeHeight.constant=0;
        
        self.childHaveBtn.responsType=2;
        
    }
    
}

#pragma mark 厨房操作按钮的点击
- (IBAction)kitchenBtnClick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isChentch=YES;
    
    [self selectBtn:sender withInArray:self.kitchenBtnArray];
    
}

#pragma mark 厕所环境按钮的点击
- (IBAction)toiletBtnClick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isTitol=YES;
    
    [self selectBtn:sender withInArray:self.toiletArray];
    
}

#pragma mark 饮水类型按钮的点击
- (IBAction)drinkingWaterBtnClick:(XKCircalButton *)sender {
    
     NSLog(@"%@",sender.titleLabel.text);
    
    self.isWater=YES;

    [self selectBtn:sender withInArray:self.drinkingWaterArray];
    
}

#pragma mark 家庭燃料按钮的点击
- (IBAction)indoorBtnClick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isFutal=YES;
    
    [self selectBtn:sender withInArray:self.indoorArray];
    
}

#pragma mark 长期服药
- (IBAction)medicineBtnclick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isLoog=YES;
    
    [self selectBtn:sender withInArray:self.medicineArray];
    
}

#pragma mark 睡眠规律
- (IBAction)selectBtnClick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isReguler=YES;
    
    [self selectBtn:sender withInArray:self.sleepArray];
    
}

- (IBAction)illnessBtnClick:(XKCircalButton *)sender {
#pragma mark 疾病
    
    if (sender.responsType==1) {
        
        sender.responsType=2;
        
    }else{
        
        sender.responsType=1;
        
    }
    
    if (sender==self.illnessBtntwelve ) {
        
        if (self.illnessBtntwelve.responsType==1) {
            
            [self clearBtnSelect:self.illnessArray];
            
            self.illnessBtntwelve.responsType=1;
            
        }
        
    }else{
        
        self.illnessBtntwelve.responsType=2;
        
    }
    
//    [self selectBtn:sender withInArray:self.illnessArray];
    
//    if (sender==self.illnessBtnEleven||sender==self.illnessBtnTen||sender==self.illnessBtntwelve) {
//    
//        if (sender==self.illnessBtntwelve) {
//            
//            [self.illnessTumourTxt resignFirstResponder];
//            
//            [self.illnessProfessionTxt resignFirstResponder];
//            
//            [self.illnessOtherTxt becomeFirstResponder];
//            
//        }
//        
//        if (sender==self.illnessBtnTen) {
//            
//            [self.illnessTumourTxt resignFirstResponder];
//            
//            [self.illnessProfessionTxt becomeFirstResponder];
//            
//            [self.illnessOtherTxt resignFirstResponder];
//            
//        }
//        
//        if (sender==self.illnessBtnEleven) {
//            
//            [self.illnessTumourTxt becomeFirstResponder];
//            
//            [self.illnessProfessionTxt resignFirstResponder];
//            
//            [self.illnessOtherTxt resignFirstResponder];
//            
//        }
//        
//    }else{
//        
//        [self.illnessTumourTxt resignFirstResponder];
//        
//        [self.illnessProfessionTxt resignFirstResponder];
//        
//        [self.illnessOtherTxt resignFirstResponder];
//        
//    }
    
}

#pragma mark 父病
- (IBAction)illnessFatherBtnClick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isFatherIllness=YES;
    
    if (sender.responsType==1) {
        
        sender.responsType=2;
        
    }else{
        
        sender.responsType=1;
        
    }
    
    if (sender==self.illnessFatherBtnEleven ) {
        
        if (self.illnessFatherBtnEleven.responsType==1) {
            
            [self clearBtnSelect:self.illnessFatherArray];
            
            self.illnessFatherBtnEleven.responsType=1;
            
        }
        
    }else{
        
        self.illnessFatherBtnEleven.responsType=2;
        
    }
    
}

#pragma mark 母病
- (IBAction)illnessMotherBtnClick:(XKCircalButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
    self.isMotherIllness=YES;
    
    if (sender.responsType==1) {
        
        sender.responsType=2;
        
    }else{
        
        sender.responsType=1;
        
    }
    
    if (sender==self.illnessMotherBtnEleven ) {
        
        if (self.illnessMotherBtnEleven.responsType==1) {
            
            [self clearBtnSelect:self.illnessMotherArray];
            
            self.illnessMotherBtnEleven.responsType=1;
            
        }
        
    }else{
        
        self.illnessMotherBtnEleven.responsType=2;
        
    }
    
}

#pragma mark 兄弟姐妹病
- (IBAction)illnessBortherBtnClick:(XKCircalButton *)sender {
    
    self.isBrotherIllness=YES;
    
    if (sender.responsType==1) {
        
        sender.responsType=2;
        
    }else{
        
        sender.responsType=1;
        
    }
    
    if (sender==self.illnessBortherBtnEleven) {
        
        if (self.illnessBortherBtnEleven.responsType==1) {
            
            [self clearBtnSelect:self.illnessBortherArray];
            
            self.illnessBortherBtnEleven.responsType=1;
            
        }
        
    }else{
        
        self.illnessBortherBtnEleven.responsType=2;
        
    }
    
}

#pragma mark 子女病
- (IBAction)illnessChildBtnClick:(XKCircalButton *)sender {
    
    self.isChildIllness=YES;
    
    if (sender.responsType==1) {
        
        sender.responsType=2;
        
    }else{
        
        sender.responsType=1;
        
    }
    
    if ([sender.titleLabel.text isEqualToString:@"其它疾病"]) {
        
        if (sender.responsType==1) {
            
            [self clearBtnSelect:self.illnessChildArray];
            
            sender.responsType=1;
            
        }
        
    }
    else{
        
//        sender.responsType=1;//其他疾病
        for (XKCircalButton *btn in self.illnessChildArray) {
            NSLog(@"12334btn:%@---%@",btn.titleLabel.text,btn.backgroundColor);
            if ([btn.titleLabel.text isEqualToString:@"其它疾病"]) {
                
                 btn.responsType=2;
                
            }
            
        }
       
       
    }
    
}

/**时间选择器的代理方法**/
-(void)birthDayPickerChange:(NSString *)dateStr withInstanc:(BirthDayPickerView *) picker{
    
    if (picker.field==self.traumaText2) {
        
        self.traumaText2.text=dateStr;
        
    }
    
    if (picker.field==self.traumaText4) {
        
        self.traumaText4.text=dateStr;
        
    }
    
    if (picker.field==self.transfusionText2) {
        
        self.transfusionText2.text=dateStr;
        
    }
    
    if (picker.field==self.transfusionText4) {
        
        self.transfusionText4.text=dateStr;
        
    }
    
    if (picker.field==self.otxt2) {
        
        self.otxt2.text=dateStr;
        
    }
    
    if (picker.field==self.otxt4) {
        
        self.otxt4.text=dateStr;
        
    }
    
}

/**重写返回信息的set方法**/
-(void)setPersonArc:(PersonalArcModel *)personArc{
    
    _personArc=personArc;
  
    /**处理个人背景的基本信息**/
    [self dealWithPersonalMessage];
    self.illnessChildArray = [[NSMutableArray alloc]init];
    childSelectedArr = [[NSMutableArray alloc]init];
    self.illnessMotherArray = [[NSMutableArray alloc]init];
    motherSelectedArr = [[NSMutableArray alloc]init];
    self.illnessFatherArray = [[NSMutableArray alloc]init];
    fatherSelectedArr = [[NSMutableArray alloc]init];
    self.illnessBortherArray = [[NSMutableArray alloc]init];
    brotherSelectedArr = [[NSMutableArray alloc]init];
    self.illnessArray = [[NSMutableArray alloc]init];
    illesSelectedArr = [[NSMutableArray alloc]init];
    
    [self createUI:self.illnessChildArray ViewCalButtonView:_collectionView selectedArr:childSelectedArr];
    
     [self createUI:self.illnessArray ViewCalButtonView:_illesCollectionView selectedArr:illesSelectedArr];

    [self createUI:self.illnessBortherArray ViewCalButtonView:_brotherCollectionView selectedArr:brotherSelectedArr];
    

    [self createUI:self.illnessFatherArray ViewCalButtonView:_fatherCollectionView selectedArr:fatherSelectedArr];
    

    [self createUI:self.illnessMotherArray ViewCalButtonView:_motherCollectionView selectedArr:motherSelectedArr];
    /**调用方法处理既往病史**/
    [self dealWithHistoryIllness];
    
    /**调用方法处理手术**/
    [self dealWithOperation];
    
    /**调用方法处理外伤**/
    [self dealWithTrauma];
    
    /**调用方法处理输血**/
    [self dealWithProjectTransfusion];
    
    /**调用方法处理家庭病史**/
    [self dealWithfamilyIllness];
    
    /**调用方法处理睡眠是否规律**/
    [self dealWithSleep];
    
    /**处理抽烟和喝酒的数据**/
    [self dealWithSmoking];
    
    /**调用方法处理是否长期服用药物**/
    [self dealWtihLongMedic];
    
    /**调用方法处理家庭环境**/
    [self dealWithLifeEnvironmentName];
    
    ArchivesEditView *view = [[ArchivesEditView alloc]initWithFrame: CGRectMake(0, KScreenHeight - 240, KScreenWidth, 150)];
    
    view.delegate=self;
    self.marlab.inputView=view;
    
    view.dataArr=self.personalDictionaryMsg.MaritalStatus;
 
    self.txtInputView1=view;
    
    ArchivesEditView *view1 = [[ArchivesEditView alloc]initWithFrame: CGRectMake(0, KScreenHeight - 240, KScreenWidth, 150)];
    
    view1.dataArr=self.personalDictionaryMsg.BloodType;
    
    view1.delegate=self;
    
    self.bloodlab.inputView=view1;
    
    self.txtInputView2=view1;
    
    ArchivesEditView *view2 = [[ArchivesEditView alloc]initWithFrame: CGRectMake(0, KScreenHeight - 240, KScreenWidth, 150)];
    
    view2.delegate=self;
    
    self.drinkLab.inputView=view2;
    
    view2.dataArr=self.personalDictionaryMsg.DrinkingStatus;
    
    self.txtInputView3=view2;
    
    
    ArchivesEditView *view3 = [[ArchivesEditView alloc]initWithFrame: CGRectMake(0, KScreenHeight - 240, KScreenWidth, 150)];
    
    view3.delegate=self;
    
    self.notionLab.inputView=view3;
    
    view3.dataArr=self.personalDictionaryMsg.NationList;
    
    self.txtInputView4=view3;
    
    ArchivesEditView *view4 = [[ArchivesEditView alloc]initWithFrame: CGRectMake(0, KScreenHeight - 240, KScreenWidth, 150)];
    
    view4.delegate=self;
    
    self.educationTxt.inputView=view4;
    
    view4.dataArr=self.personalDictionaryMsg.EducationLevel;
    
    self.txtInputView5=view4;
    
    BirthDayPickerView *timePick=[[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    timePick.delegate = self;
    timePick.alpha = 1;
    self.traumaText2.inputView=timePick;
    timePick.isShowButtonView=YES;
    timePick.field=self.traumaText2;
    
    
    BirthDayPickerView *timePick1=[[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    timePick1.delegate = self;
    timePick1.alpha = 1;
    self.traumaText4.inputView=timePick1;
    timePick1.isShowButtonView=YES;
    timePick1.field=self.traumaText4;
    
    BirthDayPickerView *timePick3=[[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    timePick3.delegate = self;
    timePick3.alpha = 1;
    self.transfusionText2.inputView=timePick3;
    timePick3.isShowButtonView=YES;
    timePick3.field=self.transfusionText2;
    
    
    BirthDayPickerView *timePick4=[[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    timePick4.delegate = self;
    timePick4.alpha = 1;
    self.transfusionText4.inputView=timePick4;
    timePick4.isShowButtonView=YES;
    timePick4.field=self.transfusionText4;
    
    BirthDayPickerView *timePick5=[[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    timePick5.delegate = self;
    timePick5.alpha = 1;
    self.otxt2.inputView=timePick5;
    timePick5.isShowButtonView=YES;
    timePick5.field=self.otxt2;
    
    
    BirthDayPickerView *timePick6=[[BirthDayPickerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    timePick6.delegate = self;
    timePick6.alpha = 1;
    self.otxt4.inputView=timePick6;
    timePick6.isShowButtonView=YES;
    timePick6.field=self.otxt4;
    

   

}

/**选择器的协议方法**/
-(void)changeDataPicker:(DictionaryMsg *)msg andRow:(NSInteger)row withSelef:(ArchivesEditView *)view{
    
    if (view==self.txtInputView1) {
        
        self.marlab.text=msg.DictionaryName;
        
    }
    
    if (view==self.txtInputView2) {
        
        self.bloodlab.text=msg.DictionaryName;
        
    }
    
    if (view==self.txtInputView3) {
        
        self.drinkLab.text=msg.DictionaryName;
        
    }
    
    if (view==self.txtInputView4) {
        
        self.notionLab.text=msg.DictionaryName;
        
    }
    
    if (view==self.txtInputView5) {
        
        self.educationTxt.text=msg.DictionaryName;
        
    }
    
}

- (IBAction)clickSave:(id)sender {
    
    NSLog(@"保存档案");
#pragma mark 血型已经解决
    
    if (self.addressTxt.text.length==0) {//判断籍贯是否为空
        
        [self showAlertController:@"请填写籍贯"];
        
        return;
        
    }
    
    if (self.notionLab.text.length==0) {//判断民族是否为空
        
        [self showAlertController:@"请填写民族"];
        
        return;
        
    }
    
    if (self.educationTxt.text.length==0) {//判断教育等级是否为空
        
        [self showAlertController:@"请填写教育等级"];
        
        return;
        
    }
    
    if (!self.isHousType) {//判断是否有填写户口类型
     
        [self showAlertController:@"请填写户口类型"];
        
        return;
        
    }
    
    if (self.marlab.text.length==0) {//判断婚姻状是否填写
        
        [self showAlertController:@"请填写婚姻状况"];
        
        return;
        
    }
    
    if (self.bloodlab.text.length==0) {//判断血型是否为空
        
        [self showAlertController:@"请填写血型"];
        
        return;
        
    }
    
    if (!self.isFutal) {
        
        [self showAlertController:@"请填写家庭燃料"];
        
        return;
        
    }
    
    if (!self.isWater) {
        
        [self showAlertController:@"请填写饮水环境"];
        
        return;
        
    }
    
    if (!self.isTitol) {
        
        [self showAlertController:@"请填写厕所环境"];
        
        return;
        
    }
    
    if (!self.isChentch) {
        
        [self showAlertController:@"请填写厨房环境"];
        
        return;
        
    }
    
    NSInteger bloodid=-1;
    //匹配拿到血型相应的字典
    for (DictionaryMsg *model in self.personalDictionaryMsg.BloodType) {//血型
        
        if ([model.DictionaryName isEqualToString:self.bloodlab.text]) {
            
            bloodid=model.DictionaryID;
            
            break;
            
        }
        
    }
    
#pragma mark 喝酒状态已经解决
    NSInteger drinkStatusid=-1;
    for (DictionaryMsg *model in self.personalDictionaryMsg.DrinkingStatus) {//喝酒状态
        
        if ([self.drinkLab.text isEqualToString:model.DictionaryName]) {
            
            drinkStatusid=model.DictionaryID;
            
            break;
            
        }
        
    }
#pragma mark 饮水环境已经解决
    NSInteger drinkid=-1;
    for (DictionaryMsg *model in self.personalDictionaryMsg.DrinkingWater) {//饮水环境
        
        NSLog(@"%li",model.DictionaryID);
        
        NSLog(@"%@",model.DictionaryName);
        
        for (XKCircalButton *btn in self.drinkingWaterArray) {
            
            if (btn.responsType==1) {
                
                if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
                    
                    drinkid=model.DictionaryID;
                    
                    break;
                    
                }
                
            }
            
        }
        
    }
    
#pragma mark 厨房环境已经解决
    NSInteger kitchenId=-1;
    
    for (XKCircalButton *btn in self.kitchenBtnArray) {//厨房环境
        
        if (btn.responsType==1) {
            
            for (DictionaryMsg *model in self.personalDictionaryMsg.ExhaustMeasures) {
                
                if ([model.DictionaryName isEqualToString:btn.titleLabel.text]) {
                    
                    kitchenId=model.DictionaryID;
                    
                    break;
                    
                }
                
            }
            
        }
        
    }
#pragma mark 燃料已经解决
    NSInteger FuelTypeID=-1;
    for (XKCircalButton *btn in self.indoorArray) {//燃料
        
        if (btn.responsType==1) {
            
            for (DictionaryMsg *model in self.personalDictionaryMsg.FuelType) {
                
                if ([model.DictionaryName isEqualToString:btn.titleLabel.text]) {
                    
                    FuelTypeID=model.DictionaryID;
                    
                    break;
                    
                }
                
            }
            
        }
        
    }
    
#pragma mark 婚姻状态已经解决
    NSInteger marId=-1;
    //婚姻状况
    for (DictionaryMsg *model in self.personalDictionaryMsg.MaritalStatus) {
        
        if ([model.DictionaryName isEqualToString:self.marlab.text]) {
            
            marId=model.DictionaryID;
            
            break;
            
        }
        
    }
    
#pragma mark 已解决
    //户口类型
    NSInteger ResidenceTypeID=-1;
    for (DictionaryMsg *model in self.personalDictionaryMsg.ResidenceType) {
        
        if (self.houseTypeOne.responsType==1) {
            
            if ([model.DictionaryName isEqualToString:self.houseTypeOne.titleLabel.text]) {
                ResidenceTypeID=model.DictionaryID;
            }
            
        }
        
        if (self.houseTypeTwo.responsType==1) {
            
            if ([model.DictionaryName isEqualToString:self.houseTypeTwo.titleLabel.text]) {
                ResidenceTypeID=model.DictionaryID;
            }
            
        }
        
    }
    NSLog(@"%li",ResidenceTypeID);
    
#pragma mark 抽烟已经解决
    NSInteger SmokingAge=[self.smokingAgeLab.text integerValue];//艳玲
    NSInteger SmokingAmountDay=[self.smokingCount.text integerValue];//每日抽烟数量
    NSInteger SmokingStatusID=-1;//抽烟状态
    if (self.somekingNotBtn.responsType==1) {
        
        SmokingStatusID=0;
        
    }
    if (self.somekingHaveBtn.responsType==1) {
        
        SmokingStatusID=1;
        
    }
    
#pragma mark 厕所环境已经解决
    //ToiletID厕所环境
    NSInteger ToiletID=-1;
    for (XKCircalButton *btn in self.toiletArray) {
        
        if (btn.responsType==1) {
            
            for (DictionaryMsg *model in self.personalDictionaryMsg.Toilet) {
                
                if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
                    
                    ToiletID=model.DictionaryID;
                    
                    break;
                    
                }
                
            }
            
        }
        
    }
    
#pragma mark 输血  外伤 手术 已经解决
    NSString *ProjectOperation=[NSString stringWithFormat:@"%@,%@|%@,%@",self.otxt1.text,self.otxt2.text,self.otxt3.text,self.otxt4.text];//手术
    if ([self.otxt1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0 && [self.otxt3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        ProjectOperation=[NSString stringWithFormat:@"%@,%@",self.otxt1.text,self.otxt2.text];
    }
    if ([self.otxt1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 && [self.otxt3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
        ProjectOperation=[NSString stringWithFormat:@"%@,%@",self.otxt3.text,self.otxt4.text];
    }
    if ([self.otxt1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0 && [self.otxt3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
        ProjectOperation=[NSString stringWithFormat:@"%@,%@|%@,%@",self.otxt1.text,self.otxt2.text,self.otxt3.text,self.otxt4.text];//手术
    }
    if ([self.otxt1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 && [self.otxt3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        ProjectOperation = @"";
    }
    
    NSString *ProjectTrauma=[NSString stringWithFormat:@"%@,%@|%@,%@",self.traumaText1.text,self.traumaText2.text,self.traumaText3.text,self.traumaText4.text];//外伤
    if ([self.traumaText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0 && [self.traumaText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        ProjectTrauma=[NSString stringWithFormat:@"%@,%@",self.traumaText1.text,self.traumaText2.text];
    }
    if ([self.traumaText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 && [self.traumaText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
        ProjectTrauma=[NSString stringWithFormat:@"%@,%@",self.traumaText3.text,self.traumaText4.text];
    }
    if ([self.traumaText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0 && [self.traumaText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
        ProjectTrauma=[NSString stringWithFormat:@"%@,%@|%@,%@",self.traumaText1.text,self.traumaText2.text,self.traumaText3.text,self.traumaText4.text];//外伤
        
    }
    if ([self.traumaText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 && [self.traumaText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        ProjectTrauma = @"";//外伤
        
    }
    
    NSString *ProjectTransfusion=[NSString stringWithFormat:@"%@,%@|%@,%@",self.transfusionText1.text,self.transfusionText2.text,self.transfusionText3.text,self.transfusionText4.text];//输血
    if ([self.transfusionText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0 && [self.transfusionText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        ProjectTransfusion=[NSString stringWithFormat:@"%@,%@",self.transfusionText1.text,self.transfusionText2.text];
    }
    if ([self.transfusionText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 && [self.transfusionText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
        ProjectTransfusion=[NSString stringWithFormat:@"%@,%@",self.transfusionText3.text,self.transfusionText4.text];
    }
    if ([self.transfusionText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0 && [self.transfusionText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
        ProjectTransfusion=[NSString stringWithFormat:@"%@,%@|%@,%@",self.transfusionText1.text,self.transfusionText2.text,self.transfusionText3.text,self.transfusionText4.text];//输血
        
    }
    if ([self.transfusionText1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 && [self.transfusionText3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        ProjectTransfusion =@"";//输血
        
    }

    
#pragma mark 医药支付类型已经通过验证
    //医药支付类型
    NSMutableString *medStr=[[NSMutableString alloc]initWithCapacity:0];
    for (XKCircalButton *btn in self.payBtnArray) {
        
        if (btn.responsType==1) {
            
            for (DictionaryMsg *model in self.personalDictionaryMsg.MedicalPayment) {
                
                if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
                    
                    if (medStr.length==0) {
                        
                        [medStr appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                        
                    }else{
                        
                        [medStr appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    if (medStr.length==0) {//判断医药支付类型是否为空
        
        [self showAlertController:@"请填写医药支付类型"];
        
        return;
        
    }
    
#pragma mark 既往病史提交已经解决
    //既往病史
    NSMutableString *illness=[[NSMutableString alloc]initWithCapacity:0];
    if (self.diseaseNoBtn.responsType!=1) {
        
//        for (XKCircalButton *btn in self.illnessArray) {
//            
//            if (btn.responsType==1) {
//                
//                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
//                    
//                    NSLog(@"%li-既往病史-%@",model.DictionaryID,model.DictionaryName);
//                    
//                    if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
//                        
//                        if (illness.length==0) {
//                            
//                            [illness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
//                            
//                        }else{
//                            
//                            [illness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
//                            
//                        }
//                        
//                    }
//                    
//                }
//                if (illness.length == 0) {
//                    [self showAlertController:@"请选择既往病史疾病"];
//                    
//                    return;
//                }
//                
//            }
//            
//        }
        for (int i = 0;i<illesSelectedArr.count;i++) {
            NSString *str = illesSelectedArr[i];
            if ([str isEqualToString:@"1"]) {
                NSString *name = self.illnessArray[i];
                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
                    
                    NSLog(@"%li-既往病史-%@",model.DictionaryID,model.DictionaryName);
                    
                    if ([name isEqualToString:model.DictionaryName]) {
                        
                        if (illness.length==0) {
                            
                            [illness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                            
                        }else{
                            
                            [illness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                            
                        }
                        
                    }
                    
                }
               
                
            }
            
        }
    }else{
        
        [illness appendString:[NSString stringWithFormat:@""]];//无既往病史 无疾病
        
    }
    if (self.diseaseNoBtn.responsType!=1&&illness.length==0) {
        [self showAlertController:@"请选择既往病史的疾病"];
        return;
    }
        
    //父亲
    NSMutableString *fatherillness=[[NSMutableString alloc]initWithCapacity:0];
    if (self.fatherNotBtn.responsType!=1) {
        
//        for (XKCircalButton *btn in self.illnessFatherArray) {
//            
//            if (btn.responsType==1) {
//                
//                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
//                        
//                        if (fatherillness.length==0) {
//                            
//                            [fatherillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
//                            
//                        }else{
//                            
//                            [fatherillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
//                            
//                        }
//                        
//                    }
//                    
//                }
//                if (fatherillness.length == 0) {
//                    [self showAlertController:@"请选择家庭病史的父亲疾病"];
//                    
//                    return;
//                }
//                
//            }
//            
//        }
        
        for (int i = 0;i<fatherSelectedArr.count;i++) {
            NSString *str = fatherSelectedArr[i];
            if ([str isEqualToString:@"1"]) {
                NSString *name = self.illnessFatherArray[i];
                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
                    
                    NSLog(@"%li-既往病史-%@",model.DictionaryID,model.DictionaryName);
                    
                    if ([name isEqualToString:model.DictionaryName]) {
                        
                        if (fatherillness.length==0) {
                            
                            [fatherillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                            
                        }else{
                            
                            [fatherillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
        
    }else{
        
        [fatherillness appendString:[NSString stringWithFormat:@""]];//父亲无既往病史无疾病
        
    }
    if (self.fatherNotBtn.responsType!=1&&fatherillness.length==0) {
        [self showAlertController:@"请选择家庭病史中父亲的疾病"];
        return;
    }
    //母亲病史
    NSMutableString *motherillness=[[NSMutableString alloc]initWithCapacity:0];
    if (self.motherNotBtn.responsType!=1) {
    
//        for (XKCircalButton *btn in self.illnessMotherArray) {
//            
//            if (btn.responsType==1) {
//                
//                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
//                        
//                        if (motherillness.length==0) {
//                            
//                            [motherillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
//                            
//                        }else{
//                            
//                            [motherillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
//                            
//                        }
//                        
//                    }
//                    
//                }
//                if (motherillness.length == 0) {
//                    [self showAlertController:@"请选择家庭病史的母亲疾病"];
//                    
//                    return;
//                }
//                
//            }
//            
//        }
        
        for (int i = 0;i<motherSelectedArr.count;i++) {
            NSString *str = motherSelectedArr[i];
            if ([str isEqualToString:@"1"]) {
                NSString *name = self.illnessMotherArray[i];
                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
                    
                    NSLog(@"%li-既往病史-%@",model.DictionaryID,model.DictionaryName);
                    
                    if ([name isEqualToString:model.DictionaryName]) {
                        
                        if (motherillness.length==0) {
                            
                            [motherillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                            
                        }else{
                            
                            [motherillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                            
                        }
                        
                    }
                    
                }
                
                
            }
        }
        
    }else{
        
//        [motherillness appendString:[NSString stringWithFormat:@"无疾病"]];//母亲无既往病史
         [motherillness appendString:[NSString stringWithFormat:@""]];
    }
    if (self.motherNotBtn.responsType!=1&&motherillness.length==0) {
        [self showAlertController:@"请选择家庭病史中母亲的疾病"];
        return;
    }
    //兄弟姐妹病史
    NSMutableString *bortherillness=[[NSMutableString alloc]initWithCapacity:0];
    if (self.brotherNotBtn.responsType!=1) {
        
//        for (XKCircalButton *btn in self.illnessBortherArray) {
//            
//            if (btn.responsType==1) {
//                
//                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
//                        
//                        if (bortherillness.length==0) {
//                            
//                            [bortherillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
//                            
//                        }else{
//                            
//                            [bortherillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
//                            
//                        }
//                        
//                    }
//                    
//                }
//                if (bortherillness.length == 0) {
//                    [self showAlertController:@"请选择家庭病史的兄弟姐妹病史疾病"];
//                    
//                    return;
//                }
//                
//            }
//            
//        }
        for (int i = 0;i<brotherSelectedArr.count;i++) {
            NSString *str = brotherSelectedArr[i];
            if ([str isEqualToString:@"1"]) {
                NSString *name = self.illnessFatherArray[i];
                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
                    
                    NSLog(@"%li-既往病史-%@",model.DictionaryID,model.DictionaryName);
                    
                    if ([name isEqualToString:model.DictionaryName]) {
                        
                        if (bortherillness.length==0) {
                            
                            [bortherillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                            
                        }else{
                            
                            [bortherillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
        }
    }else{
        
        [bortherillness appendString:[NSString stringWithFormat:@""]];//无疾病
        
    }
    if (self.brotherNotBtn.responsType!=1&&bortherillness.length==0) {
        [self showAlertController:@"请选择家庭病史中兄弟姐妹的疾病"];
        return;
    }
    //子女病史
    NSMutableString *childillness=[[NSMutableString alloc]initWithCapacity:0];
    if (self.childNotBtn.responsType!=1) {
        
//        for (XKCircalButton *btn in self.illnessChildArray) {
//            
//            if (btn.responsType==1) {
//                
//                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:model.DictionaryName]) {
//                        
//                        if (childillness.length==0) {
//                            
//                            [childillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
//                            
//                        }else{
//                            
//                            [childillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
//                            
//                        }
//                           
//                    }
//                    
//                }
//                
//                
//            }
//            
//        }
        for (int i = 0;i<childSelectedArr.count;i++) {
            NSString *str = childSelectedArr[i];
            if ([str isEqualToString:@"1"]) {
                NSString *name = self.illnessChildArray[i];
                for (DictionaryMsg *model in self.personalDictionaryMsg.PastHistory) {
                    
                    NSLog(@"%li-既往病史-%@",model.DictionaryID,model.DictionaryName);
                    
                    if ([name isEqualToString:model.DictionaryName]) {
                        
                        if (childillness.length==0) {
                            
                            [childillness appendString:[NSString stringWithFormat:@"%li",model.DictionaryID]];
                            
                        }else{
                            
                            [childillness appendString:[NSString stringWithFormat:@"%@%li",@",",model.DictionaryID]];
                            
                        }
                        
                    }
                    
                }
                
            }
            }
    }else{
        
        [childillness appendString:[NSString stringWithFormat:@""]];//无疾病
        
    }
    if (self.childNotBtn.responsType!=1&&childillness.length==0) {
        [self showAlertController:@"请选择家庭病史中子女的疾病"];
        return;
    }
    
#pragma mark 处理是否睡眠规律  是否长期服用药物
    NSInteger LongMedication=-1;
    if (self.medicineBtnOne.responsType==1) {
        
        LongMedication=1;
        
    }else{
        
         LongMedication=0;
        
    }
    
    NSInteger SleepRule=-1;
    if (self.sleepBtnOne.responsType==1) {
        
        SleepRule=1;
        
    }else{
        
        SleepRule=0;
        
    }

#pragma mark 处理名族的id
    NSInteger NationID=-1;
        for (DictionaryMsg *model in self.personalDictionaryMsg.NationList) {
            
            if ([self.notionLab.text isEqualToString:model.DictionaryName]) {
    
                NationID=model.DictionaryID;
                
                break;

            }
    
        }
    
#pragma mark 处理教育等级
    NSInteger EducationIdLevelID=-1;
    for (DictionaryMsg *model in self.personalDictionaryMsg.EducationLevel) {
        
        if ([self.educationTxt.text isEqualToString:model.DictionaryName]) {
            
            EducationIdLevelID=model.DictionaryID;
            
            break;
            
        }
        
    }
    
    NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,
                         @"BloodTypeID":@(bloodid),
                           @"PermanentAddress":self.addressTxt.text,
                           @"DrinkingStatusID":@(drinkStatusid),
                           @"DrinkingWaterID":@(drinkid),
                           @"ExhaustMeasuresID":@(kitchenId),
                           @"FuelTypeID":@(FuelTypeID),
                           @"MaritalStatusID":@(marId),
                           @"NationID":@(NationID),
                           @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                           @"ResidenceTypeID":@(ResidenceTypeID),
                           @"SmokingAge":@(SmokingAge),
                           @"SmokingAmountDay":@(SmokingAmountDay),
                           @"ToiletID":@(ToiletID),
                           @"ProjectOperation":ProjectOperation,
                           @"ProjectTrauma":ProjectTrauma,
                           @"ProjectTransfusion":ProjectTransfusion,
                           @"MedicalPayment":medStr,
                           @"SmokingStatusID":@(SmokingStatusID),
                           @"PastHistory":illness,
                           @"FamilyHistoryBrother":bortherillness,
                           @"FamilyHistoryFather":fatherillness,
                           @"FamilyHistoryMother":motherillness,
                           @"FamilyHistorySon":childillness,
                           @"LongMedication":@(LongMedication),
                           @"SleepRule":@(SleepRule),
                           @"EducationLevelID":@(EducationIdLevelID)};
    
//    [[XKLoadingView shareLoadingView]showLoadingText:@"保存中"];
    
    [NetWorkTool postAction:checkHomeEditPersonalFileUrl params:dict finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            //发送通知
            NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
            [center postNotificationName:@"endEditArchive" object:nil];
            
            [[self parentController].navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"homeFresh1" object:nil];
        }else{
            
            ShowErrorStatus(response.msg);
        }
        
    }];
//    [ProtosomaticHttpTool protosomaticPostWithURLString:@"310" parameters:dict success:^(id json) {
//
//        NSLog(@"%@",json);
//
//
//        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
//
//            [[XKLoadingView shareLoadingView]hideLoding];
//
//            //发送通知
//            NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
//            [center postNotificationName:@"endEditArchive" object:nil];
//
//            [[self parentController].navigationController popViewControllerAnimated:YES];
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"homeFresh1" object:nil];
//
//        }else{
//
//            NSLog(@"操作失败");
//
//            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
//
//        }
//
//    } failure:^(id error) {
//
//        NSLog(@"%@",error);
//
//        [[XKLoadingView shareLoadingView] errorloadingText:error];
//
//    }];
    
    //展示当天任务是否完成
    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
    [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,
                                   @"TaskType":@(2),
                                   @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                                   @"TypeID":@(1)}
                         withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,
                                   @"TaskType":@(2),
                                   @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                                   @"TypeID":@(1)} isPopView:YES];
    
}

/**通用的方法提示空的**/
-(void)showAlertController:(NSString *)mark{
    
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"温馨提示" message:mark preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertCon addAction:action1];
    
    [alertCon addAction:action2];
    
    [[self parentController] presentViewController:alertCon animated:YES completion:nil];
    
}

/**处理既往病史**/
-(void)dealWithHistoryIllness{
    
    NSArray *illness=[self.personArc.PastHistory componentsSeparatedByString:@","];
    
    if (self.personArc.PastHistory.length==0) {
        
        [self clikDisaseHave:self.diseaseNoBtn];
        
    }else{
        
        if ([self.personArc.PastHistory isEqualToString:@"无疾病"]) {
            
            [self clikDisaseHave:self.diseaseNoBtn];
            
        }else{
            
            if (illness.count<1) {
                
                [self clikDisaseHave:self.diseaseNoBtn];
                
            }else{
                
                [self clikDisaseHave:self.diseaseHaveBtn];
                
                for (int i=0; i<illness.count; i++) {
                    
                    NSString *str=illness[i];
                    
//                    for (XKCircalButton *btn in self.illnessArray) {
//                        
//                        if ([btn.titleLabel.text isEqualToString:str]) {
//                            
//                            [self illnessBtnClick:btn];
//                            
//                        }
//                        
//                    }
                    
                    
                    for (int i = 0; i<self.illnessArray.count; i++) {
                        NSString *name = self.illnessArray[i];
                        if ([name isEqualToString:str]) {
                            [illesSelectedArr replaceObjectAtIndex:i withObject:@"1"];
                        }
                    }

                    
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
}

/**处理个人背景的基本信息**/
-(void)dealWithPersonalMessage{
    
    self.addressTxt.text=self.personArc.PermanentAddress;
    
    self.notionLab.text=self.personArc.Nation;
    
    for (DictionaryMsg *msg in self.personalDictionaryMsg.ResidenceType) {
        
        if ([self.personArc.ResidenceTypeID integerValue]==msg.DictionaryID) {
            
            NSString *name=msg.DictionaryName;
            
            if ([self.houseTypeOne.titleLabel.text isEqualToString:name]) {
                
                [self clickHouseType:self.houseTypeOne];
                
            }
            
            if ([self.houseTypeTwo.titleLabel.text isEqualToString:name]) {
                
                [self clickHouseType:self.houseTypeTwo];
                
            }
            
            break;
            
        }
        
    }
    
    //医药支付类型处理
    NSArray *payArray=[self.personArc.MedicalPaymentNameList componentsSeparatedByString:@","];
    for (NSString *str in payArray) {
        
        for (XKCircalButton *btn in self.payBtnArray) {
            
            if ([btn.titleLabel.text isEqualToString:str]) {
                
                [self clickPayType:btn];
                
            }
            
        }
        
    }
    
    //婚姻状态
    self.marlab.text=self.personArc.MaritalStatus;
    self.bloodlab.text=self.personArc.BloodType;
    
    self.educationTxt.text=self.personArc.EducationLevel;
    
}

/**处理手术**/
-(void)dealWithOperation{
    NSArray *ar1=[self.personArc.ProjectOperation componentsSeparatedByString:@","];
    NSLog(@"%@",ar1);
    if (((NSString *)ar1[0]).length==0) {
        
        [self clickOpretion:self.opreationBtnNot];
        
    }else{
        
        [self clickOpretion:self.opreationBtnHave];
        
        NSArray *ar2=[self.personArc.ProjectOperation componentsSeparatedByString:@"|"];
        
        for (int i=0; i<ar2.count; i++) {
        
            if (ar2.count==1) {
                
                NSString *s=ar2[0];
                
                NSArray *ar22=[s componentsSeparatedByString:@","];
                
                self.otxt1.text=ar22[0];
                
                self.otxt2.text=ar22[1];
                
                return;
                
            }else{
                
                NSString *s=ar2[0];
                
                NSArray *ar22=[s componentsSeparatedByString:@","];
                
                self.otxt1.text=ar22[0];
                
                self.otxt2.text=ar22[1];
                
                NSString *s2=ar2[0];
                NSArray *ar223=[s2 componentsSeparatedByString:@","];
                
                self.otxt3.text=ar223[0];
                
                self.otxt4.text=ar223[1];
                
                return;
                
            }
            
        }
        
    }
    
}

/**处理外伤**/
-(void)dealWithTrauma{
    NSArray *ar11=[self.personArc.ProjectTrauma componentsSeparatedByString:@","];
    if (((NSString *)ar11[0]).length==0) {//无外伤
        
        [self cClickAntion:self.cNotBtn];
        
    }else{//有外伤
        
        [self cClickAntion:self.cHaveBtn];
        
        NSArray *arr1=[self.personArc.ProjectTrauma componentsSeparatedByString:@"|"];
        
        for (NSString *str in arr1) {
            
            if (arr1.count<=1) {
                
                NSArray *ar1=[str componentsSeparatedByString:@","];
                
                self.traumaText1.text=ar1[0];
                
                self.traumaText2.text=ar1[1];
                
                break;
                
            }else{
                
                NSArray *ar1=[arr1[0] componentsSeparatedByString:@","];
                
                self.traumaText1.text=ar1[0];
                
                self.traumaText2.text=ar1[1];
                
                NSArray *ar2=[arr1[1] componentsSeparatedByString:@","];
                
                self.traumaText3.text=ar2[0];
                
                self.traumaText4.text=ar2[1];
                
                break;
                
            }
            
        }
        
    }
    
}

/**处理输血**/
-(void)dealWithProjectTransfusion{
    NSArray *ar11=[self.personArc.ProjectTransfusion componentsSeparatedByString:@","];
    if (((NSString *)ar11[0]).length==0) {//没有输血记录
        
        [self tClickAction:self.tNotBtn];
        
    }else{//有输血记录
        
        [self tClickAction:self.tHaveBtn];
        
        NSArray *arr1=[self.personArc.ProjectTransfusion componentsSeparatedByString:@"|"];
        
        for (NSString *str in arr1) {
            
            if (arr1.count<=1) {
                
                NSArray *ar1=[str componentsSeparatedByString:@","];
                
                self.transfusionText1.text=ar1[0];
                
                self.transfusionText2.text=ar1[1];
                
                break;
                
            }else{
                
                NSArray *ar1=[arr1[0] componentsSeparatedByString:@","];
                
                self.transfusionText1.text=ar1[0];
                
                self.transfusionText2.text=ar1[1];
                
                NSArray *ar2=[arr1[1] componentsSeparatedByString:@","];
                
                self.transfusionText3.text=ar2[0];
                
                self.transfusionText4.text=ar2[1];
                
                break;
                
            }
            
        }
        
    }
    
}

/**处理家庭病史**/
-(void)dealWithfamilyIllness{
    
    NSLog(@"家庭病史%@",self.personArc.FamilyHistory);
    
    if (self.personArc.FamilyHistory.length==0) {//家庭病史中无人有病
        
        [self fatherClick:self.fatherNotBtn];
        
        [self motherClick:self.motherNotBtn];
        
        [self brotherClick:self.brotherNotBtn];
        
        [self childClick:self.childNotBtn];
        
        
    }else{//家庭病史中没有人有病
        
        NSArray *array=[self.personArc.FamilyHistory componentsSeparatedByString:@"|"];//通过截取将人物疾病分割开来
        
        BOOL isFatherDisase=NO;
        
        BOOL isMotherDiesase=NO;
        
        BOOL isBrotherDisase=NO;
        
        BOOL isChildDiesase=NO;
        
        for (NSString *str in array) {
            
            if ([str hasPrefix:@"父亲"]) {
                
                isFatherDisase=YES;
                
            }
            
            if ([str hasPrefix:@"母亲"]) {
                
                isMotherDiesase=YES;
                
            }
            
            if ([str hasPrefix:@"兄弟姐妹"]) {
                
                isBrotherDisase=YES;
                
            }
            
            if ([str hasPrefix:@"子女"]) {
                
                isChildDiesase=YES;
                
            }
            
        }
        
        if (isFatherDisase) {
            
            [self fatherClick:self.fatherHaveBtn];
            
            NSArray *fatherArray1=[array[0] componentsSeparatedByString:@","];//分割父亲病史

            NSString *s=fatherArray1[1];
            
            NSArray *fatherArray2=[s componentsSeparatedByString:@"-"];//将父亲和病史分割开来
            
            if ([fatherArray2[0] isEqualToString:@"无疾病"]||((NSString *)fatherArray2[0]).length==0) {//判断父亲无疾病
                
                [self fatherClick:self.fatherNotBtn];
                
            }
            
            for (NSString *ss in fatherArray2) {//显示父亲疾病问题
                
//                for (XKCircalButton *btn in self.illnessFatherArray) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:ss]) {
//                        
//                        btn.responsType=1;
//                        
//                    }
//                    
//                }
                  for (int i = 0; i<self.illnessFatherArray.count; i++) {
                      NSString *name = self.illnessFatherArray[i];
                      if ([name isEqualToString:ss]) {
                            [fatherSelectedArr replaceObjectAtIndex:i withObject:@"1"];
                      }
                  }
                
                
            }
            
        }else{
            
            [self fatherClick:self.fatherNotBtn];
            
        }
        
        if (isMotherDiesase) {
            
            [self motherClick:self.motherHaveBtn];
            
            //通过逗号分割将母亲和疾病之间分割开来
            
            NSArray *motherArray1;
            
            if (isFatherDisase) {
                
                motherArray1=[array[1] componentsSeparatedByString:@","];
                
            }else{
                
                motherArray1=[array[0] componentsSeparatedByString:@","];
                
            }
            
            NSString *s=motherArray1[1];
            
            NSArray *motherArray2=[s componentsSeparatedByString:@"-"];
            
            if ([motherArray2[0] isEqualToString:@"无疾病"]||((NSString *)motherArray2[0]).length==0) {
                
                [self motherClick:self.motherNotBtn];
                
            }
            
            for (NSString *ss in motherArray2) {
                
//                for (XKCircalButton *btn in self.illnessMotherArray) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:ss]) {
//                        
//                        btn.responsType=1;
//                        
//                    }
//                    
//                }
                for (int i = 0; i<self.illnessMotherArray.count; i++) {
                    NSString *name = self.illnessMotherArray[i];
                    if ([name isEqualToString:ss]) {
                        [motherSelectedArr replaceObjectAtIndex:i withObject:@"1"];
                    }
                }
            }
            
        }else{
            
            [self motherClick:self.motherNotBtn];
            
        }
        
        if (isBrotherDisase) {
            
            NSArray *brotherArray1;
            
            [self brotherClick:self.brotherHaveBtn];
            
            if (isFatherDisase&&isMotherDiesase) {//第三个
                
                brotherArray1=[array[2] componentsSeparatedByString:@","];
                
            }
            
            if (!isFatherDisase&&!isMotherDiesase) {//第一个
                
                brotherArray1=[array[0] componentsSeparatedByString:@","];
                
            }
            
            if ((!isFatherDisase&&isMotherDiesase)||(isFatherDisase&&!isMotherDiesase)) {//第二个
                
                brotherArray1=[array[1] componentsSeparatedByString:@","];
                
            }
            
            NSString *s=brotherArray1[1];
            
            NSArray *brotherArray2=[s componentsSeparatedByString:@"-"];
            
            if ([brotherArray2[0] isEqualToString:@"无疾病"]||((NSString *)brotherArray2[0]).length==0) {
                
                [self brotherClick:self.brotherNotBtn];
                
            }
            
            for (NSString *ss in brotherArray2) {
                
                for (int i = 0; i<self.illnessBortherArray.count; i++) {
                    NSString *name = self.illnessBortherArray[i];
                    if ([name isEqualToString:ss]) {
                        [brotherSelectedArr replaceObjectAtIndex:i withObject:@"1"];
                    }
                }
//
//                for (XKCircalButton *btn in self.illnessBortherArray) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:ss]) {
//                        
//                        btn.responsType=1;
//                        
//                    }
//                    
//                }
//                
            }
        
        }else{
            
            [self brotherClick:self.brotherNotBtn];
            
        }
        
        if (isChildDiesase) {
            
            [self childClick:self.childHaveBtn];
            
            NSArray *childArray1;
            
            if (isFatherDisase&&isMotherDiesase&&isBrotherDisase) {//第四个
                
                childArray1=[array[3] componentsSeparatedByString:@","];
                
            }
            
            if (!isFatherDisase&&!isMotherDiesase&&!isBrotherDisase) {//第一个
                
                childArray1=[array[0] componentsSeparatedByString:@","];
                
            }
            
            if ((isFatherDisase&&!isMotherDiesase&&!isBrotherDisase)||(!isFatherDisase&&isMotherDiesase&&!isBrotherDisase)||(!isFatherDisase&&!isMotherDiesase&&isBrotherDisase)) {//第二个
                
                childArray1=[array[1] componentsSeparatedByString:@","];
                
            }
            
            if ((isFatherDisase&&isMotherDiesase&&!isBrotherDisase)||(isFatherDisase&&!isMotherDiesase&&isBrotherDisase)||(!isFatherDisase&&isMotherDiesase&&isBrotherDisase)) {//第三个
                
                childArray1=[array[2] componentsSeparatedByString:@","];
                
            }
            
            NSString *s=childArray1[1];
            
            NSArray *childArray2=[s componentsSeparatedByString:@"-"];
            
            if ([childArray2[0] isEqualToString:@"无疾病"]||((NSString *)childArray2[0]).length==0) {
                
                [self childClick:self.childNotBtn];
                
            }
            
           for (NSString *ss in childArray2) {
//                
//                for (XKCircalButton *btn in self.illnessChildArray) {
//                    
//                    if ([btn.titleLabel.text isEqualToString:ss]) {
//                        
//                        btn.responsType=1;
//                        
//                    }
//                    
//                }
//
               
               for (int i = 0; i<self.illnessChildArray.count; i++) {
                   NSString *name = self.illnessChildArray[i];
                   if ([name isEqualToString:ss]) {
                       [childSelectedArr replaceObjectAtIndex:i withObject:@"1"];
                   }
               }
               
               
            }
            [self.collectionView reloadData];
            
        }else{
            
            [self childClick:self.childNotBtn];
            
        }
        
    }
    
}

/**处理抽烟和喝酒的数据**/
-(void)dealWithSmoking{
    
    if ([self.personArc.SmokingStatusID isEqualToString:@"1"]) {//抽烟
        
        [self clickSomeking:self.somekingHaveBtn];
        
        self.smokingAgeLab.text=self.personArc.SmokingAge;
        
        self.smokingCount.text=self.personArc.SmokingAmountDay;
        
        UILabel *lab33=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.smokingAgeLab.frame)-75, 0, 30, 50)];
        
        lab33.text=@"/年";
        
        lab33.textColor=GRAYCOLOR;
        
        [self.smokingAgeLab addSubview:lab33];
        
        UILabel *lab44=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.smokingAgeLab.frame)-75, 0, 30, 50)];
        
        lab44.text=@"/支";
        
        lab44.textColor=GRAYCOLOR;
            
        [self.smokingCount addSubview:lab44];
        
    }else{//不抽烟
        
        [self clickSomeking:self.somekingNotBtn];
        
    }
    
    self.drinkLab.text=self.personArc.DrinkingStatusName;
    
}

/**处理睡眠是否规律**/
-(void)dealWithSleep{
    
    if ([self.personArc.SleepRule isEqualToString:@"1"]) {//睡眠规律
        
        self.sleepBtnOne.responsType=1;
        
        self.sleepBtnTwo.responsType=2;
        
        
        
    }else{//睡眠不规律
        
        self.sleepBtnOne.responsType=2;
        
        self.sleepBtnTwo.responsType=1;
        
    }
    
}

/**处理是否长期服用药物**/
-(void)dealWtihLongMedic{
    
    if ([self.personArc.LongMedication isEqualToString:@"1"]) {//长期服用
        
        [self medicineBtnclick:self.medicineBtnOne];
        
    }else{//没有长期服用药物
        
        [self medicineBtnclick:self.medicineBtnTwo];
        
    }
    
}

/**处理家庭环境**/
-(void)dealWithLifeEnvironmentName{
    
    if (self.personArc.LifeEnvironmentName.length!=0) {
        
        NSArray *array=[self.personArc.LifeEnvironmentName componentsSeparatedByString:@","];
        
        for (int i=0; i<array.count; i++) {
            
            NSString *str=array[i];
            
            if (i==0) {
                
                for (XKCircalButton *btn in self.indoorArray) {
                    
                    if ([btn.titleLabel.text isEqualToString:str]) {
                        
                        btn.responsType=1;
                        
                        self.isFutal=YES;
                        
                        break;
                        
                    }
                    
                }
                
            }
            
            if (i==1) {
                
                for (XKCircalButton *btn in self.drinkingWaterArray) {
                    
                    if ([btn.titleLabel.text isEqualToString:str]) {
                        
                        btn.responsType=1;
                        
                        self.isWater=YES;
                        
                        break;
                        
                    }
                    
                }
                
            }
            
            if (i==2) {
                
                for (XKCircalButton *btn in self.toiletArray) {
                    
                    if ([btn.titleLabel.text isEqualToString:str]) {
                        
                        btn.responsType=1;
                        
                        self.isTitol=YES;
                        
                        break;
                        
                    }
                    
                }
                
            }
            
            if (i==3) {
                
                for (XKCircalButton *btn in self.kitchenBtnArray) {
                    
                    if ([btn.titleLabel.text isEqualToString:str]) {
                        
                        btn.responsType=1;
                        
                        self.isChentch=YES;
                        
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

@end
