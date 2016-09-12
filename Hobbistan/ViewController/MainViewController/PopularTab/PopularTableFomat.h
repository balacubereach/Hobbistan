//
//  PopularTableFomat.h
//  Hobbistan
//
//  Created by KPTech on 1/9/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^reQuestNewData)(NSMutableArray *newData);
typedef void(^refreshData)(reQuestNewData reQuestNewData);
@interface PopularTableFomat : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) refreshData refreshData;
@property (nonatomic, copy) reQuestNewData reQuestNewData;

- (void)refreshEventData;
- (id)initWithBlock:(refreshData) refreshData;

@end
