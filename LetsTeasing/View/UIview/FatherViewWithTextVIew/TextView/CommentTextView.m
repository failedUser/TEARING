//
//  CommentTextView.m
//  LetsTeasing
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "CommentTextView.h"
#define JQMainScreenSize [UIScreen mainScreen].bounds.size
#define JQPlacehoderPadding 8 //提示语与边框的距离(上下左)
#define NumberOfInputText 140
@implementation CommentTextView
-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;//允许autoLayout
        self.contentMode = UIViewContentModeCenter;
        self.textColor =UIColorFromHex(0xffffff);
        self.font = [UIFont fontWithName:@"Arial" size:15];
        self.delegate =self;
        //2.添加子控件
        [self addSubView];
        //        [self addimage];
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
    _placehoderLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 50, 30)];
    //->设置默认提示文字
    _placehoderLbl.text=(self.placeHoder.length>0?self.placeHoder:@"我来吐槽");
    //->默认字体 == textView字体
    _placehoderLbl.font=[UIFont fontWithName:@"Arial" size:13.0];
    //->设置默认字体透明度
    _placehoderLbl.alpha=0.8;
    //->提示框也可以多行
    _placehoderLbl.numberOfLines=0;
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
    [self.placehoderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.mas_left).offset(YY_ININPONE5_WITH(10.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(30.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(5.0f));
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"开始输入");
    return YES;
}

//键入Done时，插入换行符，然后执行addBookmark
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    //判断加上输入的字符，是否超过界限
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > NumberOfInputText)
    {
        textView.text = [textView.text substringToIndex:NumberOfInputText];
        return NO;
    }
    return YES;
}
/*由于联想输入的时候，函数textView:shouldChangeTextInRange:replacementText:无法判断字数，
 因此使用textViewDidChange对TextView里面的字数进行判断
 */
- (void)textViewDidChange:(UITextView *)textView
{//该判断用于联想输入
    if (textView.text.length > NumberOfInputText)
    {
        textView.text = [textView.text substringToIndex:NumberOfInputText];
    }
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(YY_ININPONE5_WITH(200.0f), MAXFLOAT)];
    NSInteger height = sizeToFit.height-5 ;
    NSLog(@"改变的高度是多少%li",(long)height);
    if (height<65) {
        CGRect frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, YY_ININPONE5_WITH(200.0f), height);
        self.frame =frame;
    }
    
    //得到TextView的高度
    //    if (self.text.length ==0) {
    //        height
    //    }
}


@end
