//
//  HomeTabController.h
//  Hobbistan
//
//  Created by KPTech on 1/8/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHomeViewController.h"


@interface HomeTabController : UIViewController
- (IBAction)closebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *popUpView;

@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet UISwitch *sorting1;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *homeEventArr;
@property (nonatomic, assign) BOOL isBookmark;
@property (nonatomic, assign) BOOL isSearch;

@property (nonatomic, strong) NSMutableArray *HomeEventArray;
@property (nonatomic, strong) NSString *locationString;
@property (weak, nonatomic) IBOutlet UILabel *eventsLable;

@property (nonatomic, strong)	NSDictionary	*contents;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;
@property (nonatomic, strong)	NSDictionary	*titles;
@property (nonatomic, strong)	NSArray			*colorSchemes;


- (IBAction)backbuttonAction;


@end
