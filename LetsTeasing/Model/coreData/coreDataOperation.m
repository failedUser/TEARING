//
//  coreDataOperation.m
//  LetsTeasing
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "coreDataOperation.h"
#import "coreDataModel.h"
@implementation coreDataOperation
@synthesize mainData;
-(instancetype)init
{
    self = [super init];
    _dataDict = [NSMutableDictionary dictionaryWithCapacity:100];
//       context = [[coreDataModel shareShenmugui] context];
    coreDataModel * model = [[coreDataModel alloc]init];
   Maincontext= model.context ;

    return self;
}

//}
-(void)insertMainData:(BmobObject*)dict
{

    //我不知道是不是可以这样调用属性，但是至今没有报错
    //获取上下文
    //单例只调用一次导致上面的循环只能执行一次，这就尴尬了
//    //构建实体对象
//
//    mainData  = [NSEntityDescription insertNewObjectForEntityForName:@"MainPageData" inManagedObjectContext:Maincontext];
//    mainData.playerName = [dict objectForKey:@"playerName"];
//    mainData.numberOfSaidWords = [dict objectForKey:@"numberOfSaidWords"];
//    mainData.saidWord = [dict objectForKey:@"saidWord"];
//    mainData.objectId = [dict objectForKey:@"objectId"];

    [_dataDict setObject:dict forKey:[dict objectForKey:@"numberOfSaidWords"]];

}

//查询
-(void)fetchdata
{

    //获取上下文
    //    NSManagedObjectContext * context =[[shenmegui shareShenmugui] context];
    //构建抓取请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MainPageData"];
    //格局指定要求查询
    //其实不用自动返回数组，可以无缝转换为数组
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"playerName" ascending:YES];
    NSSortDescriptor * sort1 = [NSSortDescriptor sortDescriptorWithKey:@"saidWord" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort1];
    request.sortDescriptors =[NSArray arrayWithObject:sort];
    //    NSMutableArray * ary = [NSMutableArray arrayWithObject:sort];
    //    [request setSortDescriptors:ary];
    //一定要注意方法之前用的executeRequest，害死我了
    NSArray * ArrayMainData = [Maincontext executeFetchRequest:request error:nil];
    for (mainData in ArrayMainData) {
        NSLog(@"%@",mainData.numberOfSaidWords);
        NSLog(@"%@",mainData.playerName);
    }
}
-(void)countStudent
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MainPageData"];
    request.predicate =[NSPredicate predicateWithFormat:@"age>15"];
    request.resultType = NSCountResultType;
    
    NSError *error ;
    NSArray * entries = [Maincontext executeFetchRequest:request error:&error];
    //吧下面id属性的格式转化为integer
    NSInteger count = [entries.firstObject integerValue];
    if (error) {
    }else
    {NSLog(@"%ld",(long)count);
        
        
    }
}
//这个是失败的，等会再解决
-(void)pingjunshu
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MainPageData"];
    //返回结果为字典
    request.resultType = NSDictionaryResultType;
    //构建表达式
    NSExpressionDescription * description = [[NSExpressionDescription alloc]init]; ;
    description.name = @"AverageAge";
    NSExpression *  args = [NSExpression  expressionForKeyPath:@"name"];
    description.expression  =[NSExpression expressionForFunction:@"average:" arguments:[NSArray arrayWithObject:args]];
    
    description.expressionResultType = NSFloatAttributeType;//指定返回值类型
    request.propertiesToFetch = [NSArray arrayWithObject:description];
    NSError *error ;
    NSArray * entries = [Maincontext executeFetchRequest:request error:&error];
    //吧下面id属性的格式转化为integer
    NSDictionary* dict = entries.firstObject;

    id count = dict[@"AverageAge"];
    if (error) {

    }else{
        NSLog(@"%@",count);
    }
}
-(void)changeValue
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"age>15"];
    NSArray<MainPageData *> * students = [Maincontext executeFetchRequest:request error:nil];
    for (mainData in students) {
        mainData.playerName = @"yueyin";
        
    }
    //运行这个之后就直接中断了
    //    [[shenmegui shareShenmugui] saveContext];
    
}
-(void)deleteValue
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"age>15"];
    //students是一个保存对象的数组
    NSArray<MainPageData *> * students = [Maincontext executeFetchRequest:request error:nil];
    for (mainData in students) {
        [Maincontext deleteObject:mainData];
    }

    
}
//添加数据
-(void)baocunshuju:(BmobObject*)dict
{
    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
    [gameScore setObject:[dict objectForKey:@"playerName"] forKey:@"playerName"];
    [gameScore setObject:[dict objectForKey:@"saidWord"] forKey:@"saidWord"];
    [gameScore setObject:[dict objectForKey:@"numberOfSaidWords"] forKey:@"numberOfSaidWords"];

    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [gameScore setObject:[dict objectForKey:@"states"] forKey:@"states"];
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
-(void)addSubObject:(BmobObject *)obj number:(NSInteger)numb
{
    NSString * str = [NSString stringWithFormat:@"%ld",numb];
    [mainData setValue:obj forKey:str];
}

@end
