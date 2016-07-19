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
@interface commentInfo : NSObject
{
        NSManagedObjectContext * CommentContext;
    CommentData * commentData;
}

@property(nonatomic,strong) NSMutableDictionary * Comment_DICT;
@property(nonatomic,strong) NSString * commentID;
-(void)commentReload;
-(NSMutableDictionary *)getDataForRow;
-(void)saveAlertData:(BmobObject*)dict  CommentsID:(NSString*)comID;
-(void)AlertDataReload;
@end
