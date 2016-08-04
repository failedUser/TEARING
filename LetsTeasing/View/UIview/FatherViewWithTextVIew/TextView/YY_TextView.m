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
#define NumberOfInputText 140
@implementation YY_TextView
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
    //->设置默认字体颜色
   
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
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(YY_ININPONE5_WITH(250.0f), MAXFLOAT)];
    NSInteger height = sizeToFit.height-5 ;
    NSLog(@"改变的高度是多少%li",(long)height);
    if (height<81) {
        CGRect frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, YY_ININPONE5_WITH(250.0f), height);
        self.frame =frame;
    }

    //得到TextView的高度
//    if (self.text.length ==0) {
//        height
//    }
}



//
//- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;
//{
//    //
//    //    NSLog(@"行高  ＝ %f container = %@,xxx = %f",self.textview.font.lineHeight,self.textview.textContainer,self.textview.textContainer.lineFragmentPadding);
//    //
//    //实际textView显示时我们设定的宽
//    CGFloat contentWidth = CGRectGetWidth(textView.frame);
//    //但事实上内容需要除去显示的边框值
//    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
//                            + textView.textContainerInset.left
//                            + textView.textContainerInset.right
//                            + textView.textContainer.lineFragmentPadding/*左边距*/
//                            + textView.textContainer.lineFragmentPadding/*右边距*/);
//    
//    CGFloat broadHeight  = (textView.contentInset.top
//                            + textView.contentInset.bottom
//                            + textView.textContainerInset.top
//                            + textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
//    
//    //由于求的是普通字符串产生的Rect来适应textView的宽
//    contentWidth -= broadWith;
//    
//    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
//    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
//    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
//    
//    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
//    
//    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
//    return adjustedSize;
//}
//
//- (void)refreshTextViewSize:(UITextView *)textView
//{
//    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
//    CGRect frame = textView.frame;
//    frame.size.height = size.height;
//    textView.frame = frame;
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
// replacementText:(NSString *)text
//{
//    //对于退格删除键开放限制
//    if (text.length == 0) {
//        return YES;
//    }
//    
//    UITextRange *selectedRange = [textView markedTextRange];
//    //获取高亮部分
//    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
//    //获取高亮部分内容
//    //NSString * selectedtext = [textView textInRange:selectedRange];
//    
//    //如果有高亮且当前字数开始位置小于最大限制时允许输入
//    if (selectedRange && pos) {
//        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
//        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
//        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
//        
//        if (offsetRange.location < NumberOfInputText) {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
//    }
//    
//    
//    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    
//    NSInteger caninputlen = NumberOfInputText - comcatstr.length;
//    
//    if (caninputlen >= 0)
//    {
//        //加入动态计算高度
//        CGSize size = [self getStringRectInTextView:comcatstr InTextView:textView];
//        CGRect frame = textView.frame;
//        frame.size.height = size.height;
//        
//        textView.frame = frame;
//        return YES;
//    }
//    else
//    {
//        NSInteger len = text.length + caninputlen;
//        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
//        NSRange rg = {0,MAX(len,0)};
//        
//        if (rg.length > 0)
//        {
//            NSString *s = @"";
//            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
//            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
//            if (asc) {
//                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
//            }
//            else
//            {
//                __block NSInteger idx = 0;
//                __block NSString  *trimString = @"";//截取出的字串
//                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
//                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
//                                         options:NSStringEnumerationByComposedCharacterSequences
//                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
//                                          
//                                          NSInteger steplen = substring.length;
//                                          if (idx >= rg.length) {
//                                              *stop = YES; //取出所需要就break，提高效率
//                                              return ;
//                                          }
//                                          
//                                          trimString = [trimString stringByAppendingString:substring];
//                                          
//                                          idx = idx + steplen;
//                                      }];
//                
//                s = trimString;
//            }
//            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
//            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
//            
//            //由于后面反回的是NO不触发didchange
//            [self refreshTextViewSize:textView];
//            //既然是超出部分截取了，哪一定是最大限制了。
////            self.text = [NSString stringWithFormat:@"%d/%ld",0,(long)NumberOfInputText];
//        }
//        return NO;
//    }
//    
//}
//
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//     _textHeight = self.frame.size.height;
//    UITextRange *selectedRange = [textView markedTextRange];
//    //获取高亮部分
//    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
//    
//    //如果在变化中是高亮部分在变，就不要计算字符了
//    if (selectedRange && pos) {
//        return;
//    }
//    
//    NSString  *nsTextContent = textView.text;
//    NSInteger existTextNum = nsTextContent.length;
//    
//    if (existTextNum > NumberOfInputText)
//    {
//        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
//        NSString *s = [nsTextContent substringToIndex:NumberOfInputText];
//        
//        [textView setText:s];
//    }
//    
//    //不让显示负数 口口日
////    self.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,NumberOfInputText - existTextNum),NumberOfInputText];
//    
//    [self refreshTextViewSize:textView];
//}
@end
