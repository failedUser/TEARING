//
//  serachView.h
//  LetsTeasing
//
//  Created by apple on 16/7/10.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View_for_Text.h"
#import "SearchHistoryAndReacommend.h"

@class serachView;

@protocol searchResults <NSObject>

@required
/**第一步根据输入的字符检索 必须实现*/
-(NSString*)CustomSearch:(serachView *)searchBar inputText:(NSString *)inputText;
@end

@protocol CustomSearchBarDataSouce <NSObject>
@required
// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection;
// 设置显示没行的内容
-(NSArray *)CustomSearchBar:(serachView *)searchBar titleForRowAtIndexPath:(NSIndexPath *)indexPath;


@optional
// 每行图片
-(NSString *)CustomSearchBar:(serachView *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CustomSearchBarDelegate <NSObject>
@optional
// 点击每一行的效果
- (BOOL)CustomSearchBar:(serachView *)searchBar didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)CustomSearchBar:(serachView *)searchBar cancleButton:(UIButton *)sender;

@end

@interface serachView : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
   
    NSDictionary * dict;
  
    UIImageView *imageViewXX;
   

}



// 显示
@property (nonatomic, strong)  NSString * inputText;
@property (nonatomic, strong)  SearchHistoryAndReacommend *searchPlistContent;
+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height;
@property (nonatomic, assign) BOOL  setImageBOOL;
@property (nonatomic, strong) UITextField * searchBarText;
@property (nonatomic, strong) NSString * getInput;
@property (nonatomic, weak) UITableView * searchBarTableView;
@property (nonatomic, assign) BOOL hiddenStates;
@property (nonatomic, assign) BOOL keyBoardShow;
@property (nonatomic, weak) id<CustomSearchBarDataSouce>    DataSource;
@property (nonatomic, weak) id<CustomSearchBarDelegate>     delegate;
@property (nonatomic, weak) id<searchResults>               searchResults;
@property (nonatomic, strong)NSArray * searchContentArray;
-(void)searchReload;

@end
