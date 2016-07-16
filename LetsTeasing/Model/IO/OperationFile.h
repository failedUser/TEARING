//
//  OperationFile.h
//  coreDataStudy
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationFile : UIViewController
{
    NSArray<NSString*> * documentPath;
    NSFileManager *manager;
    NSManagedObjectContext * context;
//    Student * student;
}

@end
