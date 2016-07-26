//
//  newMessage.m
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "newMessage.h"
#import "commentInfo.h"
#import "JCAlertView.h"
#import "photoChange.h"

@implementation newMessage
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBUtton];
        [self buttonSetTitle:0];
    }
    return self;
}
-(void)HIDDEN:(BOOL)bools num:(NSInteger)integ
{
    if (bools == NO) {
        [self setHidden:NO];
     
      
    }
}
-(void)addBUtton
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _button.backgroundColor = UIColorFromHex(0xefeff4);
//    [_button setTitleColor:UIColorFromHex(0x6e6e70) forState:UIControlStateNormal];
    _button.titleLabel.font = YYBUTTON_FONT;
    //设置字间距 NSKernAttributeName:@1.5f

    [self addSubview:_button];
  
}
-(void)buttonSetTitle:(NSInteger)inT
{
    NSString * str = [NSString stringWithFormat:@"你有%ld条未读消息",(long)inT];
    NSDictionary *dic = @{NSKernAttributeName:@1.5f,NSForegroundColorAttributeName:UIColorFromHex(0x6e6e70),NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14.0]};

    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    [_button setAttributedTitle:attributeStr forState:UIControlStateNormal];
  
//    [_button setTitle:title forState:UIControlStateNormal];
}
//-(void)addimage
//{
//    UIImage * image =[photoChange OriginImage: [UIImage imageNamed:@"message.png"]scaleToSize:CGSizeMake(15, 15)];
//    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
//    [imageView setFrame:CGRectMake(YY_ININPONE5_WITH(210.0f),YY_ININPONE5_HEIGHT(2.0f), YY_ININPONE5_HEIGHT(15.0f), YY_ININPONE5_HEIGHT(15.0f))];
//    [_button addSubview:imageView];
//
//}

@end
