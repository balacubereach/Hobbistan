//
//  ResultEventTable.h
//  Hobbistan
//
//  Created by KPTech on 1/14/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventCell.h"
#import "EventDetail.h"

typedef void(^didSelectEvent)(Event *event);

@interface ResultEventTable : UITableViewController
@property (nonatomic, strong)NSMutableArray *dataEventArray;
@property (nonatomic, copy) didSelectEvent didSelectEvent;

- (id)initWithSlectionBlock:(didSelectEvent)didSelectEventBlock;
@end
