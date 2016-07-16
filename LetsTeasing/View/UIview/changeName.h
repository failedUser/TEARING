//
//  changeName.h
//  LetsTeasing
//
//  Created by apple on 16/7/6.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changeName : UIViewController
{
    UITextField * view;
    NSString * changeName;
}
@property (nonatomic,strong) UILabel *          placehoderLbl;
@property (nonatomic,strong) UIColor            * placehoderColor;
@property (nonatomic,copy)   NSString           * placeHoder;
@end
