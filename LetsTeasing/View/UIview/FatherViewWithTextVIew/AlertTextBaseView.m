//
//  AlertTextBaseView.m
//  LetsTeasing
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "AlertTextBaseView.h"

@implementation AlertTextBaseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViewForText];
        [self addSendBUtton];
    }
    
    
    
    return self;
}
- (void)dealloc{
    //移除所有通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)addViewForText
{
    
    UILabel *  line = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self addSubview:line];
    
    
    
    self.yy_text  = [[YY_TextView alloc]initWithFrame:CGRectMake(5, 5, 280, 22)];
    self.yy_text.constrainH = self.constrainH;
    [self addSubview:self.yy_text];
    
    
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(10.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(1.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-10.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(30.0f));
    }];
    [self.yy_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(5.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(22.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-35.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(8.0f));
    }];
}
-(void)addSendBUtton
{
    _send_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_send_btn setFrame:CGRectMake(285, 0, 30, 30)];
    UIImage* image =[UIImage imageNamed:@"send.png"];
    [_send_btn setImage: [self OriginImage:image scaleToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    _send_btn.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 0, 0);
    
    [self addSubview:_send_btn];
    
    [_send_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.leftMargin.equalTo(self.mas_left).offset(5);
        make.height.offset(YY_ININPONE5_HEIGHT(30.0f));
        make.width.offset(YY_ININPONE5_WITH(30.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-10.0f));
        make.topMargin.equalTo(self.mas_top).offset(0);
    }];
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size); //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage; //返回的就是已经改变的图片
}


@end
