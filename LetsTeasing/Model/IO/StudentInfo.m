//
//  StudentInfo.m
//  coreDataStudy
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "StudentInfo.h"

@implementation StudentInfo
//
//-(instancetype)init
//{
//   
//}
//要遵循nscoding协议才能实现归档和解档操作
-(instancetype)InitWithName:(NSString*)name score:(NSInteger)socre sno:(NSString*)sno
{
    self.sno =sno;
    self.name =name;
    self.score =socre;
       return self;
}
//归档操作
-(void)encodeWithCoder:(NSCoder*) aCoder
{
    [aCoder encodeObject:_sno forKey:@"sno"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_score forKey:@"score"];
}
//解档操作
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
        _sno=[aDecoder decodeObjectForKey:@"sno"];
    _name =[aDecoder decodeObjectForKey:@"name"];
    _score=[aDecoder decodeIntegerForKey:@"score"];
    return self;
    }
@end
