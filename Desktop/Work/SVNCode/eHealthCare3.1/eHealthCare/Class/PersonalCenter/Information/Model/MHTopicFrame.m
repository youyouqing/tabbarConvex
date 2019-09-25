//
//  MHTopicFrame.m
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHTopicFrame.h"
#import "MHCommentFrame.h"
#import "MHComment.h"
@interface MHTopicFrame ()
/** 头像frame */
@property (nonatomic , assign) CGRect avatarFrame;

/** 昵称frame */
@property (nonatomic , assign) CGRect nicknameFrame;

/** 点赞frame */
@property (nonatomic , assign) CGRect thumbFrame;

/** 更多frame */
@property (nonatomic , assign) CGRect moreFrame;

/** 时间frame */
@property (nonatomic , assign) CGRect createTimeFrame;

/** 话题内容frame */
@property (nonatomic , assign) CGRect textFrame;

/** height*/
@property (nonatomic , assign) CGFloat height;

/** tableViewFrame cell嵌套tableView用到 本人有点懒 ，公用了一套模型 */
@property (nonatomic , assign ) CGRect tableViewFrame;

@end


@implementation MHTopicFrame

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化
        _commentFrames = [NSMutableArray array];
        
    }
    return self;
}
// 段头+cell+表头
/**  话题头像宽高 */
 CGFloat const MHTopicAvatarWH = 25.0f ;
/**  话题水平方向间隙 */
CGFloat const MHTopicHorizontalSpace = 10.0f;
/**  话题垂直方向间隙 */
CGFloat const MHTopicVerticalSpace = 5.0f ;
/**  话题更多按钮宽 */
CGFloat const MHTopicMoreButtonW = 19.0f ;


#pragma mark - Setter
- (void)setTopic:(MHTopic *)topic
{
    _topic = topic;
    
    // 整个宽度
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 头像
    CGFloat avatarX = MHTopicHorizontalSpace;
    CGFloat avatarY = 15;
    CGFloat avatarW = MHTopicAvatarWH;
    CGFloat avatarH = MHTopicAvatarWH;
    self.avatarFrame = (CGRect){{avatarX , avatarY+4.f+ 2.f},{avatarW , avatarH}};
    
    // 布局更多
    CGFloat moreW = MHTopicMoreButtonW*3;
    CGFloat moreX = KScreenWidth-moreW;
    CGFloat moreY = avatarY+5;
    CGFloat moreH = 22;
    self.moreFrame = CGRectMake(moreX, moreY, moreW, moreH);
    
    // 布局点赞按钮
    CGFloat thumbW = 3*19;
    CGFloat thumbX = CGRectGetMinX(self.moreFrame) - 46 - 25.0;
    CGFloat thumbY = moreY;
    CGFloat thumbH = 20;
    self.thumbFrame = CGRectMake(thumbX, thumbY, thumbW, thumbH);
    
    // 昵称
    CGFloat nicknameX = CGRectGetMaxX(self.avatarFrame)+MHTopicHorizontalSpace;
    CGFloat nicknameY = avatarY ;
    CGFloat nicknameW = CGRectGetMinX(self.thumbFrame) - nicknameX;
    CGFloat nicknameH = moreH;
    self.nicknameFrame = CGRectMake(nicknameX, nicknameY, nicknameW, nicknameH);
    
    // 时间
    CGFloat createX = nicknameX;
    CGFloat createY = CGRectGetMaxY(self.nicknameFrame);
    CGFloat createW = width - createX;
    CGFloat createH = 19;
    self.createTimeFrame = CGRectMake(createX, createY+4, createW, createH);
    
    // 内容   文本高度 你妹的宽度不能给最大！textLimitSize.width
    CGFloat textX = nicknameX;
    CGSize textLimitSize = CGSizeMake(width - textX - MHTopicHorizontalSpace, MAXFLOAT);
    CGFloat textY = CGRectGetMaxY(self.nicknameFrame)+CGRectGetHeight(self.nicknameFrame)+10;
    
    
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:topic.ReplyContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [topic.ReplyContent length])];//行高
  
    
    CGFloat textH =[topic.ReplyContent boundingRectWithSize:CGSizeMake(textLimitSize.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]} context:nil].size.height+MHTopicVerticalSpace+MHTopicVerticalSpace;
    //    [YYTextLayout layoutWithContainerSize:textLimitSize text:topic.attributedText].textBoundingSize.height+MHTopicVerticalSpace+MHTopicVerticalSpace;
    NSLog(@"文本高度---%f",textH);
    self.textFrame = (CGRect){{textX , textY} , {textLimitSize.width, textH}};
    
    
    
    CGFloat tableViewX = textX;
    CGFloat tableViewY = CGRectGetMaxY(self.textFrame);
    CGFloat tableViewW = textLimitSize.width;
    CGFloat tableViewH = 0;
    // 评论数据
    if (topic.comments>0)
    {
        
        for (int i = 0; i<topic.comments.count; i++) {
            MHComment *comment = topic.comments[i];
            MHCommentFrame *commentFrame = [[MHCommentFrame alloc] init];
            commentFrame.maxW = textLimitSize.width;
            commentFrame.comment = comment;
            [self.commentFrames addObject:commentFrame];
            
            if (i>=3) {
                break;
            }
            
            tableViewH += commentFrame.cellHeight;
            
        }
        
    }
     // 内容   文本高度 你妹的高度给的太多
    self.tableViewFrame = CGRectMake(tableViewX, tableViewY+14, tableViewW, tableViewH );
    
    NSLog(@"-tableViewH--%f",tableViewH);
    // 自身高度
    self.height = CGRectGetMaxY(self.textFrame);

}


@end
