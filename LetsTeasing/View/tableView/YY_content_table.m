//
//  YY_content_table.m
//  LetsTeasing
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "YY_content_table.h"
#import "textCell.h"
#import "AlertTableCell.h"
#import "mainPageDictFordata.h"
#import "JCAlertView.h"
#import "MJRefresh.h"
#import "alertTableCellUser.h"
#define lengthForRow  19

@implementation YY_content_table

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
 
//    [self data];
    [self.mj_footer beginRefreshing];
    _comminfo = [commentInfo ShareCommentData];
    [_comminfo AlertDataReload];
    self.backgroundColor = [UIColor whiteColor];
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.delegate =self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor whiteColor];
 
    //监听键盘状态进行刷新
    [self addNotifincation];
    
    _states =YES;
       [self MJrefresh];
    return self;
}
-(void)addNotifincation
{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDown) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardWillDown
{
    [self.mj_footer beginRefreshing];
}
-(void)MJrefresh
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(refresh1)];
    self.mj_footer = footer;
    self.mj_footer.automaticallyChangeAlpha =YES;
    [footer setTitle:@"一大波吐槽正在赶来" forState:MJRefreshStateRefreshing];
    footer.stateLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    footer.stateLabel.textColor = UIColorFromHex(0x50d2c2);
}
-(void)refresh1
{
  
    //编号有了数据也存进去，只是没有下载到数组中
    [self.comminfo commentReload];
    [self.comminfo AlertDataReload];
    [self addNotifincation];
    [self dataforName];
    sleep(0.5);
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
 
    static NSString *CMainCell = @"AlertTableCell";
   alertTableCellUser  * cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    
    if(cell == nil) cell = [[alertTableCellUser alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell.TextLabel.text != nil)cell.TextLabel.text = @"";
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
    //自适应高度
    if (cell.TextLabel.text != nil) heightForTextLabel = [cell height];
    else NSLog(@"主页面中说的话为空");
    //设置cell不能被选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _heightTable = YY_ININPONE5_HEIGHT(heightForTextLabel)+YY_ININPONE5_HEIGHT(18.0f);
    return YY_ININPONE5_HEIGHT(heightForTextLabel)+YY_ININPONE5_HEIGHT(40.0f);
    
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
//-(void)data
//{
//    [_comminfo setCommentID:_commenID];
//    NSLog(@"穿进去的这个东西%@",_commenID);
//    //interface for data
//    comDict = [NSMutableArray arrayWithCapacity:1000];
//    //这个地方应该返回数组
//    [_comminfo AlertDataReload];
//   comDict = [_comminfo getDataForRow];
//    if (comDict ==nil) {
//        NSLog(@"里面没有值");
//            comDict =nil;
//    }else  {;
//
//    }
//
//}
-(void)dataforName
{
      comDict = [NSMutableArray arrayWithCapacity:100];
    comDict = [_comminfo dictWithName:_commenName];

}
-(NSNumber *)returnCount
{
    NSNumber * number = [NSNumber numberWithInteger:_comminfo.Comment_DICT.count];
    return  number;
}
-(void)reloadData
{
    [super reloadData];
    [_comminfo AlertDataReload];
}
@end
