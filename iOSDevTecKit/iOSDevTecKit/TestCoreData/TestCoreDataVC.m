//
//  TestCoreDataVC.m
//  iOSDevTecKit
//
//  Created by horse on 16/12/15.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "TestCoreDataVC.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Card.h"
#import "Teacher.h"
#import "Course.h"
#import "MJExtension.h"

@interface TestCoreDataVC ()
//数据模型
@property(strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久性存储区
@property(strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//上下文对象
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property(strong, nonatomic) NSManagedObject *managedObject;
@end

@implementation TestCoreDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    [self inheritateOperation];
    
//    [self addData_manyToMany];
//    [self queryData_manyToMany];
//    [self addData_oneToMany];
//    [self queryData];
    
    [self addPerson];
}

- (void)addPerson {
    NSDictionary *dataDict = @{
                               @"name":@"张三",
                               @"card":@[
                                       @{
                                       @"name":@"红桃",
                                       },
                                       @{
                                           @"name":@"黑桃",
                                        },
                                       @{
                                           @"name":@"方桃",
                                        },
                                       @{
                                           @"name":@"梅花",
                                        },
                                ],
                               };
    
    // 这个Demo仅仅提供思路，具体的方法参数需要自己创建
    
    Person *person = [Person mj_objectWithKeyValues:dataDict context:self.managedObjectContext];
    
    // 利用CoreData保存模型
    NSError *error;
    [self.managedObjectContext save:&error];
    NSLog(@"error = %@", error.localizedDescription);
    
    for (Card *object in person.card) {
        NSLog(@"cardNumber=%@", [object valueForKey:@"number"]);
    }
}


- (void)inheritateOperation{
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    // 设置排序（按照age降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*Itcast-1*"];
    //request.predicate = predicate;
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    // 遍历数据
    for (Person *person in objs) {
        NSLog(@"name=%@, age=%d", person.name, person.age);
    }
}

- (void)queryData_manyToMany {
    NSFetchRequest *requestTeacher = [[NSFetchRequest alloc] initWithEntityName:@"Teacher"];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:NO];
    requestTeacher.sortDescriptors = [NSArray arrayWithObjects:sortDes, nil];
    
    NSError* error = nil;
    NSArray *objs = [self.managedObjectContext executeFetchRequest:requestTeacher error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    NSLog(@"查询老师------------------------------------------------------");
    for (Teacher *teacher in objs) {
        NSLog(@"teacher.name=%@, email=%@, id=%d", teacher.name, teacher.email, teacher.id);
        for (Course *course in teacher.course) {
            NSLog(@"course.name=%@, id=%d", course.name, course.id);
        }
    }
    
    NSFetchRequest *requestCourse = [[NSFetchRequest alloc] initWithEntityName:@"Course"];
    sortDes = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:NO];
    requestCourse.sortDescriptors = [NSArray arrayWithObjects:sortDes, nil];
    error = nil;
    objs = [self.managedObjectContext executeFetchRequest:requestCourse error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    NSLog(@"查询课程-----------------------------------------------------");
    for (Course *course in objs ) {
        NSLog(@"course.name=%@, id=%d", course.name, course.id);
        for (Teacher *teacher in course.teacher) {
            NSLog(@"teacher.name=%@, email=%@, id=%d", teacher.name, teacher.email, teacher.id);
        }
    }
}

- (void)addData_manyToMany {
    Teacher *teacherA = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    teacherA.name = @"张三";
    teacherA.email = @"zhangsan@126.com";
    teacherA.id = 1;
    
    Teacher *teacherB = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    teacherB.name = @"李四";
    teacherB.email = @"lisi@126.com";
    teacherB.id = 2;
    
    Teacher *teacherC = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    teacherC.name = @"李刚";
    teacherC.email = @"ligang@126.com";
    teacherC.id = 3;
    
    
    Course *courseA = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    courseA.name = @"电子技术";
    courseA.id = 1;
    
    Course *courseB = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    courseB.name = @"计算机科学与技术";
    courseB.id = 2;
    
     Course *courseC = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    courseC.name = @"数字电子技术";
    courseC.id = 3;
    
    //建立多对多关系
    [teacherA addCourseObject:courseA];
    [teacherA addCourseObject:courseB];
    
    [teacherB addCourseObject:courseB];
    [teacherB addCourseObject:courseC];
    
    [courseA addTeacherObject:teacherA];
    [courseA addTeacherObject:teacherB];
    
    [courseB addTeacherObject:teacherB];
    [courseB addTeacherObject:teacherC];
    
    //存储数据
    NSError* error = nil;
    BOOL success = [self.managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }
}

- (void)addData_oneToMany{
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    // 设置Person的简单属性
    [person setValue:@"张三" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:18] forKey:@"age"];
    // 传入上下文，创建一个Card实体对象
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.managedObjectContext];
    [card setValue:@"1234567890" forKey:@"number"];
    [card setValue:person forKey:@"person"];
    
    card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.managedObjectContext];
    [card setValue:@"34657680990967234" forKey:@"number"];
    [card setValue:person forKey:@"person"];
    
    card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.managedObjectContext];
    [card setValue:@"547679887965442344" forKey:@"number"];
    [card setValue:person forKey:@"person"];
    
    // 设置Person和Card之间的关联关系
//    [person setValue:card forKey:@"card"];
    // 利用上下文对象，将数据同步到持久化存储库
    NSError* error = nil;
    BOOL success = [self.managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }
}

- (void)queryData {
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    // 设置排序（按照age降序）
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
//    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*Itcast-1*"];
    //request.predicate = predicate;
    // 执行请求
    NSError* error = nil;
    NSArray *objs = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    // 遍历数据
    for (Person *obj in objs) {
        NSLog(@"name=%@; age = %d;", [obj valueForKey:@"name"], [[obj valueForKey:@"age"] intValue]);
        for (Card *object in obj.card) {
            NSLog(@"cardNumber=%@", [object valueForKey:@"number"]);
        }
        self.managedObject = obj;
    }
}

- (void)deleteData{
    // 传入需要删除的实体对象
    [self.managedObjectContext deleteObject:self.managedObject];
    // 将结果同步到数据库
    NSError *error= nil;
    [self.managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
        // 添加持久化存储库，这里使用SQLite作为存储库
        NSError *error = nil;
        NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
        if (store == nil) { // 直接抛异常
            [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
