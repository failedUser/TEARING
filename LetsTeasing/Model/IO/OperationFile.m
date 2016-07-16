//
//  OperationFile.m
//  coreDataStudy
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "OperationFile.h"
#import "coreDataModel.h"
//#import "Student.h"
#import "coreDataModel.h"
#import "StudentInfo.h"

@implementation OperationFile
-(void)viewDidLoad
{    [super viewDidLoad];
    
    
    //查沙盒目录
    //    NSString * homePathe = NSHomeDirectory();
    //    NSLog(@"%@",homePathe);
    
    //documents/data
    //检查目录是否存在，如果不存在，则创建目录
    //直接获取文件夹目录
    //获取library目录
    //    NSArray  * libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //    NSLog(@"%@",libraryPath.firstObject);
    //获取document目录
    documentPath  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSLog(@"%@",documentPath.firstObject);
    
    
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
    //    [self writeIntoPlist];
    //------------------创建文件/文件夹
    //获取沙盒目录
    NSString *homePath = NSHomeDirectory();
    //在沙盒目录中创建一个文件file.text
    NSString *filePath = [homePath stringByAppendingPathComponent:@"Documents/file.text"];
    //NSFileManager是单利模式,所以不能使用alloc+init创建
    NSFileManager *manager2 = [NSFileManager defaultManager];
    NSString *str = @"无线互联";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //参数：文件路径、文件内容、文件的属性
    BOOL sucess = [manager2 createFileAtPath:filePath contents:data attributes:nil];
    if(sucess){
        NSLog(@"文件创建成功");
    }else{
        NSLog(@"文件创建失败");
    }
    
    //创建文件夹
    NSString *filePaths = [homePath stringByAppendingPathComponent:@"Documents/file"];
    NSError *error;
    //需要传递一个创建失败的指针对象，记录创建失败的信息
    BOOL success1 = [manager2 createDirectoryAtPath:filePaths withIntermediateDirectories:YES attributes:nil error:&error];
    if(!success1){
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
    
    
    //--------------------读取文件
    //根据路径读取文件内容
    NSData *datas = [manager contentsAtPath:filePath];
    NSString *s = [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
    NSLog(@"%@",s);
    
    
    //--------------------移动文件/剪切文件
    //NSFileManager中没有提供重命名的方法，所以我们可以借助移动的api进行操作
    //把filePath移动到targetPath目录中
    NSString *targetPath = [homePath stringByAppendingPathComponent:@"Documents/file/file2.text"];
    BOOL sucess2 = [manager moveItemAtPath:filePath toPath:targetPath error:nil];
    if(sucess2) {
        NSLog(@"移动成功");
    }else{
        NSLog(@"移动失败");
    }
    
    
    //--------------------复制文件
    BOOL sucess3 = [manager copyItemAtPath:filePath toPath:targetPath error:nil];
    if(sucess3){
        //复制成功
    }else{
        //复制失败
    }
    
    
    //--------------------删除文件
    //删除之前需要判断这个文件是否存在
    BOOL isExist = [manager fileExistsAtPath:filePath];//判断文件是否存在
    if(isExist){
        BOOL sucess4 = [manager removeItemAtPath:filePath error:nil];
        if(sucess4){
            //删除成功
        }else{
            //删除失败
        }
    }
    
    
    //--------------------获取文件的属性
    NSDictionary *dic = [manager attributesOfItemAtPath:filePath error:nil];
    NSLog(@"%@",dic);//通过打印我们就可以查看文件属性的一些key

}
//判断目录是否存在
-(BOOL)fileExists:(NSString * )path
{
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:path];
    return result;
}
//吧数组里面的内容写进plist文件中
-(void)writeIntoPlist
{    //构建路径
    NSString * plist = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/studentplist.plist"];
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:plist];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:plist contents:nil attributes:nil];
    }
    NSArray * name = [NSArray arrayWithObjects:@"zhangsan",@"lisi",@"wangwu",@"liliu",@"wnagqing", nil];
    [name writeToFile:plist atomically:YES];
    NSArray * nameList = [NSArray arrayWithContentsOfFile:plist];
    NSLog(@"%@",nameList);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//把字典中的内容写进plist中
-(void)writeTheContentfromDictIntoplist
{
    NSString * plist = [NSString stringWithFormat:@"%@%@", documentPath.firstObject,@"/studentDictplist.plist"];
    NSLog(@"%@",plist);
    manager = [NSFileManager defaultManager];
    BOOL result = [manager fileExistsAtPath:plist];
    if (result == NO) {
        NSLog(@"文件不存在");
        [manager createFileAtPath:plist contents:nil attributes:nil];
    }
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"yueyin",@"name",@"21",@"age",@"175",@"height", nil];
    NSDictionary * dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"yueyin2",@"name",@"212",@"age",@"1752",@"height", nil];
    [dict writeToFile:plist atomically:YES];
    [dict2 writeToFile:plist atomically:YES];
    NSDictionary  * DICT = [NSDictionary dictionaryWithContentsOfFile:plist];
    NSLog(@"%@",DICT);
}
//归档保存学生信息解档取出学生信息，对象要遵循nscoding协议
-(void)endocdeWithStudent
{
    
    StudentInfo *student1 = [[StudentInfo alloc]InitWithName:@"yueyin" score:99 sno:@"ncjss"];
    NSString * path111 = [NSString stringWithFormat:@"%@%@",documentPath.firstObject,@"/student.archive"];
    if ([self fileExists:path111]==NO) {
        NSLog(@"米有文件");
        [manager createFileAtPath:path111 contents:nil attributes:nil];
    }
    BOOL bools =  [NSKeyedArchiver archiveRootObject:student1 toFile:path111];
    if (bools ==YES) {
        NSLog(@"Sucess");
    }
    NSLog(@"%@",path111);
    //    NSObject* object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    StudentInfo *result = [StudentInfo alloc];
    result= [NSKeyedUnarchiver unarchiveObjectWithFile:path111];
    NSLog(@"%@",result.name);
}

@end
