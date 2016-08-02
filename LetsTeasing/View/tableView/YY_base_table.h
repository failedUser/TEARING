//
//  YY_base_table.h
//  LetsTeasing
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainPageDictFordata.h"
#import "commentInfo.h"
#import "serachView.h"
#import "plistWithCatchData.h"
@interface YY_base_table : UITableView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary * dataDict;
   
    commentInfo * info;
    NSDictionary * dict1;
    NSInteger count;
     CGFloat heightForTextLavbel;

   
}
@property(nonatomic,strong) NSMutableDictionary * dictWithPlist;
@property(nonatomic,strong) plistWithCatchData * plistMaindata;
@property (nonatomic, strong) serachView * customSearchBar;
@property(nonatomic,assign)   NSInteger  getString1;
@property(nonatomic,strong)   NSString *    IdforSeletedRow;
@property(nonatomic,strong)   mainPageDictFordata * data;
@property(nonatomic,strong) NSMutableDictionary * dict;
@property(nonatomic,assign) NSInteger countOF;
@property(nonatomic,assign) NSArray * cellContent;
@property(nonatomic,assign) NSMutableArray * arrayForCell;
@property(nonatomic,assign) CGFloat    heightTable;
@property(nonatomic,assign) BOOL dictOrObject;

//@property(nonatomic,strong) NSMutableDictionary * SaidWord;
+(YY_base_table *)shareBaseTable;




@end
