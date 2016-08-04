//
//  plistWithCatchData.m
//  LetsTeasing
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "plistWithCatchData.h"

@implementation plistWithCatchData
+(plistWithCatchData*)shareMainDataPlist
{
    plistWithCatchData *MainDataPlist =nil;
    if (!MainDataPlist) {
        MainDataPlist = [[plistWithCatchData alloc]init];
    }
    return MainDataPlist;
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
//    NSLog(@"%@",documentPath.firstObject);
    //判断plist文件是否存在，
    _MaindataPlistAdress = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/mainData.plist"];
//    NSLog(@"%@",_MaindataPlistAdress);
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:_MaindataPlistAdress];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:_MaindataPlistAdress contents:nil attributes:nil];
    }
    
    
}
-(BOOL)fileExists:(NSString * )path
{
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:path];
    return result;
}
//把字典中的内容写进plist中
-(void)writeTheContentfromDictIntoplist:(NSDictionary *)dataDict
{
    NSString * plist = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/mainData.plist"];
//        NSLog(@"这个地址%@",plist);
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:plist];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:plist contents:nil attributes:nil];
    }
    NSMutableDictionary * cutDict = [NSMutableDictionary dictionaryWithCapacity:100];
    for (int i =0; i<dataDict.count; i++) {
        if (dataDict.count<100 ) {
//            NSNumber *num = [NSNumber  numberWithInteger:i];
            NSString * NumStr = [NSString stringWithFormat:@"%d",i];
            NSDictionary * dict = [self conversionBmobOjectToDict:[dataDict objectForKey:NumStr]];
            [cutDict setObject:dict forKey:NumStr];
        }if (dataDict.count>100 ) {
//            NSNumber * num = [NSNumber numberWithInteger:dataDict.count-100];
             NSString * NumStr1 = [NSString stringWithFormat:@"%lu",dataDict.count-100-i];
              [cutDict setObject:[dataDict objectForKey:NumStr1] forKey:NumStr1];
            
        }
    }
    [cutDict writeToFile:plist atomically:YES];
}
-(NSDictionary *)conversionBmobOjectToDict:(BmobObject *)object
{
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           [object objectForKey:@"playerName"],@"playerName",
                           [object objectForKey:@"objectId"],@"objectId",
                           [object objectForKey:@"numberOfSaidWords"],@"numberOfSaidWords",
                           [object objectForKey:@"saidWord"],@"saidWord",
                           [object objectForKey:@"createdAt"],@"createdAt",
                           [object objectForKey:@"countOfComment"],@"countOfComment",nil];
    return dict;
}
-(NSMutableDictionary*)getdataDictfromPlist
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithContentsOfFile:_MaindataPlistAdress];
    return dict;
}
@end
