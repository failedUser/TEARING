//
//  dict.m
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "mainPageDictFordata.h"
#import "MainPageData.h"
#import "commentInfo.h"

@implementation mainPageDictFordata
@synthesize saidWordForName;
+(mainPageDictFordata *)shareMainData
{
    static mainPageDictFordata *MainData = nil;
    if (!MainData) {
        MainData = [[mainPageDictFordata alloc]init];
    }
    return  MainData;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self getObjectFromBomob];
//        [self writeDictIntoPlist];

    }
    return  self;
}


-(NSInteger)numberOfUnReadNews:(NSMutableDictionary *)dict
{
    NSInteger  num = 0;
    
    for (int i =0; i<= dict.count; i++) {
        NSString * str = [NSString stringWithFormat:@"%d",i];
        NSMutableDictionary * dict = [_DICT objectForKey:str];
        if ([[dict objectForKey:@"states"]  isEqual: @"NO"]) {
            num = num +1;
        }
    }
    
    return num;
}
-(NSMutableArray *)NameInTheDict:(NSMutableDictionary *)dict
{
    NSMutableArray * NameArray = [NSMutableArray new];
    for (int i =0; i< dict.count; i++) {
        NSNumber * nub = [NSNumber numberWithInteger:i];
        BmobObject * dict1 = [dict objectForKey:nub];
        [NameArray addObject:[dict1 objectForKey:@"playerName"]];

        }
return NameArray;
 }
-(NSMutableArray *)searchDictFornameInTheDict:(NSMutableDictionary *)dict
{
    NSMutableArray * NameArray = [NSMutableArray new];
    
    
    for (int i =0; i< dict.count; i++) {
        NSNumber * nub = [NSNumber numberWithInteger:i];
        BmobObject * dict1 = [dict objectForKey:nub];

        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [dict1 objectForKey:@"playerName"],@"playerName",
                               [dict1 objectForKey:@"objectId"],@"objectId",
                               [dict1 objectForKey:@"numberOfSaidWords"],@"numberOfSaidWords",
                               [dict1 objectForKey:@"saidWord"],@"saidWord",
                               [dict1 objectForKey:@"createdAt"],@"createdAt",nil];
        [NameArray addObject:dict];
        
    }
    return NameArray;
}
-(NSMutableDictionary *)changeBmobDictToDict:(NSMutableDictionary *)dict
{
    NSMutableDictionary * DictWithDict = [NSMutableDictionary new];
    for (int i =0; i< dict.count; i++) {
        NSNumber * nub = [NSNumber numberWithInteger:i];
        BmobObject * dict1 = [dict objectForKey:nub];
        NSString * nubstr = [NSString stringWithFormat:@"%d",i];
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [dict1 objectForKey:@"playerName"],@"playerName",
                               [dict1 objectForKey:@"objectId"],@"objectId",
                               [dict1 objectForKey:@"numberOfSaidWords"],@"numberOfSaidWords",
                               [dict1 objectForKey:@"saidWord"],@"saidWord",
                               [dict1 objectForKey:@"createdAt"],@"createdAt",nil];
        [DictWithDict setObject:dict forKey:nubstr];
        
    }
    return DictWithDict;
}
-(BOOL)getObjectFromBomob
{
    NSLog(@"这个函数是根源啊 ,有没有在调用-------------------------------");
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"在搜索嘛？？");
        for (BmobObject *obj in array) {
            [self insertMainData:obj];
        }
        
        NSLog(@"数据加载完成-----%lu",(unsigned long)self.dataDict.count);
        [self setDataIsdownLoad:YES];
    }];
    return YES;
}

-(void)insertMainData:(BmobObject*)dict
{
    [super insertMainData:dict];

}

-(void)MainreloadData
{
//    if (self.dataDict.count == 0 ) {
//        do {
//            [self getObjectFromBomob];
//            NSLog(@"不停刷新");
//            NSLog(@"在dowhile刷新中%lu",(unsigned long)self.dataDict.count);
//            sleep(1.0);
//        } while (self.dataDict.count>0);
//    }else
//    {
//
//            NSLog(@"如果字典里面有值之后%lu",(unsigned long)self.dataDict.count);
//    }
    NSLog(@"深层根数据中开始刷新----------------------------");
      [self getObjectFromBomob];
    if (self.dataDict.count >0) {
    NSLog(@"主页的内容是有的");
    }
    NSLog(@"深层根数据中开始刷新结束----------------------------");


}
-(BmobObject*)creatNewClassFordata:(NSInteger)index
{
    NSNumber * numb = [NSNumber numberWithInteger:index];
    //现在里面的数据还只是这个，等数据对接好久好了
  BmobObject*  dict111 = [self.dataDict objectForKey:numb];
    //根据id建一个类，然后获得
    return  dict111;
}
-(NSMutableArray*)filterTheRepeatName:(NSArray *)NameArray
{
    [self releaseDict];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1000];

    for (int i=0; i<NameArray.count; i++) {
        if (i ==0) {
            [array addObject:NameArray[i]];
            NSString * name = [NameArray[i] objectForKey:@"playerName"];
            
            [self addDictWhenFilterName:name adddict:NameArray[i]];
        }else
        {
            if ([[NameArray[i] objectForKey:@"playerName"] isEqualToString:[NameArray[i-1] objectForKey:@"playerName"]]) {
                NSString * name = [NameArray[i] objectForKey:@"playerName"];
                [self addDictWhenFilterName:name adddict:NameArray[i]];
                continue;
            }else
             [array addObject:NameArray[i]];
            NSString * name = [NameArray[i] objectForKey:@"playerName"];
            [self addDictWhenFilterName:name adddict:NameArray[i]];
        }
    }
    return array;
}
-(void)addDictWhenFilterName:(NSString *)Name adddict:(NSDictionary *)dict
{
    if (!saidWordForName) {
        NSLog(@"字典不存在");
        saidWordForName = [NSMutableDictionary dictionaryWithCapacity:1000];
    }
    NSMutableArray * nameArray = [saidWordForName objectForKey:Name];
    if (!nameArray) {
        NSLog(@"数组不存在");
        NSMutableArray * nameArray = [NSMutableArray new];
        [saidWordForName setObject:nameArray forKey:Name];
    }
    [nameArray addObject:dict];

   
}
-(BmobObject *)getBmobObjectByID:(NSString *)ID
{
    for (int i =0; i<self.dataDict.count; i++) {
        NSNumber * numb = [NSNumber numberWithInteger:i];
        BmobObject * obj = [self.dataDict objectForKey:numb];
        if ([[obj objectForKey:@"objectId"]isEqualToString:ID]) {
            return  obj;
        }
    }

    return nil;
    
    
}
-(void)releaseDict
{
    [saidWordForName removeAllObjects];
}
@end
