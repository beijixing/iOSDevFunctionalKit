//
//  CircleButton.m
//  HiSchool
//
//  Created by ybon on 16/3/8.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "CircleButton.h"
#import "Masonry.h"
#import "UIButton+WebCache.h"
@interface CircleButton()

@property(nonatomic, strong) UIButton* cirCleButton;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation CircleButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.cirCleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cirCleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cirCleButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:frame];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        
        [self addSubview:self.titleLabel];
        [self layoutSubviews];
    }
    return self;
}

- (void)addButtonImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage {
    [self.cirCleButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.cirCleButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
}

- (void)addButtonImageWithURL:(NSURL *)imageUrl selectedImageWithUrl:(NSURL *)selectedImageUrl placeHolder:(NSString *)placeHolder {
    [self.cirCleButton sd_setBackgroundImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeHolder]];
    [self.cirCleButton sd_setBackgroundImageWithURL:selectedImageUrl forState:UIControlStateSelected placeholderImage:[UIImage imageNamed:placeHolder]];
}

- (void)setupTitileLabelFont:( UIFont *)font textColor:(UIColor *)color text:(NSString *)txt {
    self.titleLabel.font = font;
    self.titleLabel.textColor = color;
    self.titleLabel.text = txt;
}

- (void)buttonClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(self.tag, self.titleLabel.text);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.cirCleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.height - 50, self.frame.size.height - 50));
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.cirCleButton.mas_bottom);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
}
@end
