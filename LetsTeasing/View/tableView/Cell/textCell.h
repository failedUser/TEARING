//
//  textCell.h
//  LetsTeasing
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textCell : UITableViewCell

@property(nonatomic,strong)UILabel * dataLabel;
@property(nonatomic,strong)UILabel * namelabel;
@property(nonatomic,strong)UILabel * TextLabel;
@property(nonatomic,strong)UILabel * text_label;
-(void)addtextlabel;
@end
