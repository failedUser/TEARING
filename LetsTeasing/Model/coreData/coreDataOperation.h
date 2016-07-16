//
//  coreDataOperation.h
//  LetsTeasing
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StudentInfo.h"
#import "coreDataModel.h"
#import "MainPageData.h"

@interface coreDataOperation : NSObject
{
    NSArray<NSString*> * documentPath;
    NSFileManager *manager;
    NSManagedObjectContext * context;
 
}
@property(nonatomic,strong)   NSMutableDictionary * dataDict;
@property(nonatomic,strong)   MainPageData * mainData;

-(void)insertMainData:(BmobObject*)dict;
-(void)fetchdata;
-(void)baocunshuju:(BmobObject*)dict;
@end
