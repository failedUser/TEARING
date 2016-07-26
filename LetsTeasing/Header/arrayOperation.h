//
//  arrayOperation.h
//  LetsTeasing
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface arrayOperation : NSObject
+(NSMutableArray *)mergeArray:(NSArray*)array1 array2:(NSArray *)array2;
+(NSMutableArray *)addObjectForDict:(NSArray*)array;
+(NSMutableArray *)addUserObjectForDict:(NSArray*)array;
+(NSMutableArray *)addHistoryObjectForDict:(NSArray*)array;
@end
