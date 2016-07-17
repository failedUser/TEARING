//
//  commentInfo.m
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "commentInfo.h"



@implementation commentInfo
-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return  self;
}
//用字典保存字典
-(NSMutableDictionary*)neirong
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"加里宁",@"playerName",@"是将来一切光明和幸福的开端",@"saidWord",@"0",@"numberOf",@"hfwufg2bhf",@"objectId", nil];
    NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"诸葛亮",@"playerName",@"非学无以广才，非志无以成学",@"saidWord",@"1",@"numberOf",@"ef23ffs",@"objectId", nil];
    NSMutableDictionary * dict3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"周恩来",@"playerName",@"应当做个开创一代的人",@"saidWord",@"2",@"numberOf",@"wefeff2",@"objectId", nil];
    NSMutableDictionary * dict4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"歌德",@"playerName",@"最糟糕的是人们在生活中经常受到错误志向的阻碍而不自知，真到摆脱了那些阻碍时才能明白过来。",@"saidWord",@"3",@"numberOf",@"fefrgege2",@"objectId", nil];
    NSMutableDictionary * dict5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"巴斯德",@"playerName",@"立志、工作、成就，是人类活动的三大要素。",@"saidWord",@"4",@"numberOf",@"ergegeg",@"objectId", nil];
    NSMutableDictionary * dict6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"杜甫",@"playerName",@"会当凌绝顶，一览众山小",@"saidWord",@"5",@"numberOf",@"hthrfe",@"objectId", nil];
    NSMutableDictionary * dict7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"斯蒂文",@"playerName",@"志气这东西是能传染的，你能感染着笼罩在你的环境中的精神。那些在你周围不断向上奋发的人的胜利，会鼓励激发你作更艰苦的奋斗，以求达到如象他们所做的样子",@"saidWord",@"6",@"numberOf",@"weff",@"objectId", nil];
    NSMutableDictionary * dict8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"嘿伙计",@"playerName",@"你今天又吃错什么药了",@"saidWord",@"7",@"numberOf",@"fefeg",@"objectId", nil];
    NSMutableDictionary * dict9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"sam",@"playerName",@"你瞧这个家伙，干的蠢事",@"saidWord",@"8",@"numberOf",@"gregerge",@"objectId", nil];
    NSMutableDictionary * dict10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"一个机智的我",@"playerName",@"我太特么机智了，居然这么聪明",@"saidWord",@"9",@"numberOf",@"geqwsgg",@"objectId", nil];
    NSMutableDictionary * dict11 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"又一个机智的我",@"playerName",@"好吧，上面那句话的主人 也是我",@"saidWord",@"10",@"numberOf",@"fewgegw",@"objectId", nil];
    _Comment_DICT  = [NSMutableDictionary dictionaryWithCapacity:100];
    [_Comment_DICT setObject:dict forKey:[dict objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict2 forKey:[dict2 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict3 forKey:[dict3 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict4 forKey:[dict4 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict5 forKey:[dict5 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict6 forKey:[dict6 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict7 forKey:[dict7 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict8 forKey:[dict8 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict9 forKey:[dict9 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict10 forKey:[dict10 objectForKey:@"numberOf"]];
    [_Comment_DICT setObject:dict11 forKey:[dict11 objectForKey:@"numberOf"]];
    return _Comment_DICT;
}
-(void)DICTaddDIct:(NSMutableDictionary*)Com_dict key:(NSString*)com_num;
{
    [_Comment_DICT setObject:Com_dict forKey:com_num];
}
-(void)baocunshuju
{
    BmobObject *gameScore = [BmobObject objectWithClassName:@"yueyin1111111"];
//    [gameScore setObject:Name forKey:@"playerName"];
//    [gameScore setObject:age forKey:@"score"];
//    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
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
-(void)creatObjectTable:(NSInteger)integer
{
//    NSNumber * num = [NSNumber numberWithInteger:integer];

    
}

@end
