//
//  NewPublicFrame.m
//  eHealthCare
//
//  Created by xiekang on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewPublicFrame.h"

@implementation NewPublicFrame

-(void)setPublicModel:(PublicNoticeModel *)publicModel
{
    _publicModel = publicModel;
    
    _backFrame = CGRectMake(15, 10, KScreenWidth - 15*2,  100);
    
    _titleFrame = CGRectMake(15, 15, _backFrame.size.width - 15*2, 25);
    
    _timeFrame = CGRectMake(_titleFrame.origin.x, CGRectGetMaxY(_titleFrame) + 8, _titleFrame.size.width, 20);
    
    //图片的显示
    if (publicModel.NoticePicture.length == 0) {
        _imgFrame = CGRectMake(_titleFrame.origin.x, CGRectGetMaxY(_timeFrame) + 8, _timeFrame.size.width, 0);
    }else{
        _imgFrame = CGRectMake(_titleFrame.origin.x, CGRectGetMaxY(_timeFrame) + 8, _timeFrame.size.width, _timeFrame.size.width /2.4);
    }
    
    CGFloat text_h = [publicModel.NoticeContent boundingRectWithSize:CGSizeMake(_titleFrame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    _textFrame = CGRectMake(_titleFrame.origin.x, CGRectGetMaxY(_imgFrame) + 10, _titleFrame.size.width, text_h);
    
    //查看全文的显示
    if (_publicModel.NoticeUrl.length == 0) {
        _moreFrame = CGRectMake(_titleFrame.origin.x, CGRectGetMaxY(_textFrame) + 15, _titleFrame.size.width , 0);
        _backFrame.size.height = CGRectGetMaxY(_moreFrame) + 10;
    }else{
        _moreFrame = CGRectMake(_titleFrame.origin.x, CGRectGetMaxY(_textFrame) + 15, _titleFrame.size.width , 50);
        _backFrame.size.height = CGRectGetMaxY(_moreFrame);
    }
    _lineFrame = CGRectMake(0, 0, _moreFrame.size.width, 1);
    _readAllFrame = CGRectMake(0, _moreFrame.size.height/2 - 10, 70, 20);
    _nextIconFrame = CGRectMake(_moreFrame.size.width - 15, _moreFrame.size.height/2.0 - 7.5, 15, 15);
    
    _cellHeight = CGRectGetMaxY(_backFrame) + 10;

}

@end
