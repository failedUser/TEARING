//
//  dict.m
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "mainPageDictFordata.h"
#import "MainPageData.h"

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

-(BOOL)getObjectFromBomob
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            [self insertMainData:obj];
        }
    }];
    return YES;
}

-(void)insertMainData:(BmobObject*)dict
{
    [super insertMainData:dict];

}

-(void)MainreloadData
{
    [self getObjectFromBomob];

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
    NSLog(@"过滤出来的字典%lu",(unsigned long)saidWordForName.count);
   
}
-(void)releaseDict
{
    [saidWordForName removeAllObjects];
}
@end
