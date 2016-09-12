//
//  CALayer+XibConfiguration.m
//  Hobbistan
//
//  Created by KPTech on 1/6/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
