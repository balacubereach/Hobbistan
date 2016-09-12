//
//  BaseHomeViewController.h
//  Hobbistan
//
//  Created by KPTech on 1/14/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface BaseHomeViewController : UIViewController<CMPopTipViewDelegate>

@property (nonatomic, strong) UITableView *searchAdapter;

@property (nonatomic, strong)	NSArray			*colorSchemes;
@property (nonatomic, strong)	NSDictionary	*contents;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic, strong)	NSDictionary	*titles;
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;

@property (nonatomic, strong) UISearchController *searchController;

- (void)updateIndex;

@end
