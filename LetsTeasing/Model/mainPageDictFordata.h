//
//  dict.h
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageData.h"
#import "coreDataOperation.h"


@interface mainPageDictFordata : coreDataOperation


@property(nonatomic,strong) NSMutableDictionary * saidWordForName;
@property(nonatomic,strong) coreDataOperation *coreOP;
@property(nonatomic,strong) NSMutableDictionary * DICT;
@property(nonatomic,strong) MainPageData * mainData1;
+(mainPageDictFordata *)shareMainData;
-(NSInteger)numberOfUnReadNews:(NSMutableDictionary *)dict;
-(NSMutableArray *)NameInTheDict:(NSMutableDictionary *)dict;

-(BOOL)getObjectFromBomob;

-(void)MainreloadData;
-(BmobObject*)creatNewClassFordata:(NSInteger)index;
-(NSMutableArray *)searchDictFornameInTheDict:(NSMutableDictionary *)dict;
-(NSMutableArray*)filterTheRepeatName:(NSArray *)NameArray;
-(BmobObject *)getBmobObjectByID:(NSString *)ID;
@end
