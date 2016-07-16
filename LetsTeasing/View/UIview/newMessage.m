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
        [self addimage];
    }
    return self;
}
-(void)HIDDEN:(BOOL)bools num:(NSInteger)integ
{
    if (bools == NO) {
        [self setHidden:NO];
        [self buttonSetTitle:integ];
      
    }
}
-(void)addBUtton
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _button.backgroundColor = [UIColor lightGrayColor];
    _button.titleLabel.font = YYSYSTEM_FONT;

    [self addSubview:_button];
  
}
-(void)buttonSetTitle:(NSInteger)inT
{

    NSString * title =[NSString stringWithFormat:@"你有%ld条未读消息",(long)inT];
    [_button setTitle:title forState:UIControlStateNormal];
}
-(void)addimage
{
    UIImage * image =[photoChange OriginImage: [UIImage imageNamed:@"message.png"]scaleToSize:CGSizeMake(15, 15)];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
//    imageView.backgroundColor = [UIColor redColor];
    [imageView setFrame:CGRectMake(YY_ININPONE5_WITH(210.0f),YY_ININPONE5_HEIGHT(2.0f), YY_ININPONE5_HEIGHT(15.0f), YY_ININPONE5_HEIGHT(15.0f))];
    [_button addSubview:imageView];

}

@end
