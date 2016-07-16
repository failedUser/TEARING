//
//  View_for_Text.m
//  LetsTeasing
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "View_for_Text.h"

@interface View_for_Text()
{
    UILabel *  line;
}

@end
@implementation View_for_Text

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViewForText];
        [self addSendBUtton];
        //4.监听键盘的弹起和收缩
        [self autolayoutWithMasonry];
          }
    
  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    return self;
}

-(void)addViewForText
{
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self addSubview:line];
    
    self.yy_text  = [[YY_TextView alloc]initWithFrame:CGRectMake(5, 5, 280, 22)];
    self.yy_text.constrainH = self.constrainH;
    [self addSubview:self.yy_text];
    
    
 
  
}
-(void)addSendBUtton
{
    _send_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_send_btn setFrame:CGRectMake(285, 0, 30, 30)];
    UIImage* image =[UIImage imageNamed:@"send.png"];
    [_send_btn setImage: [self OriginImage:image scaleToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    _send_btn.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 0, 0);
    
    [self addSubview:_send_btn];
    
  
}
//自定义修改尺寸
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size); //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage; //返回的就是已经改变的图片
}
//键盘监听事件
- (void)keyBoardChange:(NSNotification *)note{
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.popView.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.popView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];

}
-(void)autolayoutWithMasonry
{
    
    [_send_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.leftMargin.equalTo(self.mas_left).offset(5);
        make.height.offset(YY_ININPONE5_HEIGHT(30.0f));
        make.width.offset(YY_ININPONE5_WITH(30.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-10.0f));
        make.topMargin.equalTo(self.mas_top).offset(0);
    }];
    
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(10.0f));
        make.height.offset(1);
        make.width.offset(YY_ININPONE5_WITH(300.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-10.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(35.0f));
    }];
    
    
    [self.yy_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(8.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(30.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-35.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(5.0f));
    }];
}
//添加监听
-(void)addObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)dealloc1{
    //移除所有通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
