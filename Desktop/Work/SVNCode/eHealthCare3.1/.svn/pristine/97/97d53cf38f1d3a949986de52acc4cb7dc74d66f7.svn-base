//
//  MHCommentCell.m
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHCommentCell.h"
#import "MHCommentFrame.h"


@interface MHCommentCell ()

/** 文本内容 */
@property (nonatomic , weak) UILabel *contentLabel;

@end

@implementation MHCommentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CommentCell";
    MHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
//    cell.sepa
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
        
    }
    
    return self;
}




#pragma mark - 公共方法
- (void)setCommentFrame:(MHCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    MHComment *comment = commentFrame.comment;
    
    // 赋值
    self.contentLabel.frame = commentFrame.textFrame;
    // 设置值
    
//    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",commentFrame.comment.ReplyTime] doubleValue] / 1000.0;
//    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
//    
    NSString *oneStr ;
    if ([comment.RNickName isEqualToString:comment.CNickName]) {
        oneStr = [NSString stringWithFormat:@"%@：%@     %@",comment.CNickName,comment.ReplyContent,@""];
        
        self.contentLabel.attributedText = [NSMutableAttributedString changeLabelWithText:oneStr withBigFont:14 withNeedchangeText:@"" withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        
    }else{
        oneStr = [NSString stringWithFormat:@"%@ 回复 %@：%@    %@",comment.RNickName,comment.CNickName,comment.ReplyContent,@""];
        
        self.contentLabel.attributedText = [NSMutableAttributedString threeChangeLabelWithText:oneStr withBigFont:14 withNeedchangeText:@"" withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        
    }

   

}


#pragma mark - 私有方法
#pragma mark - 初始化
- (void)_setup
{
    self.backgroundColor = [UIColor clearColor];// [UIColor getColor:@"f7f7f7"];
    
    
    self.contentView.backgroundColor = [UIColor clearColor];
   
}

#pragma mark - 创建自控制器
- (void)_setupSubViews
{
    // 文本
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0 ;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    contentLabel.font = [UIFont systemFontOfSize:14.f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLabelDidClicked)];
    [contentLabel addGestureRecognizer:tap];
}


#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints
{
    
}
//CGFloat const MHTopicAvatarWH = 30.0f ;
/**  话题水平方向间隙 */
//CGFloat const MHTopicHorizontalSpace = 10.0f;
/**  话题垂直方向间隙 */
//CGFloat const MHTopicVerticalSpace = 10.0f ;

#pragma mark - override
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;//30.0+2*10;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - frame.origin.x - 10;
    [super setFrame:frame];
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局子控件
    
    
}

-(void)contentLabelDidClicked{

    if (self.delegate && [self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self];
    }
}


@end
