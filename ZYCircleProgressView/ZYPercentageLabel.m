//
//  ZYPercentageLabel.m
//  ZYCircleProgressViewDemo
//
//  Created by Daniel on 16/4/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYPercentageLabel.h"

@interface ZYPercentageLabel ()
@property (nonatomic, strong)UILabel *signLabel;
@end

@implementation ZYPercentageLabel

- (UILabel *)signLabel {
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _signLabel.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize/2];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel.text = @"%";
        [_signLabel sizeToFit];
        [self addSubview:_signLabel];
    }
    return _signLabel;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat signWidth = size.height/2;
    CGFloat selfWidth = size.width+signWidth*2;
    
    self.bounds = CGRectMake(0, 0, selfWidth, size.height);
    self.textAlignment = NSTextAlignmentCenter;
    self.signLabel.frame = CGRectMake(selfWidth - signWidth, 0, signWidth, signWidth);
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.signLabel.font = [UIFont fontWithName:font.fontName size:font.pointSize/2];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    self.signLabel.textColor = textColor;
}

@end
