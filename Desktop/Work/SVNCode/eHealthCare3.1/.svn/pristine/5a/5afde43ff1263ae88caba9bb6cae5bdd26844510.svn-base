//
//  MHCommentFrame.m
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHCommentFrame.h"

@interface MHCommentFrame ()

/** 内容尺寸 */
@property (nonatomic , assign) CGRect textFrame;
/** cell高度 */
@property (nonatomic , assign) CGFloat cellHeight;

@end
/**  评论水平方向间隙 */
CGFloat const MHCommentHorizontalSpace = 10.0f;
/**  评论垂直方向间隙 */
CGFloat const MHCommentVerticalSpace = 20.0f;

/** 文本行高 */
CGFloat const  MHCommentContentLineSpacing = 10.0f;

@implementation MHCommentFrame

#pragma mark - Setter

- (void)setComment:(MHComment *)comment
{
    _comment = comment;
    
    // 文本内容
    CGFloat textX = MHCommentHorizontalSpace;
    CGFloat textY = 0;
    CGSize  textLimitSize = CGSizeMake(self.maxW - 2 *textX, MAXFLOAT);
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",comment.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSString *oneStr ;
    if ([comment.RNickName isEqualToString:comment.CNickName]) {
        oneStr = [NSString stringWithFormat:@"%@：%@",comment.CNickName,comment.ReplyContent];
        
        
        
    }else{
        oneStr = [NSString stringWithFormat:@"%@ 回复 %@：%@ ",comment.RNickName,comment.CNickName,comment.ReplyContent];
        
       
        
    }

    
    CGFloat textH = [[NSString stringWithFormat:@"%@",oneStr] boundingRectWithSize:CGSizeMake(textLimitSize.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}context:nil].size.height+MHCommentVerticalSpace;
    NSLog(@"textHtextH--%f",textH);
    self.textFrame = (CGRect){{textX , textY} , {textLimitSize.width , textH}};
    
    self.cellHeight = CGRectGetMaxY(self.textFrame) + 0;
}

@end
