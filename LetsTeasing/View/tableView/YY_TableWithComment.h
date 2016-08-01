//
//  YY_TableWithComment.h
//  LetsTeasing
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentInfo.h"
@interface YY_TableWithComment : UITableView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *commDICT;
    CGFloat heightForTextLabel;
    NSMutableArray *comDict;
       NSInteger count;
    
}
@property(nonatomic,assign) BmobObject  * getBmobObject;
@property(nonatomic,assign) BmobObject  * dicto;
@property(nonatomic,strong) commentInfo * comminfo;
//@property(nonatomic,assign)

@property(nonatomic,assign) NSInteger countOF;
@property(nonatomic,assign) NSMutableArray * cellContent;
@property(nonatomic,assign) CGFloat    heightTable;
@property(nonatomic,strong) NSString * commenID;
@property(nonatomic,strong) NSString * commenName;
@property(nonatomic,assign) BOOL  states;
-(void)data;
-(NSNumber *)returnCount;
@end
