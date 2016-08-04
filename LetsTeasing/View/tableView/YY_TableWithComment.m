//
//  YY_TableWithComment.m
//  LetsTeasing
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "YY_TableWithComment.h"
#import "textCell.h"
#import "AlertTableCell.h"
#import "mainPageDictFordata.h"
#import "JCAlertView.h"
#import "MJRefresh.h"
#import "commentInfo.h"
#define lengthForRow  19
@implementation YY_TableWithComment

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    //    [self data];
  
    
    
//    [_comminfo AlertDataReload];
    self.backgroundColor = [UIColor whiteColor];
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.delegate =self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    //监听键盘状态进行刷新
//    [self addNotifincation];
         [self MJrefresh];
    
    _states =YES;
    return self;
}
-(void)beginRefinish
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
      NSLog(@"自动刷新了?");
    //编号有了数据也存进去，只是没有下载到数组中
    [self.comminfo commentReload];
    [self.comminfo AlertDataReload];
//    [self addNotifincation];
    [self data];
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
    
    if (comDict == nil) {

        return  1;
        
    }else {return comDict.count+1;}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {

        NSLog(@"it is the first row");
        textCell * cell = [[textCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textCell"];
        [self setCount];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setLabelText:count];
        NSString * dateStr = [_getBmobObject objectForKey:@"createdAt"];
        NSString * cut  = [dateStr substringFromIndex:10];
        cell.TextLabel.text = [_getBmobObject objectForKey:@"saidWord"];
        cell.namelabel.text = [_getBmobObject objectForKey:@"playerName"];
        cell.dataLabel.text = cut;
            if (cell.TextLabel.text != nil) heightForTextLabel = [cell height];
        return cell;
    }
    else
    {
    static NSString *CMainCell = @"AlertTableCell";
    AlertTableCell  * cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    
    if(cell == nil) cell = [[AlertTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(cell.TextLabel.text != nil)cell.TextLabel.text = @"";
            if (comDict ==nil) {
                //创建完字体格式之后就告诉cell
                NSLog(@" no data");
            }else{
                _dicto = comDict[indexPath.row-1];
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _heightTable = YY_ININPONE5_HEIGHT(heightForTextLabel)+YY_ININPONE5_HEIGHT(18.0f);
    if (indexPath.row ==0) {
          return YY_ININPONE5_HEIGHT(heightForTextLabel)+YY_ININPONE5_HEIGHT(60.0f);
    }else
    {
    return YY_ININPONE5_HEIGHT(heightForTextLabel)+YY_ININPONE5_HEIGHT(40.0f);
    }
    
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
    _comminfo = [commentInfo ShareCommentData];
    //interface for data
    comDict = [NSMutableArray arrayWithCapacity:1000];
    //这个地方应该返回数组
    [_comminfo AlertDataReload];
    [_comminfo commentReload];
    NSLog(@"id ====%@",[_getBmobObject objectForKey:@"objectId"]);
    NSLog(@"how many%lu",(unsigned long)_comminfo.CommentResuluDict.count);
   comDict = [_comminfo.CommentResuluDict  objectForKey:[_getBmobObject objectForKey:@"objectId"]];
    if (comDict ==nil) {
        comDict =nil;
    }else  {
    }
    
}
-(void)setCount
{
    count = [_comminfo Count:[_getBmobObject objectForKey:@"objectId"]];
}
-(NSNumber *)returnCount
{
    NSNumber * number = [NSNumber numberWithInteger:_comminfo.Comment_DICT.count];
    return  number;
}
-(void)reloadData
{
    [super reloadData];
//    [_comminfo AlertDataReload];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:comDict.count inSection:0];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)addNewComment:(BmobObject *)OBject
{
    [comDict addObject:OBject];
}
@end
