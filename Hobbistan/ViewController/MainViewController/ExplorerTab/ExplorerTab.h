//
//  ExplorerTab.h
//  Hobbistan
//
//  Created by KPTech on 1/11/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplorerTab : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (void)sharePhotoAction;
- (void)rankAction;
- (void)checkInAction;
- (void)visaAction;
- (void)bookingAction;
- (void)engamentAction;
- (void)viewAllAction;

- (void)loadPoints;
@end
