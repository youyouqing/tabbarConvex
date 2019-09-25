//
//  XKRecordPhotoCollectionCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKRecordPhotoCollectionCell.h"

@interface XKRecordPhotoCollectionCell ()

@end

@implementation XKRecordPhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.photoBtn.hidden = YES;
    
}

-(void)setModel:(XKPatientPhotoModel *)model{
    
    _model = model;
    
    if (_model.fereshPhoto) {
        
        self.imgIcon.image = _model.fereshPhoto;
        
    }else{
        [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:_model.PicUrl] placeholderImage:[UIImage imageNamed:@"homeExtention"]];
    }
    
}

- (IBAction)addAction:(UIButton *)sender {
    
  
    
    if ([self.delegate respondsToSelector:@selector(addPhoto:)]) {
        [self.delegate addPhoto:nil];
    }
    
}
/**
 删除图片操作
 */
- (IBAction)deleteAction:(id)sender {
   NSLog(@"删除图片操作");
    
    if ([self.delegate respondsToSelector:@selector(deletePhoto:)]) {
        
        [self.delegate deletePhoto:self.model];
        
    }
    
}

@end
