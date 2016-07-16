//
//  photoChange.h
//  LetsTeasing
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 yueyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface photoChange : NSObject
//change the size of image ,
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
