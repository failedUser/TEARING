//
//  CommentTextView.h
//  LetsTeasing
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTextView : UITextView<UITextViewDelegate>
@property (nonatomic,assign)   CGFloat            textHeight;
@property (nonatomic,strong) UIColor            * placehoderColor;
@property (nonatomic,copy)   NSString           * placeHoder;
@property (nonatomic,strong) UILabel            * Under_line;
@property (nonatomic,strong) UIImageView        * PlaceHoder_Image;
@property (nonatomic,strong) NSLayoutConstraint * constrainH;//高度约束
@property (nonatomic,strong) UILabel *          placehoderLbl;
@end
