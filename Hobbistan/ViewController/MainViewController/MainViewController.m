
//
//  MainViewController.m
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "MainViewController.h"
#import "HMSegmentedControl.h"
#import "HomeTabController.h"
#import "NearbyTab.h"
#import "PopularTab.h"
#import "ExplorerTab.h"
#import "ResultEventTable.h"
#import "EventDetail.h"
#import "FilterVC.h"

#import "iRate.h"


@interface MainViewController ()<UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
{
    NSString *searchBtnClicked;
    NSString *filterBtnClicked;
    NSString *favorites;
    NSString *popular;
    NSString *hotspot;
    NSString *explore;
}
@property (nonatomic, strong)HMSegmentedControl *segmentedControl;
@property (nonatomic, strong)HomeTabController  *homeTab;
@property (nonatomic, strong)NearbyTab  *nearTab;
@property (nonatomic, strong)PopularTab  *popularTab;
@property (nonatomic, strong)ExplorerTab  *explorerTab;
@property (nonatomic, assign)NSInteger  selectedIndex;

@property (nonatomic, strong) UISearchController *searchController;
// our secondary search results table view
@property (nonatomic, strong) ResultEventTable *resultsTableController;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchBtnClicked = @"search";
    filterBtnClicked = @"filter";
    
    favorites = @"fav";
    popular = @"popular";
    hotspot = @"hotspt";
    explore = @"exp";
    
    _eventArray = [[NSMutableArray alloc] init];
    __weak typeof(self)wSelf    = self;
    _resultsTableController = [[ResultEventTable alloc] initWithSlectionBlock:^(Event *event) {
        [wSelf gotoEventDetail:event];
    }];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.delegate    = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:31/255 green:27/255 blue:28/255 alpha:1.0];
    
    
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    
     //self.searchController.searchBar.backgroundColor = [UIColor clearColor];
  // self.searchController.searchBar.backgroundColor = [UIColor redColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applauchtimeSave)
                                                 name:@"applaunch"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appinactivetime)
                                                 name:@"appinactive"
                                               object:nil];
    
//    for (UIView *subview in self.searchController.searchBar.subviews) {
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            [subview removeFromSuperview];
//            break;
//        }
//    }

//    self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:0.9294 green:0.3059 blue:0.5647 alpha:1.0];
//    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:0.9294 green:0.3059 blue:0.5647 alpha:1.0];

}

-(void)applauchtimeSave{
    
    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
    
    NSString *valueToSave = [NSString stringWithFormat:@"%f",seconds] ;
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"enterTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

-(void) appinactivetime{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"LaunchedOnce"])
    {
    
    NSTimeInterval inactiveseconds = [[NSDate date] timeIntervalSince1970];
    
    NSString *inactiveTime = [NSString stringWithFormat:@"%f",inactiveseconds] ;
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"enterTime"];
    
    NSLog(@"%@",inactiveTime);
    
    NSLog(@"%@",savedValue);
    
    CGFloat minuteDifference = ([inactiveTime doubleValue] - [savedValue doubleValue])/ 60.0;
    
     CGFloat avgSec = 30.00;
    
    if (minuteDifference > avgSec)
    {
        
         NSInteger appLaunchAmounts = [[NSUserDefaults standardUserDefaults] integerForKey:@"LaunchCounts"];
        
         [[NSUserDefaults standardUserDefaults] setInteger:appLaunchAmounts+1 forKey:@"LaunchCounts"];
        
    }
   
  }
    
}

- (void)gotoEventDetail:(Event *)event {
    [self.searchController setActive:FALSE];
    
     appDelegate.selectedTabDetail = @"";
    EventDetail *eventDetail  = [[EventDetail alloc] initWithNibName:@"EventDetail" bundle:nil];
    eventDetail.eventObject = event;
    [self.navigationController pushViewController:eventDetail  animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [self setupSegmentControl];
    [self setupTabs];
}

- (void)setupTabs {
    if (!_homeTab) {
        _homeTab    = [[HomeTabController alloc] initWithNibName:@"HomeTabController" bundle:nil];
        [_homeTab.view setFrame:CGRectMake(0, 0, kScreenWidth, _scrollView.frame.size.height)];
        [self addChildViewController:_homeTab];
        [self.scrollView addSubview:_homeTab.view];
        [_homeTab didMoveToParentViewController:self];
    }
    
    if (!_nearTab) {
        
        _nearTab    = [[NearbyTab alloc] initWithNibName:@"NearbyTab" bundle:nil];
        [_nearTab.view setFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollView.frame.size.height)];
        [self addChildViewController:_nearTab];
        [self.scrollView addSubview:_nearTab.view];
        [_nearTab didMoveToParentViewController:self];
    }
    
    if (!_popularTab) {
        _popularTab    = [[PopularTab alloc] initWithNibName:@"PopularTab" bundle:nil];
        [_popularTab.view setFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, _scrollView.frame.size.height)];
        [self addChildViewController:_popularTab];
        [self.scrollView addSubview:_popularTab.view];
        [_popularTab didMoveToParentViewController:self];
    }
    
    if (!_explorerTab) {
        _explorerTab    = [[ExplorerTab alloc] initWithNibName:@"ExplorerTab" bundle:nil];
        [_explorerTab.view setFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, _scrollView.frame.size.height)];
        [self addChildViewController:_explorerTab];
        [self.scrollView addSubview:_explorerTab.view];
        [_explorerTab didMoveToParentViewController:self];
        [_scrollView setContentSize:CGSizeMake(kScreenWidth*4, _scrollView.frame.size.height)];
    }
    
}

- (void)setupSegmentControl
{
    if (!_segmentedControl)
    {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:@[[UIImage imageNamed:@"home-dark"],
                                                                                [UIImage imageNamed:@"export-dark"],
                                                                                [UIImage imageNamed:@"nearby-dark"],
                                                                                [UIImage imageNamed:@"tickets-dark"]]
                                                        sectionSelectedImages:@[[UIImage imageNamed:@"home-white"],
                                                                                [UIImage imageNamed:@"explore-white"],
                                                                                [UIImage imageNamed:@"nearby-white"],
                                                                                [UIImage imageNamed:@"tickets-white"]]];
        _segmentedControl.frame                         = CGRectMake(0, 0, _segmentView.bounds.size.width, 50);
        _segmentedControl.selectionIndicatorHeight      = 4.0f;
        _segmentedControl.backgroundColor               = [UIColor clearColor];
        _segmentedControl.selectionIndicatorLocation    = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionStyle                = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorColor       = [UIColor whiteColor];

        [self.segmentView addSubview:_segmentedControl];
        
        
        
//        __weak typeof(self) weakSelf = self;
        
        [self.segmentedControl setIndexChangeBlock:^(NSInteger index)
        {
//            weakSelf.selectedIndex = index;
////            [weakSelf updateIndex];
//            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
//            [weakSelf.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * index, 0, kScreenWidth, weakSelf.scrollView.frame.size.height) animated:YES];
            
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            

            [self.view layoutIfNeeded];

        }];
        
    }
     [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
}
-(IBAction)segmentAction:(UISegmentedControl *)sender
{
   
    switch ([sender selectedSegmentIndex])
    {
        case 0:
            if ([favorites isEqualToString:@"fav"])
            {
                
                            favorites = @"";
                            NSString *contentMessage = nil;
                            UIView *contentView = nil;
                            NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
                            id content = [self.contents objectForKey:key];
                            if ([content isKindOfClass:[UIView class]]) {
                                contentView = content;
                            }
                            else if ([content isKindOfClass:[NSString class]]) {
                                contentMessage = content;
                            }
                            else {
                                contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
                            }
                
                            UIColor *backgroundColor = [UIColor blackColor];
                            UIColor *textColor = [UIColor whiteColor];
                
                
                            NSString *title = [self.titles objectForKey:key];
                
                            CMPopTipView *popTipView;
                            if (contentView) {
                                popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
                            }
                            else if (title) {
                                popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
                            }
                            else {
                                popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
                            }
                            popTipView.delegate = self;
                
                            /* Some options to try.
                             */
                            //popTipView.shouldEnforceCustomViewPadding = YES;
                            //popTipView.disableTapToDismiss = YES;
                            //popTipView.preferredPointDirection = PointDirectionUp;
                            //popTipView.hasGradientBackground = NO;
                            //popTipView.cornerRadius = 2.0;
                            //popTipView.sidePadding = 30.0f;
                            //popTipView.topMargin = 20.0f;
                            //popTipView.pointerSize = 50.0f;
                            //popTipView.hasShadow = NO;
                
                            if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
                                popTipView.backgroundColor = backgroundColor;
                            }
                            if (textColor && ![textColor isEqual:[NSNull null]]) {
                                popTipView.textColor = textColor;
                            }
                
                            popTipView.animation = arc4random() % 2;
                            popTipView.has3DStyle = (BOOL)(arc4random() % 2);
                
                            popTipView.dismissTapAnywhere = YES;
                            //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
                
                            if ([sender isKindOfClass:[UIButton class]])
                            {
                                UIButton *button = (UIButton *)sender;
                                [popTipView presentPointingAtView:button inView:self.view animated:YES];
                            }
                            else
                            {
              
                                
                                UISegmentedControl *button = (UISegmentedControl *)sender;
                                [popTipView presentPointingAtView:button inView:self.view animated:YES];
                            }
                            
                            [self.visiblePopTipViews addObject:popTipView];
                           
                            self.currentPopTipViewTarget = sender;
                                
                        }
                            else
                            {
                                _eventArray = _homeTab.homeEventArr;
                                
                                [self.navigationController setLeftTitle:@"FAVORITES"];
                            }
            break;
        case 1:
            if ([popular isEqualToString:@"popular"])
                            {
                                popular = @"";
                                NSString *contentMessage = nil;
                                UIView *contentView = nil;
                                NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
                                id content = [self.contents objectForKey:key];
                                if ([content isKindOfClass:[UIView class]]) {
                                    contentView = content;
                                }
                                else if ([content isKindOfClass:[NSString class]]) {
                                    contentMessage = content;
                                }
                                else {
                                    contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
                                }
                                // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
                                //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
                                //  UIColor *textColor = [colorScheme objectAtIndex:1];
                
                                //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
                                UIColor *backgroundColor = [UIColor blackColor];
                                UIColor *textColor = [UIColor whiteColor];
                
                
                                NSString *title = [self.titles objectForKey:key];
                
                                CMPopTipView *popTipView;
                                if (contentView) {
                                    popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
                                }
                                else if (title) {
                                    popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
                                }
                                else {
                                    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
                                }
                                popTipView.delegate = self;
                
                                /* Some options to try.
                                 */
                                //popTipView.shouldEnforceCustomViewPadding = YES;
                                //popTipView.disableTapToDismiss = YES;
                                //popTipView.preferredPointDirection = PointDirectionUp;
                                //popTipView.hasGradientBackground = NO;
                                //popTipView.cornerRadius = 2.0;
                                //popTipView.sidePadding = 30.0f;
                                //popTipView.topMargin = 20.0f;
                                //popTipView.pointerSize = 50.0f;
                                //popTipView.hasShadow = NO;
                
                                if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
                                    popTipView.backgroundColor = backgroundColor;
                                }
                                if (textColor && ![textColor isEqual:[NSNull null]]) {
                                    popTipView.textColor = textColor;
                                }
                
                                popTipView.animation = arc4random() % 2;
                                popTipView.has3DStyle = (BOOL)(arc4random() % 2);
                
                                popTipView.dismissTapAnywhere = YES;
                                //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
                
                                if ([sender isKindOfClass:[UIButton class]]) {
                                    UIButton *button = (UIButton *)sender;
                                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
                                }
                                else {
                                   // UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
                                    //[popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
                                    UISegmentedControl *button = (UISegmentedControl *)sender;
                                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
                                   // [popTipView presentPointingAtView:button inView:self.view animated:YES];
                
                                }
                                
                                [self.visiblePopTipViews addObject:popTipView];
                                
                                self.currentPopTipViewTarget = sender;
                            }
                            else
                            {
                                _eventArray = _nearTab.nearEventArr;
                                
                                [self.navigationController setLeftTitle:@"POPULAR"];
                                
                
                            }
            break;
        case 2:
            if ([hotspot isEqualToString:@"hotspt"])
                            {
                                hotspot = @"";
                                NSString *contentMessage = nil;
                                UIView *contentView = nil;
                                NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
                                id content = [self.contents objectForKey:key];
                                if ([content isKindOfClass:[UIView class]]) {
                                    contentView = content;
                                }
                                else if ([content isKindOfClass:[NSString class]]) {
                                    contentMessage = content;
                                }
                                else {
                                    contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
                                }
                                // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
                                //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
                                //  UIColor *textColor = [colorScheme objectAtIndex:1];
                
                                //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
                                UIColor *backgroundColor = [UIColor blackColor];
                                UIColor *textColor = [UIColor whiteColor];
                
                
                                NSString *title = [self.titles objectForKey:key];
                
                                CMPopTipView *popTipView;
                                if (contentView) {
                                    popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
                                }
                                else if (title) {
                                    popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
                                }
                                else {
                                    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
                                }
                                popTipView.delegate = self;
                
                                /* Some options to try.
                                 */
                                //popTipView.shouldEnforceCustomViewPadding = YES;
                                //popTipView.disableTapToDismiss = YES;
                                //popTipView.preferredPointDirection = PointDirectionUp;
                                //popTipView.hasGradientBackground = NO;
                                //popTipView.cornerRadius = 2.0;
                                //popTipView.sidePadding = 30.0f;
                                //popTipView.topMargin = 20.0f;
                                //popTipView.pointerSize = 50.0f;
                                //popTipView.hasShadow = NO;
                
                                if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
                                    popTipView.backgroundColor = backgroundColor;
                                }
                                if (textColor && ![textColor isEqual:[NSNull null]]) {
                                    popTipView.textColor = textColor;
                                }
                
                                popTipView.animation = arc4random() % 2;
                                popTipView.has3DStyle = (BOOL)(arc4random() % 2);
                
                                popTipView.dismissTapAnywhere = YES;
                                //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
                
                                if ([sender isKindOfClass:[UIButton class]]) {
                                    UIButton *button = (UIButton *)sender;
                                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
                                }
                                else {
                
                                    UISegmentedControl *button = (UISegmentedControl *)sender;
                                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
                                }
                                
                                [self.visiblePopTipViews addObject:popTipView];
                                
                                self.currentPopTipViewTarget = sender;
                            }
                            else
                            {
                                _eventArray = _popularTab.popularityEventArr;
                                
                                // _eventArray = _nearTab.popularityEventArr;
                                
                                [self.navigationController setLeftTitle:@"HOTSPOT"];
                            }
            break;
        case 3:
            if ([explore isEqualToString:@"exp"])
                            {
                                explore = @"";
                                NSString *contentMessage = nil;
                                UIView *contentView = nil;
                                NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
                                id content = [self.contents objectForKey:key];
                                if ([content isKindOfClass:[UIView class]]) {
                                    contentView = content;
                                }
                                else if ([content isKindOfClass:[NSString class]]) {
                                    contentMessage = content;
                                }
                                else {
                                    contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
                                }
                                // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
                                //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
                                //  UIColor *textColor = [colorScheme objectAtIndex:1];
                
                                //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
                                UIColor *backgroundColor = [UIColor blackColor];
                                UIColor *textColor = [UIColor whiteColor];
                
                
                                NSString *title = [self.titles objectForKey:key];
                
                                CMPopTipView *popTipView;
                                if (contentView) {
                                    popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
                                }
                                else if (title) {
                                    popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
                                }
                                else {
                                    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
                                }
                                popTipView.delegate = self;
                
                                /* Some options to try.
                                 */
                                //popTipView.shouldEnforceCustomViewPadding = YES;
                                //popTipView.disableTapToDismiss = YES;
                                //popTipView.preferredPointDirection = PointDirectionUp;
                                //popTipView.hasGradientBackground = NO;
                                //popTipView.cornerRadius = 2.0;
                                //popTipView.sidePadding = 30.0f;
                                //popTipView.topMargin = 20.0f;
                                //popTipView.pointerSize = 50.0f;
                                //popTipView.hasShadow = NO;
                
                                if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
                                    popTipView.backgroundColor = backgroundColor;
                                }
                                if (textColor && ![textColor isEqual:[NSNull null]]) {
                                    popTipView.textColor = textColor;
                                }
                
                                popTipView.animation = arc4random() % 2;
                                popTipView.has3DStyle = (BOOL)(arc4random() % 2);
                
                                popTipView.dismissTapAnywhere = YES;
                                //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
                                
                                if ([sender isKindOfClass:[UIButton class]]) {
                                    UIButton *button = (UIButton *)sender;
                                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
                                }
                                else
                                {
                                    
                                    UISegmentedControl *button = (UISegmentedControl *)sender;
                                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
                                }
                                
                                [self.visiblePopTipViews addObject:popTipView];
                                
                                self.currentPopTipViewTarget = sender;
                            }
                            else
                            {
                                [self.explorerTab loadPoints];
                                [self.navigationController setLeftTitle:@"EXPLORE"];
                
                            }
        default:
            break;

    }
}
//- (void)segmentAction:(UISegmentedControl*)sender
//{
//    switch (_selectedIndex)
//    {
//        case 0:
//        {
//            if ([favorites isEqualToString:@"fav"])
//            {
//        
//            favorites = @"";
//            NSString *contentMessage = nil;
//            UIView *contentView = nil;
//            NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
//            id content = [self.contents objectForKey:key];
//            if ([content isKindOfClass:[UIView class]]) {
//                contentView = content;
//            }
//            else if ([content isKindOfClass:[NSString class]]) {
//                contentMessage = content;
//            }
//            else {
//                contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
//            }
//           
//            UIColor *backgroundColor = [UIColor blackColor];
//            UIColor *textColor = [UIColor whiteColor];
//            
//            
//            NSString *title = [self.titles objectForKey:key];
//            
//            CMPopTipView *popTipView;
//            if (contentView) {
//                popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
//            }
//            else if (title) {
//                popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
//            }
//            else {
//                popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
//            }
//            popTipView.delegate = self;
//            
//            /* Some options to try.
//             */
//            //popTipView.shouldEnforceCustomViewPadding = YES;
//            //popTipView.disableTapToDismiss = YES;
//            //popTipView.preferredPointDirection = PointDirectionUp;
//            //popTipView.hasGradientBackground = NO;
//            //popTipView.cornerRadius = 2.0;
//            //popTipView.sidePadding = 30.0f;
//            //popTipView.topMargin = 20.0f;
//            //popTipView.pointerSize = 50.0f;
//            //popTipView.hasShadow = NO;
//            
//            if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
//                popTipView.backgroundColor = backgroundColor;
//            }
//            if (textColor && ![textColor isEqual:[NSNull null]]) {
//                popTipView.textColor = textColor;
//            }
//            
//            popTipView.animation = arc4random() % 2;
//            popTipView.has3DStyle = (BOOL)(arc4random() % 2);
//            
//            popTipView.dismissTapAnywhere = YES;
//            //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
//            
//            if ([sender isKindOfClass:[UIButton class]])
//            {
//                UIButton *button = (UIButton *)sender;
//                [popTipView presentPointingAtView:button inView:self.view animated:YES];
//            }
//            else
//            {
////                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
////                [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
//                
//                UISegmentedControl *button = (UISegmentedControl *)sender;
//                [popTipView presentPointingAtView:button inView:self.view animated:YES];
//            }
//            
//            [self.visiblePopTipViews addObject:popTipView];
//           
//            self.currentPopTipViewTarget = sender;
//                
//        }
//            else
//            {
//                _eventArray = _homeTab.homeEventArr;
//                
//                [self.navigationController setLeftTitle:@"FAVORITES"];
//            }
//            
//            
//        }
//            break;
//            case 1:
//            
//        {
//            if ([popular isEqualToString:@"popular"])
//            {
//                popular = @"";
//                NSString *contentMessage = nil;
//                UIView *contentView = nil;
//                NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
//                id content = [self.contents objectForKey:key];
//                if ([content isKindOfClass:[UIView class]]) {
//                    contentView = content;
//                }
//                else if ([content isKindOfClass:[NSString class]]) {
//                    contentMessage = content;
//                }
//                else {
//                    contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
//                }
//                // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
//                //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
//                //  UIColor *textColor = [colorScheme objectAtIndex:1];
//                
//                //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
//                UIColor *backgroundColor = [UIColor blackColor];
//                UIColor *textColor = [UIColor whiteColor];
//                
//                
//                NSString *title = [self.titles objectForKey:key];
//                
//                CMPopTipView *popTipView;
//                if (contentView) {
//                    popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
//                }
//                else if (title) {
//                    popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
//                }
//                else {
//                    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
//                }
//                popTipView.delegate = self;
//                
//                /* Some options to try.
//                 */
//                //popTipView.shouldEnforceCustomViewPadding = YES;
//                //popTipView.disableTapToDismiss = YES;
//                //popTipView.preferredPointDirection = PointDirectionUp;
//                //popTipView.hasGradientBackground = NO;
//                //popTipView.cornerRadius = 2.0;
//                //popTipView.sidePadding = 30.0f;
//                //popTipView.topMargin = 20.0f;
//                //popTipView.pointerSize = 50.0f;
//                //popTipView.hasShadow = NO;
//                
//                if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
//                    popTipView.backgroundColor = backgroundColor;
//                }
//                if (textColor && ![textColor isEqual:[NSNull null]]) {
//                    popTipView.textColor = textColor;
//                }
//                
//                popTipView.animation = arc4random() % 2;
//                popTipView.has3DStyle = (BOOL)(arc4random() % 2);
//                
//                popTipView.dismissTapAnywhere = YES;
//                //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
//                
//                if ([sender isKindOfClass:[UIButton class]]) {
//                    UIButton *button = (UIButton *)sender;
//                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
//                }
//                else {
//                   // UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
//                    //[popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
//                    UISegmentedControl *button = (UISegmentedControl *)sender;
//                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
//                   // [popTipView presentPointingAtView:button inView:self.view animated:YES];
//
//                }
//                
//                [self.visiblePopTipViews addObject:popTipView];
//                
//                self.currentPopTipViewTarget = sender;
//            }
//            else
//            {
//                _eventArray = _nearTab.nearEventArr;
//                
//                [self.navigationController setLeftTitle:@"POPULAR"];
//                
//
//            }
//        }
//            // _eventArray = _popularTab.nearEventArr;
//            
//            break;
//            case 2:
//        {
//            if ([hotspot isEqualToString:@"hotspt"])
//            {
//                hotspot = @"";
//                NSString *contentMessage = nil;
//                UIView *contentView = nil;
//                NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
//                id content = [self.contents objectForKey:key];
//                if ([content isKindOfClass:[UIView class]]) {
//                    contentView = content;
//                }
//                else if ([content isKindOfClass:[NSString class]]) {
//                    contentMessage = content;
//                }
//                else {
//                    contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
//                }
//                // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
//                //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
//                //  UIColor *textColor = [colorScheme objectAtIndex:1];
//                
//                //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
//                UIColor *backgroundColor = [UIColor blackColor];
//                UIColor *textColor = [UIColor whiteColor];
//                
//                
//                NSString *title = [self.titles objectForKey:key];
//                
//                CMPopTipView *popTipView;
//                if (contentView) {
//                    popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
//                }
//                else if (title) {
//                    popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
//                }
//                else {
//                    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
//                }
//                popTipView.delegate = self;
//                
//                /* Some options to try.
//                 */
//                //popTipView.shouldEnforceCustomViewPadding = YES;
//                //popTipView.disableTapToDismiss = YES;
//                //popTipView.preferredPointDirection = PointDirectionUp;
//                //popTipView.hasGradientBackground = NO;
//                //popTipView.cornerRadius = 2.0;
//                //popTipView.sidePadding = 30.0f;
//                //popTipView.topMargin = 20.0f;
//                //popTipView.pointerSize = 50.0f;
//                //popTipView.hasShadow = NO;
//                
//                if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
//                    popTipView.backgroundColor = backgroundColor;
//                }
//                if (textColor && ![textColor isEqual:[NSNull null]]) {
//                    popTipView.textColor = textColor;
//                }
//                
//                popTipView.animation = arc4random() % 2;
//                popTipView.has3DStyle = (BOOL)(arc4random() % 2);
//                
//                popTipView.dismissTapAnywhere = YES;
//                //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
//                
//                if ([sender isKindOfClass:[UIButton class]]) {
//                    UIButton *button = (UIButton *)sender;
//                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
//                }
//                else {
////                    UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
////                    [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
//                    
//                    UISegmentedControl *button = (UISegmentedControl *)sender;
//                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
//                }
//                
//                [self.visiblePopTipViews addObject:popTipView];
//                
//                self.currentPopTipViewTarget = sender;
//            }
//            else
//            {
//                _eventArray = _popularTab.popularityEventArr;
//                
//                // _eventArray = _nearTab.popularityEventArr;
//                
//                [self.navigationController setLeftTitle:@"HOTSPOT"];
//            }
//            
//            
//        }
//            break;
//            default:
//        {
//            if ([explore isEqualToString:@"exp"])
//            {
//                explore = @"";
//                NSString *contentMessage = nil;
//                UIView *contentView = nil;
//                NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
//                id content = [self.contents objectForKey:key];
//                if ([content isKindOfClass:[UIView class]]) {
//                    contentView = content;
//                }
//                else if ([content isKindOfClass:[NSString class]]) {
//                    contentMessage = content;
//                }
//                else {
//                    contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
//                }
//                // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
//                //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
//                //  UIColor *textColor = [colorScheme objectAtIndex:1];
//                
//                //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
//                UIColor *backgroundColor = [UIColor blackColor];
//                UIColor *textColor = [UIColor whiteColor];
//                
//                
//                NSString *title = [self.titles objectForKey:key];
//                
//                CMPopTipView *popTipView;
//                if (contentView) {
//                    popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
//                }
//                else if (title) {
//                    popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
//                }
//                else {
//                    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
//                }
//                popTipView.delegate = self;
//                
//                /* Some options to try.
//                 */
//                //popTipView.shouldEnforceCustomViewPadding = YES;
//                //popTipView.disableTapToDismiss = YES;
//                //popTipView.preferredPointDirection = PointDirectionUp;
//                //popTipView.hasGradientBackground = NO;
//                //popTipView.cornerRadius = 2.0;
//                //popTipView.sidePadding = 30.0f;
//                //popTipView.topMargin = 20.0f;
//                //popTipView.pointerSize = 50.0f;
//                //popTipView.hasShadow = NO;
//                
//                if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
//                    popTipView.backgroundColor = backgroundColor;
//                }
//                if (textColor && ![textColor isEqual:[NSNull null]]) {
//                    popTipView.textColor = textColor;
//                }
//                
//                popTipView.animation = arc4random() % 2;
//                popTipView.has3DStyle = (BOOL)(arc4random() % 2);
//                
//                popTipView.dismissTapAnywhere = YES;
//                //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
//                
//                if ([sender isKindOfClass:[UIButton class]]) {
//                    UIButton *button = (UIButton *)sender;
//                    [popTipView presentPointingAtView:button inView:self.view animated:YES];
//                }
//                else {
//                    UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
//                    [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
//                }
//                
//                [self.visiblePopTipViews addObject:popTipView];
//                
//                self.currentPopTipViewTarget = sender;
//            }
//            else
//            {
//                [self.explorerTab loadPoints];
//                [self.navigationController setLeftTitle:@"EXPLORE"];
//
//            }
//            
//            
//        }
//            break;
//    }
//}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    if (_selectedIndex != page) {
        _selectedIndex  = page;
       // [self updateIndex];
    }
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    
}

- (void)searchButtonClicked
{
    [self.navigationController presentViewController:self.searchController animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.eventArray mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0)
    {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    //
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems)
    {
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"eventName"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        lhs = [NSExpression expressionForKeyPath:@"eventVenue"];
        rhs = [NSExpression expressionForConstantValue:searchString];
        finalPredicate = [NSComparisonPredicate
                          predicateWithLeftExpression:lhs
                          rightExpression:rhs
                          modifier:NSDirectPredicateModifier
                          type:NSContainsPredicateOperatorType
                          options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        // yearIntroduced field matching
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
//        NSNumber *targetNumber = [numberFormatter numberFromString:searchString];
//        if (targetNumber != nil) {
//            lhs = [NSExpression expressionForKeyPath:@"startDate"];
//            rhs = [NSExpression expressionForConstantValue:targetNumber];
//            finalPredicate = [NSComparisonPredicate
//                              predicateWithLeftExpression:lhs
//                              rightExpression:rhs
//                              modifier:NSDirectPredicateModifier
//                              type:NSEqualToPredicateOperatorType
//                              options:NSCaseInsensitivePredicateOption];
//            [searchItemsPredicate addObject:finalPredicate];
//            lhs = [NSExpression expressionForKeyPath:@"endDate"];
//            rhs = [NSExpression expressionForConstantValue:targetNumber];
//            finalPredicate = [NSComparisonPredicate
//                              predicateWithLeftExpression:lhs
//                              rightExpression:rhs
//                              modifier:NSDirectPredicateModifier
//                              type:NSEqualToPredicateOperatorType
//                              options:NSCaseInsensitivePredicateOption];
//            [searchItemsPredicate addObject:finalPredicate];
//        }
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    ResultEventTable *tableController = (ResultEventTable *)self.searchController.searchResultsController;
    tableController.dataEventArray = searchResults;
//    tableController.tableView.backgroundColor = [UIColor colorWithRed:0.9294 green:0.3059 blue:0.5647 alpha:0.4];
    [tableController.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoBookmark
{
    
    HomeTabController *homeController = [[HomeTabController alloc] initWithNibName:@"HomeTabController" bundle:nil];
    homeController.isBookmark = YES;
    homeController.isSearch = NO;


    switch (_selectedIndex)
    {
        case 0:
            
            [_homeTab.navigationController setLeftTitle:@"WISHLIST"];
            [_homeTab.navigationController pushViewController:homeController animated:NO];
            break;
        case 1:
            
            [_nearTab.navigationController setLeftTitle:@"WISHLIST"];
            [_nearTab.navigationController pushViewController:homeController animated:NO];
            break;
        case 2:
            
            [_popularTab.navigationController setLeftTitle:@"WISHLIST"];
            [_popularTab.navigationController pushViewController:homeController animated:NO];
            break;
        default: {
            
            [self.explorerTab.navigationController setLeftTitle:@"WISHLIST"];
            [self.explorerTab.navigationController pushViewController:homeController animated:NO];
        }
            break;
    }

}
///////////////////////////////////////////

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
    //formenu = @"No";
    
}

//- (void)searchAction:(id) sender
//{
//
////        [self.navigationController presentViewController:self.searchController
////                                                animated:YES
////                                              completion:nil];
////
////    }
//}
- (void)filterAction:(id)sender
{
    if ([filterBtnClicked isEqualToString:@"filter"])
    {
        [self dismissAllPopTipViews];
        
        filterBtnClicked = @" ";
        
        
        if (sender == self.currentPopTipViewTarget)
        {
            // Dismiss the popTipView and that is all
            self.currentPopTipViewTarget = nil;
        }
        else {
            NSString *contentMessage = nil;
            UIView *contentView = nil;
            NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
            id content = [self.contents objectForKey:key];
            if ([content isKindOfClass:[UIView class]]) {
                contentView = content;
            }
            else if ([content isKindOfClass:[NSString class]])
            {
                contentMessage = content;
            }
            else {
                contentMessage = @"A CMPopTipView can automatically point to any view or bar button item.";
            }
            // NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
            //  UIColor *backgroundColor = [colorScheme objectAtIndex:0];
            //  UIColor *textColor = [colorScheme objectAtIndex:1];
            
            //        UIColor *backgroundColor = [UIColor colorWithRed:(180/255.f) green:(180/255.f) blue:(180/255.f) alpha:1.0];
            UIColor *backgroundColor = [UIColor blackColor];
            UIColor *textColor = [UIColor whiteColor];
            
            
            NSString *title = [self.titles objectForKey:key];
            
            CMPopTipView *popTipView;
            if (contentView) {
                popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
            }
            else if (title) {
                popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
            }
            else {
                popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
            }
            popTipView.delegate = self;
            
            /* Some options to try.
             */
            //popTipView.shouldEnforceCustomViewPadding = YES;
            //popTipView.disableTapToDismiss = YES;
            //popTipView.preferredPointDirection = PointDirectionUp;
            //popTipView.hasGradientBackground = NO;
            //popTipView.cornerRadius = 2.0;
            //popTipView.sidePadding = 30.0f;
            //popTipView.topMargin = 20.0f;
            //popTipView.pointerSize = 50.0f;
            //popTipView.hasShadow = NO;
            
            if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
                popTipView.backgroundColor = backgroundColor;
            }
            if (textColor && ![textColor isEqual:[NSNull null]]) {
                popTipView.textColor = textColor;
            }
            
            popTipView.animation = arc4random() % 2;
            popTipView.has3DStyle = (BOOL)(arc4random() % 2);
            
            popTipView.dismissTapAnywhere = YES;
            //[popTipView autoDismissAnimated:YES atTimeInterval:3.0];
            
            if ([sender isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)sender;
                [popTipView presentPointingAtView:button inView:self.view animated:YES];
            }
            else {
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
                [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
            }
            
            [self.visiblePopTipViews addObject:popTipView];
            self.currentPopTipViewTarget = sender;
        }
    }
    else
    {
        UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Points" bundle:[NSBundle mainBundle]];
        FilterVC *vc = [stroy instantiateViewControllerWithIdentifier:@"FilterVC"];
        vc.mainControllr =  self;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
}

- (void)gotoSearchResultScreen {
    
    HomeTabController *homeController = [[HomeTabController alloc] initWithNibName:@"HomeTabController" bundle:nil];
    homeController.isBookmark = NO;
    homeController.isSearch = YES;
    homeController.homeEventArr = self.eventArray;
    
    switch (_selectedIndex) {
        case 0:
            
            [_homeTab.navigationController setLeftTitle:@"SEARCH RESULT"];
            [_homeTab.navigationController pushViewController:homeController animated:YES];
            break;
        case 1:
            
            [_nearTab.navigationController setLeftTitle:@"SEARCH RESULT"];
            [_nearTab.navigationController pushViewController:homeController animated:NO];
            break;
        case 2:
            
            [_popularTab.navigationController setLeftTitle:@"SEARCH RESULT"];
            [_popularTab.navigationController pushViewController:homeController animated:NO];
            break;
        default: {
            
            [self.explorerTab.navigationController setLeftTitle:@"SEARCH RESULT"];
            [self.explorerTab.navigationController pushViewController:homeController animated:NO];
        }
            break;
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
