//
//  commentsTable.m
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "commentsTable.h"
#import "textCell.h"
#import "JCAlertView.h"
#import "mainPageDictFordata.h"

@implementation commentsTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    //    [self reloadData];
    
//    [self initDict];
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.delegate =self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return self;
}
//start notifition


//tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return _cellContent.count;
    return  _dict.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CMainCell = @"textCell";
    textCell *  cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    
    if(cell == nil)
    {
        cell = [[textCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
    }
    if(cell.TextLabel.text != nil)
    {

        cell.TextLabel.text = @"";
    }
    
    
    //创建完字体格式之后就告诉cell
    //    dict * data = [[dict alloc]init];
    //    NSMutableDictionary * dict = [data neirong];
    NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSMutableDictionary * dict1 = [_dict objectForKey:str];
//    cell.TextLabel.text = [dict1 objectForKey:@"saidWord"];
    cell.namelabel.text = [dict1 objectForKey:@"playerName"];
    //    cell.TextLabel.text = _cellContent[indexPath.row];
    cell.TextLabel.numberOfLines = 0;
    CGFloat  height = [self heightForString:cell.TextLabel andWidth:YY_ININPONE5_WITH(300.0f)];
    [cell.TextLabel setFrame:CGRectMake(YY_ININPONE5_WITH(10.0f), YY_ININPONE5_HEIGHT(18.0f) , YY_ININPONE5_WITH(300.0f), height)];
    //设置cell不能被选中
    cell.tag = 10010;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Arial是字体的名字，他妈的不是给字体命名啊 我日
    UIFont * font = [UIFont fontWithName:@"Arial" size:13.0];
    UILabel * label = [[UILabel alloc]init];
    [label setFont:font];
//    NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
//    NSMutableDictionary * dict1 = [_dict objectForKey:str];
//    label.text = [dict1 objectForKey:@"saidWord"];
    //    label.text =_cellContent[indexPath.row];
    label.numberOfLines = 0;
    label.autoresizingMask =YES;
    CGFloat  height = [self heightForString:label andWidth:YY_ININPONE5_WITH(300.0f)];
    _heightTable = YY_ININPONE5_HEIGHT(height)+YY_ININPONE5_HEIGHT(18.0f);
    return YY_ININPONE5_HEIGHT(height)+YY_ININPONE5_HEIGHT(18.0f);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)showAlertWithOneButton{
    
//    [JCAlertView showOneButtonWithTitle:@"XXX评论"];
    
}
//计算行高
- (NSInteger) heightForString:(UILabel *)textView andWidth:(float)width{
    
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    NSInteger height = sizeToFit.height;
    return height;
    
}
@end
