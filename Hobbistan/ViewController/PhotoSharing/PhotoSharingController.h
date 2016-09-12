//
//  RankViewController.h
//  Hobbistan
//
//  Created by Khagesh on 23/01/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSharingController : UIViewController

@property(nonatomic, copy) NSString *points;
@property(nonatomic, copy) NSString *levelStr;

@property (nonatomic, weak) IBOutlet UILabel *pointsLbl, *levelLbl;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

-(void)loadScreen;

@end
