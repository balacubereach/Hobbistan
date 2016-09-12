//
//  BaseNavigationController.h
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface BaseNavigationController : UINavigationController<CMPopTipViewDelegate>
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIView *blackView;

@property (nonatomic, strong)	NSArray			*colorSchemes;
@property (nonatomic, strong)	NSDictionary	*contents;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic, strong)	NSDictionary	*titles;
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;


- (void)willShowTitle:(NSString *)title;
@end
