//
//  XKHistoryTotalCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKHistoryTotalCell.h"

@interface XKHistoryTotalCell (){
    
    id _target;
    SEL _action;
    
}

@property (weak, nonatomic) IBOutlet UILabel *totalLab;

@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *checkPeopleLab;

@property (weak, nonatomic) IBOutlet UILabel *titleContentLab;

@property (weak, nonatomic) IBOutlet UILabel *commentContentLab;


@end

@implementation XKHistoryTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorInset = UIEdgeInsetsMake(0, KScreenWidth, 0, 0);
    
}

-(void)setModel:(XKReportOveralMod *)model{
    
    _model = model;
    
    if (IS_IPHONE5||IS_IPHONE4S) {
        self.rightConstain.constant = 38;
    }
   
 //         [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",[self.dataArray[0] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
//    self.totalLab.text = [NSString stringWithFormat:@"总结：%@",[self flattenHTML:_model.Result]];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_model.Result dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
  
    self.titleContentLab.attributedText = attrStr;
    
    
//    [self.totalLab setAttributedText:[NSMutableAttributedString fontChangeLabelWithText:self.totalLab.text  withBigFont:15 withNeedchangeText:@"总结" withSmallFont:15 dainmaicColor:[UIColor getColor:@"121212"] excisionColor:[UIColor getColor:@"121212"]] ];
    
     NSAttributedString * attrStr1 = [[NSAttributedString alloc] initWithData:[_model.Suggest dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.commentContentLab.attributedText = attrStr1;
//    self.commentLab.text = [NSString stringWithFormat:@"建议：%@",[self flattenHTML:_model.Suggest]];
    
//    [self.commentLab setAttributedText:[NSMutableAttributedString fontChangeLabelWithText:self.commentLab.text  withBigFont:15 withNeedchangeText:@"建议" withSmallFont:15 dainmaicColor:[UIColor getColor:@"121212"] excisionColor:[UIColor getColor:@"121212"]] ];
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_model.AuditTime]] withFormat:@"yyyy-MM-dd"];
    
    self.timeLab.text = [NSString stringWithFormat:@"总检时间：%@",timeStr];
    
    self.checkPeopleLab.text = [NSString stringWithFormat:@"总检人：%@",_model.Auditor];
    
    CGFloat fontOne=14;
    
    CGFloat fontTwo=14;
    
    if (IS_IPHONE5) {
        
        fontOne=12;
        
        fontTwo=12;
        
    }else{
        
        fontOne=14;
        
        fontTwo=14;
        
    }
    
    
    [self.timeLab setAttributedText:[NSMutableAttributedString changeLabelWithText:self.timeLab.text  withBigFont:fontTwo withNeedchangeText:@"总检时间：" withSmallFont:fontOne dainmaicColor:[UIColor getColor:@"959595"] excisionColor:[UIColor getColor:@"121212"]] ];
    
    [self.checkPeopleLab setAttributedText:[NSMutableAttributedString changeLabelWithText:self.checkPeopleLab.text  withBigFont:fontTwo withNeedchangeText:@"总检人：" withSmallFont:fontOne dainmaicColor:[UIColor getColor:@"959595"] excisionColor:[UIColor getColor:@"121212"]] ];

    
}

//过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
//    MidStrTitle = html;
    return html;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
