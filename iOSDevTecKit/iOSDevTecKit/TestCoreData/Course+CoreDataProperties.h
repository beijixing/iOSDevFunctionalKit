//
//  Course+CoreDataProperties.h
//  iOSDevTecKit
//
//  Created by horse on 16/12/19.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "Course.h"


NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t id;
@property (nullable, nonatomic, retain) NSSet<Teacher *> *teacher;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addTeacherObject:(Teacher *)value;
- (void)removeTeacherObject:(Teacher *)value;
- (void)addTeacher:(NSSet<Teacher *> *)values;
- (void)removeTeacher:(NSSet<Teacher *> *)values;

@end

NS_ASSUME_NONNULL_END
