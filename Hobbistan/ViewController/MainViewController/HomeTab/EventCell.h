//
//  EventCell.h
//  Hobbistan
//
//  Created by KPTech on 1/8/16.
//  Copyright © 2016 KP Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbNail, *adImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *paidTitle;
@property (weak, nonatomic) IBOutlet UILabel *dateEvent;
@property (weak, nonatomic) IBOutlet UILabel *timeEvent;
@property (nonatomic, strong) NSString *url;
@property (weak, nonatomic) IBOutlet UIImageView *calanderimg;

- (void)configCellWithEvent:(Event *)event;

- (void)configCellWithEventwithoutDate:(Event *)event;

@end
