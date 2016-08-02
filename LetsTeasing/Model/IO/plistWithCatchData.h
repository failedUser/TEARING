//
//  plistWithCatchData.h
//  LetsTeasing
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface plistWithCatchData : NSObject
{
    
    NSArray<NSString*> * documentPath;
    NSFileManager *manager;
    NSManagedObjectContext * context;
    
    //        Student * student;
    
}
@property(nonatomic,assign)NSString * MaindataPlistAdress ;
+(plistWithCatchData*)shareMainDataPlist;
-(void)writeTheContentfromDictIntoplist:(NSDictionary *)dataDict;
-(NSMutableDictionary*)getdataDictfromPlist;
@end
