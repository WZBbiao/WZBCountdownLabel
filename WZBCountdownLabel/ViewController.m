//
//  ViewController.m
//  WZBCountdownLabel
//
//  Created by WZB on 16/6/8.
//  Copyright © 2016年 王振标. All rights reserved.
//

#import "ViewController.h"
#import "WZBCountdownLabel.h"

@interface ViewController () <WZBCountdownLabelDelegate>

@end

@implementation ViewController

#pragma mark - system
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /// 绑定代理，要在play方法之前
    [WZBCountdownLabel addDelegate:self];
    /*
     * return WZBCountdownLabel对象
     * number : 倒计时开始的数字
     * endTitle : 结束语
     * success : 倒计时成功的回调
     */
    [WZBCountdownLabel playWithNumber:5 endTitle:@"GO" begin:^(WZBCountdownLabel *label) {
        NSLog(@"blockBegin");
    } success:^(WZBCountdownLabel *label) {
        NSLog(@"blockSuccess");
    }];
}

#pragma mark - WZBCountdownLabelDelegate
- (void)countdownBegin:(WZBCountdownLabel *)label {
    NSLog(@"delegateBegin");
}

- (void)countdownSuccess:(WZBCountdownLabel *)label {
    NSLog(@"delegateSuccess");
}


@end
