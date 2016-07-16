//
//  View_for_Text.h
//  LetsTeasing
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YY_TextView.h"

@interface View_for_Text : UIView

@property   (weak, nonatomic)   NSLayoutConstraint * constrainH;
@property   (nonatomic,strong)  UIView             * popView;
@property   (nonatomic,strong)  YY_TextView        * yy_text;
@property   (nonatomic,strong)  UIButton           * send_btn;
- (void)dealloc1;
-(void)addObserver;
@end
