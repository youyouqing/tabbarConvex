//
//  NewPublicCell.m
//  eHealthCare
//
//  Created by xiekang on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewPublicCell.h"

@implementation NewPublicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.clipsToBounds = YES;
        _backView.layer.cornerRadius = 5;
        [self.contentView addSubview:_backView];
        
        _titleLal = [[UILabel alloc]init];
        _titleLal.textColor = BLACKCOLOR;
        _titleLal.font = [UIFont boldSystemFontOfSize:18];
        [_backView addSubview:_titleLal];
        
        _readLabl=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-63, 15, 15, 15)];
        _readLabl.backgroundColor=ORANGECOLOR;
        _readLabl.layer.cornerRadius=15/2;
        _readLabl.layer.masksToBounds=YES;
        
        [_backView addSubview:_readLabl];
        
        _timeLal = [[UILabel alloc]init];
        _timeLal.textColor = GRAYCOLOR;
        _timeLal.font = [UIFont systemFontOfSize:13];
        [_backView addSubview:_timeLal];
        
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor orangeColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_backView addSubview:_imgView];
        
        _textLal = [[UILabel alloc]init];
        _textLal.textColor = GRAYCOLOR;
        _textLal.textAlignment = NSTextAlignmentLeft;
        _textLal.numberOfLines = 0;
        _textLal.adjustsFontSizeToFitWidth = YES;
        _textLal.font = [UIFont systemFontOfSize:15];
        [_backView addSubview:_textLal];
        
        _moreView = [[UIView alloc]init];
//        _moreView.backgroundColor = [UIColor cyanColor];
        _moreView.clipsToBounds = YES;
        [_backView addSubview:_moreView];
        
        _lineLal = [[UILabel alloc]init];
        _lineLal.backgroundColor = LINEGRAYCOLOR;
        [_moreView addSubview:_lineLal];
        
        _readAllLal = [[UILabel alloc]init];
        _readAllLal.text = @"查看全文";
        _readAllLal.textColor = BLACKCOLOR;
        [_moreView addSubview:_readAllLal];
        
        _nextIconView = [[UIImageView alloc]init];
        _nextIconView.image = [UIImage imageNamed:@"zknext3"];
        [_moreView addSubview:_nextIconView];
        
        
        
    }
    return self;
}

-(void)setPublicFrame:(NewPublicFrame *)publicFrame
{
    _publicFrame = publicFrame;
    
    _readLabl.hidden=NO;
    
    if (_publicFrame.publicModel.isSystemMessage) {
        if (_publicFrame.publicModel.IsRead==1) {
            _readLabl.hidden=YES;

            
        }else{
            _readLabl.hidden=NO;

        }
    }else{
        _readLabl.hidden=YES;
    }
    if (_publicFrame.publicModel.IsRead==1) {
      
        _textLal.textColor = GRAYCOLOR;
        _timeLal.textColor = GRAYCOLOR;
        _titleLal.textColor = BLACKCOLOR;
      
        
    }else{
        _readLabl.hidden=NO;
        _titleLal.textColor = kMainTitleColor;
        _textLal.textColor = kMainTitleColor;
        _timeLal.textColor = [UIColor getColor:@"7C838C"];
       
    }
    //frame
    _backView.frame = publicFrame.backFrame;
    _titleLal.frame = publicFrame.titleFrame;
    _timeLal.frame = publicFrame.timeFrame;
    _imgView.frame = publicFrame.imgFrame;
    _textLal.frame = publicFrame.textFrame;
    _moreView.frame = publicFrame.moreFrame;
    _lineLal.frame = publicFrame.lineFrame;
    _readAllLal.frame = publicFrame.readAllFrame;
    _nextIconView.frame = publicFrame.nextIconFrame;
    
    //text
    _textLal.text = publicFrame.publicModel.NoticeContent;
    Dateformat *dateFormat = [[Dateformat alloc]init];
    if (publicFrame.publicModel.isSystemMessage) {
        _timeLal.text = [dateFormat DateFormatWithDate:[NSString stringWithFormat:@"%@",publicFrame.publicModel.AuditTime] withFormat:@"YYYY-MM-dd"];
    }else{
        _timeLal.text = [dateFormat DateFormatWithDate:publicFrame.publicModel.AuditTime withFormat:@"YYYY-MM-dd"];
    }
    _titleLal.text = publicFrame.publicModel.NoticeTitle;
//    NSLog(@"%@",publicFrame.publicModel.NoticeUrl);
    [_imgView sd_setImageWithURL:[NSURL URLWithString:publicFrame.publicModel.NoticePicture] placeholderImage:[UIImage imageNamed:@"defaultNomal"]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
