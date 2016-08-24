//
//  BaseTableHeaderFooterView.h
//  TXiOSClient
//
//  Created by dsc on 15/5/7.
//  Copyright (c) 2015年 liguohui. All rights reserved.
//

#import "BaseTableHeaderView.h"
#import "UIView+Additions.h"

@implementation BaseTableHeaderView
{
    UIImageView *_lineImageView;
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
        _indicatorImgView.size = CGSizeMake(15, 25);
        _indicatorImgView.image = [UIImage imageNamed:@"report_right"];
        [_sectionTitleView addSubview:_indicatorImgView];
        
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = [UIColor colorWithRed:233/250.0 green:233/250.0 blue:233/250.0 alpha:1.0];
        _lineImageView.hidden = NO;
        [_sectionTitleView addSubview:_lineImageView];
        
       
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _sectionTitleView.frame = self.contentView.bounds;
    _titleLabel.frame = CGRectMake(15, 0, self.contentView.width - 35, self.contentView.height);
    
    _lineImageView.frame = CGRectMake(15, _sectionTitleView.size.height-1, _sectionTitleView.size.width-15, 1);
    _indicatorImgView.right = self.contentView.width - 20;
    _indicatorImgView.centerY = self.contentView.centerY;
}

-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    [UIView animateWithDuration:0.25 animations:^{
        if (isOpen) {
            _indicatorImgView.transform = CGAffineTransformMakeRotation(-M_PI/2);
//            _lineImageView.hidden = NO;
            
        }else {
            _indicatorImgView.transform = CGAffineTransformMakeRotation(M_PI/2);
//            _lineImageView.hidden = YES;
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
