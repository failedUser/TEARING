//
//  dataOperation.h
//  LetsTeasing
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHistoryAndReacommend : NSObject
{
    
    NSArray<NSString*> * documentPath;
        NSFileManager *manager;
        NSManagedObjectContext * context;
//        Student * student;

}
@property(nonatomic,assign)NSString * Searchplist ;

-(NSArray*)getArrayfromPlist;
+(SearchHistoryAndReacommend*)shareSearchPlist;
-(void)writeIntoPlist:(NSArray*)array;
@end
