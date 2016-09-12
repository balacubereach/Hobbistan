//
//  UIView+Contrains.m
//  InstaPuller
//
//  Created by KPTech on 8/7/15.
//  Copyright (c) 2015 KhanhTran. All rights reserved.
//

#import "UIView+Contrains.h"

@implementation UIView (Contrains)

+ (void)addEdgeConstraint:(NSLayoutAttribute)edge
                superview:(UIView *)superview
                  subview:(UIView *)subview
                 constant:(float)constant{
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                          attribute:edge
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superview
                                                          attribute:edge
                                                         multiplier:1
                                                           constant:constant]];
}

+ (void)addEdgeConstraint:(NSLayoutAttribute)edge
                relatedBy:(NSLayoutRelation)relation
                    value:(CGFloat)value
                superview:(UIView *)superview
                  subview:(UIView *)subview {
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                          attribute:edge
                                                          relatedBy:relation
                                                             toItem:superview
                                                          attribute:edge
                                                         multiplier:1
                                                           constant:value]];
}

@end
