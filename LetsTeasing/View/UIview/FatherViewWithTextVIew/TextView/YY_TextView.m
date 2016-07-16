//
//  YY_TextView.m
//  LetsTeasing
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "YY_TextView.h"
#define JQMainScreenSize [UIScreen mainScreen].bounds.size
#define JQPlacehoderPadding 8 //提示语与边框的距离(上下左)

@implementation YY_TextView

-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;//允许autoLayout
        self.backgroundColor=[UIColor whiteColor];//默认背景色
        self.contentMode = UIViewContentModeCenter;
        self.layer.cornerRadius = 6;//圆角
        self.font = [UIFont fontWithName:@"Arial" size:16];
//        self.contentInset = UIEdgeInsetsMake(-3, 0, 0, 0);
        //2.添加子控件
        [self addSubView];
        [self addimage];
        //3.清空text:(可能在故事板中拖动的时候没有清空文本)
        self.text = @"";
        [self addMasonry];
        //3.监听textView文字通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc{
    //移除所有通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 控件相关

- (void)addSubView{
    //1.添加子控件
    _placehoderLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 320, 30)];
    //->设置默认提示文字
    _placehoderLbl.text=(self.placeHoder.length>0?self.placeHoder:@"我也来吐槽");
    //->默认字体 == textView字体
    _placehoderLbl.font=[UIFont fontWithName:@"Arial" size:13.0];
    //->设置默认字体颜色
    _placehoderLbl.textColor=[UIColor lightGrayColor];
    //->设置默认字体透明度
    _placehoderLbl.alpha=0.8;
    //->提示框也可以多行
    _placehoderLbl.numberOfLines=0;
    
    [self addSubview:_placehoderLbl];
   
}
-(void)addimage
{
    UIImage * image = [UIImage imageNamed:@"cc-write.png"];
    _PlaceHoder_Image = [[UIImageView alloc]initWithImage:image highlightedImage:nil];
    [_PlaceHoder_Image setFrame:CGRectMake(10, 7, 15, 15)];
    [self addSubview:_PlaceHoder_Image];
    [self addSubview:_placehoderLbl];
  
}

#pragma mark 点击/响应通知方法
/**
 *  每一次文本改变时调用
 */
- (void)textDidChange{
    //提示标签隐藏与否
    if (self.text.length != 0) {
        _placehoderLbl.hidden=(self.text.length>0);
        _PlaceHoder_Image.hidden = (self.text.length>0);
        //自适应高度
        //        [self autoFitHeight];
        self.scrollEnabled =YES;
//        //滚动到最后一行文字
        [self scrollRangeToVisible:NSMakeRange(self.text.length, 1)];
    }else if(self.text.length == 0){
        _placehoderLbl.hidden=(self.text.length != 0);
    _PlaceHoder_Image.hidden = (self.text.length!= 0);
        self.scrollEnabled =NO;
    }
}
-(void)addMasonry
{
    [self.PlaceHoder_Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(10.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(15.0f));
        make.width.offset(YY_ININPONE5_WITH(15.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(15.0f));
    }];
    [self.placehoderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(_PlaceHoder_Image.mas_right).offset(YY_ININPONE5_WITH(10.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(30.0f));
        make.rightMargin.equalTo(self.mas_right).offset(YY_ININPONE5_WITH(-30.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(7.0f));
    }];
}



#pragma mark 公开方法

- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    _placehoderLbl.textColor = placehoderColor;
}

#pragma mark 重写方法
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    _placehoderLbl.font=font;
    
}

/**
 *  直接给textField赋值时使用
 */
- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

@end
