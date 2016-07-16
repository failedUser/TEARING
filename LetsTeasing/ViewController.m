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

#define  HeightForTable SCREEN_HEIGHT*(538.0/568.0)
#define TextBackGroundVIewHeight SCREEN_HEIGHT*(40.0/568.0)
#define TextBackGroundVIewY SCREEN_HEIGHT*(538.0/568.0)
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
    //添加手势
    UITapGestureRecognizer * Gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesBegan)];
    [_yy_table addGestureRecognizer:Gesture];
    
    //下拉刷新
    MJRefreshHeader * header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh1)];
    _yy_table.mj_header = header;
    header.automaticallyChangeAlpha =YES;
    
    
}
-(void)refresh1
{
    [_yy_table.data MainreloadData];
    NSLog(@"这下有多少个元素%ld",_yy_table.data.dataDict.count);
    [_yy_table reloadData];
    sleep(0.5);
    [_yy_table.mj_header endRefreshing];
  

}

-(void)configNavigation
{
    //设置导航栏的标题
    self.navigationItem.title = @"一起来吐槽";
    //设置导航栏的背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    //设置导航栏标题字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial" size:13.0],NSFontAttributeName, nil]];

    //导航栏左边按钮
//    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selfCenter)];
    UIImage * image = [self scaleImage:[UIImage imageNamed:@"personal.png"] toScale:0.7];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(selfCenter) ];
    //导航栏左边按钮颜色
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchToSm)];
    //导航栏右边边按钮颜色
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    //修改这个可以修改所有的背景色、但是不能单独在页面上改所有导航栏上的属性，只能在跟页面修改
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)addTableview
{
    _yy_table = [[YY_base_table alloc]init];
//    _yy_table.cellContent = ScellContent;
    //整理逻辑的关键牌，我想写个监听
    _yy_table.backgroundColor = [UIColor grayColor];
 
    NSInteger  heighett = 0 ;
    [self longGesture:YES];
//       [self TavbleViewCellSeletShowAlert:YES];
    heighett = HeightForTable + self.yy_table.heightTable;
    [_yy_table setFrame:CGRectMake(0, 0, SCREEN_WIDTH, heighett)];
    [self.view addSubview:_yy_table];

    
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
    _baseVIew.yy_text.delegate =self;
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
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"";
//    UIImage * image =  [UIImage imageNamed:@"arrow.png"];
//    [backbutton setImage:[self scaleImage:image toScale:0.5]];
    [backbutton setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = backbutton;
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
- (NSInteger) heightForString:(UITextView *)textView andWidth:(float)width{
    
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
    }else
    {
    [self MessageManager:message];
    [_baseVIew.yy_text resignFirstResponder];
    [self.yy_table reloadData];
    //滑到更新的那一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_yy_table.dict.count-1 inSection:0];
    [self.yy_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
     _baseVIew.yy_text.text = @"";
        //传一个数据回去。作为值的变化
        [_msg_view  HIDDEN:NO num:[_yy_table.data numberOfUnReadNews:_yy_table.data.DICT]];
     }

}
//这个时候需要一个缓存机制，生成一个bmob对象，保存在字典中，然后异步提交，要么提交之后刷新数据
-(void)MessageManager:(NSString*) message
{
    if (message!= 0) {
        NSNumber * num = [NSNumber numberWithInteger:_yy_table.data.dataDict.count];
        NSDictionary * Dict_Message = [NSDictionary dictionaryWithObjectsAndKeys:@"这是我自己的号",@"playerName",message,@"saidWord",@"NO",@"states",num,@"numberOfSaidWords",nil];
    
        BmobObject * obj = [[BmobObject alloc]initWithDictionary:Dict_Message];
        NSLog(@"对象中的元素%@",[obj objectForKey:@"saidWord"]);
        [_yy_table.data baocunshuju:obj];
    }
    
}

//键盘退出
-(void)touchesBegan
{
    //隐藏键盘
    [_baseVIew.yy_text resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//修改图片尺寸
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
                                [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
                                UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                
                                return scaledImage;
                                
                                }






//给Cell添加长按手势
-(void)longGesture:(BOOL)bools
{
    if (bools) {
        UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongGesture:)];
        longGesture.minimumPressDuration = 0.5;
        [_yy_table addGestureRecognizer:longGesture];
    }
    else{
        NSLog(@"长按事件失败");
    }
    
    
}
-(void)LongGesture:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:_yy_table];
        
        NSIndexPath * indexPath = [_yy_table indexPathForRowAtPoint:point];
        
        if(indexPath == nil) ;
        else{
            [_baseVIew.yy_text resignFirstResponder];
            [self showAlertWithOneButton:@"xxx的评论"];
            [_baseVIew dealloc1];
            //写完发送事件之后添加一下就好了
            
        }
        
    }
    
}
- (void)showAlertWithOneButton:(NSString*)title{
    [JCAlertView showOneButtonWithTitle:title];

    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [_baseVIew  addObserver];
    return YES;
}
-(void)addMessageVIew
{
   _msg_view = [[newMessage alloc]initWithFrame:CGRectMake(0,64 , YY_ININPONE5_WITH(320.0f), YY_ININPONE5_HEIGHT(20.0f))];
    [_msg_view setHidden:YES];
    [self.view addSubview:_msg_view];
      [_msg_view.button addTarget:self action:@selector(showCommentAlert) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)showCommentAlert
{
    [_msg_view setHidden:YES];
        [JCAlertView showOneButtonWithTitle:@"未读的评论"];
}
//显示searchbar
-(NSMutableArray *)resultFileterArry {
    if (!_resultFileterArry) {
        _resultFileterArry = [NSMutableArray new];
    }
    return _resultFileterArry;
}


-(NSMutableArray *)myData {
    if (!_myData) {
        _myData = [NSMutableArray new];
//  
  _myData = [_yy_table.data NameInTheDict:_yy_table.dict];
        [_testTableview reloadData];
    }
    return _myData;
}
/**第一步根据输入的字符检索 必须实现*/
-(void)CustomSearch:(serachView *)searchBar inputText:(NSString *)inputText {
    [self.resultFileterArry removeAllObjects];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",inputText];
    //这里是要查询某个字符串，就先查找名字吧，先得到所有的名字，生成一个数组，
    NSArray * arry = [self.myData filteredArrayUsingPredicate:predicate];
    //然后把数据放到结果这个数组里面，就是数组加数组
    for (NSString * taxChat in arry) {
        [self.resultFileterArry addObject:taxChat];
    }
}
// 设置显示列的内容
-(NSInteger)searchBarNumberOfRowInSection {
    return self.resultFileterArry.count;
}
// 设置显示没行的内容
-(NSString *)CustomSearchBar:(serachView *)menu titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //把内容输入到查询得到的cell中这个 时候我们将传进去一个带有数据字典的字典
    return self.resultFileterArry[indexPath.row];
}
- (void)CustomSearchBar:(serachView *)segment didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---->>>>>>>>>%ld",indexPath.row);
}

-(void)CustomSearchBar:(serachView *)segment cancleButton:(UIButton *)sender {
    
}
-(NSString *)CustomSearchBar:(serachView *)searchBar imageNameForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Search_noraml";
}





@end
