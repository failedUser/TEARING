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
        [self setColor];
        self.yy_text.textColor = UIColorFromHex(0x8a8a8f);
    }
    
    
    
    return self;
}
- (void)dealloc{
    //移除所有通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)addViewForText
{
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self addSubview:line];
    
    
    
    self.yy_text  = [[YY_TextView alloc]initWithFrame:CGRectMake(5, 5, 280, 22)];
    self.yy_text.constrainH = self.constrainH;
    [self addSubview:self.yy_text];
    
    
    
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(20.0f));
        make.height.offset(1);
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-70.0f));
        make.bottomMargin.equalTo(self.mas_bottom).offset(YY_ININPONE5_HEIGHT(-12.0f));
    }];
    
    [self.yy_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(20.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-70.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(10.0f));
        make.bottomMargin.equalTo(self.mas_bottom).offset(YY_ININPONE6_HEIGHT(-20.0f));
    }];
}
-(void)addSendBUtton
{
    _send_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_send_btn setFrame:CGRectMake(285, 0, 30, 30)];
    [_send_btn setTitle:@"发布" forState:UIControlStateNormal];
    _send_btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [self addSubview:_send_btn];
    
    
    [_send_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.leftMargin.equalTo(self.mas_left).offset(5);
        make.width.offset(YY_ININPONE6_WITH(45.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE6_WITH(-20.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE6_HEIGHT(15.0f));
        make.bottomMargin.equalTo(self.mas_bottom).offset(YY_ININPONE6_HEIGHT(-15.0f));
    }];
}
-(void)setColor
{
    self.backgroundColor = [UIColor whiteColor];
    _send_btn.backgroundColor = UIColorFromHex(0x50d2c2);
    [_send_btn setTintColor:UIColorFromHex(0xffffff)];
    _yy_text.backgroundColor = [UIColor whiteColor];
    line.backgroundColor = [UIColor lightGrayColor];
    _yy_text.placehoderLbl.textColor = UIColorFromHex(0x8a8a8f);
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
