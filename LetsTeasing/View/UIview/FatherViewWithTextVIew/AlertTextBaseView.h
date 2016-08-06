//
//  AlertTextBaseView.h
//  LetsTeasing
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTextView.h"

@interface AlertTextBaseView : UIView
{
    UILabel *  line ;
    NSInteger ComSaveCount;
}
@property   (weak, nonatomic)   NSLayoutConstraint * constrainH;
@property   (nonatomic,strong)  UIView             * popView;
@property   (nonatomic,strong)  CommentTextView        * yy_CommentText;
@property   (nonatomic,strong)  UIButton           * send_btn;

@end
