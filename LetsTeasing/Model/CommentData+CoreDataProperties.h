//
//  CommentData+CoreDataProperties.h
//  LetsTeasing
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 yueyin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CommentData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSNumber *numberOfSaidWords;
@property (nullable, nonatomic, retain) NSString *objectId;
@property (nullable, nonatomic, retain) NSString *playerName;
@property (nullable, nonatomic, retain) NSString *saidWord;
@property (nullable, nonatomic, retain) NSString *idForComments;
@property (nullable, nonatomic, retain) NSString *states;

@end

NS_ASSUME_NONNULL_END
