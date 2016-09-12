//
//  StatisticsViewController.h
//  Hobbistan
//
//  Created by Khagesh on 24/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic, weak) IBOutlet UILabel *totalPointsLbl, *photoSharingPointsLbl, *ePointsLbl, *cPointsLbl, *bPointsLbl;
@property(nonatomic, copy) NSString *totalPointsStr;
- (void)loadWithDic:(NSDictionary *)dataDic;
@end
