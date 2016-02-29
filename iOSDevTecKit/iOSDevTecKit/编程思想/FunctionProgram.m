//
//  FunctionProgram.m
//  iOSDevTecKit
//
//  Created by ybon on 16/2/14.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "FunctionProgram.h"

@interface FunctionProgram ()

@end

@implementation FunctionProgram

- (void)viewDidLoad {
    [super viewDidLoad];
    Calculator *calculator = [[Calculator alloc] init];
    
  BOOL isEqule = [[[calculator calcaulator:^int(int result) {
        result += 2;
        result *= 5;
        return result;
    }] equle:^BOOL(int result) {
        return result == 10;
    }] isEqule];

    if (isEqule) {
        NSLog(@"2*5==10");
    }
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

@implementation Calculator

- (Calculator *)calcaulator:(int (^)(int result))calcaulator {
    self.result = calcaulator(self.result);
    return self;
}
- (Calculator *)equle:(BOOL (^)(int result))operation {
    self.isEqule = operation(self.result);
    return self;
}
@end
