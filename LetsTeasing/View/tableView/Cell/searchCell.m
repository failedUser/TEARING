//
//  searchCell.m
//  LetsTeasing
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import "searchCell.h"

@implementation searchCell
@synthesize TextLabel;
@synthesize stateImage;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        TextLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 260,40 )];
        stateImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        self.backgroundColor = [UIColor clearColor];
        TextLabel.backgroundColor = [UIColor clearColor];
        TextLabel.textColor =UIColorFromHex(0xffffff);
        TextLabel.font = YYSYSTEM_FONT;
        
        [self.contentView addSubview:TextLabel];
        [self.contentView addSubview:stateImage];
        
        [TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(YY_ININPONE6_WITH(310.0f));
            make.height.offset(YY_ININPONE6_HEIGHT(40.0f));
            make.leftMargin.equalTo(self.contentView.mas_left).offset(YY_ININPONE6_WITH(50.0f));
        }];
        
        [stateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(YY_ININPONE6_WITH(15.0f));
            make.height.offset(YY_ININPONE6_HEIGHT(15.0f));
            make.topMargin.equalTo(self.contentView.mas_top).offset(20.0f);
              make.leftMargin.equalTo(self.contentView.mas_left).offset(YY_ININPONE6_WITH(20.0f));
        }];
    }
    return self;
}
-(void)setHistoryImage
{
    UIImage * image =[UIImage imageNamed:@"icon_search_history.png"];
    [stateImage setImage:image];
    }
-(void)setSearchUserImage
{
    UIImage * image =[UIImage imageNamed:@"icon_search_user.png"];
      [stateImage setImage:image];
}
-(void)setSearchWOrdImage
{
    UIImage * image =[UIImage imageNamed:@"icon_search.png"];
      [stateImage setImage:image];
}
@end
