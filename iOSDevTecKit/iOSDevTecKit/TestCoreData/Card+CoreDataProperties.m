//
//  Card+CoreDataProperties.m
//  iOSDevTecKit
//
//  Created by horse on 16/12/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "Card+CoreDataProperties.h"

@implementation Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Card"];
}

@dynamic number;
@dynamic person;

@end
