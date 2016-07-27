//
//  YY_base_table.m
//  LetsTeasing
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "YY_base_table.h"
#import "textCell.h"
#import "JCAlertView.h"
#import "mainPageDictFordata.h"



@implementation YY_base_table
+(YY_base_table *)shareBaseTable
{
    static YY_base_table *BaseTable = nil;
    if (!BaseTable) {
        BaseTable = [[YY_base_table alloc]init];
    }
    return  BaseTable;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    [self initDict];
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.delegate =self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self reloadData];
    return self;
}

//tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dict.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CMainCell = @"textCell";
   textCell *  cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    
    if(cell == nil) cell = [[textCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
    if(cell.TextLabel.text != nil)  cell.TextLabel.text = @"";

    NSNumber * num = [NSNumber numberWithInteger:_dict.count-indexPath.row-1];
    dict1 = [_dict objectForKey:num];
    //给里面的评论个数传值传值
    [self setCount];
//    if (count>=1)[cell addhotCommentImage];
//        
//    else if(count==0) [cell addCommentImage];
    
    [cell setLabelText:count];
    
    NSString * dateStr = [dict1 objectForKey:@"createdAt"];
    NSString * cut  = [dateStr substringFromIndex:10];
    
    cell.TextLabel.text = [dict1 objectForKey:@"saidWord"];
    cell.namelabel.text = [dict1 objectForKey:@"playerName"];
    cell.dataLabel.text = cut;
    cell.TextLabel.numberOfLines = 0;
    
    //自适应textview的高度
    if (cell.TextLabel.text != nil) heightForTextLavbel = [cell height];
    else NSLog(@"主页面中说的话为空");
    return cell;
}
-(void)setCount
{
    count = [info Count:[dict1 objectForKey:@"objectId"]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _heightTable = YY_ININPONE5_HEIGHT(heightForTextLavbel)+YY_ININPONE5_HEIGHT(18.0f);
    return YY_ININPONE5_HEIGHT(heightForTextLavbel)+YY_ININPONE5_HEIGHT(55.0f);

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void )initDict
{
    _data = [mainPageDictFordata shareMainData];
    _dict = _data.dataDict;
        [_data MainreloadData];
}

//计算行高
- (NSInteger)heightForString:(UILabel *)textView andWidth:(float)width{
    
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    NSInteger height = sizeToFit.height;
    
    
    return height;
}
//这是行间距

-(void)reloadData
{
   
    [super reloadData];
    [info AlertDataReload];
    [_data MainreloadData];
    info = [commentInfo ShareCommentData];
    if (_getString1>=0) {
        NSLog(@"从alert传进来的数%ld", (long)_getString1);
        [self refreshIndexCell:_getString1];
    }
  
}
-(void)refreshIndexCell:(NSInteger)getIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:getIndex inSection:0];
    textCell *cell = [self cellForRowAtIndexPath:indexPath];
    NSNumber * num = [NSNumber numberWithInteger:_dict.count-indexPath.row-1];
    BmobObject* dict2 = [_dict objectForKey:num];
    //给里面的评论个数传值传值
    NSInteger COUNTT =[info Count:[dict2 objectForKey:@"objectId"]];
    if (count>=1)[cell addhotCommentImage];
    else if(count==0) [cell addCommentImage];
    [cell setLabelText:COUNTT];

    
}
@end
