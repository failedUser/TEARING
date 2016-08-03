// About me
// GitHub: https://github.com/HJaycee/JCAlertView
// Blog: http://blog.csdn.net/hjaycee
// Email: hjaycee@163.com (Feel free to connect me)

// About you
// Add "Accelerate.frameWork" first in your project otherwise error!

#import "JCAlertView.h"
#import <Accelerate/Accelerate.h>
#import "YY_content_table.h"
#import "AlertTextBaseView.h"
#import "YY_TableWithComment.h"

NSString *const JCAlertViewWillShowNotification = @"JCAlertViewWillShowNotification";


@class JCViewController;

@protocol JCViewControllerDelegate <NSObject>

@optional
- (void)coverViewTouched;

@end

@interface JCAlertView () <JCViewControllerDelegate>
@property (nonatomic, weak) JCViewController *vc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSArray *clicks;
@property(nonatomic,strong) BmobObject * dataforRow;
@property(nonatomic,strong) NSString * SendName;
- (void)setup;

@end

@interface jCSingleTon : NSObject

@property (nonatomic, strong) UIWindow *backgroundWindow;
@property (nonatomic, weak) UIWindow *oldKeyWindow;
@property (nonatomic, strong) NSMutableArray *alertStack;
@property (nonatomic, strong) JCAlertView *previousAlert;

@end

@implementation jCSingleTon

+ (instancetype)shareSingleTon{

    static jCSingleTon *shareSingleTonInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareSingleTonInstance = [jCSingleTon new];
    });
    return shareSingleTonInstance;
}
//当ALertVIew弹出来的时候window的颜色和大小
- (UIWindow *)backgroundWindow{

    if (!_backgroundWindow) {
        _backgroundWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

        _backgroundWindow.windowLevel = UIWindowLevelStatusBar - 1;
    }
    return _backgroundWindow;
}
//弹出框的堆栈
- (NSMutableArray *)alertStack{

    if (!_alertStack) {
        _alertStack = [NSMutableArray array];
    }
    return _alertStack;
}

@end

@interface JCViewController : UIViewController

@property (nonatomic, strong) UIImageView *screenShotView;
@property (nonatomic, strong) UIButton *coverView;
@property (nonatomic, weak) JCAlertView *alertView;

@property (nonatomic, weak) id <JCViewControllerDelegate> delegate;

@end

@implementation JCViewController

- (void)viewDidLoad{
//    NSLog(@"当jcviewcontroller开始加载");
    [super viewDidLoad];
    
//    [self addScreenShot];
    [self addCoverView];
    [self addAlertView];
//    
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange2:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyBoardEndChange:) name:UIKeyboardWillHideNotification object:nil];
    

    
}

- (void)addCoverView{

    self.coverView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //backgroundWindow上面覆盖的view
    self.coverView.backgroundColor = JCColor(5, 0, 10);
//    self.coverView.backgroundColor = [UIColor greenColor];
    [self.coverView addTarget:self action:@selector(coverViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.coverView];
}
//点击其他地方的一个代理
- (void)coverViewClick{

    if ([self.delegate respondsToSelector:@selector(coverViewTouched)]) {
        [self.delegate coverViewTouched];
    }
}

- (void)addAlertView{
//     NSLog(@"在控制器中添加alertvirw");
    self.alertView.multiple =1;
    //这个里面开始配置Alertveiw
    [self.alertView setup];

    [self.view addSubview:self.alertView];
}

- (void)showAlert{
//   NSLog(@"alert显示时候的动画");
    self.alertView.alertReady = NO;
    
    CGFloat duration = 0.3;
    
    for (UIButton *btn in self.alertView.subviews) {
        btn.userInteractionEnabled = NO;
    }
    //设置各个层的颜色透明度
    self.screenShotView.alpha = 0;
    self.coverView.alpha = 0;
    self.alertView.alpha = 0;
    //
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.screenShotView.alpha = 1;
        self.coverView.alpha = 0.65;
        self.alertView.alpha = 1.0;
    } completion:^(BOOL finished) {
        for (UIButton *btn in self.alertView.subviews) {
            btn.userInteractionEnabled = YES;
        }
        self.alertView.alertReady = YES;
    }];
    //弹出动画不用卵他
       if (JCiOS7OrLater) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
        animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        animation.duration = duration;
        [self.alertView.layer addAnimation:animation forKey:@"bouce"];
    } else {
        self.alertView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        [UIView animateWithDuration:duration * 0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration * 0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.alertView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration * 0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:nil];
            }];
        }];
 }
}
//退出时候的动画
- (void)hideAlertWithCompletion:(void(^)(void))completion{
// NSLog(@"alert退出时候的动画");
    self.alertView.alertReady = NO;
    
    CGFloat duration = 0.2;
    //退场动画效果
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.coverView.alpha = 0;
        self.screenShotView.alpha = 0;
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        //不知道是什么图片要消除
//        [self.screenShotView removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
   
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.4, 0.4);
    } completion:^(BOOL finished) {
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)keyBoardChange2:(NSNotification *)note{
    // 0.取出键盘动画的时间
    _alertView.multiple = 0.5;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height+YY_ININPONE5_HEIGHT(84.0);
    //修改alert的高度
 // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
//    [UIView animateWithDuration:duration animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
//    }];
}
-(void)KeyBoardEndChange:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    //修改alert的高度
    //     self.frame = CGRectMake(0, 0, JCAlertViewWidth, JCAlertViewHeight-84);
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}
@end

@implementation JCAlertView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        baseTable  = [YY_base_table shareBaseTable];
    }
    return self;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    if ([_basetextView.yy_text isFirstResponder]) {
        [_basetextView.yy_text resignFirstResponder];
    }
}
//button不在需要
- (NSArray *)buttons{

    if (!_buttons) {
        _buttons = [NSArray array];
    }
    return _buttons;
}

//table版
-(void)showOneButtonWithTitle:(NSString *)title data:(BmobObject*)datadict sendName:(NSString*)name{
    JCAlertView *alertView = [JCAlertView new];

    [alertView configAlertViewPropertyWithTitle:title data:datadict sendName:name];
}
//table版
- (void)configAlertViewPropertyWithTitle:(NSString *)title data:(BmobObject*)datadict sendName:(NSString*)name{
    self.title = title;
    self.dataforRow = datadict;
    self.SendName = name;
// NSLog(@"配置alertview属性");
    [[jCSingleTon shareSingleTon].alertStack addObject:self];
    [self showAlert];
}

- (void)showAlert{
//     NSLog(@"在alertview文件中显示alert");
      [self showAlertHandle];
}

- (void)showAlertHandle{

//类似于自己手残创建了一个window 现在要设置window的根视图，也就是alert，都是为了节目效果啊
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    if (keywindow != [jCSingleTon shareSingleTon].backgroundWindow) {
        [jCSingleTon shareSingleTon].oldKeyWindow = [UIApplication sharedApplication].keyWindow;
    }
    //实例化一个viewcontroller，
    JCViewController *vc = [[JCViewController alloc] init];
    vc.delegate = self;
    vc.alertView = self;

    self.vc = vc;
   
    [jCSingleTon shareSingleTon].backgroundWindow.frame = [UIScreen mainScreen].bounds;
    [[jCSingleTon shareSingleTon].backgroundWindow makeKeyAndVisible];
    [jCSingleTon shareSingleTon].backgroundWindow.rootViewController = self.vc;
    
    [self.vc showAlert];
}
//弹出框退出
- (void)alertBtnClick{
    [self dismissAlertWithCompletion:^{
    }];
    NSLog(@"一共%lu",(unsigned long)baseTable.dict.count);
    NSInteger  numb = [[_dataforRow objectForKey:@"numberOfSaidWords"] intValue];
    NSInteger indexROw = (NSInteger)baseTable.dict.count-numb-1;
    baseTable.getString1 =indexROw;

    [baseTable reloadData];
}
//这不才是真东西么

- (void)dismissAlertWithCompletion:(void(^)(void))completion{
    [self.vc hideAlertWithCompletion:^{
        [self stackHandle];
    }];
}

- (void)stackHandle{

    [[jCSingleTon shareSingleTon].alertStack removeObject:self];
        [self toggleKeyWindow];
//    }
}

- (void)toggleKeyWindow{

    [[jCSingleTon shareSingleTon].oldKeyWindow makeKeyAndVisible];
    [jCSingleTon shareSingleTon].backgroundWindow.rootViewController = nil;
    [jCSingleTon shareSingleTon].backgroundWindow.frame = CGRectZero;
}
//配置alert view的基本信息
- (void)setup{
// NSLog(@"加载alertview的内容");
    
    if (self.subviews.count > 0) {
        return;
    }
    self.frame = CGRectMake(0, 0, _multiple*JCAlertViewWidth, _multiple*JCAlertViewHeight);
    self.layer.cornerRadius= 12;
//    NSInteger count = self.buttons.count;
    self.center = CGPointMake(JCScreenWidth / 2, JCScreenHeight / 2);
    self.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(JCMargin, 0, JCAlertViewWidth - JCMargin * 2, JCAlertViewTitleLabelHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = self.title;
    
    titleLabel.textColor = JCAlertViewTitleColor;
    titleLabel.font = JCAlertViewTitleFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];

    if (!JCiOS7OrLater) {
        CGRect frame = self.frame;
        frame.origin.y -= 10;
        self.frame = frame;
    }
    _basetextView = [[AlertTextBaseView alloc]initWithFrame:CGRectMake(JCMargin, self.frame.size.height - TextVIewHeight-JCMargin, JCAlertViewWidth - JCMargin * 2, TextVIewHeight)];
    _basetextView.yy_text.placehoderLbl.text = (_basetextView.yy_text.placeHoder.length>0?_basetextView.yy_text.placeHoder:@"我来吐槽");
          [_basetextView.send_btn addTarget:self action:@selector(SendToAlertTable) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_basetextView];
            [self addTable];

         _CancelButton=  [[UIButton alloc]initWithFrame:CGRectMake(YY_ININPONE5_WITH(270.0f)- YY_ININPONE6_WITH(30.0), YY_ININPONE6_HEIGHT(10.0f) , YY_ININPONE6_HEIGHT(30.0), YY_ININPONE6_HEIGHT(30.0))];
    [_CancelButton setImage:[UIImage imageNamed:@"icon_cancel.png"] forState:UIControlStateNormal];
 [_CancelButton addTarget:self action:@selector(alertBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_CancelButton];


}
-(void)addTable
{
//     NSLog(@"弹出框中table的配置");
 
    //在配置完table后才会执行这个,这个先放着
   // _dataforRow只是传进来的一个外键属性
    if (_dataforRow ==nil && _SendName.length != 0) {
        self.table = [[YY_content_table alloc]init];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.table addGestureRecognizer:tapGestureRecognizer];
        _table.comminfo = [[commentInfo alloc]init];
        [self.table setCommenName:_SendName];
        [self.table setStates:NO];
        [self.table  dataforName];
        
        [_table setFrame:CGRectMake(JCMargin, JCAlertViewTitleLabelHeight, JCAlertViewWidth - JCMargin * 2, self.frame.size.height-JCAlertViewTitleLabelHeight-TextVIewHeight-JCMargin)];
        [self addSubview:_table];
      
        
    }else if(_SendName.length == 0)
    {
        self.table2 = [[YY_TableWithComment alloc]init];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.table2 addGestureRecognizer:tapGestureRecognizer];
        _table2.comminfo = [[commentInfo alloc]init];
    //dataforrow is a bmob object so i can input object
    [self.table2 setGetBmobObject:_dataforRow];
    [self.table2 data];
    [self.table reloadData];
        [_table2 setFrame:CGRectMake(JCMargin, JCAlertViewTitleLabelHeight, JCAlertViewWidth - JCMargin * 2, self.frame.size.height-JCAlertViewTitleLabelHeight-TextVIewHeight-JCMargin)];
        [self addSubview:_table2];
        [self.table2 beginRefinish];
//        [self.table2 reloadData];
    }
//    #import "YY_TableWithComment.h"
    //给table的array赋值

}
-(void)SendToAlertTable
{
    NSLog(@"点击啦");
    
    NSString * message = [self.basetextView.yy_text.text  copy];
    [self MessageManager:message];
    [self.basetextView.yy_text resignFirstResponder];
    [baseTable reloadData];
        if (_dataforRow ==nil && _SendName.length != 0) {
                [self.table reloadData];
        }
else  if(_SendName.length == 0)
{
    [self.table2 beginRefinish];
}
//    //滑到更新的那一行
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.table.comDict.count-1 inSection:0];
//    [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.basetextView.yy_text.text = @"";
}
-(void)MessageManager:(NSString*) message
{
    if (message.length!= 0) {
  
        if (_dataforRow ==nil && _SendName.length != 0) {
            NSNumber * num = [self.table returnCount];
            NSLog(@"send message in   name Alert ------------------------------------");
            NSDictionary * Dict_Message = [NSDictionary dictionaryWithObjectsAndKeys:@"这是我的评论",@"playerName",message,@"saidWord",@"NO",@"states",num,@"numberOfSaidWords",[NSNumber numberWithBool:YES],@"cheatMode",nil];
            NSLog(@"will save in bmob %@",Dict_Message);
            BmobObject * obj = [[BmobObject alloc]initWithDictionary:Dict_Message];
            NSLog(@"bmobObject with menssage %@",obj);
            NSLog(@"data for row ID %@",_dataforRow );
                    //如果没有dataforRow的话是没有id这么一讲，所以也无法搜到是不是这个人的评论
            [self.table.comminfo saveAlertData:obj CommentsID:[_dataforRow objectForKey:@"objectId"]];
        }
        else  if(_SendName.length == 0)
        {
            NSLog(@"send message in   name Alert ------------------------------------");
            NSNumber * num = [self.table2 returnCount];
            NSDictionary * Dict_Message = [NSDictionary dictionaryWithObjectsAndKeys:@"这是我的评论",@"playerName",message,@"saidWord",@"NO",@"states",num,@"numberOfSaidWords",[NSNumber numberWithBool:YES],@"cheatMode",nil];
               NSLog(@"will save in bmob %@",Dict_Message);
            BmobObject * obj = [[BmobObject alloc]initWithDictionary:Dict_Message];
            NSLog(@"bmobObject with menssage %@",obj);
            NSLog(@"data for row ID %@",_dataforRow );
            [self.table2.comminfo saveAlertData:obj CommentsID:[_dataforRow objectForKey:@"objectId"]];
        }
    
    }
    else
    {
        NSLog(@"请输入正确的值");
        
    }
    
}
-(void)AerltViewReload
{
    [self.table reloadData];
    [self.table2 reloadData];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com