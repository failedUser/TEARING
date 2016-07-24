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


@implementation serachView
-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, SCREEN_WIDTH, height)];
    if (self) {
        [self initView];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchange) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
    return self;
}
-(void)textchange
{
    if (_searchBarText.text.length == 0) {
        NSLog(@"里面的内容为0");
        dict = NULL;
        [_searchBarTableView reloadData];
    }
}
-(void)TapClick {
    [self hidSearchBar:self];
}
-(void)initView {
//毛玻璃特效
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.backgroundColor = [UIColor blackColor];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    effectView.alpha = .6f;
    
    UIView * searchBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    searchBg.backgroundColor = YYColor(244, 244, 244);
    [self addSubview:searchBg];
    
    self.searchBarText = [[UITextField alloc] initWithFrame:CGRectMake(7, 27, SCREEN_WIDTH * 0.8 , 31)];
    self.searchBarText.borderStyle = UITextBorderStyleRoundedRect;
    self.searchBarText.delegate = self;
    [searchBg addSubview:self.searchBarText];
    self.searchBarText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchBarText becomeFirstResponder];
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
    cancleBtn.titleLabel.font = YYBUTTON_FONT;
    cancleBtn.frame = CGRectMake(cancleBtnX, cancleBtnY, cancleBtnW, cancleBtnH);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:YYColor(132, 134, 137) forState:UIControlStateNormal];
    //    cancleBtn.backgroundColor = [UIColor redColor];
    [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBg addSubview:cancleBtn];
    
    
    UITableView * searchBarTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBg.frame), SCREEN_WIDTH , SCREEN_HEIGHT - CGRectGetMaxY(searchBg.frame)) style:UITableViewStylePlain];
    searchBarTableView.backgroundColor = [UIColor orangeColor];
    searchBarTableView.delegate = self;
    searchBarTableView.dataSource = self;
    [self addSubview:searchBarTableView];
    searchBarTableView.tableFooterView = [[UIView alloc] init];
    searchBarTableView.backgroundColor = self.backgroundColor;
    self.searchBarTableView = searchBarTableView;
    
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick)];
    singleTap.cancelsTouchesInView = NO;
    [searchBarTableView addGestureRecognizer:singleTap];
    
    
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
      inputText = [self.searchResults CustomSearch:self inputText:textField.text];
        [self.searchBarTableView reloadData];
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
    static NSString * ID = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
//        [cell addtextlabel];
    }
//
//    cell.backgroundColor=[UIColor clearColor];
//    cell.namelabel.textColor = [UIColor whiteColor];
//    cell.namelabel.textColor = [UIColor whiteColor];
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    // 文字
    if (self.DataSource && [self.DataSource respondsToSelector:@selector(CustomSearchBar:titleForRowAtIndexPath:)]) {
        cell.textLabel.text =[self.DataSource CustomSearchBar:self titleForRowAtIndexPath:path];
        cell.textLabel.font = YYSYSTEM_FONT;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.numberOfLines =2;
        NSRange range= [cell.textLabel.text rangeOfString:inputText];
        if (cell.textLabel.text == nil) {
            NSLog(@"cell里面没有值");
        }else  [string setTextColor:cell.textLabel FontNumber:[UIFont fontWithName:@"Arial" size:13.0] AndRange:range AndColor:[UIColor greenColor]];
       
        
    
        
//        dict =[self.DataSource CustomSearchBar:self titleForRowAtIndexPath:path];
//        cell.namelabel.text = [dict objectForKey:@"playerName"];
//        cell.TextLabel.backgroundColor = [UIColor redColor];
//        cell.text_label.text = [dict objectForKey:@"saidWord"];
//        NSString * date = [dict objectForKey:@"createdAt"];
//        NSString * cut = [date substringFromIndex:10];
//        cell.dataLabel.text = cut;
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomSearchBar:didSelectRowAtIndexPath:)]) {
        [self.delegate CustomSearchBar:self didSelectRowAtIndexPath:path];
        [self hidSearchBar:self];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YY_ININPONE5_HEIGHT(44.0f);
}
@end
