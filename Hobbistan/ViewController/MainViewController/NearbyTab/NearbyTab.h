//
//  NearbyTab.h
//  Hobbistan
//
//  Created by KPTech on 1/8/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyTab : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *nearEventArr;

@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *contentViewNear;

@property (nonatomic, strong) NSMutableArray *NearEventArray;
@property (nonatomic, strong) NSString *locationNear;

@property (weak, nonatomic) IBOutlet UILabel *neareventlbl;




@end
