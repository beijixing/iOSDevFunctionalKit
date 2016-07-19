//
//  DBManager.m
//  WoJK
//
//  Created by Megatron on 16/4/25.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import "DBManager.h"
//#import "Macro.h"

NSString *_dbPath = @"/data.sqlite";

NSString *userInfoTable = @"create table IF NOT EXISTS 'UserInfo' (realName text, id integer primary key autoincrement)";

/**
 areaName;
 areaCode;
 NSInteger order;
 NSInteger flag;//标杆城市 0不是标杆城市， 1 是标杆城市
 */
NSString *areaDataTable = @"create table IF NOT EXISTS 'AreaDataTable' (areaName text, areaCode text, ordered integer, flag integer, id integer primary key autoincrement)";

/**
 NSString *kpiCode;
 NSString *kpiName;
 NSInteger order;
 */
NSString *kpiInfoTable = @"create table IF NOT EXISTS 'KpiInfoTable' (kpiCode text, kpiName text, ordered integer, id integer primary key autoincrement)";

static FMDatabase* dataBase;
@implementation DBManager
+ (instancetype)sharedDBManager {
    static DBManager *dbManager;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[DBManager alloc] init];
        [[self class] createDataBase];
    });
    return dbManager;
}

+ (void)createDataBase {
    dataBase = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
    if (![dataBase open]) {
        DLog(@"数据库打开失败");
    }
    
    BOOL bRet = [dataBase executeUpdate:userInfoTable];
    if (!bRet) {
        DLog(@"创建 userInfoTable 失败");
    }
    
    bRet = [dataBase executeUpdate:areaDataTable];
    if (!bRet) {
        DLog(@"创建 areaDataTable 失败");
    }
    
    bRet = [dataBase executeUpdate:kpiInfoTable];
    if (!bRet) {
        DLog(@"创建 kpiInfoTable 失败");
    }
}

- (FMDatabase *)getDataBase {
    return dataBase;
}

- (BOOL)openDB {
    if ([dataBase goodConnection]) {
        return YES;
    }else {
        return [dataBase open];
    }
}

- (BOOL)closeDB {
    return [dataBase close];
}

//- (UserInfoModel *)queryUserInfo {
//    UserInfoModel *userInfo = [UserInfoModel sharedUserInfo];
//    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
//    if (![db open]) {
//        DLog(@"打开数据库失败");
//        return NULL;
//    }
//    
//    FMResultSet* result = [db executeQuery:@"Select * from 'UserInfo' "];
//    while ([result next]) {
//        userInfo.phoneNumber = [result stringForColumn:@"phoneNumber"];
//        userInfo.passWord = [result stringForColumn:@"passWord"];
//        userInfo.email = [result stringForColumn:@"email"];
//        userInfo.savePassword = [result stringForColumn:@"savePassword"];
//        userInfo.loginSuccess = [result stringForColumn:@"loginSuccess"];
//        userInfo.promoter = [result stringForColumn:@"promoter"];
//        userInfo.unpaidCount = [result stringForColumn:@"unpaidCount"];
//        userInfo.realName = [result stringForColumn:@"realName"];
//    }
//    [db close];
//    return userInfo;
//}
//
//- (BOOL)saveUserInfo:(UserInfoModel *)userInfo {
//    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
//    if (![db open]) {
//        DLog(@"打开数据库失败");
//        return false;
//    }
//    
//    db.shouldCacheStatements = YES;
//    NSString* querySql = [NSString stringWithFormat:@"SELECT * FROM 'UserInfo' WHERE email = '%@'", userInfo.email];
//    DLog(@"querySql = %@", querySql);
//    FMResultSet *result = [db executeQuery: querySql];
//    if ([result next]) {
//        NSString *sqlstr = [NSString stringWithFormat:@"UPDATE 'UserInfo' SET phoneNumber = '%@', passWord = '%@', email = '%@', savePassword = '%@', loginSuccess = '%@', promoter = '%@', unpaidCount = '%@', realName = '%@' WHERE email = '%@' ", userInfo.phoneNumber,  userInfo.passWord, userInfo.email, userInfo.savePassword, userInfo.loginSuccess, userInfo.promoter, userInfo.unpaidCount, userInfo.realName, userInfo.email];
//        [db executeUpdate: sqlstr];
//    }else{
//        NSString *sqlstr = [NSString stringWithFormat:@"INSERT INTO 'UserInfo' (phoneNumber, passWord, email, savePassword, loginSuccess, promoter, unpaidCount, realName) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ", userInfo.phoneNumber, userInfo.passWord, userInfo.email, userInfo.savePassword, userInfo.loginSuccess, userInfo.promoter, userInfo.unpaidCount, userInfo.realName];
//        [db executeUpdate:sqlstr];
//    }
//    [db close];
//    return true;
//}
//
//- (void)deleteUserInfo {
//    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
//    if (![db open]) {
//        DLog(@"打开数据库失败");
//        return;
//    }
//    db.shouldCacheStatements = YES;
//    NSString* deleteSql = [NSString stringWithFormat:@"Delete FROM 'UserInfo' "];
//    DLog(@"querySql = %@", deleteSql);
//    BOOL bRet = [db executeUpdate: deleteSql];
//    if (bRet) {
//        DLog(@"删除UserInfo");
//    }
//    
//}

- (void)saveBankCardListData:(NSArray *)bankArr {
//    if (!bankArr) {
//        return;
//    }
//    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
//    if (![db open]) {
//        DLog(@"打开数据库失败");
//        return;
//    }
//    db.shouldCacheStatements = YES;
//    NSString* deleteSql = [NSString stringWithFormat:@"Delete FROM 'BankCardListTable' "];
//    NSString *deleteServiceCardList = [NSString stringWithFormat:@"Delete FROM 'ServiceCardListTable' "];
//    [db executeUpdate: deleteServiceCardList];
//    DLog(@"querySql = %@", deleteSql);
//    BOOL bRet = [db executeUpdate: deleteSql];//?如果表是空的
//    if (bRet) {
//        for (BankCardListDataModel *cardModel in bankArr) {
//            NSString *sqlstr = [NSString stringWithFormat:@"INSERT INTO 'BankCardListTable' (dataType, bankName, cardLastNum, debt, minPay, creditLine,integral, period, deadLine, cdTime, payStatus, partPayNum, cardId, billDate, serviceCycle, endTime, serviceId, serviceType, serviceStatus, address) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ", cardModel.dataType, cardModel.bankName, cardModel.cardLastNum, cardModel.debt, cardModel.minPay, cardModel.creditLine, cardModel.integral, cardModel.period, cardModel.deadLine, cardModel.cdTime, cardModel.payStatus, cardModel.partPayNum, cardModel.cardId, cardModel.billDate, cardModel.serviceCycle, cardModel.endTime, cardModel.serviceId, cardModel.serviceType, cardModel.serviceStatus, cardModel.address];
//            [db executeUpdate:sqlstr];
//            if ([cardModel.dataType isEqualToString:@"2"]) {//增值服务
//                [self saveServiceCardListWithDBHandler:db andCardList:cardModel.serviceCardList];
//            }
//        }
//    }else
//    {
//        DLog(@"数据删除失败");
//    }
//    
//    [db close];
}

- (NSMutableArray *)queryBankCardListData{
//    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
//    if (![db open]) {
//        DLog(@"打开数据库失败");
//        return NULL;
//    }
//    NSMutableArray *cardListData = [[NSMutableArray alloc] init];
//    
//    FMResultSet* result = [db executeQuery:@"Select * from 'BankCardListTable' "];
//    while ([result next]) {
//        BankCardListDataModel *cardData = [[BankCardListDataModel alloc] init];
//        cardData.dataType = [result stringForColumn:@"dataType"];
//        cardData.bankName = [result stringForColumn:@"bankName"];
//        [cardListData addObject:cardData];
//    }
//    
//    [db close];
//    return cardListData;
    return NULL;
}


//- (void)updateBankCardListData:(BankCardListDataModel*)bankCardListData {
//    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
//    if (![db open]) {
//        DLog(@"打开数据库失败");
//        return;
//    }
//    db.shouldCacheStatements = YES;
//    NSString *sqlstr = [NSString stringWithFormat:@"UPDATE 'BankCardListTable' SET dataType = '%@', debt = '%@', minPay = '%@', creditLine = '%@', integral = '%@', period = '%@', deadLine = '%@', cdTime = '%@', payStatus = '%@', partPayNum = '%@', cardId = '%@', billDate = '%@', serviceCycle = '%@', endTime = '%@', serviceId = '%@', serviceType = '%@', serviceStatus = '%@', address = '%@' WHERE bankName = '%@' AND cardLastNum = '%@' ", bankCardListData.dataType, bankCardListData.debt, bankCardListData.minPay, bankCardListData.creditLine, bankCardListData.integral, bankCardListData.period, bankCardListData.deadLine, bankCardListData.cdTime, bankCardListData.payStatus, bankCardListData.partPayNum, bankCardListData.cardId, bankCardListData.billDate, bankCardListData.serviceCycle, bankCardListData.endTime, bankCardListData.serviceId, bankCardListData.serviceType, bankCardListData.serviceStatus,bankCardListData.address, bankCardListData.bankName, bankCardListData.cardLastNum];
//    BOOL bret = [db executeUpdate: sqlstr];
//    if (bret) {
//        DLog(@"数据更新成功");
//    }else {
//        DLog(@"数据更新失败");
//    }
//    [db close];
//}

@end