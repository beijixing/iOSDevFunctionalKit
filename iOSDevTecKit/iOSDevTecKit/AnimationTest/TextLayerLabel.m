//
//  TextLayerLabel.m
//  iOSDevTecKit
//
//  Created by Megatron on 16/7/27.
//  Copyright © 2016年 郑光龙. All rights reserved.
//

#import "TextLayerLabel.h"

@implementation TextLayerLabel

+(Class)layerClass {
    return [CATextLayer class];
}

- (CATextLayer *)textLayer {
    return (CATextLayer*)self.layer;
}

- (void)setUp {
    //set defaults from UILabel settings
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

- (void)setText:(NSString *)text {
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor {
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    super.font = font;
    CFStringRef fontNname = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontNname);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
