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

NSString *const JCAlertViewWillShowNotification = @"JCAlertViewWillShowNotification";

#define JCColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define JCScreenWidth [UIScreen mainScreen].bounds.size.width
#define JCScreenHeight [UIScreen mainScreen].bounds.size.height
#define JCAlertViewWidth YY_ININPONE5_WITH(280.0f)
#define JCAlertViewHeight YY_ININPONE5_HEIGHT(400.0f)
#define JCAlertViewMaxHeight YY_ININPONE5_HEIGHT(440.0f)
#define JCMargin 8
//#define JCButtonHeight 44
#define JCAlertViewTitleLabelHeight YY_ININPONE5_HEIGHT(20.0f)
#define JCAlertViewTitleColor [UIColor lightGrayColor]
#define JCAlertViewTitleFont [UIFont boldSystemFontOfSize:13]
#define JCAlertViewContentColor JCColor(102, 102, 102)
#define JCAlertViewContentFont [UIFont systemFontOfSize:16]
#define JCAlertViewContentHeight (JCAlertViewHeight - JCAlertViewTitleLabelHeight - JCButtonHeight - JCMargin * 2)
#define JCiOS7OrLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define tableViewHeight YY_ININPONE5_HEIGHT(290.0f)
#define TextVIewHeight YY_ININPONE5_HEIGHT(30.0f)
@class JCViewController;

@protocol JCViewControllerDelegate <NSObject>

@optional
- (void)coverViewTouched;

@end

@interface JCAlertView () <JCViewControllerDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *array;

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSArray *clicks;
@property (nonatomic, copy) clickHandleWithIndex clickWithIndex;
@property (nonatomic, weak) JCViewController *vc;
@property (nonatomic, strong) UIImageView *screenShotView;
@property (nonatomic, getter=isCustomAlert) BOOL customAlert;
@property (nonatomic, getter=isDismissWhenTouchBackground) BOOL dismissWhenTouchBackground;
@property (nonatomic, getter=isAlertReady) BOOL alertReady;

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
//点击其他地方的
- (void)coverViewClick{

    if ([self.delegate respondsToSelector:@selector(coverViewTouched)]) {
        [self.delegate coverViewTouched];
    }
}

- (void)addAlertView{
    self.alertView.multiple =1;
    [self.alertView setup];
    [self.view addSubview:self.alertView];
}

- (void)showAlert{

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
        _ScellContent = [NSMutableArray arrayWithObjects:@"你你你你你你你你你你",@"1",@"妮妮", @"你你你你你你你你你你",@"1",@"妮妮"@"你你你你你你你你你你",@"1",@"妮妮"@"你你你你你你你你你你",@"1",@"妮妮",@"你你你你你你你你你你",@"1",@"妮妮", @"你你你你你你你你你你",@"1",@"妮妮"@"你基地将诶菲菲和ufhweui你你你你你你你你你你你你你你你你你你你你你你你",@"1",@"妮妮"@"你你你你你你你你你你",nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange2:) name:UIKeyboardWillChangeFrameNotification object:nil];


    }
    return self;
}
//button不在需要
- (NSArray *)buttons{

    if (!_buttons) {
        _buttons = [NSArray array];
    }
    return _buttons;
}

//table版
+(void)showOneButtonWithTitle:(NSString *)title  {
    
    JCAlertView *alertView = [JCAlertView new];
    [alertView configAlertViewPropertyWithTitle:title];
}
//table版
- (void)configAlertViewPropertyWithTitle:(NSString *)title  {
    self.title = title;

    [[jCSingleTon shareSingleTon].alertStack addObject:self];
    [self showAlert];
}

- (void)showAlert{
      [self showAlertHandle];
}

- (void)showAlertHandle{
//类似于自己手残创建了一个window 现在要设置window的根视图，也就是alert，都是为了节目效果啊
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    if (keywindow != [jCSingleTon shareSingleTon].backgroundWindow) {
        [jCSingleTon shareSingleTon].oldKeyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    JCViewController *vc = [[JCViewController alloc] init];
    vc.delegate = self;
    vc.alertView = self;
    self.vc = vc;
    
    [jCSingleTon shareSingleTon].backgroundWindow.frame = [UIScreen mainScreen].bounds;
    [[jCSingleTon shareSingleTon].backgroundWindow makeKeyAndVisible];
    [jCSingleTon shareSingleTon].backgroundWindow.rootViewController = self.vc;
    
    [self.vc showAlert];
}
//妈的智障，clicks数组都被我删了，你们还有什么用
- (void)alertBtnClick{

    [self dismissAlertWithCompletion:^{
    }];

}
//这不才是真东西么

- (void)dismissAlertWithCompletion:(void(^)(void))completion{

    [self.vc hideAlertWithCompletion:^{
        [self stackHandle];
        //这个屌玩意是干什么的
//        if (completion) {
//            completion();
//        }
//
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

    if (self.subviews.count > 0) {
        return;
    }
    
    if (self.isCustomAlert) {
        return;
    }

    self.frame = CGRectMake(0, 0, _multiple*JCAlertViewWidth, _multiple*JCAlertViewHeight);
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
    _basetextView = [[AlertTextBaseView alloc]initWithFrame:CGRectMake(JCMargin, self.frame.size.height - TextVIewHeight, JCAlertViewWidth - JCMargin * 2, TextVIewHeight)];
    _basetextView.yy_text.placehoderLbl.text = (_basetextView.yy_text.placeHoder.length>0?_basetextView.yy_text.placeHoder:@"@评论");
          [_basetextView.send_btn addTarget:self action:@selector(SendToAlertTable) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_basetextView];
    [self addTable];
    
        UIButton * view =  [[UIButton alloc]initWithFrame:CGRectMake(YY_ININPONE5_WITH(290.0f)- YY_ININPONE5_WITH(30.0), 0 , YY_ININPONE5_HEIGHT(20.0), YY_ININPONE5_HEIGHT(20.0))];
//        view.backgroundColor = [UIColor redColor];
//    _basetextView.popView =self;
    [view setImage:[UIImage imageNamed:@"delete1.png"] forState:UIControlStateNormal];
    [view addTarget:self action:@selector(alertBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        view.popView = self;
        [self addSubview:view];


}
-(void)addTable
{
//    _UItable = [[UITableView alloc]initWithFrame:CGRectMake(JCMargin, JCAlertViewTitleLabelHeight, JCAlertViewWidth - JCMargin * 2, self.frame.size.height-JCAlertViewTitleLabelHeight-TextVIewHeight)];
//    self.table = [[YY_content_table alloc]initWithFrame:CGRectMake(JCMargin, JCAlertViewTitleLabelHeight, JCAlertViewWidth - JCMargin * 2, self.frame.size.height-JCAlertViewTitleLabelHeight-TextVIewHeight)];
    self.table = [[YY_content_table alloc]init];
    //给table的array赋值
    _UItable = self.table;

    [_UItable setFrame:CGRectMake(JCMargin, JCAlertViewTitleLabelHeight, JCAlertViewWidth - JCMargin * 2, self.frame.size.height-JCAlertViewTitleLabelHeight-TextVIewHeight)];
//    self.table.cellContent = _ScellContent;
    [self addSubview:_UItable];
}
-(void)SendToAlertTable
{
    NSLog(@"点击啦");
    
    NSString * message = [self.basetextView.yy_text.text  copy];
    NSString * num  = [NSString stringWithFormat:@"%ld",(_table.comminfo.Comment_DICT.count)];
    NSMutableDictionary * Dict_Message = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"这是我自己的号",@"playerName",message,@"saidWord",num,@"numberOf",@"dwudhwufgw",@"objectId", nil];
    [_table.comminfo DICTaddDIct:Dict_Message key:num];
//        [_ScellContent addObject:message];
//    NSLog(@"%@",message);
//    //    self.index =ScellContent.count;
    [self.basetextView.yy_text resignFirstResponder];
    [self.table reloadData];
//    //滑到更新的那一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_table.comDict.count-1 inSection:0];
    [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.basetextView.yy_text.text = @"";
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com