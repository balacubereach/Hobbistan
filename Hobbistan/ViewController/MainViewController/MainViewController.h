//
//  MainViewController.h
//  Hobbistan
//
//  Created by KPTech on 1/5/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHomeViewController.h"

@interface MainViewController : BaseHomeViewController <UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *eventArray;

- (void)gotoBookmark;
- (void)gotoSearchResultScreen;


@end
