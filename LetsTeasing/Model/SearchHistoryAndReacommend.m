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
    //查沙盒目录
        NSString * homePathe = NSHomeDirectory();
        NSLog(@"沙盒目录%@",homePathe);
    //获取library目录
    //    NSArray  * libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //    NSLog(@"%@",libraryPath.firstObject);
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
    NSLog(@"searchPlist的地址是%@",_Searchplist);
    //    if ([self fileExists]) {
    //        NSLog(@"目录不存在");
    //        //创建一个新目录，可以用一个布尔值来接受状态
    //
    //        [ manager createDirectoryAtPath:documentPath.firstObject withIntermediateDirectories:NO attributes:nil error: nil];
    //        NSLog(@"%@",documentPath.firstObject);
    //        //删除目录
    //        [manager removeItemAtPath:documentPath.firstObject error:nil];
    //    }
    //    if ([self fileExists] ==NO) {
    //        NSLog(@"被删除了");
    //    }

}
-(BOOL)fileExists:(NSString * )path
{
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:path];
    return result;
}
//数组里面的内容写进plist文n件中
-(void)writeIntoPlist:(NSArray*)array
{    //构建路径
    [array writeToFile:_Searchplist atomically:YES];
}

//把字典中的内容写进plist中
-(void)writeTheContentfromDictIntoplist
{
   _Searchplist = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/Searchplist.plist"];
    NSLog(@"%@",_Searchplist);
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:_Searchplist];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:_Searchplist contents:nil attributes:nil];
    }
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"yueyin",@"name",@"21",@"age",@"175",@"height", nil];
    NSDictionary * dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"yueyin2",@"name",@"212",@"age",@"1752",@"height", nil];
    [dict writeToFile:_Searchplist atomically:YES];
    [dict2 writeToFile:_Searchplist atomically:YES];

//    NSDictionary  * DICT = [NSDictionary dictionaryWithContentsOfFile:plist];
}
-(NSArray*)getArrayfromPlist
{
        NSArray * nameList = [NSArray arrayWithContentsOfFile:_Searchplist];
    return nameList;
}

@end
