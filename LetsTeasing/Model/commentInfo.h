//
//  commentInfo.h
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentInfo : NSObject


@property(nonatomic,strong) NSMutableDictionary * Comment_DICT;
-(void)DICTaddDIct:(NSMutableDictionary*)Com_dict key:(NSString*)com_Dict;
-(NSMutableDictionary*)neirong;
//-(NSInteger)numberOfUnReadNews;
//-(NSInteger)numberOfUnReadNews:(NSMutableDictionary *)dict;

@end
