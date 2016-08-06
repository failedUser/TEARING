//
//  commentInfo.m
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "commentInfo.h"
#import "mainPageDictFordata.h"



@implementation commentInfo
+(commentInfo*)ShareCommentData
{
    static commentInfo * comminfo = nil;
    if (!comminfo) {
        comminfo = [[commentInfo alloc]init];
    }
    return comminfo;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
            _Comment_DICT = [NSMutableDictionary dictionaryWithCapacity:1000];
        coreDataModel *model = [[coreDataModel alloc]init];
        CommentContext = model.context;
//   CommentContext  =  [[coreDataModel shareShenmugui] context];
        [self getCommentObjectFromBomob];
        _CommentResuluDict = [NSMutableDictionary new];
  data = [mainPageDictFordata shareMainData];
 
    }
    return  self;
}
-(BOOL)getCommentObjectFromBomob
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Comments"];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            [self insertAlertData:obj];
        }
    }];
    
    
    return YES;
}

-(void)insertAlertData:(BmobObject*)dict
{
    //我不知道是不是可以这样调用属性，但是至今没有报错
    //获取上下文
    //单例只调用一次导致上面的循环只能执行一次，这就尴尬了
    //构建实体对象
//    
//    commentData  = [NSEntityDescription insertNewObjectForEntityForName:@"CommentData" inManagedObjectContext:CommentContext];
//    commentData.playerName = [dict objectForKey:@"playerName"];
//    commentData.numberOfSaidWords = [dict objectForKey:@"numberOfSaidWords"];
//    commentData.saidWord = [dict objectForKey:@"saidWord"];
//    commentData.objectId = [dict objectForKey:@"objectId"];
//     commentData.states = [dict objectForKey:@"states"];
//     commentData.idForComments = [dict objectForKey:@"IdForComments"];
  
    [_Comment_DICT setObject:dict forKey:[dict objectForKey:@"numberOfSaidWords"]];
    

}
-(void)commentReload
{
    [self getCommentObjectFromBomob];
   
}

//这里由于计算量太大，会消耗很多时间，需要设计算法。
//这里需要做的是直接根据不同的id去匹配评论，key值是所要显示评论者的id，发表新评论的时候直接更新库就好了，然后刷新数组
-(NSMutableArray *)getDataForRow
{
    int j = 0;
    NSMutableArray * commentdataArray = [NSMutableArray arrayWithCapacity:1000];
    for (int i =0; i<_Comment_DICT.count; i++) {
        
        NSNumber * number = [NSNumber numberWithInteger:i];
        BmobObject * obj = [_Comment_DICT objectForKey:number];
        NSString *  objectID =[obj objectForKey:@"IdForComments"];
          if (obj ==nil)
          {
              NSLog(@"这个里面没有内容");
          }else{
        if ( [objectID isEqualToString:_commentID]) {
            
            [commentdataArray addObject:obj];
            j = j+1;
            
        }
          }
    }

    return commentdataArray;
}
-(NSMutableArray *)dictWithName:(NSString *)name
{

    NSMutableArray * NameArray = [NSMutableArray new];

    for (int i =0; i< _Comment_MainDICT.count; i++) {
        NSNumber * nub = [NSNumber numberWithInteger:i];
        BmobObject * dict1 = [_Comment_MainDICT objectForKey:nub];
        if ([[dict1 objectForKey:@"playerName"]isEqualToString:name]) {
        
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [dict1 objectForKey:@"playerName"],@"playerName",
                               [dict1 objectForKey:@"objectId"],@"objectId",
                               [dict1 objectForKey:@"numberOfSaidWords"],@"numberOfSaidWords",
                               [dict1 objectForKey:@"saidWord"],@"saidWord",
                               [dict1 objectForKey:@"createdAt"],@"createdAt",nil];
        [NameArray addObject:dict];
        }
        
    }
    return NameArray;
}
-(NSInteger)Count:(NSString *)objectId
{
    int j =0;
    for (int i =0; i< _Comment_DICT.count; i++) {
        NSNumber * nub = [NSNumber numberWithInteger:i];
        BmobObject * dict1 = [_Comment_DICT objectForKey:nub];
        if ([[dict1 objectForKey:@"IdForComments"]isEqualToString:objectId]) {
            j = j+1;
         
        }
    }

    return j;
}

-(void)saveAlertData:(BmobObject*)dict  CommentsID:(NSString*)comID
{
    //这个字典里面是有内容的，只是
    NSLog(@"开始建表");
    BmobObject *gameScore = [BmobObject objectWithClassName:@"Comments"];
    [gameScore setObject:[dict objectForKey:@"playerName"] forKey:@"playerName"];
    [gameScore setObject:[dict objectForKey:@"saidWord"] forKey:@"saidWord"];
    [gameScore setObject:[dict objectForKey:@"numberOfSaidWords"] forKey:@"numberOfSaidWords"];
    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [gameScore setObject:[dict objectForKey:@"states"] forKey:@"states"];
    [gameScore setObject:comID forKey:@"IdForComments"];
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
-(NSMutableDictionary *)CommentCountWithEachsaidWord
{
    if (_CommentResuluDict.count==0) {
        [self commentsDictwithobjectId];
    }
//    NSLog(@"在发表中里面又少个元素%lu",(unsigned long)data.dataDict.count);
    NSMutableDictionary * mainDict = [data changeBmobDictToDict:data.dataDict];
//    NSLog(@"maindict  %@",mainDict);
    NSMutableDictionary * resultDict = [NSMutableDictionary new];
    if (data.dataDict.count!=0&&mainDict.count!=0) {
    for (int i = 0; i<mainDict.count; i++) {
        NSString * iStr = [NSString stringWithFormat:@"%d",i];
        NSDictionary * dict1 = [mainDict objectForKey:iStr];

//        NSInteger countoF = [self Count:[dict1 objectForKey:@"objectId"]];
        if (_CommentResuluDict.count>0) {
                  NSArray * array = [_CommentResuluDict objectForKey:[dict1 objectForKey:@"objectId"]];
            NSNumber* numberOfcomment = [NSNumber numberWithInteger:array.count];
            
            NSDictionary * newDict  = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [dict1 objectForKey:@"playerName"],@"playerName",
                                       [dict1 objectForKey:@"objectId"],@"objectId",
                                       [dict1 objectForKey:@"numberOfSaidWords"],@"numberOfSaidWords",
                                       [dict1 objectForKey:@"saidWord"],@"saidWord",
                                       [dict1 objectForKey:@"createdAt"],@"createdAt"
                                       ,numberOfcomment,@"countOfComment",nil];
            [resultDict setObject:newDict forKey:iStr];
        }
  
     
    }
    }
    NSLog(@"转化之后的数组%@",resultDict);
    return resultDict;
}
-(NSMutableDictionary *)commentsDictwithobjectId
{
    //先根据自己的id建立一个总的数组
    if (data.dataDict.count!=0&&_Comment_DICT.count!=0) {
                for (int i =0; i<data.dataDict.count; i++) {
                    NSNumber * numbofUser = [NSNumber numberWithInteger:i];
                    BmobObject * obj = [data.dataDict objectForKey:numbofUser];
                    NSString   * objectId =[obj objectForKey:@"objectId"];
                    NSMutableArray * commentArray =[NSMutableArray new];
                    [_CommentResuluDict  setObject:commentArray forKey:objectId];
                }
        for (int j =0; j<_Comment_DICT.count; j++) {
            NSNumber * numbofComment = [NSNumber numberWithInteger:j];
            BmobObject * obj = [_Comment_DICT objectForKey:numbofComment];
            //由于根字典中的key是id，在评论中的标示符也是id，所以根据id去找出评论，然后找出相应的字典然后把数据保存到里面，key值为numbofSaidWord
            NSMutableArray * commenArray = [_CommentResuluDict objectForKey:[obj objectForKey:@"IdForComments"]];
            if (commenArray == nil) {
                NSLog(@"数组不存在");
            }else
            {
                [commenArray  addObject:obj];
            
            }
        }
    }
    if (_CommentResuluDict.count > 0 ) {
        NSLog(@"说明存放评论的数组现在是满的");
    }
    return _CommentResuluDict;
}
-(void)AlertDataReload
{
    [self getCommentObjectFromBomob];
    [self getDataForRow];
    _Comment_MainDICT = data.dataDict;
    [self commentsDictwithobjectId];
    
    
    [self CommentCountWithEachsaidWord];

}
-(BmobObject *)bmobObjectWithId:(NSString *)objectId
{
    BmobObject * obj = [_Comment_MainDICT objectForKey:objectId];
    return obj;
}
@end
