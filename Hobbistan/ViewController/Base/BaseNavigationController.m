//
//  BaseNavigationController.m
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "BaseHomeViewController.h"

#define foo4random() (1.0 * (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX)

@interface BaseNavigationController ()<UINavigationControllerDelegate>
{
    NSString *formenu;
}
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate   = self;
    [self.navigationBar setTranslucent:NO];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:37/255.0f green:33/255.0f blue:34/255.0f alpha:1.0]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.blackView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.blackView.tag = 212;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.blackView addGestureRecognizer:singleFingerTap];
    [self settingLeftLogo];
    
    
    /* set tag for uibar button */
    
    self.leftMenuBarButtonItem.tag = 1;
    
    formenu = @"yes";

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
    formenu = @"No";

}

////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)setupMenuButton
{
    
    self.navigationController.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    
    
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(leftSideMenuButtonPressed:)];
    
}

- (void)leftSideMenuButtonPressed:(id) sender
{
    if ([formenu isEqualToString:@"yes"])
    {
        [self dismissAllPopTipViews];
        
        if (sender == self.currentPopTipViewTarget) {
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
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
                [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
            }
            
            [self.visiblePopTipViews addObject:popTipView];
            self.currentPopTipViewTarget = sender;
        }
    }
    else
    {
        [self openMenu];

    }
    
    formenu = @"No";
}

- (void)openMenu {
    
    if(self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered){
        
        [self.slidingViewController.topViewController.view addSubview:self.blackView];
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
    else{
        [self.blackView removeFromSuperview];
        [self.slidingViewController resetTopViewAnimated:YES];
    }
}

- (void)settingLeftLogo {
    
//    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hobb-logo"]];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    imageView.frame = titleView.bounds;
//    [titleView addSubview:imageView];
//    
//    self.navigationItem.titleView = titleView;

    
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake((self.navigationBar.frame.size.width/2)-75, 0, 150, 44)];
    [logoView setBackgroundColor:[UIColor clearColor]];
    UIImageView *logoImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    
    [logoImageView setBackgroundColor:[UIColor clearColor]];
    [logoImageView setImage:[[UIImage imageNamed:@"hobb-logo"]imageWithRenderingMode:UIImageRenderingModeAutomatic]];
    [logoView addSubview:logoImageView];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 100, 30)];
    [_labelTitle setText:@"FAVORITES"];
    [_labelTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]];
    [_labelTitle setTextColor:[UIColor colorWithRed:217/255.0f green:33/255.0f blue:45/255.0f alpha:1.0]];
    [_labelTitle setBackgroundColor:[UIColor clearColor]];
    [logoView addSubview:_labelTitle];
    
    [self.navigationBar addSubview:logoView];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
  //  self.navigationItem.titleView = logoView;
    
   
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self viewControllers][0] == viewController) {
        if (!viewController.navigationItem.leftBarButtonItems) {
            viewController.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
        }
        if ([viewController isKindOfClass:[BaseHomeViewController class]]) {
            [(BaseHomeViewController*)viewController updateIndex];
        }
    }
}

- (void)willShowTitle:(NSString *)title
{
    [self.labelTitle setText:title];
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [self openMenu];
}

@end
