//
//  operation.h
//  PTT
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface operation : NSObject
@property(nonatomic,strong) NSString* className;


-(void)baocunshuju:(NSString *)Name userage:(id) age;
-(void)getData:(NSString *)bgId conString:(NSString *) contring;
-(void)changeBackGroundid:(NSString *)bgid changeValueName:(NSString *) changeName value:(NSObject *)value;
-(void)del:(NSString *)delName;
@end
