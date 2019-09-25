//
//  TopicCell.m
//  仿网易导航
//
//  Created by xiekang on 2017/6/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "TopicCell.h"
#import "MHCommentFrame.h"
#import "MHCommentCell.h"
@interface TopicCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView *tableView;

@property (nonatomic , weak) UIImageView *avatarView;
/** 更多 */
@property (nonatomic , weak) UIButton *moreBtn;

/** 创建时间 */
@property (nonatomic , weak) UILabel *createTimeLabel;

/** 文本内容 */
@property (nonatomic , weak) UILabel *contentLabel;

@property (nonatomic , weak) UILabel *line;
@end

@implementation TopicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundView = [[UIView alloc]init];
        
        self.backgroundColor = [UIColor clearColor];
        
        // UITableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 100) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.scrollEnabled = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.backgroundColor =  [UIColor getColor:@"f7f7f7"];;
        tableView.layer.cornerRadius = 5;
        tableView.clipsToBounds = YES;
//        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:tableView];
        self.tableView = tableView;
        
        
        
        // 头像
        UIImageView *avatarView = [[UIImageView alloc]init];
        avatarView.backgroundColor = [UIColor whiteColor];
        avatarView.layer.cornerRadius = 25*.5f;
        // 这样写比较消耗性能
        avatarView.layer.masksToBounds = YES;
        
        self.avatarView = avatarView;
        [self.contentView addSubview:avatarView];

        
        // 昵称
        UILabel *nicknameLable = [[UILabel alloc] init];
        nicknameLable.text = @"";
        nicknameLable.font = [UIFont systemFontOfSize:14.f];
        nicknameLable.textAlignment = NSTextAlignmentLeft;
       
        [self.contentView addSubview:nicknameLable];
        self.nicknameLable = nicknameLable;
        
      
        
        // 点赞按钮
        UIButton *thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thumbBtn.adjustsImageWhenHighlighted = NO;
        thumbBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [thumbBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [thumbBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateSelected];
        [thumbBtn setTitleColor:[UIColor getColor:@"bdbebd"] forState:UIControlStateNormal];
        [thumbBtn addTarget:self action:@selector(_thumbBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        thumbBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 0, 0);
        [self.contentView addSubview:thumbBtn];
        self.thumbBtn = thumbBtn;
        
        // 时间
        UILabel *createTimeLabel = [[UILabel alloc] init];
        createTimeLabel.text = @"";
        createTimeLabel.font = [UIFont systemFontOfSize:12.f];
        createTimeLabel.textAlignment = NSTextAlignmentLeft;
        createTimeLabel.textColor = [UIColor getColor:@"bdbebe"];
        [self.contentView addSubview:createTimeLabel];
        self.createTimeLabel = createTimeLabel;

        // 更多
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [moreBtn setTitleColor:[UIColor getColor:@"bdbebd"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(_moreBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
         [moreBtn setImage:[UIImage imageNamed:@"talk"] forState:UIControlStateNormal];
        moreBtn.titleEdgeInsets = UIEdgeInsetsMake(-2, 5, 0, 0);
        [self.contentView addSubview:moreBtn];
        self.moreBtn = moreBtn;

        // 文本
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:16.f];
        contentLabel.numberOfLines = 0 ;
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        UILabel *line = [[UILabel alloc] init];
       
        line.backgroundColor = [UIColor getColor:@"d8d8d8"];
        [self.contentView addSubview:line];
        self.line = line;

    }
    
    return self;
}
- (void)setTopicFrame:(MHTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    
    self.avatarView.frame = topicFrame.avatarFrame;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:topicFrame.topic.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];

    
    // 昵称
    self.nicknameLable.frame = topicFrame.nicknameFrame;
    self.nicknameLable.text = topicFrame.topic.NickName;
    
    // 点赞
    self.thumbBtn.frame = topicFrame.thumbFrame;
    
    if (topicFrame.topic.IsPraise == 1) { //已经点赞
        self.thumbBtn.selected = YES;
    }else{//未点赞
        self.thumbBtn.selected = NO;
    }

    [self.thumbBtn setTitle:[NSString stringWithFormat:@"%li",topicFrame.topic.PraiseScount] forState:UIControlStateNormal];
//    self.thumbBtn.enabled = !topic.isThumb;
    
    // 更多
     self.moreBtn.frame = topicFrame.moreFrame;
     [self.moreBtn setTitle:[NSString stringWithFormat:@"%li",topicFrame.topic.ReplyScount] forState:UIControlStateNormal];
    
    // 时间
    self.createTimeLabel.frame = topicFrame.createTimeFrame;
   
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",topicFrame.topic.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
   
    NSString *timeStr= [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
//    [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",topicFrame.topic.ReplyTime]] withFormat:@"yyyy-MM-dd"];
    
    self.createTimeLabel.text = timeStr;
    

    
    
    self.contentLabel.frame = topicFrame.textFrame;
    
    
    
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:topicFrame.topic.ReplyContent];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:6.0];//调整行间距
//    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [topicFrame.topic.ReplyContent length])];
//    [self.contentLabel setAttributedText:attri];
    /*行高*/
    self.contentLabel.text = topicFrame.topic.ReplyContent;
    
    
    
    
    // 刷新评论tableView
    if (self.topicFrame.topic.comments.count>3) {
        CGRect rect =  topicFrame.tableViewFrame;
        self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+40);
    }
    else
          self.tableView.frame = topicFrame.tableViewFrame;
    
    if (topicFrame.tableViewFrame.size.height==0) {
        self.line.frame =  CGRectMake(15, topicFrame.tableViewFrame.origin.y+15- 0.5, KScreenWidth-15, 0.5);
    }
    else  if (topicFrame.topic.comments.count>3){
        self.line.frame =  CGRectMake(15, topicFrame.tableViewFrame.origin.y+topicFrame.tableViewFrame.size.height +30+30 - 0.5, KScreenWidth-15, 0.5);
    }
    else{
       self.line.frame =  CGRectMake(15, topicFrame.tableViewFrame.origin.y+topicFrame.tableViewFrame.size.height +15 - 0.5, KScreenWidth-15, 0.5);
    }

//    self.line.frame =  CGRectMake(topicFrame.tableViewFrame.origin.x-2, topicFrame.tableViewFrame.origin.y+topicFrame.tableViewFrame.size.height +10 - 1, topicFrame.tableViewFrame.size.width, 1);
    [self.tableView reloadData];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
  
}
#pragma mark - UITableViewDelegate , UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topicFrame.commentFrames.count>3) {
        return 3;
    }
    else
    
    return self.topicFrame.commentFrames.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.topicFrame.commentFrames.count>3) {
        return 40;
    }
    return 0.01;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
   
    MHCommentFrame *commentFrame = self.topicFrame.commentFrames[0];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, commentFrame.maxW, 40)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.frame;
    [btn setTitle:@"更多回复》" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(moreReve:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    view.backgroundColor = [UIColor getColor:@"f7f7f7"];
    return view;
  
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHCommentFrame *commentFrame = self.topicFrame.commentFrames[indexPath.row];
//     NSLog(@"textHtextH--%f",commentFrame.cellHeight);
    
    return commentFrame.cellHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (cell == nil) {
        cell = [[MHCommentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    MHCommentFrame *commentFrame = self.topicFrame.commentFrames[indexPath.row];
    cell.commentFrame = commentFrame;
    cell.delegate = self;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
      MHCommentFrame *commentFrame = self.topicFrame.commentFrames[indexPath.row];
     NSLog(@"%li     ReplyID      %li",self.topicFrame.topic.ReplyID,commentFrame.comment.ReplyID);
    if (commentFrame.comment.ReplyerMemberID ==  [UserInfoTool getLoginInfo].MemberID) {
   
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCell:didSelectRowAtIndexPath:)]) {
        [self.delegate topicCell:self didSelectRowAtIndexPath:indexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark   moreReve
-(void)moreReve:(UIButton *)btn
{
   
    NSLog(@"index.row%ld",_cellId);
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCell:didSelectMore:)]) {
        [self.delegate topicCell:self didSelectMore:_cellId];
    }


}

#pragma mark - 事件处理

- (void)_thumbBtnDidClicked:(UIButton *)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellForClickedThumbAction:)]) {
        [self.delegate topicCellForClickedThumbAction:self];
    }
    
}

- (void)_moreBtnDidClicked:(UIButton *)sender
{
    
    if (self.topicFrame.topic.ReplyerMemberID ==  [UserInfoTool getLoginInfo].MemberID) {
        
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellForClickedMoreAction:)]) {
        [self.delegate topicCellForClickedMoreAction:self];
    }
}
#pragma mark - MHTopicCommentCellDelegate
- (void) topicCommentCell:(MHCommentCell *)topicCommentCell
{

    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCell:didSelectRowAtIndexPath:)]) {
        [self.delegate topicCell:self didSelectRowAtIndexPath:nil];
    }
}
@end
