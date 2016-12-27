//
//  LinkedTableView.h
//  iOSDevTecKit
//
//  Created by Megatron on 16/8/24.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LinkedTableView;
@protocol LinkedTableViewDelegate <NSObject>

-(void)linkedTableView:(LinkedTableView *)linkedTable registerCellForLeftTableView:(UITableView *)leftTable rightTableView:(UITableView *)rightTable;

- (NSInteger)linkedTableView:(LinkedTableView *)linkedTable getNumberOfRowsInSection:(NSInteger)section forLeftTableView:(BOOL)forLeft; //YES forLeftTableView; NO forRighTableView

- (NSInteger)numberOfSectionsInRightTable:(LinkedTableView *)linkedTable;

- (NSString *)linkedTableView:(LinkedTableView *)linkedTable getTableViewCellIdentifier:(BOOL)forLeftTable;//YES forLeftTableView; NO forRighTableView

- (void)linkedTableView:(LinkedTableView *)linkedTable configTableCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath forTableView:(BOOL)left; //YES forLeftTableView; NO forRighTableView
- (CGFloat)linkedTableView:(LinkedTableView *)linkedTable heightForRowOfTableView:(BOOL)left;//YES forLeftTableView; NO forRighTableView

- (CGFloat)linkedTableView:(LinkedTableView *)linkedTable heightForHeaderView:(BOOL)left;//YES forLeftTableView; NO forRighTableView
- (void)linkedTableView:(LinkedTableView *)linkedTable rightTableDidSelectedCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LinkedTableView : UIView
@property(nonatomic, weak) id <LinkedTableViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame AndLeftTableViewWidth:(float)width;
@end
