//
//  MenuViewController.h
//  Hobbistan
//
//  Created by KPTech on 1/7/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView, *bImageView;
@property (weak, nonatomic) IBOutlet UIView *touchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *nameTxt, *cityTxt;

@property (nonatomic, weak) MainViewController *mainViewController;
@end
