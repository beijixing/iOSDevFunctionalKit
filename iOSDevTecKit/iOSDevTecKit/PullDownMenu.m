//
//  PullDownMenu.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/25.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "PullDownMenu.h"

@interface PullDownMenu ()
{
    BOOL bShowList;
}
@end

@implementation PullDownMenu

+ (instancetype)menu{
    PullDownMenu* instance =  [[[NSBundle mainBundle] loadNibNamed:@"PullDownMenu" owner:self options:nil] lastObject];
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
      
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"awakeFromNib");
    self.title.frame = CGRectZero;
    self.tableview.frame = CGRectZero;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEvent)];
    self.title.userInteractionEnabled = true;
    [self.title addGestureRecognizer:tapGesture];
    bShowList = false;
}

- (void)tapGestureEvent {
    NSLog(@"tapGestureEvent");
    bShowList = !bShowList;
    [self layoutSubviews];
}

- (void)layoutSubviews {
    NSLog(@"layoutSubviews");
    if (bShowList) {
        self.frame = self.showListFrame;//CGRectMake(100, 100,100, 100);
        self.indicatorImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.tableview.hidden = NO;
        
    }else {
        self.frame = self.hideListFrame;//CGRectMake(100, 100,100, 35);
        self.indicatorImageView.transform = CGAffineTransformMakeRotation(0);
        self.tableview.hidden = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedStr = cell.textLabel.text;
    self.title.text = selectedStr;
    if (self.getSelectedText) {
        self.getSelectedText(selectedStr);
    }
    
}

@end
