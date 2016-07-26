//
//  changeName.m
//  LetsTeasing
//
//  Created by apple on 16/7/6.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "changeName.h"
#import "Personal_centerViewController.h"

@interface changeName ()
{
    UITextField * changeNameField;
    UILabel *line;
}

@end

@implementation changeName

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   changeNameField =[[UITextField alloc]initWithFrame:CGRectMake(15, 64, 350, 44)];
    changeNameField.textColor =[UIColor lightGrayColor];
    changeNameField.font =[UIFont boldSystemFontOfSize:14];
    changeNameField.tintColor = UIColorFromHex(0x50d2c2);
    [changeNameField becomeFirstResponder];
    [self.view addSubview:changeNameField];
    
   line  = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, 340, 1)];
    line.backgroundColor =  UIColorFromHex(0xf3f3f4);
    
    [self.view addSubview:line];
    
    [changeNameField textRectForBounds:CGRectMake(0, 20, 300, 30)];
    [changeNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(YY_ININPONE6_HEIGHT(50.0f));
        make.topMargin.equalTo(self.view.mas_top).offset(70.0f);
        make.leftMargin.equalTo(self.view.mas_left).offset(YY_ININPONE6_WITH(25.0f));
             make.rightMargin.equalTo(self.view.mas_right).offset(YY_ININPONE6_WITH(-25.0f));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(YY_ININPONE5_HEIGHT(1.0f));
        make.topMargin.equalTo(self.view.mas_top).offset(YY_ININPONE6_HEIGHT(52.0f)+64.0f);
                make.leftMargin.equalTo(self.view.mas_left).offset(YY_ININPONE6_WITH(25.0f));
        make.rightMargin.equalTo(self.view.mas_right).offset(YY_ININPONE6_WITH(-25.0f));
    }];
    self.navigationItem.title = @"修改昵称";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_nav_arrow.png"] style:UIBarButtonItemStyleDone target:self action:@selector(comeBack)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(changeDone)];

    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x50d2c2),NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial" size:15.0],NSFontAttributeName, nil] forState:UIControlStateNormal];

}
-(void)comeBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changeDone
{
    NSString * str = [changeNameField.text copy];
    [self changeBackGroundid:@"UVTaKKKP" changeValueName:@"playerName" value:str];
    
    if (changeNameField.text.length != 0) {

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
