//
//  operation.m
//  PTT
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "operation.h"
#import "BmobSDK/Bmob.h"


@implementation operation

//添加数据
-(void)baocunshuju:(NSString *)Name userage:(id) age
{
    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
    [gameScore setObject:Name forKey:@"playerName"];
    [gameScore setObject:age forKey:@"score"];
    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
       if(error)
       {
           NSLog(@"数据保存失败");
       }else
       {
           NSLog(@"数据保存成功");
       }
    }];

}
//得到某行数据
-(void)getData:(NSString *)bgId conString:(NSString *) contring
{
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    //查找GameScore表里面id为0c6db13c的数据
    bgId = @"UVTaKKKP";
    [bquery getObjectInBackgroundWithId:bgId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
             
                NSString* string = [object objectForKey:@"playerName"];
                
                NSLog(@"%@",string);
//                [self getstring:string];
            }
        }
    }];
    
   
}

//-(NSString *)getstring:(NSString *)string
//{
//    
//    _className =string;
//    NSLog(@"得到的string%@",_className);
//    return string;
//}
-(void)changeBackGroundid:(NSString *)bgid changeValueName:(NSString *) changeName value:(NSObject *)value
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
                [obj1 setObject:value forKey:changeName];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}
-(void)del:(NSString *)delName
{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    [bquery getObjectInBackgroundWithId:delName block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
            }
        }
    }];
}

@end
