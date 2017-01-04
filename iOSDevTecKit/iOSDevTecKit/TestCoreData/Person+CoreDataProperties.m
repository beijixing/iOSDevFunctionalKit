//
//  Person+CoreDataProperties.m
//  iOSDevTecKit
//
//  Created by horse on 16/12/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;
@dynamic card;

@end
