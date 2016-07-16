//
//  changeName.m
//  LetsTeasing
//
//  Created by apple on 16/7/6.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "changeName.h"
#import "Personal_centerViewController.h"

@interface changeName ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation changeName

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate =self;
    table.dataSource =self;
    [self.view addSubview:table];
    self.navigationItem.title = @"修改昵称";

//    self.view.backgroundColor = [UIColor colorWithRed:239 green:239 blue:244 alpha:1];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(changeDone)];

    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial" size:13.0],NSFontAttributeName, nil] forState:UIControlStateNormal];

}
-(void)changeDone
{
    NSString * str = [view.text copy];
    [self changeBackGroundid:@"UVTaKKKP" changeValueName:@"playerName" value:str];
    
    if (view.text.length != 0) {

        [self.navigationController  popViewControllerAnimated:YES];
    }
   
}
-(void)changeBackGroundid:(NSString *)bgid changeValueName:(NSString *) changeName1 value:(NSObject *)value
{
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:bgid block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                
                //设置cheatMode为YES
                [obj1 setObject:value forKey:changeName1];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    view =  [[UITextField alloc]initWithFrame:CGRectMake(0,0,320, 44)];
    
    view.placeholder = @"请修改昵称";
    view.font = [UIFont fontWithName:@"Arial" size:13];
    [cell addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(YY_ININPONE5_HEIGHT(44.0f));
        make.width.offset(YY_ININPONE5_WITH(320.0f));
    }];
    return  cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return YY_ININPONE5_HEIGHT(5.0f);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return YY_ININPONE5_HEIGHT(44.0f);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
