//
//  UIView+Contrains.h
//  InstaPuller
//
//  Created by KPTech on 8/7/15.
//  Copyright (c) 2015 KhanhTran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Contrains)

+ (void)addEdgeConstraint:(NSLayoutAttribute)edge
                superview:(UIView *)superview
                  subview:(UIView *)subview
                 constant:(float)constant;
+ (void)addEdgeConstraint:(NSLayoutAttribute)edge
                relatedBy:(NSLayoutRelation)relation
                    value:(CGFloat)value
                superview:(UIView *)superview
                  subview:(UIView *)subview;
@end
