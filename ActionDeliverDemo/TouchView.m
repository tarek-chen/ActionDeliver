//
//  TouchView.m
//  ActionDeliverDemo
//
//  Created by chen on 2017/10/26.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView {
    NSInteger counts;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    counts = 0;
}

- (IBAction)btnClicked:(UIButton *)sender {
    counts++;
    NSDictionary *parameter = @{action_obj: sender, @"count": @(counts)};
    
    [self.nextResponder action_deliverEventsWithName:buttonClicked userInfo:parameter];
}

@end
