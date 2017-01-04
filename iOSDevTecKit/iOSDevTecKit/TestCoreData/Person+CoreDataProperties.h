//
//  Person+CoreDataProperties.h
//  iOSDevTecKit
//
//  Created by horse on 16/12/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "Person.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Card *> *card;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addCardObject:(Card *)value;
- (void)removeCardObject:(Card *)value;
- (void)addCard:(NSSet<Card *> *)values;
- (void)removeCard:(NSSet<Card *> *)values;

@end

NS_ASSUME_NONNULL_END
