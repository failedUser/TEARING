//
//  dataOperation.m
//  LetsTeasing
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "SearchHistoryAndReacommend.h"

@implementation SearchHistoryAndReacommend
+(SearchHistoryAndReacommend*)shareSearchPlist
{
    SearchHistoryAndReacommend *searchPlist =nil;
    if (!searchPlist) {
        searchPlist = [[SearchHistoryAndReacommend alloc]init];
    }
    return searchPlist;
}
-(instancetype)init
{
    self= [super init];
    /*
     目录管理
     1 检查目录是否存在
     */
    //查document目录，主目录的子目录
    [self operationForFile];

    return self;
}
-(void)operationForFile
{
    //获取document目录
    documentPath  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSLog(@"%@",documentPath.firstObject);
    //判断plist文件是否存在，
    _Searchplist = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/Searchplist.plist"];
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:_Searchplist];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:_Searchplist contents:nil attributes:nil];
    }

}
-(BOOL)fileExists:(NSString * )path
{
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:path];
    return result;
}
//数组里面的内容写进plist文n件中
-(void)writeIntoPlist:(NSArray*)array
{
    //构建路径
    NSString * plist = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/Searchplist.plist"];
//    NSLog(@"这个地址%@",plist);
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:plist];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:plist contents:nil attributes:nil];
    }
//    NSArray * nameList = [NSArray arrayWithContentsOfFile:plist];
//    NSLog(@"%@",nameList);
    [array writeToFile:plist atomically:YES];

}
-(NSArray*)getArrayfromPlist
{
        NSArray * nameList = [NSArray arrayWithContentsOfFile:_Searchplist];
    return nameList;
}

@end
