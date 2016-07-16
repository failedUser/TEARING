//
//  textCell.m
//  LetsTeasing
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "textCell.h"


@implementation textCell
//这个是被引用之后第一个加载的函数，返回self，即UItableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
      
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
     
        
        _dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 100, 15)];
        _namelabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 3, 50, 15)];
        _TextLabel = [[UILabel alloc]init];
        
        
//        NSString *dateString = [dateFormatter stringFromDate:currentDate];
//        _dataLabel.text =dateString;
        //需要顶端对其？？
  
        
        _namelabel.textColor = NANECOLOR;
        _dataLabel.textColor =[UIColor lightGrayColor];
       
        //修改字体的大小
        UIFont *newFont = [UIFont fontWithName:@"Arial" size:13.0];
        //创建完字体格式之后就告诉cell

        _TextLabel.font = newFont;
        _namelabel.font = newFont;
        _dataLabel.font = newFont;

        [self.contentView addSubview:_dataLabel];
        [self.contentView addSubview:_TextLabel];
        [self.contentView addSubview:_namelabel];
        
          [self autolayout];
    }
    return self;
}

-(void)autolayout
{
    [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(self.contentView.mas_leftMargin).offset(YY_ININPONE5_WITH(5.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(15.0f));
        make.width.offset(YY_ININPONE5_WITH(80.0f));
        make.topMargin.equalTo(self.contentView.mas_top).offset(YY_ININPONE5_HEIGHT(8.0f));
    }];
    
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(_dataLabel.mas_right).offset(YY_ININPONE5_WITH(8.0f));
        make.height.offset(YY_ININPONE5_HEIGHT(15.0f));
        make.width.offset(YY_ININPONE5_WITH(150.0f));
        make.topMargin.equalTo(self.mas_top).offset(YY_ININPONE5_HEIGHT(8.0f));
    }];
}



@end
