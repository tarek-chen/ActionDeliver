//
//  UIResponder+deliver.h
//  ActionDeliverDemo
//
//  Created by chen on 2017/10/26.
//  Copyright © 2017年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const action_obj = @"action_obj";
@interface UIResponder (deliver)

- (void)action_deliverEventsWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
