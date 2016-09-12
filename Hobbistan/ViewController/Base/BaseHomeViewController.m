//
//  BaseHomeViewController.m
//  Hobbistan
//
//  Created by KPTech on 1/14/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import "BaseHomeViewController.h"

@interface BaseHomeViewController ()
{
    NSString *forMenuSearch;
    NSString *formenuFilter;
}
@end

@implementation BaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingRightLogo];
    
    formenuFilter = @"popFilter";
    forMenuSearch = @"popSearch";
    
}

- (void)settingRightLogo {
    
    CGRect mainScreenBounds = [UIScreen mainScreen].bounds;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(mainScreenBounds.size.width - 100.0, 0, 100, 44)];
    [rightView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *searchBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 30)];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightView addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchDown];
    
    /* set tag for uibar searchBtn button */
    
    searchBtn.tag = 2;
    
    UIButton *filterBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40, 10, 50, 30)];
    [filterBtn setBackgroundColor:[UIColor clearColor]];
    [filterBtn setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
    [rightView addSubview:filterBtn];
    [filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchDown];
    
    /* set tag for uibar filterBtn button */

    filterBtn.tag = 3;

    [self.navigationController.navigationBar addSubview:rightView];
}
- (void)updateIndex
{
    
}

- (void)searchAction:(id) sender
{
    if ([forMenuSearch isEqualToString:@"popSearch"])
    {
        [self dismissAllPopTipViews];
        
        forMenuSearch = @"popS";

        
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
        [self.navigationController presentViewController:self.searchController
                                                animated:YES
                                              completion:nil];
        
    }

}
- (void)filterAction:(id) sender
{
    formenuFilter = @"popF";


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0)
    {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
    
}

//////////////////////////////
@end
