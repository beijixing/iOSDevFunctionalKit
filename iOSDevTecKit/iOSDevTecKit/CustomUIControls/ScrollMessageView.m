//
//  ScrollMessageView.m
//  WoJK
//
//  Created by Megatron on 16/5/16.
//  Copyright © 2016年 zhilong. All rights reserved.
//

#import "ScrollMessageView.h"
#import "UIView+Additions.h"
@interface ScrollMessageView()
{
    UIScrollView *_scrollView;
    NSTimer *_timer;
}
@property(nonatomic, strong) UIImageView *hornImageView;
@property(nonatomic, strong) UILabel *messageTypeLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@end
@implementation ScrollMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _scrollView.userInteractionEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [_scrollView addSubview:self.hornImageView];
        [_scrollView addSubview:self.messageTypeLabel];
        [_scrollView addSubview:self.contentLabel];
        [self addSubview:_scrollView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)gestureEvent:(UITapGestureRecognizer*)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMessageView:clicked:)]) {
        [self.delegate scrollMessageView:self clicked:YES];
    }
}

- (void)layoutSubviews {
    NSLog(@"good news");
    _scrollView.frame = self.bounds;
    _hornImageView.frame = CGRectMake(2, 2, self.size.height-4, self.size.height-4);
    
    CGSize size = [self labelheight:self.messageTypeLabel];
    
    _messageTypeLabel.frame = CGRectMake(CGRectGetMaxX(_hornImageView.frame), 0, size.width, self.size.height);
    size = [self labelheight:self.contentLabel];
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_messageTypeLabel.frame), 0, size.width, self.size.height);
    _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(_contentLabel.frame), 0);
    _scrollView.contentOffset = CGPointMake(0, 0);
}


- (CGSize)labelheight:(UILabel *)detlabel

{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
//    paragraphStyle.lineSpacing = 1;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    CGSize size = CGSizeMake(CGFLOAT_MAX, self.size.height);
    CGSize contentactually = [detlabel.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return contentactually;
}

- (UIImageView *)hornImageView {
    if (_hornImageView) {
        return _hornImageView;
    }

    _hornImageView = [[UIImageView alloc] init];
    _hornImageView.image = [UIImage imageNamed:@"horn"];
    return _hornImageView;
}

- (UILabel *)messageTypeLabel {
    if (_messageTypeLabel) {
        return _messageTypeLabel;
    }
    
    _messageTypeLabel = [[UILabel alloc] init];
    _messageTypeLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    _messageTypeLabel.textColor = [UIColor redColor];
    _messageTypeLabel.text = @"升级公告:";
    return _messageTypeLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel) {
        return _contentLabel;
    }
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.text = @"今晚20：00App升级，给您带来的不便，敬请谅解！";
    return _contentLabel;
}

- (void)setMessageTypeName:(NSString *)messageTypeName {
    if (_messageTypeName == messageTypeName) {
        return;
    }
    _messageTypeName = messageTypeName;
    _messageTypeLabel.text = _messageTypeName;
    
    
}

- (void)setContent:(NSString *)content {
    if (_content == content) {
        return;
    }
    _content = content;
    _contentLabel.text = _content;
    
}

- (void)startTimer {
    if (_timer) {
        return;
    }

    if (_scrollView.contentSize.width <= _scrollView.size.width) {
        return;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction {
    __block CGPoint newOffset = _scrollView.contentOffset;
    newOffset.x  = newOffset.x+1;
    if (newOffset.x > _scrollView.contentSize.width - _scrollView.size.width/2) {
        [UIView animateWithDuration:0.2 animations:^{
            newOffset.x = 0;
        }];
    }
    _scrollView.contentOffset = newOffset;
}

@end
