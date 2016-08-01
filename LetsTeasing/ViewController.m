//
//  ViewController.m
//  LetsTeasing
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "navigation.h"
#import "YY_base_table.h"
#import "Personal_centerViewController.h"
#import "YY_TextView.h"
#import "View_for_Text.h"
#import "JCAlertView.h"
#import "mainPageDictFordata.h"
#import "newMessage.h"
#import "commentsTable.h"
#import "YY_content_table.h"
#import "MJRefresh.h"

//动画时间
#define kAnimationDuration 0.1
//view高度
#define kViewHeight 40
//cell
#define defaultHeigeht  30
#define addHeight 10

#define MesaageViewHeight SCREEN_HEIGHT*(36.0/667.0)
#define HeightForTable TextBackGroundVIewY-MesaageViewHeight
#define TextBackGroundVIewHeight SCREEN_HEIGHT*(49.0/667.0)
#define TextBackGroundVIewY SCREEN_HEIGHT*(618.0/667.0)
@interface ViewController ()<UITextViewDelegate,UITableViewDelegate,UITextViewDelegate,UITextViewDelegate>
{
    
    NSMutableArray * ScellContent;
    
}
@property(nonatomic,strong) UILabel             * title_label;
@property(nonatomic,strong) UITableView         * table_Center;
@property(nonatomic,strong) UIView              * text_view;
@property(nonatomic,strong) UILabel             * line;
@property(nonatomic,strong) UITextView          * innput_textView;
@property(nonatomic,strong) YY_base_table       * yy_table;
@property(nonatomic,strong) YY_TextView         * yy_text;
@property (weak, nonatomic) NSLayoutConstraint  * constrainH;
@property(nonatomic,strong) View_for_Text       * baseVIew;
@property(nonatomic,strong) JCAlertView         * Alertview;
@property(nonatomic,strong) newMessage          * msg_view;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    //现在的问题是自动刷新不能刷新出来数据，而得手动刷新一次才行//13:26分
    [super viewWillAppear: animated];
    // 马上进入刷新状态
            [_yy_table.mj_header beginRefreshing];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadInputViews];
    [self configNavigation];
    //实例化YY—table
    [self addTableview];
    [self addViewForText];
    [self addMessageVIew];

//监听键盘状态进行刷新
    [self addAllNotifition];
                [self MJrefresh];
  
}
-(void)addAllNotifition
{
    [self addKeboardDownNOtification];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WindowBeacome) name:UIWindowDidResignKeyNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchViewCustomSearch) name:UIWindowDidBecomeVisibleNotification object:nil];
}
-(void)addKeboardDownNOtification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDown) name:UIKeyboardWillHideNotification object:nil];
}
//当年真是无知啊，不知道这个函数，这个破问题纠结了我一个周
-(void)WindowBeacome
{
    [_baseVIew addNOtificaiton];
    [_baseVIew.yy_text resignFirstResponder];
}
-(void)keyboardWillDown
{
        [_yy_table.mj_header beginRefreshing];
}
-(void)MJrefresh
{
       MJRefreshHeader * header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh1)];
    self.yy_table.mj_header = header;
    self.yy_table.mj_header.automaticallyChangeAlpha =YES;
}
-(void)refresh1
{
   //编号有了数据也存进去，只是没有下载到数组中
    [_baseVIew addNOtificaiton];
    [self mainPageFresh];
    sleep(0.5);
    [_yy_table reloadData];
    [_yy_table.mj_header endRefreshing];
  

}
-(void)mainPageFresh
{
    [_Alertview.table reloadData];
    [_yy_table.data MainreloadData];
    [_Alertview.table.comminfo AlertDataReload];
}
-(void)configNavigation
{
    //设置导航栏的标题
    self.navigationItem.title = @"每日吐槽";
    //设置导航栏的背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    //设置导航栏标题字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial" size:16.0],NSFontAttributeName, nil]];

    //导航栏左边按钮
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selfCenter)];
    UIImage * image = [UIImage imageNamed:@"icon_nav_user.png"];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(selfCenter)];
    //导航栏左边按钮颜色
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIImage * image2 = [UIImage imageNamed:@"icon_nav_search.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStyleDone target:self action:@selector(searchToSm)];

    
    //导航栏右边边按钮颜色
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    //修改这个可以修改所有的背景色、但是不能单独在页面上改所有导航栏上的属性，只能在跟页面修改
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)addTableview
{
    _yy_table = [[YY_base_table alloc]init];
    //整理逻辑的关键牌，我想写个监听
    _yy_table.backgroundColor = [UIColor whiteColor];
    NSInteger  heighett = 0 ;
//    [self longGesture:YES];
//       [self TavbleViewCellSeletShowAlert:YES];
    heighett = HeightForTable + _yy_table.heightTable;
    [_yy_table setFrame:CGRectMake(0, MesaageViewHeight, SCREEN_WIDTH, heighett)];
    [self.view addSubview:_yy_table];
    [_yy_table reloadData];
}

-(void)ketBoardIschange
{
        [_baseVIew.yy_text resignFirstResponder];
}

-(void)addViewForText
{

   _baseVIew  = [[View_for_Text alloc]initWithFrame:CGRectMake(0, TextBackGroundVIewY, SCREEN_WIDTH, TextBackGroundVIewHeight)];

    _baseVIew.constrainH =self.constrainH;
    _baseVIew.popView =self.view;

        [self.view addSubview:_baseVIew];
    [_baseVIew.send_btn addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    }

//左边按钮的操作
-(void)selfCenter
{
    if ([_baseVIew.yy_text isFirstResponder]) {
        [_baseVIew.yy_text resignFirstResponder];
    }
    Personal_centerViewController * perV= [[Personal_centerViewController alloc]init];
//    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
//    backbutton.title = @"";
//    [backbutton setTintColor:[UIColor whiteColor]];
//    self.navigationItem.backBarButtonItem = backbutton;
    [self.navigationController pushViewController:perV animated:YES];
}

//右边按钮的操作
-(void)searchToSm
{
    [_baseVIew dealloc1];
    [self.resultFileterArry removeAllObjects];
    self.customSearchBar = [serachView show:CGPointMake(0, 0) andHeight:SCREEN_HEIGHT];
    self.customSearchBar.searchResults = self;
    self.customSearchBar.DataSource = self;
    self.customSearchBar.delegate = self;
    [self.navigationController.view insertSubview:self.customSearchBar aboveSubview:self.navigationController.navigationBar];

    
}
- (NSInteger)heightForString:(UITextView *)textView andWidth:(float)width{
    
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    NSInteger height = sizeToFit.height;
    return height;
    
}
-(void)sendText
{

   NSString * message = [_baseVIew.yy_text.text copy];
    if (message.length == 0) {
        if ([_baseVIew.yy_text isFirstResponder]) {
            [_baseVIew.yy_text resignFirstResponder];
        }else
        [_baseVIew.yy_text becomeFirstResponder];
    }else if (message.length <=140)
    {
    [self MessageManager:message];
    [_baseVIew.yy_text resignFirstResponder];
    [self.yy_table reloadData];
    //滑到更新的那一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.yy_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
     _baseVIew.yy_text.text = @"";
        //new传一个数据回去。作为值的变化
//        [_msg_view  HIDDEN:NO num:[_yy_table.data numberOfUnReadNews:_yy_table.data.DICT]];
    }
}


-(void)MessageManager:(NSString*) message
{
    if (message!= 0) {
        NSNumber * num = [NSNumber numberWithInteger:_yy_table.data.dataDict.count];
        NSDictionary * Dict_Message = [NSDictionary dictionaryWithObjectsAndKeys:@"这是我自己的号",@"playerName",message,@"saidWord",@"NO",@"states",num,@"numberOfSaidWords",nil];
        BmobObject * obj = [[BmobObject alloc]initWithDictionary:Dict_Message];
        [_yy_table.data baocunshuju:obj];
        
    }
}

////键盘退出
//-(void)touchesBegan
//{
//    [_baseVIew.yy_text resignFirstResponder];
//}
//修改图片尺寸
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
                                [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
                                UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                
                                return scaledImage;
                                
 }

- (void)showAlertWithOneButton:(NSString*)title index:(NSInteger)index{
    JCAlertView * alert = [[JCAlertView alloc]init];
  //这个里面要根据索引的内容生成了一个字典。
   BmobObject * dict =  [self.yy_table.data creatNewClassFordata:_yy_table.dict.count-index-1];
    [alert showOneButtonWithTitle:title data:dict sendName:nil];
    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [_baseVIew  addNOtificaiton];
    return YES;
}
-(void)addMessageVIew
{
   _msg_view = [[newMessage alloc]initWithFrame:CGRectMake(0,64 , YY_ININPONE5_WITH(320.0f), MesaageViewHeight)];
    [_msg_view setHidden:NO];
    [self.view addSubview:_msg_view];
      [_msg_view.button addTarget:self action:@selector(showCommentAlert) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)showCommentAlert
{
    [_msg_view setHidden:YES];
}

//显示searchbar
-(NSMutableArray *)resultFileterArry {
    if (!_resultFileterArry) {
        _resultFileterArry = [NSMutableArray new];
    }
    return _resultFileterArry;
}

-(NSMutableArray *)mergeArray
{
    if (!mergeArray) {
        mergeArray = [NSMutableArray new];
    }
    return mergeArray;
}
-(NSMutableArray *)myData {
    if (!_myData) {
        _myData = [NSMutableArray new];
        //
        _myData = [_yy_table.data NameInTheDict:_yy_table.dict];
//        _myData = [_yy_table.data searchDictFornameInTheDict:_yy_table.dict];
        [_testTableview reloadData];
    }
    return _myData;
}
-(NSMutableArray *)searchArray
{
    if (!searchArray) {
        searchArray = [[NSMutableArray alloc]init];
    }
    return searchArray;
}
/**第一步根据输入的字符检索 必须实现*/
-(NSString*)CustomSearch:(serachView *)searchBar inputText:(NSString *)inputText {
    [self.resultFileterArry removeAllObjects];
        NSMutableArray * array111 = [_yy_table.data searchDictFornameInTheDict:_yy_table.dict];
    //然后把数据放到结果这个数组里面，就是数组加数组
    if (searchBar.searchBarText.text.length==0) {
        [self.resultFileterArry removeAllObjects];
        NSMutableArray * Recommend =[arrayOperation addHistoryObjectForDict:searchBar.searchContentArray];
        for (NSDictionary * taxChat in Recommend) [self.resultFileterArry addObject:taxChat];
        [searchBar.searchBarTableView reloadData];
    }else
    {
        [filerNameArray removeAllObjects];
        arry333 =nil;
    NSPredicate * predicate2 = [NSPredicate predicateWithFormat:@"playerName CONTAINS[c] %@",inputText];
    NSArray * arry222 = [array111 filteredArrayUsingPredicate:predicate2];
    //过滤出来的名字，里面没有重复
    filerNameArray = [_yy_table.data filterTheRepeatName:arry222];
    //对里面的字符进行过滤
    NSPredicate * predicate3 = [NSPredicate predicateWithFormat:@"saidWord CONTAINS[c] %@",inputText];
    arry333= [array111 filteredArrayUsingPredicate:predicate3];

        NSMutableArray * afterAdd =  [arrayOperation addObjectForDict:arry333];
        NSMutableArray * afterAddUser = [arrayOperation addUserObjectForDict:filerNameArray];
    //数据交叉合并，这里没有值
    NSMutableArray * arr = [arrayOperation mergeArray:afterAddUser array2:afterAdd];
    for (NSDictionary * taxChat in arr) {
        [self.resultFileterArry addObject:taxChat];
    }
         NSLog(@"最终搜索出来的结果是什么%@",_resultFileterArry);
    }
    return inputText;
  
}

// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection {
    return self.resultFileterArry.count;
}
// 设置显示没行的内容，这边需要好好分析，重新实现交叉，有点麻烦
-(NSArray *)CustomSearchBar:(serachView *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //把内容输入到查询得到的cell中这个 时候我们将传进去一个带有数据字典的字典
    NSDictionary * dict =self.resultFileterArry[indexPath.row];
    if ([[dict objectForKey:@"identifier"]isEqualToString:@"User"]) {
        return  [self SrearchCellTextAndIamge:[dict objectForKey:@"playerName"] diffentIamge:@"YES"];
    }else if([[dict objectForKey:@"identifier"]isEqualToString:@"SearchContent"])
        return  [self SrearchCellTextAndIamge: [dict objectForKey:@"saidWord"] diffentIamge:@"NO"];
    else if([[dict objectForKey:@"identifier"]isEqualToString:@"History"])
    {
         return [self SrearchCellTextAndIamge:[dict objectForKey:@"playerName"] diffentIamge:@"HHH"];
    }

    return  nil;
}
- (BOOL)CustomSearchBar:(serachView *)segment didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dict =self.resultFileterArry[indexPath.row];
    JCAlertView * alert = [[JCAlertView alloc]init];
    NSString * str = [NSString stringWithFormat:@"%@的评论",[dict objectForKey:@"playerName"]];
    if ([[dict objectForKey:@"identifier"]isEqualToString:@"User"])
    {
        [alert showOneButtonWithTitle:str data:nil  sendName:[dict objectForKey:@"playerName"]];
          return YES;
    }
    else if([[dict objectForKey:@"identifier"]isEqualToString:@"SearchContent"])
    {
      [self showAlertWithID:dict alert:alert sendID:str];
          return YES;
    }
    else if([[dict objectForKey:@"identifier"]isEqualToString:@"History"])
    {
        NSDictionary * indexArray = _resultFileterArry[indexPath.row];
        segment.searchBarText.text =[indexArray objectForKey:@"playerName"];
        [self SearchViewCustomSearchWithText:[indexArray objectForKey:@"playerName"]];
        return NO;
    }
    return nil;
  
}
-(void)showAlertWithID:(NSDictionary *)dict alert:(JCAlertView *)alert sendID:(NSString *)str
{   NSString * ObjectId = [dict objectForKey:@"objectId"];
        NSLog(@"在点击的时候传入的对象是什么%@",dict);
    BmobObject * obj = [_yy_table.data getBmobObjectByID:ObjectId];
    
    NSLog(@"在点击的时候传入的对象是什么%@",obj);
    [alert showOneButtonWithTitle:str data:obj sendName:nil];
    
}
-(void)CustomSearchBar:(serachView *)segment cancleButton:(UIButton *)sender {
    
}
-(NSString *)CustomSearchBar:(serachView *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
-(void)ViewControllerDealloc
{
     [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(NSArray *)SrearchCellTextAndIamge:(NSString*)Text diffentIamge:(NSString *)boos
{
    NSArray * arry = [NSArray arrayWithObjects:Text,boos, nil];
    return arry;

    
}
-(void)SearchViewCustomSearchWithText:(NSString*)text
{//这个实现了默认搜索
    _customSearchBar.inputText=[self CustomSearch:_customSearchBar inputText:text];
            [_customSearchBar.searchBarTableView reloadData];
}
-(void)SearchViewCustomSearch
{
    //这个实现了默认搜索
   _customSearchBar.inputText=[self CustomSearch:_customSearchBar inputText:@""];
}



@end
