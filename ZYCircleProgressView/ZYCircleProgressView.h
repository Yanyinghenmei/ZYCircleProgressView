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
@property (nonatomic, strong)UIColor *borderTintColor;      // 进度条颜色
@property (nonatomic, strong)UIColor *borderColor;          // 进度条背景颜色
@property (nonatomic, assign)CGFloat borderWidth;           // 进度条宽度
@property (nonatomic, assign)CGFloat progress;              // 进度 0-1
@end
