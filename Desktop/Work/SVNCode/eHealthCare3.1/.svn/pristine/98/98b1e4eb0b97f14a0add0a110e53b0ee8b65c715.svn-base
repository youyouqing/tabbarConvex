/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConversationCell.h"

#import "EMConversation.h"
#import "UIImageView+EMWebCache.h"

CGFloat const EaseConversationCellPadding = 15;

@interface EaseConversationCell()

@property (nonatomic) NSLayoutConstraint *titleWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *titleWithoutAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *detailWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *detailWithoutAvatarLeftConstraint;
@property (nonatomic) NSLayoutConstraint *badgeWidthCons;

@end

@implementation EaseConversationCell

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    //**环信--设置字体大小
    EaseConversationCell *cell = [self appearance];
    cell.titleLabelColor = BLACKCOLOR;
    cell.titleLabelFont = [UIFont boldSystemFontOfSize:15.0];
    cell.detailLabelColor = GRAYCOLOR;
    cell.detailLabelFont = [UIFont systemFontOfSize:14.0];
    cell.timeLabelColor = GRAYCOLOR;
    
    if (IS_IPHONE5) {
        cell.timeLabelFont = [UIFont systemFontOfSize:10.0];
    }else{
        cell.timeLabelFont = [UIFont systemFontOfSize:11.0];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showAvatar = YES;
        [self _setupSubview];
    }
    
    return self;
}

#pragma mark - private layout subviews

- (void)_setupSubview
{
    _avatarView = [[EaseImageView alloc] init];
    _avatarView.imageCornerRadius = (55 )/2.0;//(EaseConversationCellMinHeight - EaseConversationCellPadding*2 )/2.0;
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_avatarView];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timeLabel.font = _timeLabelFont;
    _timeLabel.textColor = _timeLabelColor;
    _timeLabel.textAlignment = NSTextAlignmentRight;
//    _timeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.numberOfLines = 1;
//    _titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.font = _titleLabelFont;
    _titleLabel.textColor = _titleLabelColor;
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = _detailLabelFont;
    _detailLabel.textColor = _detailLabelColor;
    [self.contentView addSubview:_detailLabel];
    
    _rightBadgeLal = [[UILabel alloc] init];
    _rightBadgeLal.translatesAutoresizingMaskIntoConstraints = NO;
    _rightBadgeLal.backgroundColor = ORANGECOLOR;
    _rightBadgeLal.font = [UIFont systemFontOfSize:14.0];
    _rightBadgeLal.textColor = [UIColor whiteColor];
    _rightBadgeLal.adjustsFontSizeToFitWidth = YES;
    _rightBadgeLal.text = @"";
    _rightBadgeLal.clipsToBounds = YES;
    _rightBadgeLal.layer.cornerRadius = 10;
    _rightBadgeLal.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_rightBadgeLal];
    
    _lineView = [[UILabel alloc] init];
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;//***
    _lineView.backgroundColor = [UIColor getColor:@"d8d8d8"];
    [self.contentView addSubview:_lineView];
    
    _typeLal = [[UILabel alloc]init];
    _typeLal.translatesAutoresizingMaskIntoConstraints = NO;
//    _typeLal.backgroundColor  = [UIColor cyanColor];
    if (IS_IPHONE5) {
        _typeLal.font = [UIFont systemFontOfSize:15.5];
    }else{
        _typeLal.font = [UIFont systemFontOfSize:17.0];
    }
    _typeLal.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    [self.contentView addSubview:_typeLal];
    
    [self _setupAvatarViewConstraints];
    [self _setupTimeLabelConstraints];
    [self _setupTitleLabelConstraints];
    [self _setupDetailLabelConstraints];
    [self _setupBadgeLabelConstraints];
    [self _setuplineLabelConstraints];
    [self _setupTypeLabelConstraints];
}

#pragma mark - Setup Constraints

- (void)_setupAvatarViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:35/2.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-(35/2.0)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
}

- (void)_setupTimeLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseConversationCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

- (void)_setupTitleLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:-EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseConversationCellPadding]];
    
    self.titleWithAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseConversationCellPadding];
    self.titleWithoutAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding];
    [self addConstraint:self.titleWithAvatarLeftConstraint];
}

- (void)_setupDetailLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseConversationCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseConversationCellPadding-30]];//**环信--距离右边的距离
    self.detailWithAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseConversationCellPadding];
    self.detailWithoutAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.detailLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseConversationCellPadding];
    [self addConstraint:self.detailWithAvatarLeftConstraint];
}

-(void)_setupBadgeLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBadgeLal attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:20 +EaseConversationCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBadgeLal attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseConversationCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBadgeLal attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20.0f]];
   
    self.badgeWidthCons = [NSLayoutConstraint constraintWithItem:self.rightBadgeLal attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20.0f];
    
    [self addConstraint:self.badgeWidthCons];
}

-(void)_setuplineLabelConstraints
{
    NSLayoutConstraint *left=[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
    NSLayoutConstraint *right=[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *botton=[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *heightC=[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:0.5];
    
    left.active=YES;
    right.active=YES;
    botton.active=YES;
    heightC.active=YES;
}

-(void)_setupTypeLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.typeLal attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.typeLal attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.typeLal attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:8]];
    if (IS_IPHONE5) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.typeLal attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil  attribute:NSLayoutAttributeWidth multiplier:1.0 constant:90]];
    }
   
}

#pragma mark - setter

- (void)setShowAvatar:(BOOL)showAvatar
{
    if (_showAvatar != showAvatar) {
        _showAvatar = showAvatar;
        self.avatarView.hidden = !showAvatar;
        if (_showAvatar) {
            [self removeConstraint:self.titleWithoutAvatarLeftConstraint];
            [self removeConstraint:self.detailWithoutAvatarLeftConstraint];
            [self addConstraint:self.titleWithAvatarLeftConstraint];
            [self addConstraint:self.detailWithAvatarLeftConstraint];
        }
        else{
            [self removeConstraint:self.titleWithAvatarLeftConstraint];
            [self removeConstraint:self.detailWithAvatarLeftConstraint];
            [self addConstraint:self.titleWithoutAvatarLeftConstraint];
            [self addConstraint:self.detailWithoutAvatarLeftConstraint];
        }
    }
}

- (void)setModel:(id<IConversationModel>)model
{
    _model = model;
    
    [[UserEaseInfoManager shareInstance] getNicknameByUserNameDic:model.title cellInfoDic:^(id json) {
       
        NSDictionary *doctorDic = (NSDictionary *)json;
//        NSLog(@"cell中医生信息%@",doctorDic);
        
        UserEaseInfoModel *doctorModel = [UserEaseInfoModel objectWithKeyValues:doctorDic];
        
        if ([doctorModel.Name length] > 0) {
            self.titleLabel.text = doctorModel.Name;
        }
        else{
            self.titleLabel.text = _model.conversation.conversationId;
        }
        
        if (self.showAvatar) {

            if (doctorModel.OnLineStatus == 1) {
                [self.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:doctorModel.DoctorImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
               
                _timeLabel.textColor = _timeLabelColor;
                _titleLabel.textColor = _titleLabelColor;
                _detailLabel.textColor = _detailLabelColor;
                _typeLal.textColor = [UIColor colorWithWhite:0.15 alpha:1.0];
            }else{
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
                [imgV sd_setImageWithURL:[NSURL URLWithString:doctorModel.DoctorImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
                self.avatarView.image = [Dateformat grayImage:imgV.image];
                
                _timeLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];;
                _titleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];;
                _detailLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];;
                _typeLal.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];;
            }
        }
        
        self.typeLal.text = doctorModel.DoctorType;
        
        if (_model.conversation.unreadMessagesCount == 0) {
            _avatarView.showBadge = NO;
            _rightBadgeLal.hidden = YES;
        }
        else{
            _avatarView.showBadge = YES;
            _avatarView.badge = _model.conversation.unreadMessagesCount;
            
            _rightBadgeLal.hidden = NO;
           
            //**环信--判断未读消息数是否大于99，变大宽度
            if (_model.conversation.unreadMessagesCount > 99) {
                _rightBadgeLal.text = @"99+";
                self.badgeWidthCons.constant = 30;
                
            }else{
                _rightBadgeLal.text = [NSString stringWithFormat:@"%i",_model.conversation.unreadMessagesCount];
                self.badgeWidthCons.constant = 20;
            }
        }
        NSLog(@"cellonline -- %@ -- %li",doctorModel.Name,doctorModel.OnLineStatus);
        

    }];
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    _titleLabel.font = _titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabelColor = titleLabelColor;
    _titleLabel.textColor = _titleLabelColor;
}

- (void)setDetailLabelFont:(UIFont *)detailLabelFont
{
    _detailLabelFont = detailLabelFont;
    _detailLabel.font = _detailLabelFont;
}

- (void)setDetailLabelColor:(UIColor *)detailLabelColor
{
    _detailLabelColor = detailLabelColor;
    _detailLabel.textColor = _detailLabelColor;
}

- (void)setTimeLabelFont:(UIFont *)timeLabelFont
{
    _timeLabelFont = timeLabelFont;
    _timeLabel.font = _timeLabelFont;
}

- (void)setTimeLabelColor:(UIColor *)timeLabelColor
{
    _timeLabelColor = timeLabelColor;
    _timeLabel.textColor = _timeLabelColor;
}

#pragma mark - class method

+ (NSString *)cellIdentifierWithModel:(id)model
{
    return @"EaseConversationCell";
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return EaseConversationCellMinHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (_avatarView.badge) {
        _avatarView.badgeBackgroudColor = ORANGECOLOR;
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (_avatarView.badge) {
        _avatarView.badgeBackgroudColor = ORANGECOLOR;
    }
}

@end
