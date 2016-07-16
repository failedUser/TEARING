//
//  commentsTable.h
//  LetsTeasing
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainPageDictFordata.h"

@interface commentsTable : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableDictionary * dict;
@property(nonatomic,assign) NSInteger countOF;
@property(nonatomic,assign) NSArray * cellContent;
@property(nonatomic,assign) NSMutableArray * arrayForCell;
@property(nonatomic,assign) CGFloat    heightTable;
@end
