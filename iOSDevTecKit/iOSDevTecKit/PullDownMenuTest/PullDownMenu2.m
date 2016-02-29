//
//  PullDownMenu.m
//  iOSDevTecKit
//
//  Created by 郑光龙 on 15/12/25.
//  Copyright © 2015年 郑光龙. All rights reserved.
//

#import "PullDownMenu2.h"

@interface PullDownMenu2 ()
{
    BOOL bShowList;
}
@end

@implementation PullDownMenu2

+ (instancetype)menu{
    PullDownMenu2* instance =  [[[NSBundle mainBundle] loadNibNamed:@"PullDownMenu2" owner:self options:nil] lastObject];
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
    if (bShowList) {
        self.frame = self.showListFrame;
        if (self.showListViewEvent) {
            self.showListViewEvent();
        }

    }else
    {
        self.frame = self.hideListFrame;
        if (self.hideListViewEvent) {
            self.hideListViewEvent();
        }
    }
}

//frame变化时会调用此方法
- (void)layoutSubviews {
    NSLog(@"layoutSubviews");
    if (bShowList) {
        self.frame = self.showListFrame;//CGRectMake(100, 100,100, 100);
        self.indicatorImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.smallArrowImage.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.tableview.hidden = NO;
    }else {
        self.frame = self.hideListFrame;//CGRectMake(100, 100,100, 35);
        self.indicatorImageView.transform = CGAffineTransformMakeRotation(0);
        self.smallArrowImage.transform = CGAffineTransformMakeRotation(0);
        self.tableview.hidden = YES;
    }
}

- (void)setState:(BOOL)state {
    _state = state;
    bShowList = state;
    [self layoutSubviews];
}

- (void)setDataSoure:(NSArray *)dataSoure {
    if (_dataSoure != dataSoure) {
        _dataSoure = dataSoure;
//        if ([_dataSoure count] > 0 && [self.title.text isEqualToString:@""]) {
//             self.title.text= [_dataSoure objectAtIndex:0];
//        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSoure count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.dataSoure objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
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

- (void)showAmallImageView:(BOOL)show{

    if (show) {
        self.smallArrowImage.hidden = NO;
        self.indicatorImageView.hidden = YES;
    }else {
        self.smallArrowImage.hidden = YES;
        self.indicatorImageView.hidden = NO;
    }
}

@end
