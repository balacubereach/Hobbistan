//
//  UINavigationController+Extensions.m
//  Hobbistan
//
//  Created by KPTech on 1/14/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "UINavigationController+Extensions.h"
#import "BaseNavigationController.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation UINavigationController (Extensions)

- (void)setLeftTitle:(NSString *)title {
    if ([self.slidingViewController.topViewController isKindOfClass:[BaseNavigationController class]]){
        [(BaseNavigationController *)self.slidingViewController.topViewController willShowTitle:title];
    }
}

@end
