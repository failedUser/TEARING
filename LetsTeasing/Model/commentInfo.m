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
            _Comment_DICT = [NSMutableDictionary dictionaryWithCapacity:1000];
        coreDataModel *model = [[coreDataModel alloc]init];
        CommentContext = model.context;
//   CommentContext  =  [[coreDataModel shareShenmugui] context];
        [self getCommentObjectFromBomob];
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
    
    commentData  = [NSEntityDescription insertNewObjectForEntityForName:@"CommentData" inManagedObjectContext:CommentContext];
    commentData.playerName = [dict objectForKey:@"playerName"];
    commentData.numberOfSaidWords = [dict objectForKey:@"numberOfSaidWords"];
    commentData.saidWord = [dict objectForKey:@"saidWord"];
    commentData.objectId = [dict objectForKey:@"objectId"];
     commentData.states = [dict objectForKey:@"states"];
     commentData.idForComments = [dict objectForKey:@"IdForComments"];
  
    [_Comment_DICT setObject:dict forKey:[dict objectForKey:@"numberOfSaidWords"]];
    

}
-(void)commentReload
{
    [self getCommentObjectFromBomob];
   
}
//这里由于计算量太大，会消耗很多时间，需要设计算法。
-(NSMutableDictionary *)getDataForRow
{
  
    int j = 0;
//    NSLog(@"在没有筛选之前%@",_Comment_DICT);
//    NSLog(@"这个里面的ID%@",_commentID);
    NSMutableDictionary * commentdata = [NSMutableDictionary dictionaryWithCapacity:1000];
    for (int i =0; i<_Comment_DICT.count; i++) {
        
        NSNumber * number = [NSNumber numberWithInteger:i];
        BmobObject * obj = [_Comment_DICT objectForKey:number];
        NSString *  objectID =[obj objectForKey:@"IdForComments"];
          if (obj ==nil)
          {
              NSLog(@"这个里面没有内容");
          }else{
        if ( [objectID isEqualToString:_commentID]) {
            
                NSNumber * num = [NSNumber numberWithInteger:j];
                 [commentdata setObject:obj forKey:num];
            j = j+1;
            
            
            
        }
          }
    }
    
//            NSLog(@"这个里面没有评论");
    
//    NSLog(@"筛选之后%@",commentdata);
    return commentdata;
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
-(void)AlertDataReload
{
      [self getCommentObjectFromBomob];
    [self getDataForRow];
}

@end
