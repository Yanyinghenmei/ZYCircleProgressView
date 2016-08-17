//
//  ZYCircleProgressView.m
//  ZYCircleProgressViewDemo
//
//  Created by Daniel on 16/4/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYCircleProgressView.h"
#import "ZYPercentageLabel.h"

@interface ZYCircleProgressView ()
@property (nonatomic, strong)CAShapeLayer *progressCircleLayer;
@property (nonatomic, strong)CAShapeLayer *backCircleLayer;
@end

@implementation ZYCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setProperty];
    }
    return self;
}

- (void)awakeFromNib {
    [self setProperty];
}

- (void)setProperty {
    _borderColor = HEXCOLORV(0xf1f1f1);
    _borderTintColor = HEXCOLORV(0x1dbaf1);
    _borderWidth = 3.0f;
    self.progress = 0;
}

- (ZYPercentageLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[ZYPercentageLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.titleLabel.text = [NSString stringWithFormat:@"%d", (int)(progress * 100)];
    
    self.titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [self animation];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.progressCircleLayer.lineWidth = borderWidth;
    self.backCircleLayer.lineWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.backCircleLayer.strokeColor = borderColor.CGColor;
}

- (void)setBorderTintColor:(UIColor *)borderTintColor {
    _borderTintColor = borderTintColor;
    self.progressCircleLayer.strokeColor = borderTintColor.CGColor;
}

- (void)animation {
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(_progress);
    animation.duration = 2.0*_progress;
    self.progressCircleLayer.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    // 设置layer的animation
    [self.progressCircleLayer addAnimation:animation forKey:nil];
}

- (CAShapeLayer *)progressCircleLayer {
    if (!_progressCircleLayer) {
        
        _progressCircleLayer = [self shapeLayerWithStrokeColor:_borderTintColor];
        CATransform3D transfrom = CATransform3DIdentity;
        _progressCircleLayer.transform = CATransform3DRotate(transfrom, -M_PI/2, 0, 0, 1);
        //添加并显示
        [self.backCircleLayer addSublayer:_progressCircleLayer];
    }
    return _progressCircleLayer;
}

- (void)setLineCap:(NSString *)lineCap {
    _lineCap = lineCap;
    self.progressCircleLayer.lineCap = lineCap;
}

// 背景圆圈
- (CAShapeLayer *)backCircleLayer {
    if (!_backCircleLayer) {
        
        _backCircleLayer = [self shapeLayerWithStrokeColor:_borderColor];
        
        //添加并显示
        [self.layer addSublayer:_backCircleLayer];
    }
    return _backCircleLayer;
}

- (CAShapeLayer *)shapeLayerWithStrokeColor:(UIColor *)strokeColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath;
    if (strokeColor == _borderColor) {
        shapeLayer.frame = self.bounds;
        circlePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    } else {
        shapeLayer.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
        circlePath = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds];
    }
    shapeLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = _borderWidth;
    shapeLayer.strokeColor = strokeColor.CGColor;
    
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    return shapeLayer;
}

@end
