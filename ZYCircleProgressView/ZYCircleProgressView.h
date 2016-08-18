//
//  ZYCircleProgressView.h
//  ZYCircleProgressViewDemo
//
//  Created by Daniel on 16/4/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYPercentageLabel;
@interface ZYCircleProgressView : UIView
@property (nonatomic, strong)ZYPercentageLabel *titleLabel;
@property (nonatomic, strong)UIView *centerView;
@property (nonatomic, strong)UIColor *borderTintColor;      // 进度条颜色
@property (nonatomic, strong)UIColor *borderColor;          // 进度条背景颜色
@property (nonatomic, assign)CGFloat borderWidth;           // 进度条宽度
@property (nonatomic, assign)CGFloat progress;              // 进度 0-1

/**
 *  kCALineCapRound  首尾圆角 
 *  专门做的一个样式, 除了圆角之外会有其他效果, 都由这个属性控制:
 *  centerView 会显示
 *  在进度条起始处会有小的圆点
 */
@property (nonatomic, copy)NSString *lineCap;
@end
