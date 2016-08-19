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
@property (nonatomic, strong)CALayer *startPoint;
@property (nonatomic, strong)CAShapeLayer *endPoint;
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
    self.backgroundColor = [UIColor clearColor];
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectZero];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
        _centerView.layer.masksToBounds = YES;
        [self addSubview:_centerView];
    }
    return _centerView;
}

- (ZYPercentageLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[ZYPercentageLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setProgress:(CGFloat)progress {
    CGFloat lastProgress = _progress;
    _progress = progress;
    
    if (_lineCap) {
        self.centerView.layer.cornerRadius = (self.frame.size.width - 1.2* _borderWidth)/2;
        self.centerView.bounds = CGRectMake(0, 0, (self.frame.size.width - _borderWidth) * 0.9, (self.frame.size.width - _borderWidth) * 0.9);
        self.centerView.hidden = NO;
    } else {
        _centerView.hidden = YES;
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d", (int)(progress * 100)];
    self.titleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self bringSubviewToFront:self.titleLabel];
    
    self.centerView.layer.cornerRadius = (self.frame.size.width - _borderWidth) * 0.9 / 2;
    self.centerView.bounds = CGRectMake(0, 0, (self.frame.size.width - _borderWidth) * 0.9, (self.frame.size.width - _borderWidth) * 0.9);
    
    [self animationWithLastProgress:lastProgress];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
    if (_lineCap) {
        self.centerView.layer.cornerRadius = (self.frame.size.width - 1.2* _borderWidth)/2;
        self.centerView.bounds = CGRectMake(0, 0, (self.frame.size.width - _borderWidth) * 0.9, (self.frame.size.width - _borderWidth) * 0.9);
        self.centerView.hidden = NO;
    } else {
        _centerView.hidden = YES;
    }
    
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

- (void)animationWithLastProgress:(CGFloat)lastProgress {
    NSTimeInterval duration = fabs(2.0 * (_progress - lastProgress));
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(lastProgress+0.000001);
    animation.toValue = @(_progress+0.000001);
    animation.duration = duration;
    self.progressCircleLayer.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    // 设置layer的animation
    [self.progressCircleLayer addAnimation:animation forKey:nil];
    
    if (_lineCap) {
        
        CGFloat startPointW = _borderWidth * 0.4f;
        self.startPoint.cornerRadius = startPointW/2;
        self.startPoint.bounds = CGRectMake(0, 0, startPointW, startPointW);
        self.startPoint.position = CGPointMake(self.frame.size.width, self.frame.size.height/2);
        
        CABasicAnimation *endPointStrokeStartAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        endPointStrokeStartAni.fromValue = @(lastProgress-0.000001);
        endPointStrokeStartAni.toValue = @(_progress-0.000001);

        endPointStrokeStartAni.duration = duration;
        self.progressCircleLayer.autoreverses = NO;

        endPointStrokeStartAni.fillMode = kCAFillModeForwards;
        endPointStrokeStartAni.removedOnCompletion = NO;

        [self.endPoint addAnimation:animation forKey:nil];
        [self.endPoint addAnimation:endPointStrokeStartAni forKey:nil];
    }
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

// 起始小点
- (CALayer *)startPoint {
    if (!_startPoint) {
        
        _startPoint = [CALayer layer];
        _startPoint.backgroundColor = [UIColor whiteColor].CGColor;
        _startPoint.masksToBounds = YES;
        [_progressCircleLayer addSublayer:_startPoint];
    }
    
    return _startPoint;
}

- (CAShapeLayer *)endPoint {
    if (!_endPoint) {
        
        _endPoint = [self shapeLayerWithStrokeColor:[UIColor whiteColor]];
        CATransform3D transfrom = CATransform3DIdentity;
        _endPoint.transform = CATransform3DRotate(transfrom, -M_PI/2, 0, 0, 1);
        _endPoint.lineCap = kCALineCapRound;
        [_backCircleLayer addSublayer:_endPoint];
    }
    
    return _endPoint;
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

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setProgress:_progress];
}

@end
