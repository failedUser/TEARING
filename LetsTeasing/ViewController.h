//
//  ViewController.h
//  LetsTeasing
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serachView.h"

@interface ViewController : UIViewController<searchResults,CustomSearchBarDataSouce,CustomSearchBarDelegate>
@property(nonatomic,weak) NSIndexPath * index;
//search
@property (nonatomic, strong) serachView * customSearchBar;

@property (nonatomic, strong) UITableView * testTableview;

@property (nonatomic, strong) NSMutableArray * myData;


@property (nonatomic, strong) NSMutableArray * resultFileterArry;

@end

