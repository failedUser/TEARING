//
//  dataOperation.h
//  LetsTeasing
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataOperation : NSObject
{
    
    NSArray<NSString*> * documentPath;
        NSFileManager *manager;
        NSManagedObjectContext * context;
//        Student * student;

}
@end
