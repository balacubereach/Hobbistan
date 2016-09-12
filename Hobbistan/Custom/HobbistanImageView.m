//
//  HobbistanImageView.m
//  Hobbistan
//
//  Created by Khagesh on 14/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "HobbistanImageView.h"

@implementation HobbistanImageView

- (void)awakeFromNib {
    
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self setTintColor:[UIColor redColor]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
