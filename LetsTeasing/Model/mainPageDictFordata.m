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


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self getObjectFromBomob];
        
    }
    return  self;
}
-(NSMutableDictionary*)neirong
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"加里宁",@"playerName",@"青少年是一个美好而又是一去不可再得的时期，是将来一切光明和幸福的开端",@"saidWord",@"0",@"numberOf",@"hfwufg2bhf",@"objectId", nil];
    NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"诸葛亮",@"playerName",@"夫学须志也，才须学也，非学无以广才，非志无以成学",@"saidWord",@"1",@"numberOf",@"ef23ffs",@"objectId", nil];
    NSMutableDictionary * dict3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"周恩来",@"playerName",@"每一个人要有做一代豪杰的雄心斗志！应当做个开创一代的人",@"saidWord",@"2",@"numberOf",@"wefeff2",@"objectId", nil];
    NSMutableDictionary * dict4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"歌德",@"playerName",@"最糟糕的是人们在生活中经常受到错误志向的阻碍而不自知，真到摆脱了那些阻碍时才能明白过来。",@"saidWord",@"3",@"numberOf",@"fefrgege2",@"objectId", nil];
    NSMutableDictionary * dict5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"巴斯德",@"playerName",@"立志、工作、成就，是人类活动的三大要素。立志是事业的大门，工作是登堂入室的旅程。这旅程的尽头有个成功在等待着，来庆祝你的努力结果",@"saidWord",@"4",@"numberOf",@"ergegeg",@"objectId", nil];
    NSMutableDictionary * dict6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"杜甫",@"playerName",@"会当凌绝顶，一览众山小",@"saidWord",@"5",@"numberOf",@"hthrfe",@"objectId", nil];
    NSMutableDictionary * dict7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"斯蒂文",@"playerName",@"志气这东西是能传染的，你能感染着笼罩在你的环境中的精神。那些在你周围不断向上奋发的人的胜利，会鼓励激发你作更艰苦的奋斗，以求达到如象他们所做的样子",@"saidWord",@"6",@"numberOf",@"weff",@"objectId", nil];
    NSMutableDictionary * dict8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"嘿伙计",@"playerName",@"你今天又吃错什么药了",@"saidWord",@"7",@"numberOf",@"fefeg",@"objectId", nil];
    NSMutableDictionary * dict9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"sam",@"playerName",@"你瞧这个家伙，干的蠢事",@"saidWord",@"8",@"numberOf",@"gregerge",@"objectId", nil];
    NSMutableDictionary * dict10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"一个机智的我",@"playerName",@"我太特么机智了，居然这么聪明",@"saidWord",@"9",@"numberOf",@"geqwsgg",@"objectId", nil];
    NSMutableDictionary * dict11 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"又一个机智的我",@"playerName",@"好吧，上面那句话的主人 也是我",@"saidWord",@"10",@"numberOf",@"fewgegw",@"objectId", nil];
  _DICT  = [NSMutableDictionary dictionaryWithCapacity:100];
    [_DICT setObject:dict forKey:[dict objectForKey:@"numberOf"]];
    [_DICT setObject:dict2 forKey:[dict2 objectForKey:@"numberOf"]];
    [_DICT setObject:dict3 forKey:[dict3 objectForKey:@"numberOf"]];
    [_DICT setObject:dict4 forKey:[dict4 objectForKey:@"numberOf"]];
    [_DICT setObject:dict5 forKey:[dict5 objectForKey:@"numberOf"]];
    [_DICT setObject:dict6 forKey:[dict6 objectForKey:@"numberOf"]];
    [_DICT setObject:dict7 forKey:[dict7 objectForKey:@"numberOf"]];
    [_DICT setObject:dict8 forKey:[dict8 objectForKey:@"numberOf"]];
    [_DICT setObject:dict9 forKey:[dict9 objectForKey:@"numberOf"]];
    [_DICT setObject:dict10 forKey:[dict10 objectForKey:@"numberOf"]];
    [_DICT setObject:dict11 forKey:[dict11 objectForKey:@"numberOf"]];
    return _DICT;
}
-(void)DICTaddDIct:(NSMutableDictionary*)dict key:(NSString*)num
{
    [_DICT setObject:dict forKey:num];
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
        NSString * str = [NSString stringWithFormat:@"%d",i];
        NSMutableDictionary * dict1 = [dict objectForKey:str];
        [NameArray addObject:[dict1 objectForKey:@"playerName"]];

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
-(void)fetchData
{
    [super fetchdata];
}
-(BOOL)opSucess
{
    return YES;
}
-(void)MainreloadData
{
    
    [self getObjectFromBomob];
    NSLog(@"刷新之后有%lu个元素",(unsigned long)self.dataDict.count);
}

@end
