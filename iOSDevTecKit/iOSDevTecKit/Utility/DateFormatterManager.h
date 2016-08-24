//
//  DateFormatterManager.h
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/22.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatterManager : NSObject
+ (instancetype)sharedManager;
- (NSDateFormatter*)getDateFormater;
@end
