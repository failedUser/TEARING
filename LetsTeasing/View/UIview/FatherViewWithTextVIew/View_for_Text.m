//
//  View_for_Text.m
//  LetsTeasing
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "View_for_Text.h"
#define MaxTextViewHeight  100

@interface View_for_Text()
{
    UILabel *  line;
    NSInteger  saveHeight;
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
        self.backgroundColor = UIColorFromHex(0x313131);
          }
    [self setUIColor];
    [self addNOtificaiton];
    saveHeight =0;
    return self;
}
-(void)addNOtificaiton
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
 
}
-(void)KeyWillShow
{
    
}
-(void)textChange
{
    if (saveHeight ==0) {
        saveHeight =_yy_text.frame.size.height;
    }else
    {
        if (saveHeight-_yy_text.frame.size.height ==0) {
        }
        else if(_yy_text.frame.size.height<85)
        {
            CGFloat  changeHeight = _yy_text.frame.size.height -saveHeight;
            CGRect frame =   CGRectMake(0, self.frame.origin.y-changeHeight, SCREEN_WIDTH, self.frame.size.height+changeHeight);
            self.frame =frame;
            saveHeight =_yy_text.frame.size.height;
            
        }else
        {
//            CGFloat  changeHeight = _yy_text.frame.size.height -saveHeight;
//            CGRect frame =   CGRectMake(0, self.frame.origin.y-changeHeight, SCREEN_WIDTH, self.frame.size.height+changeHeight);
//            self.frame =frame;
//            saveHeight =_yy_text.frame.size.height;
        }
    }
}

-(void)addViewForText
{
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 1)];
    [self addSubview:line];

    
    self.yy_text  = [[YY_TextView alloc]initWithFrame:CGRectMake(20, 0, 280, 22)];
    self.yy_text.constrainH = self.constrainH;
    _yy_text.YTdelegate =self;
    
    [self addSubview:self.yy_text];
}
-(void)addSendBUtton
{
    _send_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_send_btn setFrame:CGRectMake(285, 0, 30, 30)];
    [_send_btn setTitle:@"发布" forState:UIControlStateNormal];
    _send_btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
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
-(void)setUIColor
{
    self.backgroundColor = UIColorFromHex(0x313131);
    line.backgroundColor = UIColorFromHex(0x8a8a8f);
    _yy_text.backgroundColor = UIColorFromHex(0x313131);
    _yy_text.placehoderLbl.textColor=UIColorFromHex(0x8a8a8f);
    _send_btn.backgroundColor = UIColorFromHex(0x50d2c2);
    [_send_btn setTintColor:UIColorFromHex(0xffffff)];
}
-(void)autolayoutWithMasonry
{       [_send_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(YY_ININPONE6_WITH(50.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(25.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE6_WITH(-24.0f));
//        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE6_HEIGHT(15.0f));
        make.bottomMargin.equalTo(self.mas_bottom).offset(YY_ININPONE5_HEIGHT(-15.0f));
    }];
    
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(20.0f));
        make.height.offset(1);
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-75.0f));
        make.bottomMargin.equalTo(self.mas_bottom).offset(YY_ININPONE5_HEIGHT(-15.0f));
    }];
    
    [self.yy_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(20.0f));
        make.width.offset(YY_ININPONE5_WITH(250.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(15.0f));
        make.bottomMargin.equalTo(self.mas_bottom).offset(YY_ININPONE6_HEIGHT(-20.0f));
    }];
}

-(void)dealloc1{
    //移除所有通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)TextShouldEditing:(YY_TextView *)beginEdting
{
        NSLog(@"开始输入");
    [self addNOtificaiton];
}
@end
