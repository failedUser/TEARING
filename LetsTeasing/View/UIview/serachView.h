//
//  serachView.h
//  LetsTeasing
//
//  Created by apple on 16/7/10.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View_for_Text.h"

@class serachView;

@protocol searchResults <NSObject>

@required
/**第一步根据输入的字符检索 必须实现*/
-(void)CustomSearch:(serachView *)searchBar inputText:(NSString *)inputText;
@end

@protocol CustomSearchBarDataSouce <NSObject>
@required
// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection;
// 设置显示没行的内容
-(NSString *)CustomSearchBar:(serachView *)searchBar titleForRowAtIndexPath:(NSIndexPath *)indexPath;


@optional
// 每行图片
-(NSString *)CustomSearchBar:(serachView *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CustomSearchBarDelegate <NSObject>
@optional
// 点击每一行的效果
- (void)CustomSearchBar:(serachView *)searchBar didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)CustomSearchBar:(serachView *)searchBar cancleButton:(UIButton *)sender;

@end

@interface serachView : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>



// 显示
+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height;
@property (nonatomic, strong) UITextField * searchBarText;

@property (nonatomic, weak) UITableView * searchBarTableView;

@property (nonatomic, weak) id<CustomSearchBarDataSouce>    DataSource;
@property (nonatomic, weak) id<CustomSearchBarDelegate>     delegate;
@property (nonatomic, weak) id<searchResults>               searchResults;

@end
