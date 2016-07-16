//
//  shenmegui.m
//  coreDataStudy
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "coreDataModel.h"

@implementation coreDataModel
@synthesize model;
@synthesize context;
@synthesize coordinator;
@synthesize store;
//单例模式保证这个实例只被实例化了一次，也就是在不同文件中，调用这个实例，都会得到这个实例中的数据
+(id)shareShenmugui

{
    static coreDataModel * coredataStack = nil;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coredataStack = [[self alloc] init];
    });
    return coredataStack;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        NSBundle * bundle =[NSBundle mainBundle];
        NSURL *Url = [bundle URLForResource:@"LetsTeasing" withExtension:@"momd"];
        model = [[NSManagedObjectModel alloc]initWithContentsOfURL:Url];
        coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        
        context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        context.persistentStoreCoordinator = coordinator;
        NSFileManager * manager = [NSFileManager defaultManager];
        NSArray *url = [manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL * documentUrl = url.firstObject;
        NSURL * storeUrl = [documentUrl URLByAppendingPathComponent:@"LetsTeasing"];
        store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:nil];

    }
    return  self;
    
}
//构建对象模型
-(void)buildModel
{
    NSBundle * bundle =[NSBundle mainBundle];
    NSURL *Url = [bundle URLForResource:@"LetsTeasing" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc]initWithContentsOfURL:Url];
    
}
//构建持久化存储助理
-(void)buildCoordinator
{
    coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
}
//构建托管对象上下文
-(void)buildContext
{
    
    context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = coordinator;
}
//创建持久化储存
-(void)buildManger
{
    NSFileManager * manager = [NSFileManager defaultManager];
    NSArray *url = [manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL * documentUrl = url.firstObject;
    NSURL * storeUrl = [documentUrl URLByAppendingPathComponent:@"LetsTeasing'"];
    store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:nil];
    
    
}
//用于保存数据
-(void)saveContext
{
    if([context hasChanges])
    {
        [context save:nil]; ;
    }
}
@end
