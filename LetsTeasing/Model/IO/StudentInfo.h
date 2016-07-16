//
//  StudentInfo.h
//  coreDataStudy
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentInfo : NSObject<NSCoding>
{
   
   
  
}
@property(nonatomic,strong) NSString  * name ;
@property(nonatomic,strong)  NSString  * sno;
@property(nonatomic,assign)   NSInteger     score;
-(instancetype)InitWithName:(NSString*)name score:(NSInteger)socre sno:(NSString*)sno;
@end
