//
//  Card+CoreDataProperties.h
//  iOSDevTecKit
//
//  Created by horse on 16/12/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "Card.h"


NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END
