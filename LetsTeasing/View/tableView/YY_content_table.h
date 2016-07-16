//
//  YY_content_table.h
//  LetsTeasing
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentInfo.h"

@interface YY_content_table :UITableView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign) NSMutableDictionary  * dicto;
@property(nonatomic,strong) commentInfo * comminfo;
@property(nonatomic,assign) NSMutableDictionary *comDict;
@property(nonatomic,assign) NSInteger countOF;
@property(nonatomic,assign) NSMutableArray * cellContent;
@property(nonatomic,assign) CGFloat    heightTable;

@end
