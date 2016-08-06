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
#import "View_for_Text.h"



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
        info = [commentInfo ShareCommentData];
    _dictWithPlist =[NSMutableDictionary dictionaryWithCapacity:100];
        [self writeDictIntoPlist];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(savedataInPlist) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    return self;
}
-(void)writeDictIntoPlist
{
    _plistMaindata = [plistWithCatchData shareMainDataPlist];
    _dictWithPlist= [_plistMaindata getdataDictfromPlist];
    if (_dictWithPlist==nil) {
        if (_data.dataDict.count>0) {
            NSMutableDictionary * dict = [info CommentCountWithEachsaidWord];
            [_plistMaindata writeTheContentfromDictIntoplist:dict];
        }
    }
    
}
//tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _Maindict.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CMainCell = @"textCell";
   textCell *  cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    
    if(cell == nil) cell = [[textCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
    if(cell.TextLabel.text != nil)  cell.TextLabel.text = @"";
    NSString * num = [NSString stringWithFormat:@"%lu",_Maindict.count-indexPath.row-1];
    dict1 = [_Maindict objectForKey:num];
    //给里面的评论个数传值传值
    [self setCount];
    NSInteger counbt = [[dict1 objectForKey:@"countOfComment"] integerValue];
    [cell setLabelText:counbt];
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
    NSLog(@"baseView函数中开始实例化数据--------------------------------");
    _data = [mainPageDictFordata shareMainData];
    _dict = _data.dataDict;
    if (_data.dataDict.count ==0) {
    _Maindict = [self changeBmobObject:_dictWithPlist];
        _dictOrObject =YES;
    }else
    {
        [_Maindict removeAllObjects];
        _Maindict = [info CommentCountWithEachsaidWord];
         _dictOrObject =NO;
    }
    
}
-(NSMutableDictionary *)changeBmobObject:(NSMutableDictionary *)mutDict
{
    NSMutableDictionary * MainResultDict = [NSMutableDictionary new];
    for (int i =0; i<mutDict.count; i++) {
        NSString * string  = [NSString stringWithFormat:@"%d",i];
        NSDictionary * dict = [mutDict objectForKey:string];
        BmobObject * obj = [[BmobObject alloc]initWithDictionary:dict];
        [obj setClassName:@"GameScore"];
        [MainResultDict setObject:obj forKey:string];
    }
    return MainResultDict;
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
   
    NSLog(@"在basetablez中开始刷新-------------------------------");
    [super reloadData];
    [info AlertDataReload];
    [self initDict];
    [self writeDictIntoPlist];
    //在这个地方对datadict 进行操作
 
//    if (_getString1>=0) {
//        [self refreshIndexCell:_getString1];
//    }
// 
   NSLog(@"在basetablez中刷新结束-------------------------------");
}
-(void)reloadDict
{
    [self initDict];
}
//-(void)refreshIndexCell:(NSInteger)getIndex
//{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:getIndex inSection:0];
//    textCell *cell = [self cellForRowAtIndexPath:indexPath];
////    NSNumber * num = [NSNumber numberWithInteger:_dict.count-indexPath.row-1];
//    NSString *num = [NSString stringWithFormat:@"%lu",_Maindict.count-indexPath.row-1];
//    NSDictionary* dict2 = [_Maindict objectForKey:num];
//    //给里面的评论个数传值传值
//    NSInteger COUNTT =[info Count:[dict2 objectForKey:@"objectId"]];
//    if (count>=1)[cell addhotCommentImage];
//    else if(count==0) [cell addCommentImage];
//    [cell setLabelText:COUNTT];
//
//    
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BmobObject * obj = [self.data.dataDict objectForKey:[NSNumber numberWithInteger:_dict.count-indexPath.row-1]];
        BmobObject * obj = [self.Maindict objectForKey:[NSString stringWithFormat:@"%lu",_dict.count-indexPath.row-1]];
    NSLog(@"点击的时候%@",obj);
    NSString * name = [obj objectForKey:@"playerName"];
    [self showAlertWithOneButton:[NSString stringWithFormat:@"%@的评论",name]index:indexPath.row];
    
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    if (self.Tdelegate && [self.Tdelegate respondsToSelector:@selector(BaseTableview:didSelectRowAtIndexPath:)]) {
        
        [self.Tdelegate BaseTableview:self didSelectRowAtIndexPath:path];
        
    }
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)showAlertWithOneButton:(NSString*)title index:(NSInteger)index{
    JCAlertView * alert = [[JCAlertView alloc]init];
    //这个里面要根据索引的内容生成了一个字典。
    BmobObject * dict =  [self.data creatNewClassFordata:_dict.count-index-1];

    if (index==0) {
        //        NSLog(@"传进来的名字%@",[dict objectForKey:@"playerName"]);
    }
    
    [alert showOneButtonWithTitle:title data:dict sendName:nil];
    [alert AerltViewReload];

    
}
-(void)savedataInPlist
{
    NSLog(@"Plist数据保存成功");
    [_plistMaindata writeTheContentfromDictIntoplist:_Maindict];
}

@end
