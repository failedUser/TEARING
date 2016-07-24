//
//  string.m
//  LetsTeasing
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "string.h"

@implementation string
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}
@end
