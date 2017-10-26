//
//  ViewController.m
//  ActionDeliverDemo
//
//  Created by chen on 2017/10/26.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TouchView *tv = [[NSBundle mainBundle] loadNibNamed:@"TouchView" owner:nil options:nil].firstObject;
    tv.frame = CGRectMake(0, 0, 375, 667);
    [self.view addSubview:tv];
}

- (void)action_deliverEventsWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    // 1.一般用法
//    if ([buttonClicked isEqualToString:eventName]) {
//       [self changeTitle:userInfo];
//    }
//    return;
    
    // 2.进阶用法：建议封装于基类VC，子类无需拦截直接实现对应即可
    SEL selector = NSSelectorFromString(eventName);
    if ([self respondsToSelector:selector]) {
        if (userInfo) {
            [self performSelector:selector withObject:userInfo];
        } else {
            [self performSelector:selector];
        }
    } else {
        // 无法响应，继续传递
        [self.nextResponder action_deliverEventsWithName:eventName userInfo:userInfo];
    }
    
}

- (void)changeTitle:(NSDictionary *)userInfo {
    UIButton *btn = userInfo[action_obj];
    NSString *title = [NSString stringWithFormat:@"暴击 x%ld", [userInfo[@"count"] integerValue]];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
