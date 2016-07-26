//
//  textCell.h
//  LetsTeasing
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
@interface textCell : UITableViewCell
{
    UIImageView * commentImageView;
}
@property(nonatomic,strong)UILabel * ComCount;
@property(nonatomic,strong)UILabel * dataLabel;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)TTTAttributedLabel * TextLabel;
@property(nonatomic,strong)UILabel * text_label;
@property(nonatomic,strong)UILabel * line_label;
@property(nonatomic,strong)UILabel * comment_Count;
@property(nonatomic,assign)NSInteger Count;
-(void)addtextlabel;
-(CGFloat)height;
-(void)setLabelText:(NSInteger)count;
-(void)addCommentImage;
-(void)addhotCommentImage;
@end
