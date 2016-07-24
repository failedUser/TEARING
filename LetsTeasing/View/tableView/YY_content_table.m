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
#import "MJRefresh.h"
#define lengthForRow  19

@implementation YY_content_table

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
 
//    [self data];
    [self.mj_footer beginRefreshing];
      _comminfo = [[commentInfo alloc]init];

    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.delegate =self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self MJrefresh];
    //监听键盘状态进行刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDown) name:UIKeyboardWillHideNotification object:nil];
    return self;
}
-(void)keyboardWillDown
{
    [self.mj_footer beginRefreshing];
}
-(void)MJrefresh
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refresh1)];
    self.mj_footer.automaticallyChangeAlpha =YES;
}
-(void)refresh1
{
//    NSLog(@"刷新");
    //编号有了数据也存进去，只是没有下载到数组中
    sleep(0.5);
    //    NSLog(@"这下有多少个元素%ld",_yy_table.data.dataDict.count);
    [self.comminfo commentReload];
    [self.comminfo AlertDataReload];
//    [self data];
    [self reloadData];

    [self.mj_footer endRefreshing];
    
    
}
//tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

//    NSLog(@"在给cell数目赋值的时候有多少个%lu",(unsigned long)comDict.count);
    if (comDict == nil) {
//        NSLog(@"table里面的内容是空的");
        return  0;
        
    }else {return comDict.count;}
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
        if (comDict ==nil) {
            //创建完字体格式之后就告诉cell
    

        NSLog(@" no data");
    }else{
        _dicto = comDict[indexPath.row];
        NSString * dateStr = [_dicto objectForKey:@"createdAt"];
        NSString * cut  = [dateStr substringFromIndex:10];
    cell.TextLabel.text = [_dicto objectForKey:@"saidWord"];
    cell.namelabel.text = [_dicto objectForKey:@"playerName"];
        cell.dataLabel.text =cut;
    }
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

    BmobObject * dict1 = comDict[indexPath.row];
    if (dict1 ==nil) {
        
    }else label.text = [dict1 objectForKey:@"saidWord"];
   

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
    //为什么有你就不行

    [_comminfo setCommentID:_commenID];
    //interface for data
    comDict = [NSMutableArray arrayWithCapacity:100];
    //这个地方应该返回数组
   comDict = [_comminfo getDataForRow];

    if (comDict.count == 0) {
        NSLog(@"里面没有值");
            comDict =nil;
//        NSLog(@"赋值的字典里面有多少个元素%lu",(unsigned long)comDict.count);
    }else  {;

    }

}
-(void)dataforName:(NSString*)name
{
      comDict = [NSMutableArray arrayWithCapacity:100];
    comDict = [_comminfo dictWithName:name];

}
-(NSNumber *)returnCount
{
    NSNumber * number = [NSNumber numberWithInteger:_comminfo.Comment_DICT.count];
//    NSLog(@"返回的numb值%@",number);
    return  number;
}



@end
