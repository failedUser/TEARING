//
//  YY_content_table.m
//  LetsTeasing
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "YY_content_table.h"
#import "textCell.h"
#import "mainPageDictFordata.h"
#import "JCAlertView.h"
#define lengthForRow  19

@implementation YY_content_table

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
 
    [self data];
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.delegate =self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    return self;
}
//-(void)touchesBegan
//{
//    // self.Alert.hidden = y0(<#double#>)
//}

//tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comDict.count;
//    return _cellContent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"textCell";
    textCell * cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    
    if(cell == nil)
    {
        cell = [[textCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
    }
    if(cell.TextLabel.text != nil)
    {

        cell.TextLabel.text = @"";
    }
    //创建完字体格式之后就告诉cell
    NSString *str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
   _dicto = [_comDict objectForKey:str];
    cell.TextLabel.text = [_dicto objectForKey:@"saidWord"];
    cell.namelabel.text = [_dicto objectForKey:@"playerName"];
//    cell.TextLabel.text = _cellContent[indexPath.row];
    
//    cell.TextLabel.numberOfLines = ceilf(cell.TextLabel.text.length/19)+1;
    cell.TextLabel.numberOfLines =0;
    CGFloat  height = [self heightForString:cell.TextLabel andWidth:YY_ININPONE5_WITH(240.0f)];
    [cell.TextLabel setFrame:CGRectMake(YY_ININPONE5_WITH(10.0f), YY_ININPONE5_HEIGHT(5.0f) , YY_ININPONE5_WITH(240.0f), YY_ININPONE5_HEIGHT(height)+YY_ININPONE5_HEIGHT(20.0f))];
    //设置cell不能被选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Arial是字体的名字，他妈的不是给字体命名啊 我日
    UIFont * font = [UIFont fontWithName:@"Arial" size:13.0];
    UILabel * label = [[UILabel alloc]init];
    [label setFont:font];
    NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSMutableDictionary * dict1 = [_comDict objectForKey:str];
    label.text = [dict1 objectForKey:@"saidWord"];
//    label.text =_cellContent[indexPath.row];
//    label.numberOfLines = ceilf(label.text.length/19)+1;
    label.numberOfLines =0;
    //cell里面字显示不出来是因为cell的高度不够，等以后整体功能做好了再仔细修改
    CGFloat  height = [self heightForString:label andWidth:YY_ININPONE5_WITH(240.0f)];
    _heightTable = height+28;

    return YY_ININPONE5_HEIGHT(height)+YY_ININPONE5_HEIGHT(20.0f);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


//计算行高
- (NSInteger) heightForString:(UILabel *)textView andWidth:(float)width{
    
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    NSInteger height = sizeToFit.height;
    return height;
    
}
-(void)data
{
    _comminfo = [[commentInfo alloc]init];
    _comDict = [_comminfo neirong];
    
}
//直接给每条数据都建一张表


@end
