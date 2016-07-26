//
//  searchCell.h
//  LetsTeasing
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface searchCell : UITableViewCell

@property(nonatomic,strong)  UILabel     * TextLabel;
@property(nonatomic,strong)  UIImageView * stateImage;

-(void)setHistoryImage;
-(void)setSearchUserImage;
-(void)setSearchWOrdImage;
@end
