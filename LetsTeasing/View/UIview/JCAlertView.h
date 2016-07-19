// About me
// GitHub: https://github.com/HJaycee/JCAlertView
// Blog: http://blog.csdn.net/hjaycee
// Email: hjaycee@163.com (Feel free to connect me)

// About you
// Add "Accelerate.frameWork" first in your project otherwise error!

#import  <UIKit/UIKit.h>
#import "AlertTextBaseView.h"
#import "YY_content_table.h"
#import "YY_base_table.h"

// maybe useful
@class JCAlertView;
UIKIT_EXTERN NSString *const JCAlertViewWillShowNotification;

typedef void(^clickHandle)(void);

//typedef void(^clickHandleWithIndex)(NSInteger index);
//@protocol AlertViewDelegate <NSObject>
//-(void)alertview:(JCAlertView*)view FuncSendstring:(NSString*)send;
//@end


@interface JCAlertView : UIView<UITextViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) AlertTextBaseView * basetextView;
@property(nonatomic,strong) NSMutableArray *ScellContent;
@property (nonatomic,strong) YY_content_table * table;
@property(nonatomic,assign) NSInteger multiple;
@property (nonatomic, getter=isAlertReady) BOOL alertReady;
@property(nonatomic,strong) NSString * sendString;


//@property(nonatomic,weak) id<AlertViewDelegate> Adelegate;


// ------------------------Show AlertView with title and message----------------------

//
- (void)setup;
-(void)showOneButtonWithTitle:(NSString *)title data:(BmobObject*)datadict;
//-(void)FuncSendstring:(NSString*)send;


// ------------------------Show AlertView with customView-----------------------------


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com