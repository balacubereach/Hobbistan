//
//  UIHelper.h
//  SocialEvening
//
//  Created by KP Tech on 07/12/2015.
//  Copyright © 2015 KPTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIHelper : NSObject

+ (UIHelper *)sharedInstance;

- (void)showHudInView:(UIView *)view;
- (void)hideHudInView:(UIView *)view;

@end
