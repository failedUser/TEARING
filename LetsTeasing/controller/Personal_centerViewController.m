//
//  Personal_centerViewController.m
//  LetsTeasing
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "Personal_centerViewController.h"
#import "changeName.h"
#import "MJRefresh.h"
#define heigdtforSection (10.0f/568.0f)*SCREEN_HEIGHT
#define HeightforCell YY_ININPONE5_HEIGHT(44.0f)

@interface Personal_centerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray * List_name1;
    NSArray * List_name2;
    NSArray * List_name3;
    NSArray * Array_section;
    UITableView  * person_tabV;
    UISwitch * Switch;
  
}

@end

@implementation Personal_centerViewController
-(void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear: animated];
    // 马上进入刷新状态

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_arrow.png"] style:UIBarButtonItemStyleDone target:self action:@selector(comeBack)];
    //导航栏左边按钮颜色
    [person_tabV.mj_header beginRefreshing];
    
}
-(void)comeBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
   // 或
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）

    
  
    
    self.navigationItem.title = @"我";
    List_name1 = [NSArray arrayWithObjects:@"昵称", nil];
    List_name2 = [NSArray arrayWithObjects:@"消息推送",@"个性化", nil];
    List_name3 = [NSArray arrayWithObjects:@"给个好评",@"帮助",@"关于", nil];
    Array_section = [NSArray arrayWithObjects:List_name1,List_name2,List_name3, nil];
    person_tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
       person_tabV.separatorStyle = UITableViewCellSelectionStyleNone;
    person_tabV.backgroundColor = [UIColor whiteColor];
//    person_tabV = UITableViewCellSeparatorStyleNone;
    //下拉刷新
       MJRefreshHeader * header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    header.automaticallyChangeAlpha =YES;

    
    
    person_tabV.mj_header = header;
    person_tabV.delegate = self;
    person_tabV.dataSource = self;
    
    
//    person_tabV.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view  addSubview:person_tabV];
    [self addLogOutButton:person_tabV];
}
//下来刷新
-(void)refresh
{
    [self getDAta];
    sleep(0.5);
    [person_tabV.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 2;
    }else if(section == 2){
        return 3;
    }else
    {
        return 0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellname = @"perCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname ];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    //创建字体一定要在值的前面，要不然已经取值之后无法修改
    UIFont *newFont = [UIFont fontWithName:@"Arial" size:13.0];
    //创建完字体格式之后就告诉cell
    cell.textLabel.font = newFont;
    //获取cell当前section的数组
    NSArray * list = Array_section[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    
    if(indexPath.section == 1)
    {
        [self addbutton:cell button:Switch];
    }else if(indexPath.section == 0||indexPath.section == 2)
    {
        if (indexPath.section == 0) {
            [self addNameLabel:cell];
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.tintColor = [UIColor redColor];
        
        
  
    }
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(YY_ININPONE5_WITH(16.0f), HeightforCell-2,YY_ININPONE5_HEIGHT(280.0f), 1)];
    line.backgroundColor =  UIColorFromHex(0xf3f3f4);
    //        line.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:line];
    return cell;
}
-(void)addNameLabel:(UITableViewCell *)cell
{
    _self_Name_lbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 180, HeightforCell)];
    [self getDAta];
    _self_Name_lbl.textAlignment = NSTextAlignmentRight;
    _self_Name_lbl.backgroundColor= [UIColor whiteColor];
    _self_Name_lbl.tintColor = [UIColor grayColor];
    _self_Name_lbl.font = [UIFont fontWithName:@"Arial" size:13];
    [cell.contentView addSubview:_self_Name_lbl];

    [_self_Name_lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(HeightforCell);

        make.rightMargin.equalTo(cell.contentView.mas_right).offset(YY_ININPONE5_WITH(-30.0f));
        make.width.offset(YY_ININPONE5_WITH(180.0f));
        
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return heigdtforSection*2;
    else if (section == 1)
        return heigdtforSection;
    else if (section == 2)
        return heigdtforSection;
    return  0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
        return heigdtforSection;
    else if (section == 1)
        return heigdtforSection;
    else if (section == 2)
        return heigdtforSection;
    return  0;
    
}
//添加switch
-(void)addbutton:(UITableViewCell *) cell1 button:(UISwitch *)Switch1
{
    Switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(YY_ININPONE5_WITH(270.0f),YY_ININPONE5_HEIGHT(7.0f), YY_ININPONE5_WITH(10.0f), YY_ININPONE5_HEIGHT(15.0f))];
    [Switch1 setOn:YES animated:YES];

    [Switch1 setOnTintColor:UIColorFromHex(0x50d2c2)];
    Switch1.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [cell1 addSubview:Switch1];
//    
//    [Switch1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.offset(YY_ININPONE5_HEIGHT(15.0f));
//        make.leftMargin.equalTo(cell1.mas_left).offset(YY_ININPONE5_WITH(280.0f));
//        make.topMargin.equalTo(cell1.mas_top).offset(YY_ININPONE5_HEIGHT(15.0f));
//        make.width.offset(YY_ININPONE5_WITH(10.0f));
//        
//        
//    }];
    
}
//需要写事件
-(void)addLogOutButton:(UITableView * ) tableview
{
    UIButton* logOut = [[UIButton alloc]initWithFrame:CGRectMake(0, 320, 320, 44)];
    [logOut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    logOut.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    logOut.titleLabel.textAlignment = NSTextAlignmentCenter;
    logOut.backgroundColor = UIColorFromHex(0x313131);
    [logOut setTitleColor:UIColorFromHex(0x50d2c2) forState:UIControlStateNormal];
    [logOut setTitle:@"退出当前登录" forState:(UIControlStateNormal)];



    [tableview addSubview:logOut];
    [logOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(YY_ININPONE5_HEIGHT(44.0f));
        make.topMargin.equalTo(tableview.mas_top).offset(YY_ININPONE5_HEIGHT(35.0f)*6+heigdtforSection*5+YY_ININPONE5_HEIGHT(100.0f));
        make.width.offset(YY_ININPONE5_WITH(320.0f));

    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HeightforCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
//查询获得数据
-(void)getData:(NSString *)bgId conString:(NSString *) contring
{
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    //查找GameScore表里面id为0c6db13c的数据
//    bgId = @"UVTaKKKP";
    [bquery getObjectInBackgroundWithId:bgId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                
                NSString* string = [object objectForKey:@"playerName"];
                [self getString:string];
            }
        }
    }];
    
    
}
-(void)getDAta
{
        [self getData:@"a5f5759fb4" conString:@"playerName"];
}
-(void)getString:(NSString*) string
{
    _self_Name_lbl.text= string;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
     
        changeName * view = [[changeName alloc]init];
        
        [self.navigationController pushViewController:view animated:YES];
    }
       [person_tabV deselectRowAtIndexPath:indexPath animated:NO];

}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 )
    {
        return NO;
    }
    return YES;
}


@end
