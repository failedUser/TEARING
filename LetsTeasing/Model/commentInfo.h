//
//  commentInfo.h
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "coreDataModel.h"
#import "CommentData.h"
#import "mainPageDictFordata.h"
@interface commentInfo : NSObject
{
        NSManagedObjectContext * CommentContext;
    mainPageDictFordata * data ;
    NSMutableArray *mergeArray;
//    CommentData * commentData;
}
@property(nonatomic,strong) NSMutableDictionary * Comment_MainDICT;
@property(nonatomic,strong) NSMutableDictionary * Comment_DICT;
@property(nonatomic,strong) NSString * commentID;
+(commentInfo*)ShareCommentData;
-(void)commentReload;
-(NSMutableArray *)getDataForRow;
-(void)saveAlertData:(BmobObject*)dict  CommentsID:(NSString*)comID;
-(void)AlertDataReload;
-(NSMutableArray *)dictWithName:(NSString *)name;
-(NSInteger)Count:(NSString *)objectId;

@end
