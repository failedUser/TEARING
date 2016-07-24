//
//  arrayOperation.m
//  LetsTeasing
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "arrayOperation.h"

@implementation arrayOperation
+(NSMutableArray *)mergeArray:(NSArray*)array1 array2:(NSArray *)array2
{        NSMutableArray * mergeArray = [NSMutableArray new];
    if (array1.count !=0 &&array2.count!=0) {

        if (array1.count >array2.count) {
            for (int i = 0; i<array1.count+array2.count; i++) {
                if (i< 2*array2.count) {
                    if (i%2 ==0) [mergeArray addObject:array1[i/2]];
                    else if((i-1)%2==0 ) [mergeArray addObject:array2[(i-1)/2]];
                }else if( i>2*array2.count) [mergeArray addObject:array1[i-array2.count]];
            }
        }else
        {
            for (int i = 0; i<array1.count+array2.count; i++) {
                if (i< 2*array1.count) {
                    if (i%2 ==0)[mergeArray addObject:array1[i/2]];
                    else if((i-1)%2==0 )  [mergeArray addObject:array2[(i-1)/2]];
                }else if( i>2*array1.count) [mergeArray addObject:array2[i-array1.count]];
            }
        }
    }else if(array1.count ==0 && array2.count!=0)
    {
        for (int i =0; i<array2.count; i++) {
            [mergeArray addObject:array2[i]];
        }
    }else if(array1.count !=0 && array2.count==0)
    {
        for (int i =0; i<array1.count; i++) {
            [mergeArray addObject:array1[i]];
        }
    }
       return mergeArray;
    
    
}

@end
