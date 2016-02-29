//
//  lianshiThink.m
//  iOSDevTecKit
//
//  Created by ybon on 16/2/14.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "LineProgram.h"

@interface LineProgram ()

@end

@implementation LineProgram

- (void)viewDidLoad {
    [super viewDidLoad];

    int result = [NSObject makeCaculators:^(CaculatorMaker *maker) {
        maker.add(1).add(1).add(3);
    }];
    
    NSLog(@"result = %d", result);
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

@implementation CaculatorMaker

-(CaculatorMaker * (^)(int))add {
    return ^CaculatorMaker* (int value){
        self.result += value;
        return self;
    };
}

-(CaculatorMaker * (^)(int))sub {
    return ^CaculatorMaker *(int value) {
        self.result -= value;
        return self;
    };
}

-(CaculatorMaker * (^)(int))divide {
    return ^CaculatorMaker *(int value) {
        self.result *= value;
        return self;
    };
}

-(CaculatorMaker * (^)(int))multi {
    return ^CaculatorMaker *(int value) {
        self.result /= value;
        return self;
    };
}
@end


@implementation NSObject (Caculator)
+(int)makeCaculators:(void(^)(CaculatorMaker *maker))caculatorMaker {
    CaculatorMaker* maker = [[CaculatorMaker alloc] init];
    caculatorMaker(maker);
    return maker.result;
}
@end
