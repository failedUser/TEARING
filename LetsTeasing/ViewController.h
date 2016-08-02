//
//  ViewController.h
//  LetsTeasing
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serachView.h"
#import "YY_base_table.h"
@interface ViewController : UIViewController<UITableViewDelegate,searchResults,CustomSearchBarDataSouce,CustomSearchBarDelegate>
{
    NSMutableArray * _myData;
    NSMutableArray * searchArray;
    NSMutableArray * filerNameArray;
    NSMutableArray * mergeArray;
    NSArray * arry333;
   
}
@property(nonatomic,strong) YY_base_table       * yy_table;
@property(nonatomic,weak) NSIndexPath * index;
//search
@property (nonatomic, strong) serachView * customSearchBar;

@property (nonatomic, strong) UITableView * testTableview;



@property (nonatomic, strong) NSMutableArray * resultFileterArry;

@end

