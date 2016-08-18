//
//  ViewController.m
//  ZYCircleProgressViewDemo
//
//  Created by Daniel on 16/4/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "ZYPercentageLabel.h"

#import "ZYCircleProgressView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZYCircleProgressView *cir1;
@property (weak, nonatomic) IBOutlet ZYCircleProgressView *cir2;
@property (weak, nonatomic) IBOutlet ZYCircleProgressView *cir3;
@property (weak, nonatomic) IBOutlet ZYCircleProgressView *cir4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cir1.borderTintColor = [UIColor colorWithRed:243/255.00 green:126/255.00 blue:58/255.00 alpha:1];
    _cir2.borderTintColor = [UIColor colorWithRed:243/255.00 green:126/255.00 blue:58/255.00 alpha:1];
    
    _cir1.borderWidth = 10;
    _cir1.titleLabel.hidden = YES;
    
    _cir3.lineCap = kCALineCapRound;
    _cir3.borderWidth = 15;
    
    [self refresh:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refresh:(id)sender {
    _cir1.progress = (double)(arc4random()%100)/100;
    _cir2.progress = (double)(arc4random()%100)/100;
    _cir3.progress = (double)(arc4random()%100)/100;
    _cir4.progress = (double)(arc4random()%100)/100;
}

@end
