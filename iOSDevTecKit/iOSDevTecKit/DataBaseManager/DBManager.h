//
//  DBManager.h
//  WoJK
//
//  Created by Megatron on 16/4/25.
//  Copyright © 2016年 zhilong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface DBManager : NSObject
+ (instancetype)sharedDBManager;
//- (UserInfoModel *)queryUserInfo;
//- (BOOL)saveUserInfo:(UserInfoModel *)userInfo;
//- (void)deleteUserInfo;

//- (void)saveBankCardListData:(NSArray *)bankArr;
//- (NSMutableArray *)queryBankCardListData;
//

- (FMDatabase *)getDataBase;
- (BOOL)openDB;
- (BOOL)closeDB;
@end
