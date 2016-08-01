//
//  serachView.m
//  LetsTeasing
//
//  Created by apple on 16/7/10.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "serachView.h"
#import "photoChange.h"
#import "JCAlertView.h"
#import "textCell.h"
#import "UIImageView+LBBlurredImage.h"
#import "searchCell.h"

@implementation serachView
@synthesize searchContentArray;
@synthesize inputText;
-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, SCREEN_WIDTH, height)];
    if (self) {
        [self initView];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchange) name:UITextFieldTextDidChangeNotification object:nil];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoarddidshow) name:UIKeyboardDidShowNotification object:nil];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardisHidden) name:UIKeyboardDidHideNotification object:nil];
        [self initSearchPlist];
    }
    return self;
}
-(void)keyBoardisHidden
{
    _keyBoardShow =NO;
}
-(void)keyBoarddidshow
{
    _keyBoardShow =YES;
}

-(void)initSearchPlist
{
    _searchPlistContent = [SearchHistoryAndReacommend shareSearchPlist];
    searchContentArray = [_searchPlistContent getArrayfromPlist];
    if (searchContentArray==nil) {
        searchContentArray = [NSArray arrayWithObjects:@"这是",@"很好",@"a", nil];
        [_searchPlistContent writeIntoPlist:searchContentArray];
    }
}

-(void)textchange
{
    if (_searchBarText.text.length == 0) {
    }
}
-(void)initView {
//毛玻璃特效
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.backgroundColor = [UIColor blackColor];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    effectView.alpha = .6f;
    //虚化搜索背景，只是现在没有图片
//    
//    imageViewXX = [[UIImageView alloc]init];
//    imageViewXX.frame = self.bounds;
//    [imageViewXX setImageToBlur:[UIImage imageNamed:@"clearsearchBack.png"]
//                        blurRadius:kLBBlurredImageDefaultBlurRadius
//                   completionBlock:^(){
//                       NSLog(@"The blurred image has been set");
//                   }];
//    [self addSubview:imageViewXX];
    UIView * searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    searchBg.backgroundColor =UIColorFromHex(0x313131);
    [self addSubview:searchBg];
    
    self.searchBarText = [[UITextField alloc] initWithFrame:CGRectMake(YY_ININPONE6_WITH(16.0f), 27, SCREEN_WIDTH * 0.78 , 29)];
    self.searchBarText.borderStyle = UITextBorderStyleRoundedRect;
    self.searchBarText.delegate = self;
    self.searchBarText.font = YYSYSTEM_FONT;
    [searchBg addSubview:self.searchBarText];
    self.searchBarText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchBarText becomeFirstResponder];
    self.searchBarText.returnKeyType = UIReturnKeySearch;
    
    [self.searchBarText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 5, 10, 10);
    UIImage * image =  [photoChange OriginImage:[UIImage imageNamed:@"searchfb.png"] scaleToSize:CGSizeMake(14, 14)];
    [leftBtn setImage:image forState:UIControlStateNormal];
    self.searchBarText.leftView = leftBtn;
    [self.searchBarText.leftView setFrame:CGRectMake(0, 0, 25, 20)];
    self.searchBarText.leftViewMode = UITextFieldViewModeAlways;
   
    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat cancleBtnW = 40;
    CGFloat cancleBtnH = 18;
    CGFloat cancleBtnX = SCREEN_WIDTH - 10 - cancleBtnW;
    CGFloat cancleBtnY = (44 * 0.5 - 9) + 20;
    cancleBtn.titleLabel.font = YYSEARCHCANCEL_FONT;
    cancleBtn.frame = CGRectMake(cancleBtnX, cancleBtnY, cancleBtnW, cancleBtnH);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    cancleBtn.backgroundColor = [UIColor redColor];
    [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBg addSubview:cancleBtn];
    
   
    UITableView * searchBarTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBg.frame), SCREEN_WIDTH , SCREEN_HEIGHT - CGRectGetMaxY(searchBg.frame)) style:UITableViewStylePlain];

    searchBarTableView.delegate = self;
    searchBarTableView.dataSource = self;
    [self addSubview:searchBarTableView];
    searchBarTableView.tableFooterView = [[UIView alloc] init];
    searchBarTableView.backgroundColor = self.backgroundColor;
    self.searchBarTableView = searchBarTableView;
    searchBarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)cancleClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomSearchBar:cancleButton:)]) {
        [self.delegate CustomSearchBar:self cancleButton:sender];
    }
    
    [self hidSearchBar:self];
}
-(void)hidSearchBar:(serachView *)searchBar {
    [self.searchBarText resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
}

+(instancetype)show:(CGPoint)orgin andHeight:(CGFloat)height {
    return [[self alloc] initWithOrgin:orgin andHeight:height];
}

- (void)textFieldDidChange:(UITextField *)textField
{
 

    if (self.searchResults && [self.searchResults respondsToSelector:@selector(CustomSearch:inputText:)]) {
        inputText =_searchBarText.text;
        [self.searchResults CustomSearch:self inputText:textField.text];
    }
}


#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.DataSource && [self.DataSource respondsToSelector:@selector(searchBarNumberOfRowInSection)]) {
        return [self.DataSource searchBarNumberOfRowInSection];
    }else {
        return 0;
    }
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"searchCell";
    searchCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[searchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    // 文字
    if (self.DataSource && [self.DataSource respondsToSelector:@selector(CustomSearchBar:titleForRowAtIndexPath:)]) {
     
        NSArray * NameArry = [self.DataSource CustomSearchBar:self titleForRowAtIndexPath:path];
        if([NameArry[1] isEqualToString:@"YES"]) [cell setSearchUserImage];
        else if([NameArry[1]isEqualToString:@"NO"])[cell setSearchWOrdImage];
        else if([NameArry[1] isEqualToString:@"HHH"])
        {
            cell.TextLabel.text = NameArry[0];
            [cell setHistoryImage];
        }
        NSString * Name =NameArry[0];
        NSRange range2= [Name rangeOfString:inputText];
        if (range2.location!=NSNotFound) {
            if (range2.location >45 ) {
                NSString * EndSting = [Name substringWithRange:NSMakeRange(range2.location -20, Name.length-range2.location+20)];
                cell.TextLabel.text = EndSting;
                NSLog(@"1");
            }
            else cell.TextLabel.text = Name;
        }
        cell.TextLabel.numberOfLines =2;
        NSRange range= [cell.TextLabel.text rangeOfString:inputText];
        if (cell.TextLabel.text == nil) {
            NSLog(@"cell里面没有值");
        }else
        {[string setTextColor:cell.TextLabel FontNumber:[UIFont fontWithName:@"Arial" size:13.0] AndRange:range AndColor:UIColorFromHex(0x50d2c2)];
        }

    }


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomSearchBar:didSelectRowAtIndexPath:)]) {
      
        if (  [self.delegate CustomSearchBar:self didSelectRowAtIndexPath:path]==NO) {
        }else
        {
              [self hidSearchBar:self];
        }
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YY_ININPONE6_HEIGHT(60);
}
-(void)searchReload
{
    [self initSearchPlist];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    [self.searchBarTableView reloadData];
    NSMutableArray * array = [NSMutableArray arrayWithArray:searchContentArray];
    NSMutableArray * resultArray = [self FileRepeatText:array text:inputText];
    if (resultArray.count>10) [resultArray removeObjectAtIndex:0];
    [_searchPlistContent writeIntoPlist:resultArray];
    [self searchReload];
    
    return  YES;
}
-(NSMutableArray*)FileRepeatText:(NSMutableArray*)array text:(NSString*)text
{
    int j = 0;
    for (int i=0; i<array.count; i++) {
        if ([text isEqualToString:array[i]]) {
            j=j+1;
            break;
            
        }else continue;
    }
    if (j==0) {
        [array addObject:text];
        return array;
    }else if (j==1) {
          return array;
    }
    return nil;
  
}
//键盘监听事件
- (void)keyBoardChange:(NSNotification *)note{
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 2.计算控制器的view需要平移的距离
    if (_keyBoardShow) {
        NSLog(@"keyboard is show");
    }else
    {
        NSLog(@"keyboard is hidden");
    CGFloat transformY = -keyboardFrame.size.height + self.searchBarTableView.frame.size.height;
    CGRect frame = CGRectMake(0, 64, SCREEN_WIDTH ,transformY );
    self.searchBarTableView.frame =frame;
    }
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
//        self.searchBarTableView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
}

@end
