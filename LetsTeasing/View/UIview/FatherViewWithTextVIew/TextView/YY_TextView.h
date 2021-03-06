//
//  YY_TextView.h
//  LetsTeasing
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YY_TextView;
@protocol YYTextViewDelegate<NSObject>
@optional
// 点击每一行的效果
- (void)TextShouldEditing:(YY_TextView *)beginEdting;

@end
@interface YY_TextView : UITextView<UITextViewDelegate>
@property (nonatomic,assign)   CGFloat            textHeight;
@property (nonatomic,strong) UIColor            * placehoderColor;
@property (nonatomic,copy)   NSString           * placeHoder;
@property (nonatomic,strong) UILabel            * Under_line;
@property (nonatomic,strong) UIImageView        * PlaceHoder_Image;
@property (nonatomic,strong) NSLayoutConstraint * constrainH;//高度约束
@property (nonatomic,strong) UILabel *          placehoderLbl;
@property (nonatomic, strong) id<YYTextViewDelegate>   YTdelegate;
@end
