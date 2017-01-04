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
    dispatch_source_t _timer;
}
@property(nonatomic, strong) UIImageView *hornImageView;
@property(nonatomic, strong) UILabel *messageTypeLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UITextView *contentTextView;
@end
@implementation ScrollMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _scrollView.userInteractionEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
//        [self addSubview:_scrollView];
        [self addSubview:self.hornImageView];
        [self addSubview:self.messageTypeLabel];
//        [_scrollView addSubview:self.contentLabel];
        [self addSubview:self.contentTextView];
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
//    _scrollView.frame = self.bounds;
    _hornImageView.frame = CGRectMake(0, 2, self.size.height-4, self.size.height-4);
    
    CGSize size = [self labelheight:self.messageTypeLabel limitedWidth:30];
    float offsetY = ([UIScreen mainScreen].bounds.size.width > 320.1) ? 8 : 4;
    _messageTypeLabel.frame = CGRectMake(15, 0, size.width, self.size.height);
    _contentTextView.frame = CGRectMake(CGRectGetMaxX(_messageTypeLabel.frame)+5, offsetY, self.size.width-CGRectGetMaxX(_messageTypeLabel.frame)-10, self.size.height-2*offsetY);
    if ([UIScreen mainScreen].bounds.size.width > 320.1) {
        _contentTextView.contentOffset= CGPointMake(0, 10);
    }else {
        _contentTextView.contentOffset= CGPointMake(0, 10);
    }
    

//    size = [self labelheight:self.contentLabel];
//    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_messageTypeLabel.frame)+5, 0, self.size.width-CGRectGetMaxX(_messageTypeLabel.frame)-20, size.height);
//    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_contentLabel.frame));
//    _scrollView.contentOffset = CGPointMake(0, 0);
}


- (CGSize)labelheight:(UILabel *)detlabel limitedWidth:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    CGSize size = CGSizeMake(width , CGFLOAT_MAX);
    CGSize contentactually = [detlabel.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return contentactually;
}

- (UIImageView *)hornImageView {
    if (_hornImageView) {
        return _hornImageView;
    }

    _hornImageView = [[UIImageView alloc] init];
    _hornImageView.image = [UIImage imageNamed:@"horn"];
    _hornImageView.backgroundColor = [UIColor whiteColor];
    _hornImageView.hidden = YES;
    return _hornImageView;
}

- (UILabel *)messageTypeLabel {
    if (_messageTypeLabel) {
        return _messageTypeLabel;
    }
    
    _messageTypeLabel = [[UILabel alloc] init];
//    _messageTypeLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:14.0];
    _messageTypeLabel.font =[UIFont italicSystemFontOfSize:14.0];
    _messageTypeLabel.textColor = [UIColor redColor];
    _messageTypeLabel.text = @"升级公告";
    _messageTypeLabel.numberOfLines = 2;
    _messageTypeLabel.backgroundColor = [UIColor whiteColor];
//    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-20 * (CGFloat)M_PI / 180), 1, 0, 0);
//    
//    _messageTypeLabel.transform = matrix;
    return _messageTypeLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel) {
        return _contentLabel;
    }
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _contentLabel.text = @"今晚20：00App升级，给您带来的不便，敬请谅解！哈哈 收到货发顺丰该多好过圣诞节";
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
    [_contentLabel setAttributedText:attributedString1];
    [_contentLabel sizeToFit];
    return _contentLabel;
}

- (UITextView *)contentTextView {
    if (_contentTextView) {
        return _contentTextView;
    }
    
    _contentTextView = [[UITextView alloc] init];
    _contentTextView.editable = NO;
    _contentTextView.userInteractionEnabled = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _contentTextView.attributedText = [[NSAttributedString alloc] initWithString:@"今晚20：00App升级，给您带来的不便，敬请谅解！哈哈 收到货发顺丰该多好过圣诞" attributes:attributes];
    
    return _contentTextView;

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
    _contentTextView.text = _content;
}

- (void)startTimer {
    if (_timer) {
        return;
    }

    if (_contentTextView.contentSize.height <= _contentTextView.size.height) {
        return;
    }
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
    NSTimeInterval period = 0.1; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    typeof(self) __weak seakself = self;
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [seakself timerAction];
        });
    });
    dispatch_resume(_timer);
}

- (void)timerAction {
    __block CGPoint newOffset = _contentTextView.contentOffset;
    newOffset.y  = newOffset.y+1;
    if (newOffset.y > _contentTextView.contentSize.height) {
        [UIView animateWithDuration:0.2 animations:^{
            newOffset.y = -_contentTextView.frame.size.height;
        }];
    }
    _contentTextView.contentOffset = newOffset;
}
@end
