//
//  UIView+Extra.m
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "UIView+Extra.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Extra)

- (void)setRoundCorner:(float)radian boderColor:(UIColor *)color {
    if (radian) {
        self.layer.cornerRadius = radian;
        self.layer.masksToBounds    = YES;
    }
    if (color) {
        self.layer.borderWidth  = 1.0f;
        self.layer.borderColor  = color.CGColor;
    }
}

@end
