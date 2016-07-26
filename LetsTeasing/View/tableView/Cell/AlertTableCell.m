//
//  AlertTableCell.m
//  LetsTeasing
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "AlertTableCell.h"
#define topMerge  YY_ININPONE5_HEIGHT(15.0f)
#define ImagetopMerge  YY_ININPONE5_HEIGHT(18.0f)
#define leftMerge YY_ININPONE5_WITH(30.0f)
#define WithForTextLabel YY_ININPONE5_WITH(220.0f)

@implementation AlertTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //        _Count = 114;
        //        NSDate *currentDate = [NSDate date];//获取当前时间，日
        _dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 100, 15)];
        _namelabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 3, 50, 15)];
        _TextLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(30, 50, 280, 0)];
        _line_label = [[UILabel  alloc]initWithFrame:CGRectMake(0, 50, 320, 1)];
        
        
        _TextLabel.numberOfLines = 0;
        _TextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _TextLabel.lineSpacing = 6;//设置行间距tttLabel.font = [UIFont systemFontOfSize:12];
        
        
        
        _namelabel.textColor = UIColorFromHex(0x6e6e70);
        _dataLabel.textColor =UIColorFromHex(0x8a8a8f);
        _TextLabel.textColor =UIColorFromHex(0x1d1d26);
        
        _line_label.backgroundColor = UIColorFromHex(0xf3f3f4);
        //创建完字体格式之后就告诉cell
        
        _TextLabel.font = YYSYSTEM_FONT;
        _namelabel.font = YYSYSTEM_FONT;
        _dataLabel.font = YYSYSTEM_FONT;
        
        
        _dataLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_dataLabel];
        [self.contentView addSubview:_TextLabel];
        [self.contentView addSubview:_namelabel];
        [self.contentView addSubview:_line_label];
        [self autolayout];
    }
    return self;
}

-(void)autolayout
{

    
    [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(YY_ININPONE5_WITH(80.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(13.0f));
        make.topMargin.equalTo(self.contentView.mas_top).offset(topMerge);
        make.rightMargin.equalTo(self.contentView.mas_right).offset(YY_ININPONE5_HEIGHT(-20.0f));
    }];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.contentView.mas_leftMargin).offset(leftMerge);
        make.height.offset(YY_ININPONE5_HEIGHT(15.0f));
        make.width.offset(YY_ININPONE5_WITH(150.0f));
        make.topMargin.equalTo(self.contentView.mas_top).offset(topMerge);
    }];
    
    [_TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.contentView.mas_leftMargin).offset(leftMerge);
        make.width.offset(WithForTextLabel);
        make.topMargin.equalTo(self.contentView.mas_top).offset(YY_ININPONE5_HEIGHT(40.0f));
    }];
    
    [_line_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(YY_ININPONE5_WITH(320.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(1.0f));
        make.top.equalTo(self.contentView.mas_bottom).offset(YY_ININPONE5_HEIGHT(-1.0f));
    }];
}

-(CGFloat)height
{
    //    NSString *str = @"UILabel自定义行间距时获取高度,UILabel自定义行间距时获取高度,UILabel自定义行间距时获取高度,UILabel自定义行间距时获取高度,UILabel自定义行间距时获取高度,UILabel自定义行间距时获取高度,UILabel自定义行间距时获取高度.";
    NSString *str = _TextLabel.text;
    //创建tttLabelTTTAttributedLabel *tttLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(30, 55, 300, 100)];
    
    //设置行数为0[tttLabel setText:str];
    _TextLabel.textAlignment = NSTextAlignmentLeft;
    //获取tttLabel的高度
    //先通过NSMutableAttributedString设置和上面tttLabel一样的属性,例如行间距,字体
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    //自定义str和TTTAttributedLabel一样的行间距
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrapStyle setLineSpacing:6];
    //设置行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, str.length)];
    //设置字体
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, str.length)];
    //得到自定义行间距的UILabel的高度
    //CGSizeMake(300,MAXFLOAt)中的300,代表是UILable控件的宽度,它和初始化TTTAttributedLabel的宽度是一样的.
    CGFloat height = [TTTAttributedLabel sizeThatFitsAttributedString:attrString withConstraints:CGSizeMake(WithForTextLabel, MAXFLOAT) limitedToNumberOfLines:0].height;
    //重新改变tttLabel的frame高度
    CGRect rect = _TextLabel.frame;
    rect.size.height = height;
    _TextLabel.frame = rect;
    return rect.size.height;
}


@end
