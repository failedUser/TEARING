//
//  shenmegui.h
//  coreDataStudy
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface coreDataModel : NSObject
{
    
}
@property(nonatomic,strong)NSManagedObjectContext *context;

@property(nonatomic,strong)NSPersistentStoreCoordinator  * coordinator;
@property(nonatomic,strong)NSManagedObjectModel * model;

@property(nonatomic,strong)NSPersistentStore  * store;



-(void)saveContext;
+(id)shareShenmugui;

@end
