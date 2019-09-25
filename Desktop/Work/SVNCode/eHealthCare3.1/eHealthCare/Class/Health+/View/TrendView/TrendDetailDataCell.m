//
//  TrendDetailDataCell.m
//  eHealthCare
//
//  Created by xiekang on 16/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TrendDetailDataCell.h"

@interface TrendDetailDataCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigWidthCons;


@end

@implementation TrendDetailDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(NewTrendDataModel *)model
{

    _model = model;
    
    self.bigWidthCons.constant=(KScreenWidth-30)/3*2;
    NSInteger a = model.ValueOne ;
    
    
    if (a == model.ValueOne) {
        _titleLal1.text = [NSString stringWithFormat:@"%ld%@",(long)a,self.suggestModel.PhysicalItemUnitOne];
        
    }
    else
        _titleLal1.text = [NSString stringWithFormat:@"%@%@",[NSNumber numberWithFloat:model.ValueOne],self.suggestModel.PhysicalItemUnitOne];
    
    
    
    
//    NSInteger b = model.ValueTwo ;
//    if (b == model.ValueTwo) {
//        _titleLal2.text = [NSString stringWithFormat:@"%ld%@",(long)b,self.suggestModel.PhysicalItemUnitTwo];
//
//    }
//    else
//        _titleLal2.text = [NSString stringWithFormat:@"%@%@",[NSNumber numberWithFloat:model.ValueTwo],self.suggestModel.PhysicalItemUnitTwo];
//
    
    // 如果数据为0把它变为未知数据
    if (model.ValueOne == 0.0 ) {
        _titleLal1.text = @"未检测";
    }
//    if (model.ValueTwo == 0.0 ) {
//        _titleLal2.text = @"未检测";
//    }
    
    _timeLal.text = model.TestTime;
    if (model.hasTwoLine > 0) {
        
        //        _titleLal2.text = [NSString stringWithFormat:@"%.2f%@",model.ValueTwo,self.suggestModel.PhysicalItemUnitTwo];
        
    }else{
        [self layoutIfNeeded];
        self.bigWidthCons.constant=(KScreenWidth-30)/2;
        self.windthCon.constant = -(self.bigWidthCons.constant/2);
    }
    
    //标题cell
    if (model.titleName1.length > 0) {
        _bottomCons.constant = 10;
        _topCons.constant = 10;
        _titleLal1.font = [UIFont systemFontOfSize:17.0];
        _titleLal2.font = [UIFont systemFontOfSize:17.0];
        _timeLal.font = [UIFont systemFontOfSize:17.0];
        
        _titleLal1.text = model.titleName1;
        _timeLal.text = @"检测日期";
//        if (model.titleName2.length > 0) {
//            _titleLal2.text = model.titleName2;
//            self.windthCon.constant = 0;
//            self.bigWidthCons.constant=(KScreenWidth-30)/3*2;
//        }else{
            self.bigWidthCons.constant=(KScreenWidth-30)/2;
            self.windthCon.constant = -(self.bigWidthCons.constant/2);
//        }
    }

    
    if (model.OneStatus == 0) {
//        if (model.PhysicalItemID != 1) {
            _titleLal1.textColor = ORANGECOLOR;//判断体重时，不判断体重的状态，只判断BMI状态
//        }
    }else{
        _titleLal1.textColor = BLACKCOLOR;
    }
    
//    if (model.TwoStatus == 0) {
//        _titleLal2.textColor = ORANGECOLOR;
//        if (model.PhysicalItemID == 1) {
//            _titleLal1.textColor = ORANGECOLOR;//判断BMI状态是否异常来显示体重的状态
//        }
//    }else{
//        _titleLal2.textColor = BLACKCOLOR;
//    }
    
    if (model.titleName1.length > 0) {
        _titleLal2.textColor = BLACKCOLOR;
        _titleLal1.textColor = BLACKCOLOR;
    }
    
    if ([_titleLal1.text isEqualToString:@"未检测"]) {
        
        _titleLal1.textColor = BLACKCOLOR;
        
    }
    
    if ([_titleLal2.text isEqualToString:@"未检测"]) {
        
        _titleLal2.textColor = BLACKCOLOR;
        
    }
    
    [self layoutIfNeeded];

    
}
-(void)setSugarmodel:(XKNewTrendDataSugarModel *)sugarmodel
{
    
    _sugarmodel = sugarmodel;
    
    self.bigWidthCons.constant=(KScreenWidth-30)/3*2;
  
  //  NSLog(@"self.sugarsuggestModel.PhysicalItemUnitOne%@ %@",self.sugarsuggestModel.PhysicalItemUnitOne);
    _titleLal1.text = [NSString stringWithFormat:@"%@%@",[NSNumber numberWithFloat:sugarmodel.BloodSugar],self.sugarsuggestModel.PhysicalItemUnitOne];
    // 如果数据为0把它变为未知数据
    if (sugarmodel.BloodSugar == 0.0 ) {
        _titleLal1.text = @"未检测";
    }

     Dateformat *format = [[Dateformat alloc]init];
    _timeLal.text = [format DateFormatWithDate:sugarmodel.TestTime withFormat:@"YYYY-MM-dd" ];

        [self layoutIfNeeded];
        self.bigWidthCons.constant=(KScreenWidth-30)/2;
        self.windthCon.constant = -(self.bigWidthCons.constant/2);
   
    
    //标题cell
    if (sugarmodel.titleName1.length > 0) {
        _bottomCons.constant = 10;
        _topCons.constant = 10;
        _titleLal1.font = [UIFont systemFontOfSize:17.0];
        _titleLal2.font = [UIFont systemFontOfSize:17.0];
        _timeLal.font = [UIFont systemFontOfSize:17.0];
        
        _titleLal1.text = sugarmodel.titleName1;
        _timeLal.text = @"检测日期";

            self.bigWidthCons.constant=(KScreenWidth-30)/2;
            self.windthCon.constant = -(self.bigWidthCons.constant/2);
        
    }

    
    
    if (sugarmodel.Status == 0) {
//        if (sugarmodel.PhysicalItemID != 1) {
            _titleLal1.textColor = ORANGECOLOR;//判断体重时，不判断体重的状态，只判断BMI状态
//        }
    }else{
        _titleLal1.textColor = BLACKCOLOR;
    }
    

    
    if (sugarmodel.titleName1.length > 0) {
        _titleLal2.textColor = BLACKCOLOR;
        _titleLal1.textColor = BLACKCOLOR;
    }
    
    if ([_titleLal1.text isEqualToString:@"未检测"]) {
        
        _titleLal1.textColor = BLACKCOLOR;
        
    }
    
    if ([_titleLal2.text isEqualToString:@"未检测"]) {
        
        _titleLal2.textColor = BLACKCOLOR;
        
    }
    
    [self layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
