//
//  XKDetectTableViewCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKDetectTableViewCell.h"

@implementation XKDetectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 模型数据

 @param deviceDetailMod <#deviceDetailMod description#>
 */
-(void)setDeviceDetailMod:(XKDeviceDetailMod *)deviceDetailMod
{

    _deviceDetailMod = deviceDetailMod;
    


    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_deviceDetailMod.DeviceImg dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

//    self.dataLab.attributedText = attrStr;

    [self.weBIvew loadHTMLString:attrStr.string baseURL:nil];
// self.dataLab.text = [NSString stringWithFormat:@"总结：%@",[self flattenHTML:_deviceDetailMod.DeviceImg]];
    
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
@end
