//
//  BaseTableHeaderFooterView.h
//  TXiOSClient
//
//  Created by dsc on 15/5/7.
//  Copyright (c) 2015年 liguohui. All rights reserved.
//

#import "TableHeaderView.h"
#import "UIView+Additions.h"

@implementation TableHeaderView
{
    UILabel *_titleLabel;   //  标题
    UIView *_sectionTitleView;  //  承载标题的view
    UIImageView *_indicatorImgView; //  指示图标
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _sectionTitleView = [[UIView alloc] initWithFrame:CGRectZero];
        _sectionTitleView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionDidTaped:)];
        [_sectionTitleView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:_sectionTitleView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_sectionTitleView addSubview:_titleLabel];
        
        _indicatorImgView = [[UIImageView alloc] init];
        _indicatorImgView.size = CGSizeMake(8, 16);
        _indicatorImgView.image = [UIImage imageNamed:@"rightArrow"];
        [_sectionTitleView addSubview:_indicatorImgView];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.layer.cornerRadius = 10;
    _sectionTitleView.frame = self.contentView.bounds;
    _titleLabel.frame = CGRectMake(20, 0, self.contentView.width - 40, self.contentView.height);
    _indicatorImgView.right = self.contentView.width - 20;
    _indicatorImgView.centerY = self.contentView.centerY;
}

- (void)setSectionTitle:(NSString *)sectionTitle
{
    _titleLabel.text = sectionTitle;
}

-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    [UIView animateWithDuration:0.25 animations:^{
        if (isOpen) {
            _indicatorImgView.transform = CGAffineTransformMakeRotation(M_PI/2);
            
        }else {
            _indicatorImgView.transform = CGAffineTransformMakeRotation(0);
        }
    }];
}

-(void)setContentBGColor:(UIColor *)contentBGColor
{
    self.contentView.backgroundColor = contentBGColor;
}

#pragma mark - tap action
- (void)sectionDidTaped:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(headerViewDidTaped:sectionIndex:)]) {
        [self.delegate headerViewDidTaped:self sectionIndex:self.sectionIndex];
    }
}


@end
