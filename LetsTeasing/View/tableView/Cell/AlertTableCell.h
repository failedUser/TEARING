//
//  AlertTableCell.h
//  LetsTeasing
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
@interface AlertTableCell : UITableViewCell
{
    UIImageView * commentImageView;
}
@property(nonatomic,strong)UILabel * dataLabel;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)TTTAttributedLabel * TextLabel;
@property(nonatomic,strong)UILabel * line_label;
-(CGFloat)height;


@end
